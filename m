Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129145AbQKXM67>; Fri, 24 Nov 2000 07:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129947AbQKXM6u>; Fri, 24 Nov 2000 07:58:50 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:64989 "EHLO
        isis.its.uow.edu.au") by vger.kernel.org with ESMTP
        id <S129145AbQKXM6l>; Fri, 24 Nov 2000 07:58:41 -0500
Message-ID: <3A1E5EFC.16E7625A@uow.edu.au>
Date: Fri, 24 Nov 2000 23:28:44 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Ellis <mark.uzumati@virgin.net>
CC: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: OOPS on bringing down ppp
In-Reply-To: <20001124105539.A18945@ElCapitan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Ellis wrote:
> 
> Hi all, consistently getting the following when pppd is terminated.

When pppd downs the ppp0 device, unregister_netdevice() is
trying to run /sbin/hotplug in a new kernel thread.  That
thread's `files' structure is copied from pppd, but it is
NULL.  Presumably pppd's files pointer was also NULL.

Try this:

--- linux-2.4.0-test11-ac2/kernel/kmod.c	Tue Nov 21 20:11:21 2000
+++ linux-akpm/kernel/kmod.c	Fri Nov 24 23:03:34 2000
@@ -99,8 +99,10 @@
 	flush_signal_handlers(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
-	for (i = 0; i < current->files->max_fds; i++ ) {
-		if (current->files->fd[i]) close(i);
+	if (current->files) {
+		for (i = 0; i < current->files->max_fds; i++ ) {
+			if (current->files->fd[i]) close(i);
+		}
 	}
 
 	/* Drop the "current user" thing */


Not my area, but I don't think exec_usermodehelper() should assume
that current->files is always valid.

Al, is this correct?  If so, does daemonize() also need this test?
If not, then how did this thread get (current->files == NULL)?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
