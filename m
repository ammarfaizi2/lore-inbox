Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274019AbRISIwJ>; Wed, 19 Sep 2001 04:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274022AbRISIvv>; Wed, 19 Sep 2001 04:51:51 -0400
Received: from codepoet.org ([166.70.14.212]:64117 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S274019AbRISIvi>;
	Wed, 19 Sep 2001 04:51:38 -0400
Date: Wed, 19 Sep 2001 02:52:02 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Simon Kirby <sim@netnation.com>, linux-kernel@vger.kernel.org
Subject: Re: O_NONBLOCK on files
Message-ID: <20010919025201.A4300@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Simon Kirby <sim@netnation.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010918234648.A21010@netnation.com> <m1r8t3fyot.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <m1r8t3fyot.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.8-ac10-rmk1-rmk2, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed Sep 19, 2001 at 01:05:06AM -0600, Eric W. Biederman wrote:
> Simon Kirby <sim@netnation.com> writes:
> 
> > I've always wondered why it's not possible to do this:
> > 
> > fd = open("an_actual_file",O_RDONLY);
> > fcntl(fd,F_SETFL,O_NONBLOCK);
> > r = read(fd,buf,4096);
> > 
> > And actually have read return -1 and errno == EWOULDBLOCK/EAGAIN if the
> > block requested is not already cached.
> > 
> > Wouldn't this be the ideal interface for daemons of all types that want
> > to stay single-threaded and still offer useful performance when the
> > working set doesn't fit in cache?  It works with sockets, so why not
> > with files?
> 
> Besides the SUS or the POSIX specs...
> What would cause the data to be read in if read just checks the caches?
> With sockets the other side is clearing pushing or pulling the data.  With
> files there is no other side...
> 
> This is resolveable just not currently implemented.

I was actually playing around with this a few days back, since this would have
the advantage of 1) maximizing utilization of the bottleneck device and 2)
leave the app free to update a user interface etc while the kernel was busy
reading/writing.

There are two problems with a dd type app.  First the dd algorithm is
fundamentally serial -- read from A, stop, write to B, stop, rinse, repeat.
Second, it leaves the thread stuck in D state forever.  For example, try
something like
    dd if=/dev/sda of=/dev/sdb bs=1M
(assuming these devices are not holding important stuff) and let it run for a
bit and then hit ^C.  Then wait for a minute or two while the kernel finishes
flushing everything before dd finally exits... So to get sane stop behavior,
you have to minimize the buffer size (and add many minutes to the copy time),
while to maximize performance, you have to maximize the buffer size (goodbye
user friendly).

So are there no single threaded semantics by which one can copy from device
A to device B without blocking (thereby serializing the copy and leaving
the app unresponsive)?  I'd really hate to have to use threads to do this,

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, formerly of Lineo
--This message was written using 73% post-consumer electrons--

--QTprm0S8XgL7H0Dt
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="scopy.c"

/* vi: set sw=4 ts=4: */
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>
#include <signal.h>
#include <dirent.h>
#include <unistd.h>
#include <utime.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>

static const char *const app_name = "scopy";
static int intr_flag = 0;

static void verror_msg(const char *s, va_list p)
{
	fflush(stdout);
	fprintf(stderr, "%s: ", app_name);
	vfprintf(stderr, s, p);
}
static void vperror_msg(const char *s, va_list p)
{
	int err = errno;

	if (s == 0)
		s = "";
	verror_msg(s, p);
	if (*s)
		s = ": ";
	fprintf(stderr, "%s%s\n", s, strerror(err));
}

static void perror_msg_and_die(const char *s, ...)
{
	va_list p;

	va_start(p, s);
	vperror_msg(s, p);
	va_end(p);
	exit(EXIT_FAILURE);
}

static FILE *xfopen(const char *path, const char *mode)
{
	FILE *fp;

	if ((fp = fopen(path, mode)) == NULL)
		perror_msg_and_die("%s", path);
	return fp;
}

static void show_usage(void)
{
	fprintf(stderr, "Usage: scopy source dest\n");
	exit(EXIT_FAILURE);
}

static void sig_int(int signo)
{
	intr_flag = 1;
}

int main(int argc, char **argv)
{
	int status = 0;
	int opt;
	char *sname, *dname;
	fd_set rfds, wfds;
	FILE *source, *dest;
	int source_fd, dest_fd, n;
	ssize_t rsize = 0, wsize = 0;
	char buf[1024 * 1024];
	ssize_t bufsiz = sizeof(buf);
	struct timeval tv = { 0, 250000 };	/* 0.25 seconds */

	while ((opt = getopt(argc, argv, "adfipR")) != -1)
		switch (opt) {
		default:
			show_usage();
		}

	if (optind + 2 > argc)
		show_usage();

	/* If there are only two arguments and...  */
	if (optind + 2 != argc)
		show_usage();

	/* Store filenames for later use */
	sname = argv[optind++];
	dname = argv[optind];

	source = xfopen(sname, "r");
	dest = xfopen(dname, "w");
	source_fd = fileno(source);
	dest_fd = fileno(dest);

	/* Watch to see if things happen */
	FD_ZERO(&rfds);
	FD_ZERO(&wfds);
	n = (source_fd > dest_fd) ? source_fd + 1 : dest_fd + 1;

	if (fcntl(source_fd, F_SETFL, O_NONBLOCK) == -1)
		perror_msg_and_die("Setting O_NONBLOCK on %s", sname);
	if (fcntl(dest_fd, F_SETFL, O_NONBLOCK) == -1)
		perror_msg_and_die("Setting O_NONBLOCK on %s", dname);
	signal(SIGINT, sig_int);

	/* Ok, do the deed */
	while (1) {
		if (intr_flag) {
			printf("interrupted...  Please wait...\n");
			exit(EXIT_FAILURE);
		}
		FD_SET(fileno(source), &rfds);
		FD_SET(fileno(dest), &wfds);
		status = select(n, &rfds, &wfds, NULL, &tv);
		if (status < 0) {
			if (errno == EINTR) {
				printf("interrupted...  Please wait...\n");
				exit(EXIT_FAILURE);
			} else if (errno != EBADF) {
				perror_msg_and_die("select");
			}
		}

		if (FD_ISSET(source_fd, &rfds)) {
			rsize = read(source_fd, buf, bufsiz);
			if (rsize < 0)
				perror_msg_and_die("reading %d", sname);
			if (rsize == 0)
				exit(EXIT_SUCCESS);
		}
		if (FD_ISSET(dest_fd, &wfds)) {
			wsize = write(dest_fd, buf, rsize);
			if (wsize < 0)
				perror_msg_and_die("writing %s", dname);
			if (wsize == 0)
				exit(EXIT_SUCCESS);
		}

	}

	return 0;
}

--QTprm0S8XgL7H0Dt--
