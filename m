Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264637AbUFVPe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbUFVPe5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbUFVPee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:34:34 -0400
Received: from holomorphy.com ([207.189.100.168]:33411 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264637AbUFVPQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 11:16:17 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [profile]: [0/23] mmap() support for /proc/profile
Message-ID: <0406220816.1a3aYaLbLbXaKbKb1aWa4a1a3a2a3aIb2a0aZaWaHb4aXaXaZa1aKbZaWa5aHb3a15250@holomorphy.com>
CC: rddunlap@osdl.org
Date: Tue, 22 Jun 2004 08:16:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/*
I was trying to profile a mostly-idle workload to get an idea of what
area of the kernel things were diving into and falling asleep in during
an OAST run. Without these patches, kerneltop et al showed heavy /proc/
activity along with copy_to_user() at the top of the profiles.

With these patches in place, kernel participation in profile data
movement was greatly reduced, and the profile showed very meaningful
try_atomic_semop() as the area of the kernel being exercised, which
indicated contention for a sysv semaphore originating from userspace.

The program below was used to report the data. Patches vs. 2.6.7-final.


-- wli
*/

#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <ctype.h>
#include <string.h>
#include <curses.h>
#include <signal.h>
#include <time.h>
#include <getopt.h>
#include <limits.h>
#include <termios.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/utsname.h>

#define LINEBUF_SIZE		256
#define SYSTEM_MAP_ERROR	1
#define PROC_PROFILE_ERROR	2
#define INTERVAL_TIMER_ERROR	3
#define TCGETATTR_ERROR		4
#define NCURSES_ERROR		5
#define ARRAY_SIZE(x)		((int)(sizeof(x)/sizeof(x[0])))

struct ksym {
	u_int64_t vaddr;
	char *s;
	struct ksym *next;
};

struct sym {
	u_int64_t vaddr;
	u_int32_t cur_hits, cum_hits;
	char *s;
};

struct prof_state {
	WINDOW *window;
	struct ksym *ksyms, *end_ksym;
	struct sym *symtab, *idle_sym;
	char *strtab, *mapfile;
	u_int32_t *profile;
	u_int64_t start_vaddr, end_vaddr;
	size_t profile_size;
	int nsyms, tot_strlen, delay, iofd, idle;
	struct termios saved_termios[3];
};

static const char proc_profile[] = "/proc/profile";
static struct utsname utsname;
static size_t uts_len = 0;
static int user_interrupt = 0, input_ready = 0, tick_pending, ticks = 0;

static int prepare_to_profile(struct prof_state *, int, char *[]);
static int wait_for_readiness(struct prof_state *);
static void cleanup_state(struct prof_state **);
static struct prof_state *alloc_prof_state(void);
static int display_profile(struct prof_state *);
static void cleanup_system_map(struct prof_state *);
static void unmap_proc_profile(struct prof_state *);
static int parse_system_map(struct prof_state *, int, char *[]);
static int map_proc_profile(struct prof_state *, int, char *[]);
static int setup_interval_timer(struct prof_state *, int, char *[]);
static int push_vaddr(struct prof_state *, u_int64_t, const char *);
static int prof_tabulate_syms(struct prof_state *);
static void cleanup_interval_timer(struct prof_state *);
static int user_input(struct prof_state *);

int main(int argc, char *argv[])
{
	int c, err = 0;
	long delay;
	struct prof_state *state = alloc_prof_state();

	if (state == NULL)
		return errno;
	while ((c = getopt(argc, argv, "d:m:")) != -1) {
		switch (c) {
			case 'd':
				delay = strtol(optarg, NULL, 0);
				if (delay < INT_MAX && delay > 0)
					state->delay = delay;
				else {
					perror("bad delay value");
					err = errno;
					goto out_err;
				}
				break;
			case 'm':
				if ((state->mapfile = strdup(optarg)) == NULL) {
					err = errno;
					goto out_err;
				}
				break;
			default:
				break;
		}
	}
	if (!state->delay)
		state->delay = 1;
	if (prepare_to_profile(state, argc, argv)) {
		err = errno;
		goto cleanup_state;
	}
	while (!wait_for_readiness(state)) {
		if (user_input(state))
			break;
		else if (display_profile(state))
			break;
	}
cleanup_state:
	cleanup_state(&state);
out_err:
	return err;
}

static int user_input(struct prof_state *state)
{
	static char buf[LINEBUF_SIZE];
	int n, k;

	(void)state;
	if (!input_ready)
		return 0;
	input_ready = 0;
	while ((n = read(STDIN_FILENO, buf, sizeof(buf))) > 0) {
		for (k = 0; k < n; ++k) {
			if (buf[k] == 'q' || buf[k] == 'Q')
				return 1;
			else if (buf[k] == 'i')
				state->idle = !state->idle;
			else if (buf[k] == 'w')
				tick_pending = 1;
			else if (isdigit(buf[k]) && buf[k] != '0') {
				struct itimerval new, old;
				state->delay = buf[k] - '0';
				if (getitimer(ITIMER_REAL, &old))
					return 0;
				new.it_interval.tv_sec = state->delay;
				new.it_interval.tv_usec = 0;
				if (old.it_value.tv_sec < state->delay)
					memcpy(&new.it_value,
						&old.it_value,
						sizeof(struct timeval));
				else {
					new.it_value.tv_sec = state->delay;
					new.it_value.tv_usec = 0;
				}
				setitimer(ITIMER_REAL, &new, NULL);
			}
		}
	}
	return 0;
}

static int prepare_to_profile(struct prof_state *state, int argc, char *argv[])
{
	int err;

	if (tcgetattr(STDIN_FILENO, &state->saved_termios[0]))
		return TCGETATTR_ERROR;
	else if (tcgetattr(STDOUT_FILENO, &state->saved_termios[1]))
		return TCGETATTR_ERROR;
	else if (tcgetattr(STDERR_FILENO, &state->saved_termios[2]))
		return TCGETATTR_ERROR;
	else if (!(state->window = initscr()))
		return NCURSES_ERROR;
	else if (parse_system_map(state, argc, argv))
		return SYSTEM_MAP_ERROR;
	else if (map_proc_profile(state, argc, argv)) {
		err = PROC_PROFILE_ERROR;
		goto cleanup_system_map;
	} else if (setup_interval_timer(state, argc, argv)) {
		err = INTERVAL_TIMER_ERROR;
		goto unmap_proc_profile;
	} else
		return 0;
unmap_proc_profile:
	unmap_proc_profile(state);
cleanup_system_map:
	cleanup_system_map(state);
	return err;
}

static int parse_system_map(struct prof_state *state, int argc, char *argv[])
{
	int fd, err = 0;
	size_t len;
	struct stat *stbuf;
	char *buf;
	off_t pos, new_pos;

	(void)argc;
	(void)argv;
	if (uname(&utsname))
		return errno;
	uts_len = strlen(utsname.sysname) + strlen(utsname.release)
						+ strlen(utsname.nodename);
	len = strlen("/boot/System.map-") + strlen(utsname.release) + 1;
	if (state->mapfile == NULL) {
		if ((state->mapfile = malloc(len)) == NULL)
			return errno;
		memset(state->mapfile, 0, len);
		err = snprintf(state->mapfile, len, "/boot/System.map-%s",
					utsname.release);
		if (err == (int)(len-1))
			err = 0;
		else {
			err = ENOENT;
			goto free_mapfile;
		}
	}
	stbuf = malloc(sizeof(struct stat));
	if (stbuf == NULL) {
		err = errno;
		goto free_mapfile;
	}
	buf = malloc(LINEBUF_SIZE);
	if (buf == NULL) {
		err = errno;
		goto free_stbuf;
	}
	fd = open(state->mapfile, O_RDONLY);
	if (fd < 0) {
		err = errno;
		goto free_buf;
	}
	if (fstat(fd, stbuf)) {
		err = errno;
		goto close_fd;
	}
	pos = 0;
	while (pos < stbuf->st_size) {
		int m, k;
		u_int64_t vaddr;
		pread(fd, buf, LINEBUF_SIZE, pos);
		for (new_pos = k = 0; k < LINEBUF_SIZE; ++k) {
			if (buf[k] == '\n') {
				new_pos = pos + k + 1;
				break;
			}
		}
		if (new_pos <= pos) {
			err = -ENOENT;
			break;
		}
		vaddr = 0;
		for (m = 0; m < k; ++m) {
			if (buf[m] == ' ')
				break;
			else if (!isxdigit(buf[m])) {
				err = -EINVAL;
				goto close_fd;
			}
			vaddr <<= 4;
			if (buf[m] >= 'a' && buf[m] <= 'f')
				vaddr += (int)(buf[m] - 'a') + 10;
			else if (buf[m] >= 'A' && buf[m] <= 'F')
				vaddr += (int)(buf[m] - 'A') + 10;
			else if (buf[m] >= '0' && buf[m] <= '9')
				vaddr += (int)(buf[m] - '0');
		}
		while (m < k && buf[m] == ' ')
			++m;
		if (m == k || (buf[m] != 't' && buf[m] != 'T'))
			goto new_pos;
		++m;
		while (m < k && buf[m] == ' ')
			++m;
		if (m == k || buf[m] == '\n')
			goto new_pos;
		if (push_vaddr(state, vaddr, &buf[m])) {
			err = ENOMEM;
			goto close_fd;
		}

		new_pos:
			pos = new_pos;
	}
	if (prof_tabulate_syms(state))
		err = errno;
close_fd:
	close(fd);
free_buf:
	free(buf);
free_stbuf:
	free(stbuf);
free_mapfile:
	free(state->mapfile);
	return err;
}

static struct prof_state *alloc_prof_state(void)
{
	struct prof_state *state = malloc(sizeof(struct prof_state));
	if (state != NULL)
		memset(state, 0, sizeof(struct prof_state));
	return state;
}

static int push_vaddr(struct prof_state *state, u_int64_t vaddr, const char *s)
{
	struct ksym *ksym = malloc(sizeof(struct ksym));
	int k;

	if (ksym == NULL)
		return errno;
	k = 0;
	while (s[k] != '\n')
		++k;
	ksym->s = strndup(s, k);
	if (ksym->s == NULL) {
		free(ksym);
		return errno;
	}
	ksym->vaddr = vaddr;
	ksym->next = NULL;
	state->tot_strlen += strlen(ksym->s) + 1;
	if (!strcmp(ksym->s, "stext"))
		state->start_vaddr = vaddr;
	else if (!strcmp(ksym->s, "__sched_text_end"))
		state->end_vaddr = vaddr;
	if (state->end_ksym == NULL)
		state->ksyms = state->end_ksym = ksym;
	else {
		state->end_ksym->next = ksym;
		state->end_ksym = ksym;
	}
	state->nsyms++;
	return 0;
}

static void cleanup_system_map(struct prof_state *state)
{
	while (state->ksyms) {
		struct ksym *ksym = state->ksyms;
		state->ksyms = ksym->next;
		free(ksym->s);
		free(ksym);
		state->nsyms--;
	}
	state->end_ksym = NULL;
}

static int prof_tabulate_syms(struct prof_state *state)
{
	int sym_pos = 0, str_pos = 0;

	state->symtab = calloc(state->nsyms, sizeof(struct sym));
	if (state->symtab == NULL)
		return errno;
	state->strtab = malloc(state->tot_strlen);
	if (state->strtab == NULL) {
		free(state->symtab);
		return errno;
	}
	while (state->ksyms) {
		struct ksym *ksym = state->ksyms;

		state->symtab[sym_pos].s = &state->strtab[str_pos];
		strcpy(state->symtab[sym_pos].s, ksym->s);
		str_pos += strlen(ksym->s) + 1;
		state->symtab[sym_pos].vaddr = ksym->vaddr;
		if (!strcmp(state->symtab[sym_pos].s, "default_idle"))
			state->idle_sym = &state->symtab[sym_pos];
		sym_pos++;

		state->ksyms = ksym->next;
		free(ksym->s);
		free(ksym);
	}
	state->end_ksym = NULL;
	return 0;
}

static int profile_hit(struct prof_state *state, int n, int queue[], int sym)
{
	int m, k;
	u_int64_t vaddr, end;
	u_int32_t hits = 0;

	if (state->symtab[sym].vaddr <= state->start_vaddr)
		return 0;
	if (state->symtab[sym].vaddr >= state->end_vaddr)
		return 0;
	if (sym == state->nsyms - 1)
		end = state->end_vaddr;
	else
		end = state->symtab[sym + 1].vaddr;
	k = 1+(state->symtab[sym].vaddr - state->start_vaddr)/state->profile[0];
	state->symtab[sym].cum_hits += state->symtab[sym].cur_hits;

	for (vaddr = state->symtab[sym].vaddr; vaddr < end; vaddr += state->profile[0], ++k)
		hits += state->profile[k];
	if (hits >= state->symtab[sym].cum_hits)
		state->symtab[sym].cur_hits = hits - state->symtab[sym].cum_hits;
	else {
		state->symtab[sym].cur_hits = 0;
	}
	if (!state->symtab[sym].cur_hits)
		return 0;
	if (!state->idle && &state->symtab[sym] == state->idle_sym)
		return 0;
	for (k = -1, m = 0; m < n; ++m) {
		if (queue[m] < 0) {
			k = m;
			break;
		} else if (k < 0) {
			if (state->symtab[queue[m]].cur_hits
					< state->symtab[sym].cur_hits)
				k = m;
		} else if (k >= 0) {
			if (state->symtab[queue[m]].cur_hits
					< state->symtab[queue[k]].cur_hits)
				k = m;
		}
	}
	if (k >= 0)
		queue[k] = sym;
	return state->symtab[sym].cur_hits;
}

static int map_proc_profile(struct prof_state *state, int argc, char *argv[])
{
	struct stat *st_buf;
	size_t size;
	int fd, step;

	(void)argc;
	(void)argv;
	st_buf = malloc(sizeof(struct stat));
	if (st_buf == NULL)
		return errno;
	fd = open(proc_profile, O_RDONLY);
	if (fd < 0) {
		free(st_buf);
		return errno;
	}
	fstat(fd, st_buf);
	size = (st_buf->st_size + getpagesize() - 1) & ~(getpagesize() - 1);
	free(st_buf);
	state->profile = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
	state->profile_size = size;
	if (state->profile == MAP_FAILED)
		goto close_fd;
	step = state->profile[0];
close_fd:
	close(fd);
	return errno;
}

static void unmap_proc_profile(struct prof_state *state)
{
	if (state->profile != NULL && state->profile != MAP_FAILED)
		munmap(state->profile, state->profile_size);
}

static int wait_for_readiness(struct prof_state *state)
{
	(void)state;
	if (pause() != -1)
		return errno;
	else if (user_interrupt)
		return EAGAIN;
	else {
		errno = 0;
		return 0;
	}
}

static int display_profile(struct prof_state *state)
{
	int queue[LINES - 4];
	int victim, m, k, hits = 0;
	time_t now;
	static char timestr[LINEBUF_SIZE];

	if (!tick_pending)
		return 0;
	tick_pending = 0;
	clrtobot();
	move(0, 0);
	for (k = 0; k < ARRAY_SIZE(queue); ++k)
		queue[k] = -1;
	for (k = 0; k < state->nsyms; ++k)
		hits += profile_hit(state, ARRAY_SIZE(queue), queue, k);
	time(&now);
	ctime_r(&now, timestr);
	printw("%s: %s-%s %*s", utsname.nodename, utsname.sysname,
			utsname.release, COLS - uts_len - 4, timestr);
	printw("%8d profile hits registered, step %d\n\n", hits, ticks);
	attron(A_STANDOUT);
	printw("%8s\t%9s\t%*s\n", "TICKS", "%SYS", 33 - COLS, "FUNCTION");
	attroff(A_STANDOUT);
	for (m = 0; m < ARRAY_SIZE(queue) - 1; ++m) {
		if (queue[m] < 0)
			break;
		for (k = m + 1, victim = -1; k < ARRAY_SIZE(queue); ++k) {
			if (queue[k] < 0)
				break;
			if (victim < 0 && state->symtab[queue[m]].cur_hits
					< state->symtab[queue[k]].cur_hits)
				victim = k;
			else if (victim >= 0 &&
					state->symtab[queue[victim]].cur_hits
					< state->symtab[queue[k]].cur_hits)
				victim = k;
		}
		if (victim != -1) {
			k = queue[victim];
			queue[victim] = queue[m];
			queue[m] = k;
		}
	}
	for (k = 0; k < ARRAY_SIZE(queue); ++k) {
		if (queue[k] < 0)
			continue;
		printw("%8lu\t%8.4f%%\t%s\n",
				(unsigned long)state->symtab[queue[k]].cur_hits,
				hits ? 100.0*((double)state->symtab[queue[k]].cur_hits/(double)hits) : 0.0,
				state->symtab[queue[k]].s);

	}
	move(2, 0);
	refresh();
	return 0;
}

static void cleanup_state(struct prof_state **state)
{
	static int fds[3] = { STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO };
	int k;
	cleanup_interval_timer(*state);
	cleanup_system_map(*state);
	unmap_proc_profile(*state);
	close((*state)->iofd);
	refresh();
	endwin();
	for (k = 0; k <= 2; ++k) {
		(*state)->saved_termios[k].c_iflag |= BRKINT;
		(*state)->saved_termios[k].c_iflag &= ~ICRNL;
		(*state)->saved_termios[k].c_oflag |= ONLCR;
		if (tcsetattr(fds[k], TCSANOW, &(*state)->saved_termios[k]) < 0)
			fprintf(stderr, "tcsetattr failed\n");
	}
	free(*state);
	*state = NULL;
}

static void action(int sig, siginfo_t *info, void *ucontext)
{
	(void)sig;
	(void)info;
	(void)ucontext;
	++ticks;
	tick_pending = 1;
}

static void quit(int sig, siginfo_t *info, void *ucontext)
{
	(void)sig;
	(void)info;
	(void)ucontext;
	user_interrupt = 1;
}

static void input(int sig, siginfo_t *info, void *ucontext)
{
	(void)sig;
	(void)info;
	(void)ucontext;
	input_ready = 1;
}

static int setup_interval_timer(struct prof_state *state, int argc, char *argv[])
{
	struct itimerval itimer = {
		.it_interval	= { .tv_sec = state->delay, .tv_usec = 0, },
		.it_value	= { .tv_sec = 0, .tv_usec = 100*1000, },
	};
	struct sigaction act = {
		.sa_sigaction = action,
		.sa_flags = SA_SIGINFO | SA_RESTART,
	};

	(void)argc;
	(void)argv;
	sigemptyset(&act.sa_mask);
	if (sigaction(SIGALRM, &act, NULL))
		return errno;
	else if (setitimer(ITIMER_REAL, &itimer, NULL))
		return errno;
	act.sa_sigaction = quit;
	if (sigaction(SIGINT, &act, NULL))
		return errno;
	act.sa_sigaction = input;
	if (sigaction(SIGUSR1, &act, NULL))
		return errno;
	if ((state->iofd = dup(STDIN_FILENO)) < 0)
		return errno;
	else if (fcntl(state->iofd, F_SETFL, O_RDONLY|O_ASYNC|O_NONBLOCK) < 0)
		return errno;
	else if (fcntl(state->iofd, F_SETOWN, getpid()) < 0)
		return errno;
	else if (fcntl(state->iofd, F_SETSIG, SIGUSR1) < 0)
		return errno;
	return 0;
}

static void cleanup_interval_timer(struct prof_state *state)
{
	struct itimerval itimer;

	(void)state;
	if (!getitimer(ITIMER_REAL, &itimer)) {
		memset(&itimer.it_value, 0, sizeof(struct timeval));
		setitimer(ITIMER_REAL, &itimer, NULL);
	}
}
