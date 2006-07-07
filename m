Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWGGHHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWGGHHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWGGHHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:07:06 -0400
Received: from mail.gmx.net ([213.165.64.21]:65417 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751255AbWGGHHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:07:05 -0400
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 07 Jul 2006 09:07:03 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
Message-ID: <20060707070703.165520@gmx.net>
MIME-Version: 1.0
Subject: splice/tee bugs?
To: axboe@suse.de
X-Authenticated: #24879014
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jens,

While editing and extending your draft man pages for
tee(), splice(), vmsplice() I've been testing out 
the splice()/tee() calls using a modified version of 
the program you provided in the tee.2 manual page.

The most notable differences between my program and yours
are:

* I print some debugging info to stderr.

* I don't pass SPLICE_F_NONBLOCK to tee().

I'm running this on kernel 2.6.17, using the following 
command line:

$ ls *.c  | ktee r  | wc

On different runs I see:

a) No output from ls through the pipeline:

tee returned 0
      0       0       0


b) Very many instances of EAGAIN followed by expected results:

...
EAGAIN
EAGAIN
EAGAIN
EAGAIN
EAGAIN
EAGAIN
tee returned 19
splice returned 19
tee returned 0
      2       2      19

In some of these cases the elapsed time to run the command-line 
is 1 or 2 seconds in this case (instead of the more typical 
0.05 seconds).


c) Occasionally the command line just hangs, producing no output.
   In this case I can't kill it with ^C or ^\.  This is a 
   hard-to-reproduce behaviour on my (x86) system, but I have 
   seen it several times by now.

Assuming I'm not messing up with my test method, some 
observations:

Result a) seems to be occurring because tee() returns 0 if its
in_fd is not yet "ready" to deliver data.  Shouldn't tee() 
be blocking in this case?  And should not 0 only 
be returned for EOF? on the input file descriptor?

If I uncomment the usleep() line in the program, this behavior 
does not occur--the program always just produces the expected
output:

tee returned 19
splice returned 19
tee returned 0
      2       2      19

For behaviour b) -- why does tee() give EAGAIN when
I haven't specified SPLICE_F_NONBLOCK?  (This is a 
philosophical question; I can see that there are code paths
that lead to EAGAIN without SPLICE_F_NONBLOCK, but that
seems confusing behaviour for userland.)

Behaviour c) hints of a bug in tee().

Your thoughts?

Cheers,

Michael

====

/* ktee.c */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <assert.h>
#include <errno.h>
#include <limits.h>

#if defined(__i386__)
#define __NR_splice     313
#define __NR_tee        315
#else
#error unsupported arch
#endif

#define SPLICE_F_MOVE   (0x01)  /* move pages instead of copying */
#define SPLICE_F_NONBLOCK (0x02) /* don't block on the pipe splicing (but */
                                 /* we may still block on the fd we splice */
                                 /* from/to, of course */
#define SPLICE_F_MORE   (0x04)  /* expect more data */
#define SPLICE_F_GIFT   (0x08)  /* pages passed in are a gift */


static inline int splice(int fdin, loff_t *off_in, int fdout,
                         loff_t *off_out, size_t len, unsigned int flags)
{
    return syscall(__NR_splice, fdin, off_in, fdout, off_out, len, flags);
}

static inline int tee(int fdin, int fdout, size_t len, unsigned int flags)
{
    return syscall(__NR_tee, fdin, fdout, len, flags);
}

int
main(int argc, char *argv[])
{
    int fd;
    int len, slen;

    assert(argc == 2);

    fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd == -1) {
        perror("open");
        exit(EXIT_FAILURE);
    }

    //usleep(100000);
    do {
        /*
         * tee stdin to stdout.
         */
        len = tee(STDIN_FILENO, STDOUT_FILENO,
                  INT_MAX, 0);

        if (len < 0) {
            if (errno == EAGAIN) {
                fprintf(stderr, "EAGAIN\n");
                continue;
            }
            perror("tee");
            exit(EXIT_FAILURE);
        }
        fprintf(stderr, "tee returned %ld\n",  (long) len);
        if (len == 0)
            break;

        /*
         * Consume stdin by splicing it to a file.
         */
        while (len > 0) {
            slen = splice(STDIN_FILENO, NULL, fd, NULL,
                          len, SPLICE_F_MOVE);
            if (slen < 0) {
                perror("splice");
                break;
            }
            fprintf(stderr, "splice returned %ld\n", (long) slen);
            len -= slen;
        }
    } while (1);

    close(fd);
    exit(EXIT_SUCCESS);
}

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
