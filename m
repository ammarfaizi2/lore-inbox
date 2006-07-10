Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWGJMLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWGJMLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 08:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWGJMLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 08:11:12 -0400
Received: from mail.gmx.de ([213.165.64.21]:49371 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964805AbWGJMLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 08:11:12 -0400
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 10 Jul 2006 14:11:10 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
Message-ID: <20060710121110.26260@gmx.net>
MIME-Version: 1.0
Subject: splice() and file offsets
To: Jens Axboe <axboe@suse.de>
X-Authenticated: #24879014
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

What are the semantics of splice() supposed to be with respect 
to the current file offsets of 'fd_in' and 'fd_out', and how
is the presence or absence (NULL) of 'off_in' and 'off_out'
supposed to affect things.

Using the program below, here is what I observe for 
fd_out/off_out:

1. If off_out is NULL, then 
   a) splice() changes the current file offset of fd_out.

2. If off_out is not NULL, then splice() 
   a) does not change the current file offset of fd_out, but 
   b) treats off_out as a value result parameter, returning 
      an updated offset of the file.

It is "2 a)" that surprises me.  But perhaps it's expected 
behaviour; or I'm doing something dumb in my test program.

If the test program is run without a third command-line 
argument, then 'off_out' is specified as NULL, and we see:

$ find .. | ./t_splice out
splice() returned 69632
After splice(), offset of fd is: 69632; off_out = 0
splice() returned 32768
After splice(), offset of fd is: 102400; off_out = 0
splice() returned 100000
After splice(), offset of fd is: 202400; off_out = 0
splice() returned 14688
After splice(), offset of fd is: 217088; off_out = 0
splice() returned 31990
After splice(), offset of fd is: 249078; off_out = 0
splice() returned 0
After splice(), offset of fd is: 249078; off_out = 0

If the test program is run with a third command-line 
argument, then 'off_out' is initialised to 0, and then
supplied as an argument on each splice() call, and we 
see:

$ find .. | ./t_splice out x
splice() returned 20480
After splice(), offset of fd is: 0; off_out = 20480
splice() returned 49152
After splice(), offset of fd is: 0; off_out = 69632
splice() returned 100000
After splice(), offset of fd is: 0; off_out = 169632
splice() returned 35168
After splice(), offset of fd is: 0; off_out = 204800
splice() returned 44278
After splice(), offset of fd is: 0; off_out = 249078
splice() returned 0
After splice(), offset of fd is: 0; off_out = 249078

Cheers,

Michael

/* t_splice.c */

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
    int slen;
    loff_t off_out;

    assert(argc >= 2);

    fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd == -1) {
        perror("open");
        exit(EXIT_FAILURE);
    }

    off_out = 0;
    for (;;) {
        slen = splice(STDIN_FILENO, NULL, fd,
                (argc > 2) ? &off_out : NULL, 100000, 0);
        if (slen < 0) {
            perror("splice");
            break;
        }
        fprintf(stderr, "splice() returned %ld\n", (long) slen);
        fprintf(stderr, "After splice(), offset of fd is: %lld; "
                "off_out = %lld\n",
                (long long) lseek(fd, 0, SEEK_CUR),
                (long long) off_out);
        if (slen == 0)
            break;
    }

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
