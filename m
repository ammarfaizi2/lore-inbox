Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTFJWYf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 18:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbTFJWYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 18:24:35 -0400
Received: from sb0-cf9a4970.dsl.impulse.net ([207.154.73.112]:12037 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S261411AbTFJWYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 18:24:31 -0400
Subject: Re: Large files
From: Ray Lee <ray-lk@madrabbit.org>
To: root@chaos.analogic.com, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-emoq6w94x3cHLRzS2snQ"
Message-Id: <1055284691.1177.4.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 10 Jun 2003 15:38:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-emoq6w94x3cHLRzS2snQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> With 32 bit return values, ix86 Linux has a file-size limitation 
> which is currently about 0x7fffffff. Unfortunately, instead of 
> returning from a write() with a -1 and errno being set, so that 
> a program can do something about it, write() executes a signal(25) 
> which kills the task even if trapped

Works For Me(tm)

        ray:~/work/test/signals$ ls
        sig.c
        ray:~/work/test/signals$ tcc -run sig.c
        write errored
        seem to have gone overboard, switching to next log file...
        write errored
        seem to have gone overboard, switching to next log file...
        write errored
        seem to have gone overboard, switching to next log file...
        ray:~/work/test/signals$ ls -l
        total 4
        -rw-------    1 ray      ray      2147483647 Jun 10 15:35 log.0
        -rw-------    1 ray      ray      2147483647 Jun 10 15:35 log.1
        -rw-------    1 ray      ray      2147483647 Jun 10 15:35 log.2
        -rw-------    1 ray      ray           259 Jun 10 15:35 log.3
        -rw-r--r--    1 ray      ray          2119 Jun 10 15:33 sig.c
        ray:~/work/test/signals$
        
Test code attached. Please excuse the somewhat haphazard structure, it
was tossed together from code I'd written for other projects.

Ray


--=-emoq6w94x3cHLRzS2snQ
Content-Disposition: attachment; filename=sig.c
Content-Type: text/x-c; name=sig.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <termios.h>

#include <errno.h>
#include <signal.h>

typedef void sigfunc_t(int);

void signal_handler(int param) {
	static int fd;
	unsigned char sig;

	if (fd && param==0) {
		close(fd);
		return;
	}
	
	if (param < 1) {
		fd = -param;
		return;
	}

	if (fd) {
		sig=param;
		while (-1 == write(fd, &sig, 1) && EINTR == errno)
			;
	}
}

sigfunc_t *connect_signal(int signo, sigfunc_t *func) {
	struct sigaction act, oact;

	act.sa_handler = func;
	sigemptyset(&act.sa_mask);
	act.sa_flags = 0;
	if (sigaction(signo, &act, &oact) < 0)
		return SIG_ERR;
	return oact.sa_handler;
}

int open_signal_file(void) {
	int fd[2];
	
	pipe(fd);
	signal_handler(-fd[1]);    // hand off the write side of the pipe

	connect_signal(SIGHUP, signal_handler);
	connect_signal(SIGINT, signal_handler);
	connect_signal(SIGXFSZ, signal_handler);

	return fd[0];  //return the read side of the pipe
}

void close_signal_file(int fd) {
	signal_handler(0);
	close(fd);
}

int main(void) {
	fd_set read_fds;
	char buf[256], fname[]="log.0";
	int sigfd, fd, i;
	unsigned long long bytes_left=3ull * (1ull<<31) + 256ull;

	sigfd = open_signal_file();

	if (!sigfd)
		return 1;
	
	while (bytes_left) {
		int len;
		fd = creat(fname, S_IRUSR | S_IWUSR);
		if (fd == -1)
			return 2;
		
		len = 0x7fffffff;
		if (len > bytes_left)
			len = bytes_left;
		ftruncate(fd, len);
		bytes_left -= len;
		
		if (!bytes_left)
			break;
		
		lseek(fd, 0, SEEK_END);
		i = write(fd, buf, 256);

		if (i>0)
			bytes_left -= i;
		if (i<0)
			puts("write errored");
		
		FD_SET(sigfd, &read_fds);
		select(sigfd + 1, &read_fds, NULL, NULL, NULL);
		
		if (FD_ISSET(sigfd, &read_fds)) {
			int sigs = read(sigfd, buf, 256);
			if (sigs > 0)
				for (i=0; i<sigs; i++)
					switch(buf[i]) {
						case SIGINT:
							return 0;
						case SIGXFSZ:
							puts("seem to have gone overboard, switching to next log file...");
							break;
						default:
							break;
					}
		}
		
		close(fd);
		fname[4]++;
	}

	close_signal_file(sigfd);
	return 0;
}

--=-emoq6w94x3cHLRzS2snQ--

