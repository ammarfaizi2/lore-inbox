Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUATAtk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265365AbUATArp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:47:45 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.16]:52291 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S265350AbUATAqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:46:49 -0500
Date: Tue, 20 Jan 2004 01:46:47 +0100
From: Haakon Riiser <haakon.riiser@fys.uio.no>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: Busy-wait delay in qmail 1.03 after upgrading to Linux 2.6
Message-ID: <20040120004647.GA292@s.chello.no>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20040113210923.GA955@s.chello.no> <20040113135152.3ed26b85.akpm@osdl.org> <20040113232624.GA302@s.chello.no> <20040113154348.5542cb7b.akpm@osdl.org> <20040114000746.GA691@s.chello.no> <20040114112920.GB298@s.chello.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114112920.GB298@s.chello.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I've been able to create a simple test program that
demonstrates the bug I encountered with Qmail.

What Qmail did was basically to use a named pipe as a trigger,
where one program select()s on the FIFO file descriptor, waiting
for another program to write() the FIFO.  Once select() returns,
the listener close()s the FIFO (the data was not important,
it was only used as a signal), does some work, then re-open()s
the FIFO file, and ends up in the same select() waiting for the
whole thing to happen again.

I created a small program to simulate this behavior:

/****************************************************************************/
#include <sys/select.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void run_listener(void)
{
        int i;
        int fd;
        fd_set rfds, wfds;
        struct timeval tv = { 1477, 355000 };

        mkfifo("test.fifo", 0700);

        for (;;) {
                if ((fd = open("test.fifo", O_RDONLY | O_NONBLOCK)) < 0) {
                        perror("open test.fifo");
                        exit(1);
                }
                FD_ZERO(&rfds);
                FD_SET(fd, &rfds);
                FD_ZERO(&wfds);
                switch (select(fd + 1, &rfds, &wfds, NULL, &tv)) {
                case 0:
                        fprintf(stderr, "select timed out\n");
                        exit(0);
                case -1:
                        perror("select()");
                        exit(1);
                }
                if (close(fd) < 0) {
                        perror("close");
                }
                /* Do some work before returning to select() */
                for (i = 0; i < 1000000; i++)
                        ;
        }
}

void run_writer(void)
{
        struct timeval tv1, tv2;
        int fd;

        for (;;) {
                while ((fd = open("test.fifo", O_WRONLY | O_NONBLOCK)) < 0)
                        ;
                gettimeofday(&tv1, NULL);
                if (write(fd, &fd, 1) == 1) {
                        gettimeofday(&tv2, NULL);
                        fprintf(stderr, "dt = %f ms\n",
                                (tv2.tv_sec - tv1.tv_sec) * 1000.0 +
                                (tv2.tv_usec - tv1.tv_usec) / 1000.0);
                }
                if (close(fd) < 0) {
                        perror("close");
                }
        }
}

int main(int argc, char *argv[])
{
        signal(SIGPIPE, SIG_IGN);
        if (argc > 1) {
                run_listener();
        }
        run_writer();
        return 0;
}
/****************************************************************************/

Start this program with arguments to run it in listener mode,
and without to run as writer.  The writer will print the time it
spent in write() every time write() succeeds.  The results are
quite interesting.  You don't even need to print the actual time
spent to see that something is wrong -- any output would suffice.

When run on 2.4.24, output lines from the writer are scrolling
past in a constant high pace, and the numbers are always fractions
of a millisecond.

When run on 2.6.1, everything appears to be fine for a short while,
but suddenly things slow down to the point where write()s take
up to 300 ms!  This happens for a second or so, and the delay
drops down to sub-milliseconds again.  But wait a little longer,
and it happens again:  Slows down to 100-300 msecs per write()
for a short time, and suddenly jumps back to normal pace.

Here's an example run on 2.6.  On my computer, there was around
700 sub-msec lines between each series of long delays, so I grep
out the lines that take one msec or more.

  $ ./a.out LISTENER &
  [1] 449
  $ ./a.out 2>&1 | grep -v '= 0'
  dt = 302.220000 ms
  dt = 100.586000 ms
  dt = 101.651000 ms
  dt = 100.603000 ms
  dt = 101.574000 ms
  dt = 100.272000 ms
  dt = 101.020000 ms
  dt = 101.775000 ms
  dt = 99.725000 ms
  dt = 100.477000 ms
  dt = 100.128000 ms
  dt = 101.708000 ms
  dt = 100.041000 ms

I don't know if this is exactly the same problem as the one I'm
seeing with Qmail, but it might be worth investigating nonetheless.

-- 
 Haakon
