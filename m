Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbULVCi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbULVCi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 21:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbULVCi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 21:38:29 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:19886 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261917AbULVCiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 21:38:16 -0500
Subject: Re: A (dumb?) waitpid(2) question
From: Steven Rostedt <rostedt@goodmis.org>
To: "usvyatsky, ilya" <usvyatsky_ilya@emc.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F550846C103@srgraham.eng.emc.com>
References: <FA2F59D0E55B4B4892EA076FF8704F550846C103@srgraham.eng.emc.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 21 Dec 2004 21:38:11 -0500
Message-Id: <1103683091.14114.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-21 at 19:26 -0500, usvyatsky, ilya wrote:
> As dumb as it seems, I am seing a weird behavior on my RH3.0 box
> (2.4.21-20.Elsmp kernel).
> 
> It looks like (contrary to the man page and POSIX .1) waitpid(2) does not
> return upon a SIGALRM.
> 
> I am porting an old piece of Solaris userland code (stripped from all useful
> functionality):

I changed your code with the following:

@@ -25,11 +25,15 @@
     if (child_pid) {
         /* parent */
         int status = 0, timeout = 1;
+       struct sigaction sa;
+       sa.sa_handler = sig_handler;
+       sa.sa_flags = SA_NOMASK;

         do {
             printf("Parent: setting an alarm for %d seconds\n", timeout);

-            signal(SIGALRM, sig_handler);
+           sigaction(SIGALRM, &sa,NULL);
+//            signal(SIGALRM, sig_handler);
             alarm(timeout);

             printf("Parent: waiting for a child %d\n", child_pid);


And got the following result:

$ ./alarmit
Child:  sleeping for 6 seconds
Parent: setting an alarm for 1 seconds
Parent: waiting for a child 25926
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1 seconds
Parent: waiting for a child -1
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1 seconds
Parent: waiting for a child -1
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1 seconds
Parent: waiting for a child -1
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1 seconds
Parent: waiting for a child -1
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1 seconds
Parent: waiting for a child -1
Child:  exiting
Parent: child 25926 terminated normally with status 0


> Is it a bug or a feature?

I guess it's a feature, and the default signal function must have
SA_RESTART set.

> Any suggestions would be greatly appreciated...
> 

Use sigaction instead of signal.


-- Steve


