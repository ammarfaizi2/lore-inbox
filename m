Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbTAaR2Q>; Fri, 31 Jan 2003 12:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbTAaR2Q>; Fri, 31 Jan 2003 12:28:16 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:60087 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261645AbTAaR2O>; Fri, 31 Jan 2003 12:28:14 -0500
Message-ID: <3E3AB44D.D4B9DC22@austin.ibm.com>
Date: Fri, 31 Jan 2003 11:37:17 -0600
From: Saurabh Desai <sdesai@austin.ibm.com>
Organization: IBM Corporation
X-Mailer: Mozilla 4.7 [en] (X11; U; AIX 4.3)
X-Accept-Language: en-US,en-GB
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mingo@elte.hu
CC: phil-list@redhat.com
Subject: [PATCH]fix for thread signal delivery
Content-Type: multipart/mixed;
 boundary="------------9F6638E0D27DA4A14E32F9CA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9F6638E0D27DA4A14E32F9CA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


A signal delivery to a thread is not working
properly in the kernel when a signal 
handler is specified. Here is the case:
A process blocks all signals and registers
a handler for a signal. 
A newly created thread unblocks that signal.
When that signal is sent to a process, the 
sighandler is not getting called.
(if this signal is sent twice, it works)
  
I've attached a small test program to reproduce 
it using NPTL. 
The following patch fixes this problem in kernel.
Please apply.

Thanks,
Saurabh Desai
--------------9F6638E0D27DA4A14E32F9CA
Content-Type: text/plain; charset=us-ascii;
 name="sigfix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sigfix.diff"

diff -Naur linux-2.5.59.orig/kernel/signal.c linux-2.5.59/kernel/signal.c
--- linux-2.5.59.orig/kernel/signal.c	2003-01-30 16:54:44.000000000 -0600
+++ linux-2.5.59/kernel/signal.c	2003-01-30 16:55:22.000000000 -0600
@@ -854,11 +854,13 @@
 
 	tmp = p->sig->curr_target;
 
-	if (!tmp || tmp->tgid != p->tgid)
+	if (!tmp || tmp->tgid != p->tgid) {
 		/* restart balancing at this thread */
 		p->sig->curr_target = p;
+		tmp = p;
+	}
 
-	else for (;;) {
+	for (;;) {
 		if (thread_group_empty(p))
 			BUG();
 		if (!tmp || tmp->tgid != p->tgid)

--------------9F6638E0D27DA4A14E32F9CA
Content-Type: text/plain; charset=us-ascii;
 name="tsig.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tsig.c"


#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
#include <signal.h>

void sigcatcher(int sig)
{
    fprintf(stderr, "The sigcatcher caught signal %d\n", sig);
    pthread_exit(0);
}

void *sig_thread(void *p)
{
    sigset_t sigs_to_catch;

    /* Unblock SIGINT */
    sigemptyset(&sigs_to_catch);
    sigaddset(&sigs_to_catch, SIGINT);
    pthread_sigmask(SIG_UNBLOCK, &sigs_to_catch, NULL);

    fprintf(stderr, "sent a SIGINT (ctrl-C) to this process(%d)\n", getpid());
    sleep(60);

    return (NULL);
}

extern int main(void)
{
    pthread_t thread;
    sigset_t sigs_to_block;
    struct sigaction action;

    /* Block all signals */
    sigfillset(&sigs_to_block);
    pthread_sigmask(SIG_BLOCK, &sigs_to_block, NULL);
    /* Set a signal handler */
    action.sa_handler = sigcatcher;
    action.sa_flags = 0;
    sigaction(SIGINT, &action, NULL);

    pthread_create(&thread, NULL, sig_thread, NULL);

    /* wait until thread is finished */
    pthread_join(thread, NULL);

    return 0;
}

--------------9F6638E0D27DA4A14E32F9CA--

