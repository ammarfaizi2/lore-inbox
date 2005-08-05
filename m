Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263006AbVHEMta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbVHEMta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 08:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbVHEMta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 08:49:30 -0400
Received: from pop.gmx.de ([213.165.64.20]:53640 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263006AbVHEMt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 08:49:29 -0400
Date: Fri, 5 Aug 2005 14:49:28 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: dwmw2@infradead.org
Cc: drepper@redhat.com, jakub@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <11156.1123243084@www3.gmx.net>
Subject: =?ISO-8859-1?Q?Re:_Add_pselect,_ppoll_system_calls.?=
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <25911.1123246168@www3.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Not sure if your message below was meant as a reply-all or not,
but I've brought it back onto the list.

There are some problems with your test program -- 
it's not actually using pselect() in proper way, which is:

    /* Block signals that will be later unblocked by pselect() */

    sigemptyset(&block);
    sigaddset(&block, SIGINT);
    sigprocmask(SIG_BLOCK, &block, NULL);

    sigemptyset(&set);
    status = my_pselect(1, &s, NULL, NULL, &timeout, &set);

If I change your program to do something like the above, I also
do not see a message from the handler -- i.e., it is not being
called, and I'm pretty sure it should be.

Below, is my modified version of your program -- it uses SIGINT.

Cheers,

Michael

#define _GNU_SOURCE
#include <syscall.h>
#include <unistd.h>
#include <signal.h>
#include <sys/select.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>

#define __NR_pselect6 289

static int my_pselect(int   n,
       fd_set   *readfds,  fd_set  *writefds,  fd_set
       *exceptfds, const struct timespec *timeout, sigset_t *sigmask)
{
        struct {
                sigset_t *set;
                size_t size;
        } __attribute__((packed)) arg6;

        arg6.size = 8;
        arg6.set = sigmask;
        return syscall(__NR_pselect6, n, readfds, writefds,
                exceptfds, timeout, &arg6);
}

static void usr1_handler(int signo)
{
        write(1, "handler called\n", 20);
}


int main(void)
{
        fd_set s;
        int status;
        sigset_t set, block;
        struct timespec timeout;

        timeout.tv_sec = 30;
        timeout.tv_nsec = 0;

        FD_ZERO(&s);
        FD_SET(0, &s);

        signal(SIGINT, usr1_handler);

        sigemptyset(&block);
        sigaddset(&block, SIGINT);
        sigprocmask(SIG_BLOCK, &block, NULL);

        sigemptyset(&set);
        status = my_pselect(1, &s, NULL, NULL, &timeout, &set);
        printf("status=%d\n", status);
        if (status == -1) perror("pselect");
}

--- Weitergeleitete Nachricht ---
Von: David Woodhouse <dwmw2@infradead.org>
An: Michael Kerrisk <mtk-lkml@gmx.net>
Betreff: Re: Add pselect, ppoll system calls.
Datum: Fri, 05 Aug 2005 13:03:14 +0100

This is the test program I used. I send it SIGUSR1 manually.

#define __USE_MISC
#include <unistd.h>
#include <signal.h>
#include <sys/select.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>

#define __NR_pselect6 273

int my_pselect(int   n,   fd_set   *readfds,  fd_set  *writefds,  fd_set
       *exceptfds, const struct timespec *timeout, const sigset_t *sigmask)
{
        struct {
                sigset_t *set;
                size_t size;
        } __attribute__((packed)) arg6;

        arg6.size = 8;
        arg6.set = sigmask;
        return syscall(__NR_pselect6, n, readfds, writefds, exceptfds,
timeout, &arg6);
}

void usr1_handler(int signo)
{
        write(1, "usr1_handler called\n", 20);
}
int main(void)
{
        fd_set s;
        int p;
        char buf[80];
        sigset_t set;
        fcntl(0, F_SETFL, O_NONBLOCK | fcntl(0, F_GETFL));

        FD_ZERO(&s);
        FD_SET(0, &s);

        sigfillset(&set);

        signal(SIGUSR1, usr1_handler);

        printf("I am %d\n", getpid());

        while (1) {
                printf("Block usr1\n");
                fflush(stdout);
                sigaddset(&set, SIGUSR1);
                my_pselect(1, &s, NULL, NULL, NULL, &set);
                read(0, buf, 80);
                printf("Allow usr1\n");
                fflush(stdout);
                sigdelset(&set, SIGUSR1);
                my_pselect(1, &s, NULL, NULL, NULL, &set);
                read(0, buf, 80);
        }

}


-- 
5 GB Mailbox, 50 FreeSMS http://www.gmx.net/de/go/promail
+++ GMX - die erste Adresse für Mail, Message, More +++
