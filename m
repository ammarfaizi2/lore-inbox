Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWJJO0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWJJO0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 10:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWJJO0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 10:26:13 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56525 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750806AbWJJO0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 10:26:13 -0400
Date: Tue, 10 Oct 2006 16:26:10 +0200
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] 2.6.19-rc1-git5: consolidation of file backed fault handlers
Message-ID: <20061010142610.GD2431@wotan.suse.de>
References: <20061010121314.19693.75503.sendpatchset@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010121314.19693.75503.sendpatchset@linux.site>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arh, bad subject: should be 2.6.19-rc1-mm1

On Tue, Oct 10, 2006 at 04:21:32PM +0200, Nick Piggin wrote:
> Has passed an allyesconfig on G5, and booted and stress tested (on ext3
> and tmpfs) on 2x P4 Xeon with my userspace tester (which I will send in
> a reply to this email). (stress tests run with the set_page_dirty_buffers
> fix that is upstream).

Anyway, here is the pagefault vs invalidate/truncate race finder. It
can trigger the bug introduced in patch 1/5 for both linear and nonlinear
mappings. After the patchset, I cannot reproduce.
--

#define _XOPEN_SOURCE 600
#include <sys/time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include <time.h>

#include <stdlib.h>
#include <signal.h>
#include <setjmp.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>

#define max(x, y) ((x) > (y) ? (x) : (y))

/* following 4 parameters: (1, 1, 7, 1) gives nonlinear bug */
/* (1, 0, 7, 1) for linear bug */
static int invalidate = 0;
static int nonlinear = 0;
static int faulters = 7;
static int samepage = 1;

#define O_DIRECT	00040000

#define FNAME		"dnp-inv.dat"
static int PAGE_SIZE;

static void error(const char *str)
{
	perror(str);
	exit(EXIT_FAILURE);
}

static void oom(void)
{
	fprintf(stderr, "Out of memory\n");
	exit(EXIT_FAILURE);
}

static sigjmp_buf SIGBUS_env;
static void SIGBUS_handler(int sig)
{
	siglongjmp(SIGBUS_env, 1);
}

static void dnp_child(int nr, int fd)
{
	time_t start;
	int i;
	struct sigaction sa = { .sa_handler = &SIGBUS_handler };
	if (sigemptyset(&sa.sa_mask) == -1)
		error("sigemptyset");
	if (sigaction(SIGBUS, &sa, NULL) == -1)
		error("sigaction");
 
	if (ftruncate(fd, PAGE_SIZE*faulters) == -1)
		error("ftruncate");

	i = 0;
	for (;;) {
		volatile long *lock;
		char *mem;

		if (i > 100) {
			i = 0;
			printf(".");
			fflush(stdout);
		}

		start = time(NULL);

		mem = mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE,
						MAP_SHARED, fd, (samepage && !nonlinear) ? 0 : PAGE_SIZE*nr);
		if (mem == MAP_FAILED)
			error("mmap");

		if (nonlinear) {
			if (remap_file_pages(mem, PAGE_SIZE, 0, samepage ? 0 : faulters-nr, 0) == -1)
				goto next;
		}
		lock = mem;
		lock += nr;

		if (!sigsetjmp(SIGBUS_env, 1)) {
			static int stuck = 0;
			int l;
			*lock = 1;

			for (l = 0; *lock; l++) {
				if (!stuck) {
					time_t delta;
					delta = time(NULL) - start;
					if (delta > 10) {
						stuck = 1;
						fprintf(stderr, "page stuck\n");
						exit(EXIT_FAILURE);
					}
				}
				if (l > 1000)	
					usleep(1);
			}
			if (stuck)
				fprintf(stderr, "page unstuck\n");

			i++;
		}

next:
		if (munmap(mem, PAGE_SIZE) == -1)
			error("munmap");
	}
}

static void trunc_child(int fd)
{
	int k;
	char buf = 0;

	for (k = 0;; k++) {
		int i;
		int err;

		if (k > 1000) {
			k = 0;
			printf("+");
			usleep(1*1000*1000);
			fflush(stdout);
		}

		if (ftruncate(fd, 0) == -1)
			error("ftruncate");
		if (ftruncate(fd, PAGE_SIZE*faulters) == -1)
			error("ftruncate");

		for (i = 0; i < (samepage?1:faulters); i++) {
			time_t start = time(NULL);
			do {
				time_t delta;
				err = pwrite(fd, &buf, 1, PAGE_SIZE*i);

				delta = time(NULL) - start;
				if (delta > 10) {
					fprintf(stderr, "write stuck\n");
					break;
				}
			} while (err == -1 /* && errno == EINTR */);
			if (err == -1)
				error("write");
			if (err != 1)
				fprintf(stderr, "Partial write? %d\n", err), exit(EXIT_FAILURE);
		}

	}
}

static void inv_child(int fd)
{
	int k;
	char *buf;
	int flags;

	if (posix_memalign(&buf, PAGE_SIZE, PAGE_SIZE) != 0)
		oom();

	if (ftruncate(fd, PAGE_SIZE*faulters) == -1)
		error("ftruncate");

	flags = fcntl(fd, F_GETFL);
	if (flags == -1)
		error("fcntl");
	if (fcntl(fd, F_SETFL, flags|O_DIRECT) == -1)
		error("fcntl");

	memset(buf, 0, PAGE_SIZE);

	for (k = 0;; k++) {
		int i;
		int err;

		if (k > 100) {
			k = 0;
			printf("+");
			usleep(1*1000*1000);
			fflush(stdout);
		}

		for (i = 0; i < (samepage?1:faulters); i++) {
			time_t start = time(NULL);
			do {
				time_t delta;

				err = pwrite(fd, buf, PAGE_SIZE, PAGE_SIZE*i);

				delta = time(NULL) - start;

				if (delta > 10) {
					fprintf(stderr, "write stuck\n");
					break;
				}
			} while (err == -1 /* && errno == EINTR */);
			if (err == -1)
				error("write");
			if (err != PAGE_SIZE)
				fprintf(stderr, "Partial write? %d\n", err), exit(EXIT_FAILURE);
		}
	}
}

int main(void)
{
	int i;
	int fd, err;

	PAGE_SIZE = getpagesize();

	fd = open(FNAME, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
	if (fd == -1)
		error("open");

	for (i = 0; i < faulters; i++) {
		err = fork();
		if (err == -1)
			error("fork");
		if (!err) {
			//nice(20);
			dnp_child(i, fd);
			exit(EXIT_SUCCESS);
		}
	}

#if 1
	if (invalidate)
		inv_child(fd);
	else
		trunc_child(fd);
#endif
	sleep(10);

	if (close(fd) == -1)
		error("close");

	exit(EXIT_SUCCESS);
}

