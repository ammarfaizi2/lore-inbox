Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272309AbRIKHTN>; Tue, 11 Sep 2001 03:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272312AbRIKHTE>; Tue, 11 Sep 2001 03:19:04 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:20485 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S272309AbRIKHSu>; Tue, 11 Sep 2001 03:18:50 -0400
From: Matt Chapman <matthewc@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Tue, 11 Sep 2001 17:19:08 +1000
Subject: SMP race: child gets SIGSTOP as parent exits
Message-ID: <20010911171908.A26199@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was tested on 2.4.7 but I can't see any relevant changes in
the code or the changelog.  In arch/i386/kernel/signal.c:

                if (ka->sa.sa_handler == SIG_DFL) {
...
                        case SIGSTOP:
                                current->state = TASK_STOPPED;
                                current->exit_code = signr;
                                if (!(current->p_pptr->sig->action[SIGCHLD-1].sa
.sa_flags & SA_NOCLDSTOP))
                                        notify_parent(current, SIGCHLD);

The problem is that if the parent is in the process of exiting,
do_exit calls exit_sighand which sets tsk->sig = NULL _before_
the children get reparented in exit_notify.  So the above code
oopses dereferencing current->p_pptr->sig.

This simple program demonstrates the bug (when run in a while
true loop for a second or two):

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

int main()
{
        switch (fork())
        {
                case -1:
                        perror("fork");
                        exit(1);

                case 0: /* child */
                        kill(getpid(), SIGSTOP);
                        break;

                default: /* parent */
                        exit(0);
        }
}

The obvious (not necessarily best) fix is to check that
current->p_ptr->sig is not NULL.

Cheers,
Matt


diff -ru linux-2.4.10-pre8/arch/i386/kernel/signal.c linux-2.4.10-pre8-fix/arch/i386/kernel/signal.c
--- linux-2.4.10-pre8/arch/i386/kernel/signal.c	Tue Sep 11 17:07:30 2001
+++ linux-2.4.10-pre8-fix/arch/i386/kernel/signal.c	Tue Sep 11 17:12:27 2001
@@ -651,6 +651,7 @@
 		}
 
 		if (ka->sa.sa_handler == SIG_DFL) {
+			struct signal_struct *p_sig;
 			int exit_code = signr;
 
 			/* Init gets no signals it doesn't want.  */
@@ -669,7 +670,8 @@
 			case SIGSTOP:
 				current->state = TASK_STOPPED;
 				current->exit_code = signr;
-				if (!(current->p_pptr->sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
+				p_sig = current->p_pptr->sig;
+				if ((p_sig != NULL) && !(p_sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
 					notify_parent(current, SIGCHLD);
 				schedule();
 				continue;
