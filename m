Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVCODe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVCODe5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVCODe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:34:57 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:13445 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262224AbVCODeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:34:25 -0500
Date: Tue, 15 Mar 2005 14:34:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PPC64 iSeries: cleanup viopath
Message-Id: <20050315143412.0c60690a.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__15_Mar_2005_14_34_12_+1100_wBUfWEXehAY.XIhx"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__15_Mar_2005_14_34_12_+1100_wBUfWEXehAY.XIhx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

Since you brought this file to my attention, I figured I might as well do
some simple cleanups.  This patch does:
	- single bit int bitfields are a bit suspect and Anndrew pointed
	  out recently that they are probably slower to access than ints
	- get rid of some more stufly caps
	- define the semaphore and the atomic in struct alloc_parms
	  rather than pointers to them since we just allocate them on
	  the stack anyway.
	- one small white space cleanup
	- use the HvLpIndexInvalid constant instead of ita value

Built and booted on iSeries (which is the only place it is used).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus/arch/ppc64/kernel/viopath.c linus-cleanup.1/arch/ppc64/kernel/viopath.c
--- linus/arch/ppc64/kernel/viopath.c	2005-03-13 04:07:42.000000000 +1100
+++ linus-cleanup.1/arch/ppc64/kernel/viopath.c	2005-03-15 14:02:48.000000000 +1100
@@ -42,6 +42,7 @@
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/iSeries/HvTypes.h>
 #include <asm/iSeries/LparData.h>
 #include <asm/iSeries/HvLpEvent.h>
 #include <asm/iSeries/HvLpConfig.h>
@@ -56,8 +57,8 @@
  * But this allows for other support in the future.
  */
 static struct viopathStatus {
-	int isOpen:1;		/* Did we open the path?            */
-	int isActive:1;		/* Do we have a mon msg outstanding */
+	int isOpen;		/* Did we open the path?            */
+	int isActive;		/* Do we have a mon msg outstanding */
 	int users[VIO_MAX_SUBTYPES];
 	HvLpInstanceId mSourceInst;
 	HvLpInstanceId mTargetInst;
@@ -81,10 +82,10 @@ static void handleMonitorEvent(struct Hv
  * blocks on the semaphore and the handler posts the semaphore.  However,
  * if system_state is not SYSTEM_RUNNING, then wait_atomic is used ...
  */
-struct doneAllocParms_t {
-	struct semaphore *sem;
+struct alloc_parms {
+	struct semaphore sem;
 	int number;
-	atomic_t *wait_atomic;
+	atomic_t wait_atomic;
 	int used_wait_atomic;
 };
 
@@ -97,9 +98,9 @@ static u8 viomonseq = 22;
 /* Our hosting logical partition.  We get this at startup
  * time, and different modules access this variable directly.
  */
-HvLpIndex viopath_hostLp = 0xff;	/* HvLpIndexInvalid */
+HvLpIndex viopath_hostLp = HvLpIndexInvalid;
 EXPORT_SYMBOL(viopath_hostLp);
-HvLpIndex viopath_ourLp = 0xff;
+HvLpIndex viopath_ourLp = HvLpIndexInvalid;
 EXPORT_SYMBOL(viopath_ourLp);
 
 /* For each kind of incoming event we set a pointer to a
@@ -200,7 +201,7 @@ EXPORT_SYMBOL(viopath_isactive);
 
 /*
  * We cache the source and target instance ids for each
- * partition.  
+ * partition.
  */
 HvLpInstanceId viopath_sourceinst(HvLpIndex lp)
 {
@@ -450,36 +451,33 @@ static void vio_handleEvent(struct HvLpE
 
 static void viopath_donealloc(void *parm, int number)
 {
-	struct doneAllocParms_t *parmsp = (struct doneAllocParms_t *)parm;
+	struct alloc_parms *parmsp = parm;
 
 	parmsp->number = number;
 	if (parmsp->used_wait_atomic)
-		atomic_set(parmsp->wait_atomic, 0);
+		atomic_set(&parmsp->wait_atomic, 0);
 	else
-		up(parmsp->sem);
+		up(&parmsp->sem);
 }
 
 static int allocateEvents(HvLpIndex remoteLp, int numEvents)
 {
-	struct doneAllocParms_t parms;
-	DECLARE_MUTEX_LOCKED(Semaphore);
-	atomic_t wait_atomic;
+	struct alloc_parms parms;
 
 	if (system_state != SYSTEM_RUNNING) {
 		parms.used_wait_atomic = 1;
-		atomic_set(&wait_atomic, 1);
-		parms.wait_atomic = &wait_atomic;
+		atomic_set(&parms.wait_atomic, 1);
 	} else {
 		parms.used_wait_atomic = 0;
-		parms.sem = &Semaphore;
+		init_MUTEX_LOCKED(&parms.sem);
 	}
 	mf_allocate_lp_events(remoteLp, HvLpEvent_Type_VirtualIo, 250,	/* It would be nice to put a real number here! */
 			    numEvents, &viopath_donealloc, &parms);
 	if (system_state != SYSTEM_RUNNING) {
-		while (atomic_read(&wait_atomic))
+		while (atomic_read(&parms.wait_atomic))
 			mb();
 	} else
-		down(&Semaphore);
+		down(&parms.sem);
 	return parms.number;
 }
 
@@ -558,8 +556,7 @@ int viopath_close(HvLpIndex remoteLp, in
 	unsigned long flags;
 	int i;
 	int numOpen;
-	struct doneAllocParms_t doneAllocParms;
-	DECLARE_MUTEX_LOCKED(Semaphore);
+	struct alloc_parms parms;
 
 	if ((remoteLp >= HvMaxArchitectedLps) || (remoteLp == HvLpIndexInvalid))
 		return -EINVAL;
@@ -580,11 +577,11 @@ int viopath_close(HvLpIndex remoteLp, in
 
 	spin_unlock_irqrestore(&statuslock, flags);
 
-	doneAllocParms.used_wait_atomic = 0;
-	doneAllocParms.sem = &Semaphore;
+	parms.used_wait_atomic = 0;
+	init_MUTEX_LOCKED(&parms.sem);
 	mf_deallocate_lp_events(remoteLp, HvLpEvent_Type_VirtualIo,
-			      numReq, &viopath_donealloc, &doneAllocParms);
-	down(&Semaphore);
+			      numReq, &viopath_donealloc, &parms);
+	down(&parms.sem);
 
 	spin_lock_irqsave(&statuslock, flags);
 	for (i = 0, numOpen = 0; i < VIO_MAX_SUBTYPES; i++)

--Signature=_Tue__15_Mar_2005_14_34_12_+1100_wBUfWEXehAY.XIhx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCNle64CJfqux9a+8RArCKAJ9L6FezPeJyQhUc8tDBHV36yOtOGgCgirxe
GMnV54vkmX2+0oW80DvnSc8=
=7l5Y
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Mar_2005_14_34_12_+1100_wBUfWEXehAY.XIhx--
