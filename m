Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753817AbWKFVVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbWKFVVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753816AbWKFVVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:21:23 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:58291 "EHLO Smtp.neuf.fr")
	by vger.kernel.org with ESMTP id S1753817AbWKFVVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:21:22 -0500
Date: Mon, 06 Nov 2006 22:17:37 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
In-reply-to: <20061102080122.GA1302@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: zhou drangon <drangon.mail@gmail.com>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Message-id: <454FA671.7000204@cosmosbay.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_T+lzm35Dy9FWPcVK6ElZkA)"
References: <20061101130614.GB7195@atrey.karlin.mff.cuni.cz>
 <20061101132506.GA6433@2ka.mipt.ru> <20061101160551.GA2598@elf.ucw.cz>
 <20061101162403.GA29783@2ka.mipt.ru> <slrnekhpbr.2j1.olecom@flower.upol.cz>
 <20061101185745.GA12440@2ka.mipt.ru>
 <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com>
 <aaf959cb0611011829k36deda6ahe61bcb9bf8e612e1@mail.gmail.com>
 <aaf959cb0611011830j1ca3e469tc4a6af3a2a010fa@mail.gmail.com>
 <4549A261.9010007@cosmosbay.com> <20061102080122.GA1302@2ka.mipt.ru>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_T+lzm35Dy9FWPcVK6ElZkA)
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 8BIT

Evgeniy Polyakov a écrit :
> 
> If there would exist sockets support, then I could patch it to work with
> kevents.
> 

OK I post here my last version of epoll_bench.

It works with pipes (default),
or AF_UNIX socketpair() (option -u),
or AF_INET sockets (on loopback device), (option -i)
Only one machine involved (so no real ethernet trafic, and a limit on max 
number of AF_INET sockets since I use one listener 'only')

Option -f ask to bypass epoll.

On a dual opteron 246 machine (2GHZ cpu, 1MB of cache on each cpu, but 
somewhat busy 2.6.18 )

Perf for 2000 concurrent streams is :

259643 evts/sec for pipes
170188 evts/sec for AF_UNIX sockets (-u)
58771 evts/sec for AF_INET sockets (-i)
69475 evts/sec for AF_INET and no epoll gathering at all. (-i -f)

I believe difference between AF_INET sockets and other streams come from 
synchronous/asynchronous wakeups :
I added counters of context switches per second and also number of events 
handled per epoll_wait() call, and we can see that in AF_INET case, the 
consumer is awaken more often. That means lower latency, but less bandwidth alas.

Detailed Results :
pipe
# ./epoll_bench -n 2000
2000 handles setup
255320 evts/sec 362.074 samples per call
254054 evts/sec 10473 ctxt/sec 381.569 samples per call
249868 evts/sec 9155 ctxt/sec 407.461 samples per call
181010 evts/sec 22656 ctxt/sec 420.36 samples per call
233368 evts/sec 8565 ctxt/sec 348.773 samples per call
284682 evts/sec 11114 ctxt/sec 299.987 samples per call
292485 evts/sec 10235 ctxt/sec 279.042 samples per call
279194 evts/sec 10760 ctxt/sec 267.694 samples per call
267917 evts/sec 12035 ctxt/sec 264.106 samples per call
291450 evts/sec 11024 ctxt/sec 247.028 samples per call
266837 evts/sec 11732 ctxt/sec 241.915 samples per call
272762 evts/sec 11492 ctxt/sec 247.629 samples per call
253756 evts/sec 11011 ctxt/sec 253.395 samples per call
251250 evts/sec 9912 ctxt/sec 259.88 samples per call
260706 evts/sec 10754 ctxt/sec 265.079 samples per call
Avg: 259643 evts/sec

  AF_UNIX
# ./epoll_bench -n 2000 -u
2000 handles setup
264827 evts/sec 6.01538 samples per call
259241 evts/sec 15682 ctxt/sec 5.70332 samples per call
262266 evts/sec 17072 ctxt/sec 5.64829 samples per call
262730 evts/sec 16744 ctxt/sec 5.43087 samples per call
253212 evts/sec 17343 ctxt/sec 5.14736 samples per call
255219 evts/sec 17579 ctxt/sec 5.0197 samples per call
166655 evts/sec 13090 ctxt/sec 5.27575 samples per call
111348 evts/sec 10127 ctxt/sec 5.61362 samples per call
104812 evts/sec 9476 ctxt/sec 5.93361 samples per call
95897 evts/sec 8876 ctxt/sec 6.22481 samples per call
97096 evts/sec 9372 ctxt/sec 6.51874 samples per call
113808 evts/sec 11142 ctxt/sec 6.86422 samples per call
102509 evts/sec 10035 ctxt/sec 7.17618 samples per call
100318 evts/sec 9731 ctxt/sec 7.47926 samples per call
102893 evts/sec 9458 ctxt/sec 7.78841 samples per call
Avg: 170188 evts/sec

AF_INET
# ./epoll_bench -n 2000 -i
2000 handles setup
69210 evts/sec 2.97224 samples per call
59436 evts/sec 12876 ctxt/sec 5.48675 samples per call
60722 evts/sec 12093 ctxt/sec 8.03185 samples per call
60583 evts/sec 14582 ctxt/sec 10.5644 samples per call
58192 evts/sec 12066 ctxt/sec 12.999 samples per call
54291 evts/sec 10613 ctxt/sec 15.2398 samples per call
47978 evts/sec 10942 ctxt/sec 17.2222 samples per call
59009 evts/sec 13692 ctxt/sec 19.6426 samples per call
58248 evts/sec 15099 ctxt/sec 22.0306 samples per call
58708 evts/sec 15118 ctxt/sec 24.4497 samples per call
58613 evts/sec 14608 ctxt/sec 26.816 samples per call
58490 evts/sec 13593 ctxt/sec 29.1708 samples per call
59108 evts/sec 15078 ctxt/sec 31.5557 samples per call
59636 evts/sec 15053 ctxt/sec 33.9292 samples per call
59355 evts/sec 15531 ctxt/sec 36.2914 samples per call
Avg: 58771 evts/sec

The last sample shows that epoll overhead is very small indeed, since 
disabling it doesnt boost AF_INET perf at all.
AF_INET + no epoll
# ./epoll_bench -n 2000 -i -f
2000 handles setup
79939 evts/sec
78468 evts/sec 9989 ctxt/sec
73153 evts/sec 10207 ctxt/sec
73668 evts/sec 10163 ctxt/sec
73667 evts/sec 20084 ctxt/sec
74106 evts/sec 10068 ctxt/sec
73442 evts/sec 10119 ctxt/sec
74220 evts/sec 10122 ctxt/sec
74367 evts/sec 10097 ctxt/sec
64402 evts/sec 47873 ctxt/sec
53555 evts/sec 58733 ctxt/sec
46000 evts/sec 48984 ctxt/sec
67052 evts/sec 21006 ctxt/sec
68460 evts/sec 12344 ctxt/sec
67629 evts/sec 10655 ctxt/sec
Avg: 69475 evts/sec

I add here oprofile results for the AF_INET (with epoll) test

CPU: AMD64 processors, speed 1992.3 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Cycles outside of halt state) with a unit 
mask of 0x00 (No unit mask) count 50000
samples  %        symbol name
1127210   9.1969  tcp_sendmsg
692516    5.6502  fget_light
598653    4.8844  lock_sock
575396    4.6946  __tcp_push_pending_frames
364699    2.9756  tcp_ack
364352    2.9727  tcp_v4_rcv
356383    2.9077  ipt_do_table
324388    2.6467  do_sync_write
257869    2.1039  wait_on_retry_sync_kiocb
255977    2.0885  inet_sk_rebuild_header
255171    2.0819  tcp_recvmsg
249554    2.0361  copy_user_generic_c
232551    1.8974  tcp_transmit_skb
215471    1.7580  release_sock
208563    1.7017  tcp_window_allows
194983    1.5909  kfree
186842    1.5244  system_call
180074    1.4692  kmem_cache_free
160799    1.3120  ep_poll_callback
159235    1.2992  update_send_head
134291    1.0957  sys_epoll_wait
133670    1.0906  ip_queue_xmit
132829    1.0837  ret_from_sys_call
129348    1.0553  __mod_timer
129258    1.0546  sys_write
117884    0.9618  tcp_rcv_established
115181    0.9398  tcp_poll
102805    0.8388  memcpy
99017     0.8079  skb_clone
91125     0.7435  vfs_write
87087     0.7105  __kfree_skb
75387     0.6151  tcp_mss_to_mtu
72483     0.5914  init_or_fini
72207     0.5891  do_sync_read
72054     0.5879  tcp_ioctl
70555     0.5757  local_bh_enable_ip
70001     0.5711  tg3_start_xmit_dma_bug
69914     0.5704  ip_local_deliver
69002     0.5630  tcp_v4_do_rcv
68681     0.5604  dev_queue_xmit
68411     0.5582  do_ip_getsockopt
68235     0.5567  skb_copy_datagram_iovec
66489     0.5425  local_bh_enable

oprofile results for the pipe case :
(where epoll is not noise)

CPU: AMD64 processors, speed 1992.3 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Cycles outside of halt state) with a unit 
mask of 0x00 (No unit mask) count 50000
samples  %        symbol name
1346203  12.2441  ep_poll_callback
1220770  11.1033  pipe_writev
1020377   9.2806  sys_epoll_wait
991913    9.0218  pipe_readv
779611    7.0908  fget_light
638929    5.8113  __wake_up
625332    5.6876  current_fs_time
486427    4.4242  __mark_inode_dirty
385763    3.5086  __write_lock_failed
217402    1.9773  system_call
175292    1.5943  sys_write
153698    1.3979  __wake_up_common
153242    1.3938  bad_pipe_w
143597    1.3061  generic_pipe_buf_map
140814    1.2807  pipe_poll
130028    1.1826  ret_from_sys_call
122930    1.1181  do_pipe
122359    1.1129  copy_user_generic_c
107443    0.9772  file_update_time
106037    0.9644  sysret_check
101256    0.9210  sys_read
99176     0.9020  iov_fault_in_pages_read
96823     0.8806  generic_pipe_buf_unmap
96675     0.8793  vfs_write
64635     0.5879  rw_verify_area
62997     0.5730  pipe_ioctl
60983     0.5547  tg3_start_xmit_dma_bug
59624     0.5423  get_task_comm
49573     0.4509  tg3_poll
46041     0.4188  schedule
44321     0.4031  vfs_read
35962     0.3271  eventpoll_release_file
30267     0.2753  tg3_write_flush_reg32
29395     0.2674  ipt_do_table
27683     0.2518  page_to_pfn
27492     0.2500  touch_atime
24921     0.2267  memcpy


Eric

--Boundary_(ID_T+lzm35Dy9FWPcVK6ElZkA)
Content-type: text/plain; name=epoll_bench.c
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=epoll_bench.c

/*
 * How to stress epoll
 *
 * This program uses many pipes|sockets and two threads.
 * First we open as many pipes|sockets we can. (see ulimit -n)
 * Then we create a worker thread.
 * The worker thread will send bytes to random streams.
 * The main thread uses epoll to collect ready events and clear them, reading streams.
 * Each second, a number of collected events is printed on stderr
 * After one minute, program prints an average value and stops.
 *
 * Usage : epoll_bench [-f] [-{u|i}] [-n X]
 *   -f : No epoll loop, just feed streams in a cyclic manner
 *   -u : Use AF_UNIX sockets (instead of pipes)
 *   -i : Use AF_INET sockets
 */
#include <pthread.h>
#include <stdlib.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <sys/epoll.h>
#include <signal.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/socket.h>
# include <netinet/in.h>
#include <fcntl.h>
#include <sys/ioctl.h>

int nbhandles = 1024;
int time_test = 15;
unsigned long nbhandled;
unsigned long epw_samples;
unsigned long epw_samples_cnt;

struct pipefd {
	int fd[2];
} *tab;

int epoll_fd;
int fflag;
int afunix;
int afinet;

static int alloc_streams()
{
	int i;
	int listen_sock;
	struct sockaddr_in me, to;
	socklen_t namelen;
    int on = 1;
	int off = 0;

	if (!fflag) {
		epoll_fd = epoll_create(nbhandles);
		if (epoll_fd == -1) {
			perror("epoll_create");
			return -1;
		}
	}
	tab = malloc(sizeof(struct pipefd) * nbhandles);
	if (tab == NULL) {
		perror("malloc");
		return -1;
	}
	if (afinet) {
		listen_sock = socket(AF_INET, SOCK_STREAM, 0);
		if (listen_sock == -1) {
			perror("socket");
			return -1;
		}
		if (listen(listen_sock, 256) == -1) {
			perror("listen");
			return -1;
		}
		namelen = sizeof(me);
		getsockname(listen_sock, (struct sockaddr *)&me, &namelen);
	}
	for (i = 0 ; i < nbhandles ; i++) {
		if (afinet) {
			tab[i].fd[0] = socket(AF_INET, SOCK_STREAM, 0);
			if (tab[i].fd[0] == -1)
				break;
			to = me;
			ioctl(tab[i].fd[0], FIONBIO, &on);
			if (connect(tab[i].fd[0], (struct sockaddr *)&to, sizeof(to)) != -1 || errno != EINPROGRESS)
				break;
			tab[i].fd[1] = accept(listen_sock, (struct sockaddr *)&to, &namelen);
			if (tab[i].fd[1] == -1)
				break;
			ioctl(tab[i].fd[0], FIONBIO, &off);
		}
		else if (afunix) {
			if (socketpair(AF_UNIX, SOCK_STREAM, 0, tab[i].fd) == -1)
				break;
		} else {
			if (pipe(tab[i].fd) == -1)
				break;
		}
		if (!fflag) {
			struct epoll_event ev;
			ev.events = EPOLLIN | EPOLLET;
			ev.data.u64 = (uint64_t)i;
			epoll_ctl(epoll_fd, EPOLL_CTL_ADD, tab[i].fd[0], &ev);
		}
	}
	nbhandles = i;
	printf("%d handles setup\n", nbhandles);
	return 0;
}

int sample_proc_stat(long *ctxt)
{
	int fd = open("/proc/stat", 0);
	char buffer[4096+1], *p;
	int lu;
	*ctxt = 0;
	if (fd == -1) {
		perror("/proc/stat");
		return -1;
	}
	lu = read(fd, buffer, sizeof(buffer));
	close(fd);
	if (lu < 10)
		return -1;
	buffer[lu] = 0;
	p = strstr(buffer, "ctxt");
	if (p)
		*ctxt = atol(p + 4);
	return 0;
}


static void timer_func()
{
	char buffer[128];
	size_t len;
	static unsigned long old;
	static unsigned long oldctxt=0;
	unsigned long ctxt;
	unsigned long delta = nbhandled - old;
	static int alarm_events = 0;

	old = nbhandled;
	len = sprintf(buffer, "%lu evts/sec", delta);
	sample_proc_stat(&ctxt);
	delta = ctxt - oldctxt;
	if (delta && oldctxt)
		len += sprintf(buffer + len, " %lu ctxt/sec", delta);
	oldctxt = ctxt;
	if (epw_samples)
		len += sprintf(buffer + len, " %g samples per call", (double)epw_samples_cnt/(double)epw_samples);
	buffer[len++] = '\n';
	write(2, buffer, len);
	if (++alarm_events >= time_test) {
		delta = nbhandled/alarm_events;
		len = sprintf(buffer, "Avg: %lu evts/sec\n", delta);
		write(2, buffer, len);
		exit(0);
	}
}

static void timer_setup()
{
	struct itimerval it;
	struct sigaction sg;

	memset(&sg, 0, sizeof(sg));
	sg.sa_handler = timer_func;
	sigaction(SIGALRM, &sg, 0);
	it.it_interval.tv_sec = 1;
	it.it_interval.tv_usec = 0;
	it.it_value.tv_sec = 1;
	it.it_value.tv_usec = 0;
	if (setitimer(ITIMER_REAL, &it, 0))
		perror("setitimer");
}

static void * worker_thread_func(void *arg)
{
	int fd = -1;
	char c = 1;
	int cnt = 0;
	nice(10);
	for (;;) {
		if (fflag)
			fd = (fd + 1) % nbhandles;
		else
			fd = rand() % nbhandles;
		write(tab[fd].fd[1], &c, 1);
		if (++cnt >= nbhandles) {
			cnt = 0 ;
			pthread_yield(); /* relax :) */
			}
	}
}

void usage(int code)
{
	fprintf(stderr, "Usage : epoll_bench [-n num] [-{u|i}] [-f] [-t duration] [-l limit] [-e maxepoll]\n");
	exit(code);
}

int main(int argc, char *argv[])
{
	char buff[1024];
	pthread_t tid;
	int c, fd;
	int limit = 1000;
	int max_epoll = 1024;

	while ((c = getopt(argc, argv, "fuin:l:e:t:")) != EOF) {
		if (c == 'n') nbhandles = atoi(optarg);
		else if (c == 'f') fflag++;
		else if (c == 'l') limit = atoi(optarg);
		else if (c == 'e') max_epoll = atoi(optarg);
		else if (c == 't') time_test = atoi(optarg);
		else if (c == 'u') afunix++;
		else if (c == 'i') afinet++;
		else usage(1);
	}
	alloc_streams();
	pthread_create(&tid, NULL, worker_thread_func, (void *)0);
	timer_setup();

	if (fflag) {
		for (fd = 0;;fd = (fd + 1) % nbhandles) {
			if (read(tab[fd].fd[0], buff, 1024) > 0)
				nbhandled++;
			}
		}
	else {
		struct epoll_event *events;
		events = malloc(sizeof(struct epoll_event) * max_epoll) ;
		for (;;) {
			int nb = epoll_wait(epoll_fd, events, max_epoll, -1);
			int i;
			epw_samples++;
			epw_samples_cnt += nb;
			for (i = 0 ; i < nb ; i++) {
				fd = tab[events[i].data.u64].fd[0];
				if (read(fd, buff, 1024) > 0)
					nbhandled++;
			}
			if (nb < limit)
				pthread_yield();
		}
	}
}

--Boundary_(ID_T+lzm35Dy9FWPcVK6ElZkA)--
