Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbTF3Svv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 14:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTF3Svv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 14:51:51 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20565 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264921AbTF3Svt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 14:51:49 -0400
Date: Mon, 30 Jun 2003 15:06:09 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pete Zaitcev <zaitcev@redhat.com>, Ernie Petrides <petrides@redhat.com>
Subject: Re: semtimedop() support on s390/s390x
Message-ID: <20030630150609.K13329@devserv.devel.redhat.com>
References: <200306301833.h5UIXSrS028891@pasta.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200306301833.h5UIXSrS028891@pasta.boston.redhat.com>; from petrides@redhat.com on Mon, Jun 30, 2003 at 02:33:28PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 30 Jun 2003 14:33:28 -0400
> From: Ernie Petrides <petrides@redhat.com>

> On Friday, 27-Jun-2003 at 23:5 EDT, Pete Zaitcev wrote:

> > > +-	if (call <= SEMCTL)
> > > ++	if (call <= SEMTIMEDOP)
> > >   		switch (call) {
> > >  +		case SEMTIMEDOP:
> > 
> > I guess this is the reason for the ENOSYS. Good catch!
> 
> Thanks ... there's no substitute for actual testing.  :)
> 
> That odd "switch-optimization" sequence in the s390x compat code
> is also in several 2.5.73 (....) architectures, but none of
> them have yet implemented semtimedop() support:
> 
> 	h8300, m68k, m68knommu, sh, sparc, sparc64
> 
> They'll all hit the same problem if/when they ever do semtimedop().

What do folks think about the attached patch, then?

Linus was making noises that he wishes to throttle "cleanups",
and this is a cleanup. But still... It's contained in arch code.
I'm pretty sure I can slip it in quietly if there's a sense
it is likely to save us the same problem in the future.

Also, I hate "<=" irrationally for some reason. I always
use "<" and ">=". This has something to do with programming
in pseudo-code and compiling by hand. On some brain-dead CPUs
and with some data types it is a better comparison.

I'll replicate to s390 and see if s390 -S output changes
if the source level looks ok to Martin's & Ulrich's eyes.

-- Pete

diff -urN -X dontdiff linux-2.5.73-bk7/arch/sparc/kernel/sys_sparc.c linux-2.5.73-bk7-sparc/arch/sparc/kernel/sys_sparc.c
--- linux-2.5.73-bk7/arch/sparc/kernel/sys_sparc.c	2003-05-26 18:00:38.000000000 -0700
+++ linux-2.5.73-bk7-sparc/arch/sparc/kernel/sys_sparc.c	2003-06-30 11:53:29.000000000 -0700
@@ -120,7 +120,7 @@
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
 
-	if (call <= SEMCTL)
+	if (call < SEM_LIM)
 		switch (call) {
 		case SEMOP:
 			err = sys_semop (first, (struct sembuf __user *)ptr, second);
@@ -143,7 +143,7 @@
 			err = -ENOSYS;
 			goto out;
 		}
-	if (call <= MSGCTL) 
+	if (call < MSG_LIM) 
 		switch (call) {
 		case MSGSND:
 			err = sys_msgsnd (first, (struct msgbuf __user *) ptr, 
@@ -176,7 +176,7 @@
 			err = -ENOSYS;
 			goto out;
 		}
-	if (call <= SHMCTL) 
+	if (call < SHM_LIM) 
 		switch (call) {
 		case SHMAT:
 			switch (version) {
diff -urN -X dontdiff linux-2.5.73-bk7/include/asm-sparc/ipc.h linux-2.5.73-bk7-sparc/include/asm-sparc/ipc.h
--- linux-2.5.73-bk7/include/asm-sparc/ipc.h	2003-05-26 18:00:22.000000000 -0700
+++ linux-2.5.73-bk7-sparc/include/asm-sparc/ipc.h	2003-06-30 11:52:31.000000000 -0700
@@ -14,14 +14,17 @@
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
+#define SEM_LIM		 4	/* Top of SEMFOO numbers */
 #define MSGSND		11
 #define MSGRCV		12
 #define MSGGET		13
 #define MSGCTL		14
+#define MSG_LIM		15	/* Top of MSGFOO numbers */
 #define SHMAT		21
 #define SHMDT		22
 #define SHMGET		23
 #define SHMCTL		24
+#define SHM_LIM		25	/* Top of SHMFOO numbers */
 
 /* Used by the DIPC package, try and avoid reusing it */
 #define DIPC            25
