Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbULVCxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbULVCxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 21:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbULVCxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 21:53:07 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:63801 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261927AbULVCwv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 21:52:51 -0500
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F550846C104@srgraham.eng.emc.com>
From: "usvyatsky, ilya" <usvyatsky_ilya@emc.com>
To: "'Steven Rostedt'" <rostedt@goodmis.org>,
       "usvyatsky, ilya" <usvyatsky_ilya@emc.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: RE: A (dumb?) waitpid(2) question
Date: Tue, 21 Dec 2004 21:52:42 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-PMX-Version: 4.6.1.107272, Antispam-Core: 4.6.1.106808, Antispam-Data: 2004.12.21.35
X-PerlMx-Spam: Gauge=, SPAM=7%, Report='EMC_FROM_0 -0, __TLG_EMC_ENVFROM_0 0, __IMS_MSGID 0, __HAS_MSGID 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __MIME_VERSION 0, __ANY_IMS_MUA 0, __IMS_MUA 0, __HAS_X_MAILER 0, __CT_TEXT_PLAIN 0, __CT 0, __MIME_TEXT_ONLY 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot, I suspected something of this sort...

-----Original Message-----
From: Steven Rostedt [mailto:rostedt@goodmis.org] 
Sent: Tuesday, December 21, 2004 9:38 PM
To: usvyatsky, ilya
Cc: LKML
Subject: Re: A (dumb?) waitpid(2) question


On Tue, 2004-12-21 at 19:26 -0500, usvyatsky, ilya wrote:
> As dumb as it seems, I am seing a weird behavior on my RH3.0 box 
> (2.4.21-20.Elsmp kernel).
> 
> It looks like (contrary to the man page and POSIX .1) waitpid(2) does 
> not return upon a SIGALRM.
> 
> I am porting an old piece of Solaris userland code (stripped from all 
> useful
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
Parent: wait was interrupted by a signalParent: setting an alarm for 1
seconds
Parent: waiting for a child -1
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1
seconds
Parent: waiting for a child -1
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1
seconds
Parent: waiting for a child -1
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1
seconds
Parent: waiting for a child -1
Alarm!!!
Parent: wait was interrupted by a signalParent: setting an alarm for 1
seconds
Parent: waiting for a child -1
Child:  exiting
Parent: child 25926 terminated normally with status 0


> Is it a bug or a feature?

I guess it's a feature, and the default signal function must have SA_RESTART
set.

> Any suggestions would be greatly appreciated...
> 

Use sigaction instead of signal.


-- Steve

