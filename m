Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269104AbUIHLKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269104AbUIHLKE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269105AbUIHLKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:10:04 -0400
Received: from holomorphy.com ([207.189.100.168]:57766 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269104AbUIHLHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:07:40 -0400
Date: Wed, 8 Sep 2004 04:07:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [test] pagetable OOM handling (again, but 64-bit this time)
Message-ID: <20040908110718.GX3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

/*
 * This appears to panic an Altix. An earlier version of this without
 * the VSZ limiting appeared to panic a 4x logical x86-64 box, and yet
 * another version panicked an E3K. panic string:
 * "Kernel panic - not syncing: Out of memory and no killable processes..."
 * The basic idea is to keep mm->total_vm low enough to evade VSZ rlimits
 * and avoid the OOM killer long enough to get into a state where the
 * SIGKILL will be ignored. mm->total_vm is kept low with the 1 pte per
 * pmd trick. Getting into 'D' state is done by faulting in pte pages.
 * It also relies on a race that clobbers PF_MEMDIE instead of getting
 * stuck in a non-allocating codepath where it waits in 'D' state in
 * order to ignore signals. "Normally" the task->flags setting works;
 * however, the restoration of ->flags after the try_to_free_pages()
 * call in __alloc_pages() causes tasks to honor OOM kills while they
 * don't honor signals per se; the race means that if it's caught
 * between the the load and the store of the restoration (x86 addressing
 * modes make this either far less likely or impossible) PF_MEMDIE is
 * lost. To do this more reliably on x86-64 finding another way to get
 * into 'D' state outside the allocator for a sacrificial victim or
 * something on that order is needed. Having little enough RAM to be
 * able to use the VSZ of pid 1 as a limit would also work. Of course,
 * I can't be 100% certain how it does what it does without more
 * instrumentation, but these things are at least what motivated how I
 * wrote it. Originally zeromap_page_range() on a large (ca. 512GB)
 * virtual area and fork() of only a few processes was what triggered
 * the panic() (and much faster than this does on ia64), but that
 * didn't seem to do anything on x86-64. Altix' console log included.
 * This test is useless on 32-bit architectures.
 */
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <sys/mman.h>
#include <sys/stat.h>

extern char _end[];

static int nr_signals;

void ignore(int sig, siginfo_t *info, void *ucontext)
{
	(void)sig;
	(void)info;
	(void)ucontext;
	++nr_signals;
}

int main(void)
{
	long page_size, pmd_size, physpages, pages, nr_children, max_fds,
		init_vsz, total_vsz = 0;
	char *start, *p, *end, *pos;
	const int flags = MAP_ANONYMOUS|MAP_PRIVATE|MAP_FIXED,
				prot = PROT_READ|PROT_WRITE;
	int fd, *child_fds, child;
	struct sigaction action = {
		.sa_sigaction = ignore,
		.sa_flags = SA_SIGINFO,
	};
	FILE *file;

	file = fopen("/proc/1/status", "r");
	if (!file) {
		fprintf(stderr, "couldn't open /proc/1/status\n");
		exit(EXIT_FAILURE);
	} else {
		char *buf = NULL;
		size_t bufsz;

		while (getline(&buf, &bufsz, file) > 0) {
			if (sscanf(buf, "VmSize: %ld", &init_vsz) == 1) {
				init_vsz <<= 17;
				fclose(file);
				goto self_vsz;
			}
		}
		fprintf(stderr, "failed to parse /proc/1/status\n");
		exit(EXIT_FAILURE);
self_vsz:
		if (!(file = fopen("/proc/self/status", "r"))) {
			fprintf(stderr, "couldn't open /proc/self/status\n");
			exit(EXIT_FAILURE);
		}
		while (getline(&buf, &bufsz, file) > 0) {
			if (sscanf(buf, "VmSize: %ld", &total_vsz) == 1) {
				total_vsz <<= 10;
				fclose(file);
				free(buf);
				goto setup;
			}
		}
		fprintf(stderr, "failed to parse /proc/self/status\n");
		exit(EXIT_FAILURE);
	}
setup:
	nr_signals = 0;
	sigemptyset(&action.sa_mask);
	sigaction(SIGSEGV, &action, NULL);
	sigaction(SIGBUS, &action, NULL);
	setvbuf(stdin, NULL, _IONBF, 0);
	setvbuf(stdout, NULL, _IONBF, 0);
	setvbuf(stderr, NULL, _IONBF, 0);
	fd = open("/dev/zero", O_RDONLY|O_NOCTTY);
	if ((page_size = sysconf(_SC_PAGE_SIZE)) < 0)
		exit(EXIT_FAILURE);
	pmd_size = (page_size*page_size)/sizeof(long);
	start = (char *)(((long)_end + pmd_size - 1) & ~(pmd_size - 1));
	if ((unsigned long)start < (unsigned long)_end + page_size)
		start = start + pmd_size - page_size;
	else
		start -= page_size;
	printf("pmd_size = 0x%lx\n", pmd_size);
	printf("pgdir_size = 0x%lx\n", pmd_size*page_size/sizeof(long));
	close(STDIN_FILENO);
	close(STDOUT_FILENO);
	/* close(STDERR_FILENO); */
	if (fork())
		exit(EXIT_SUCCESS);
	setsid();
	pos = start;
	while ((p = mmap(pos, 2*page_size, prot, flags, 0, 0)) != MAP_FAILED &&
			total_vsz < init_vsz) {
		pos += 2*pmd_size;
		total_vsz += 2*page_size;
		if ((long)pos < 0) {
			fprintf(stderr, "starting address wrapped\n");
			break;
		} else if (pos >= (char *)((long)&p & ~(pmd_size - 1))) {
			fprintf(stderr, "starting address hit the stack\n");
			break;
		}
	}
	end = pos;
	if ((physpages = sysconf(_SC_PHYS_PAGES)) < 0) {
		FILE *file;
		char *buf = NULL;
		size_t bufsz;

		fprintf(stderr, "sysconf(_SC_PHYS_PAGES) failed, ret = %ld\n",
				physpages);
		fprintf(stderr, "trying to parse /proc/meminfo\n");
		file = fopen("/proc/meminfo", "r");
		if (!file) {
			fprintf(stderr, "failed to open /proc/meminfo\n");
			exit(EXIT_FAILURE);
		}
		if (getline(&buf, &bufsz, file) <= 0) {
			fprintf(stderr, "failed to read first line of /proc/meminfo\n");
			exit(EXIT_FAILURE);
		}
		if (sscanf(buf, "MemTotal: %ld", &physpages) != 1) {
			fprintf(stderr, "failed to parse first line of /proc/meminfo\n");
			exit(EXIT_FAILURE);
		}
		if (physpages <= 0) {
			fprintf(stderr, "parsed /proc/meminfo, but result was crap\n");
			exit(EXIT_FAILURE);
		}
		fclose(file);
		free(buf);
	}
	if ((max_fds = sysconf(_SC_OPEN_MAX)) < 0) {
		fprintf(stderr, "sysconf(_SC_OPEN_MAX) failed\n");
		exit(EXIT_FAILURE);
	}
	pages = (end - start)/pmd_size;
	nr_children = (physpages + pages - 1)/pages;
	fprintf(stderr, "blocking\n");
	fprintf(stderr, "start = %p, end = %p\n", start, end);
	fprintf(stderr, "%ld physical pages\n", physpages);
	fprintf(stderr, "%ld pagetable pages per process\n", pages);
	fprintf(stderr, "%ld children needed to exhaust RAM\n", nr_children);
	fprintf(stderr, "%ld open files maximum\n", max_fds);
	fprintf(stderr, "%ld KB VSZ per process\n", total_vsz >> 10);
	nr_children *= 8;
	if (nr_children*sizeof(int [2]) > (size_t)(2*page_size)) {
		fprintf(stderr, "Either your kernel port or your arch sucks\n"
				"You need more than two pages worth of "
				"storage to hold the fd's to communicate "
				"with the children\n"
				"This thing wants %ld fd's, %zd bytes of "
				"RAM to store them, and thinks the "
				"page size on your box is %ld\n",
				2*nr_children,
				nr_children*sizeof(int [2]),
				page_size);
		exit(EXIT_FAILURE);
	}
	if (2*nr_children + 1 > max_fds) {
		fprintf(stderr, "Either your rlimits are utterly retarded "
				"or your arch sucks. You have an open fd "
				"limit of %ld fd's per process and this "
				"thing wants to spawn %ld processes, and "
				"open 2 fd's for each for %ld total fd's.\n",
				max_fds,
				nr_children,
				2*nr_children);
	}
	if ((child = fork()) < 0)
		exit(EXIT_FAILURE);
	else if (child)
		exit(EXIT_SUCCESS);
	else
		setsid();
	child_fds = (int *)start;
	for (child = 0; child < nr_children; ++child) {
		if (pipe(&child_fds[2*child])) {
			fprintf(stderr, "pipe(2) failed, bailing out\n");
			exit(EXIT_FAILURE);
		}
	}
	for (child = 0; child < nr_children; ++child) {
		pid_t pid = fork();

		if (pid < 0)
			fprintf(stderr, "fork() appears to have failed "
					"for child %d\n",
					child);
		else if (!pid) {
			char c;

			read(child_fds[2*child], &c, 1);
			action.sa_sigaction = ignore,
			action.sa_flags = SA_SIGINFO,
			sigemptyset(&action.sa_mask);
			sigaction(SIGSEGV, &action, NULL);
			sigaction(SIGBUS, &action, NULL);
			sigfillset(&action.sa_mask);
			sigprocmask(SIG_BLOCK, &action.sa_mask, NULL);
			for (pos = start; pos < end; pos += 2*pmd_size) {
				if (*pos && pos - start >= pmd_size)
					fprintf(stderr, "bad kernel!\n"
						"zeromapped memory appears to "
						"be corrupted! (check 1)\n");
				if (pos[page_size] && pos - start >= pmd_size)
					fprintf(stderr, "bad kernel!\n"
						"zeromapped memory appears to "
						"be corrupted! (check 1)\n");
			}
			pause();
			return EXIT_SUCCESS;
		}
	}
	for (pos = start + pmd_size; pos < end; pos += pmd_size)
		munmap(pos, 2*page_size);
	for (child = 0; child < nr_children; ++child) {
		char c = '\0';

		fprintf(stderr, "pretending to wake child %d\n", child);
		write(child_fds[2*child+1], &c, 1);
	}
	/*
	 * The parent now offers itself as the sacrificial victim to be
	 * OOM killed in the place of its children.
	 */
	start += pmd_size;
	p = mmap(start, (((size_t)&child) & ~(pmd_size - 1)) - (size_t)start,
			PROT_READ, MAP_PRIVATE|MAP_FIXED, fd, 0);
	if (p == MAP_FAILED)
		fprintf(stderr, "mmap in parent failed!\n");
	close(fd);
	pause();
	return EXIT_SUCCESS;
}

--TybLhxa8M7aNoW+V
Content-Type: application/octet-stream
Content-Description: altix.log.51.bz2
Content-Disposition: attachment; filename="altix.log.51.bz2"
Content-Transfer-Encoding: base64

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
C1GDLGIy2nWxi6ypbXWU1kJWysa1UUWjbJKFtCsgVFGlKiWlWDmUwWShOvMzAo9XXUUUmm7S
1dnTt003dhal3cqbly4bNNaiOcrt6Y7rrd44XS7FNLGVEnpeKXnTKYg2Jl2tta2SVU1Gmcil
twqWlHWtTOWGdDljy7pIvXdukUG8XkePTyvEhTSg2u9GvU2EgDY1eCus0bJtSV4iJTc3ja5X
d1XjMt1OlIMBtlybApe2BO3HKsVOLWpXdQyqqVLaszqUOZ2puuKbOpzEVdQ7PJis5CiDm5WI
KxM7BVVUa1WKy3YCxYxHIsjDCrLAxx51S+cisdet5ShWBH4+BUc5xSo6VHfxgKj81Cu7b037
YitKFbwrRCs8br2BWMVCsGWZv9bpdhEoX8Lrvj9PPfVVFzIr0hWVIViy5iSMueeT3lR2lHvc
pJVzZr0Ionlbykh+a+NzzQrFbPl1umlpabm/IiRrQrWhI27t3j3zUzQr8YqqLjcCRx0ryVVQ
rsIrqtNW74ZESPeRXDS4CSOFCupUrW7PfVVCtSJGVjMiULO48grohXHF55TGftIrK5Y7buWK
FYwhPzFRgkr0hHfBUdFVV9MiRty5VKFd1UlC4SgM0K/K67stipW+0+WhXZEBt59pEjJv9tCt
28SRhohXVlkRI8+vbQrbQrmSMVStoKxihXcRIx4evGrTuxoRI3XX8+mTpcrOSrkqPb3x/9GD
B7FK+2+JUe510I+zr29nPH0fEqPl+79DfJ0BUakkauNCsUKxbwrWqqhXVsCoZkCoXUUReMSP
O5CCCKnPOAio+sqMEip5fB8KSvdyCuy3br+NCurshAYx1IShfUhXXbqFeL3UU2hWLneupQrj
RQgFQ9hhOc+H/xdyRThQkCTU/0A=

--TybLhxa8M7aNoW+V--
