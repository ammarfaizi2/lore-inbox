Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbULAGeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbULAGeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 01:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbULAGeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 01:34:14 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:57086 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261310AbULAGdy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 01:33:54 -0500
Date: Wed, 1 Dec 2004 12:00:26 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/4] Cleanup file_count usage
Message-ID: <20041201063025.GA3121@impedimenta.in.ibm.com>
References: <20041116135200.GA23257@impedimenta.in.ibm.com> <16794.32730.184008.344036@cargo.ozlabs.ibm.com> <20041117165021.GC3152@impedimenta.in.ibm.com> <16795.52144.648958.233683@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16795.52144.648958.233683@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 09:07:44AM +1100, Paul Mackerras wrote:
> ... 
> The difficulty comes when pppd does a PPPIOCNEWUNIT, a PPPIOCDETACH,
> and another PPPIOCNEWUNIT.  To test that, you would need to use
> ppp-2.4.0 or ppp-2.4.1 and use the persist option to pppd.  Make one
> connection and then terminate it (unplug the modem, or use the idle
> option to pppd).  Pppd should then try to reestablish the connection.
> The question is whether the second connection attempt succeeds or not.
> I think that with your patch it won't (from a quick look).

I think I've fixed the memory leak and the reconnect issues with the
following patch.  Patch Tested with ppp-2.4.0 and ppp-2.4.2.

Note: The mainline kernel 2.6.10-rc2 kills pppd if  idle and persisit options 
are passed:

Unmodified ppp driver with ppp-2.4.0, debug, persist, idle 20 options
----------------------------------------------------------------------------
Dec  1 11:29:07 roamer kernel: PPP generic driver version 2.4.2
Dec  1 11:29:07 roamer pppd[3409]: pppd 2.4.0 started by root, uid 0
Dec  1 11:29:07 roamer pppd[3409]: Using interface ppp0
Dec  1 11:29:07 roamer pppd[3409]: Connect: ppp0 <--> /dev/ttyS1
Dec  1 11:29:13 roamer kernel: PPP Deflate Compression module registered
Dec  1 11:29:13 roamer pppd[3409]: local  IP address 9.184.120.238
Dec  1 11:29:13 roamer pppd[3409]: remote IP address 9.184.120.1
Dec  1 11:29:44 roamer pppd[3409]: Terminating connection due to lack of
activity.
Dec  1 11:29:44 roamer pppd[3409]: Connection terminated.
Dec  1 11:29:44 roamer pppd[3409]: Connect time 0.7 minutes.
Dec  1 11:29:44 roamer pppd[3409]: Sent 289 bytes, received 199 bytes.
Dec  1 11:29:44 roamer pppd[3409]: Using interface ppp0
Dec  1 11:29:44 roamer pppd[3409]: Connect: ppp0 <--> /dev/ttyS1
Dec  1 11:29:47 roamer pppd[3409]: Hangup (SIGHUP)
Dec  1 11:29:47 roamer pppd[3409]: Modem hangup
Dec  1 11:29:47 roamer pppd[3409]: Connection terminated.
Dec  1 11:29:47 roamer pppd[3409]: tcgetattr: No such device or address(6)
Dec  1 11:29:47 roamer pppd[3409]: Exit.

pppd dies similarly with this patch if idle and persist options are passed.  But, 
pppd does not die on older 2.6.5 based kernels -- with and without this patch.  
Maybe recent changes to tty subsystem has caused this behaviour?.  Since the 
patch doesn't kill pppd on 2.6.5 kernels, I think this patch is correct.  
Comments?

Thanks,
Kiran


Patch to cleanup reads to f_count from ppp driver, deprecate PPPIOCDETACH 
ioctl, and print warning messages if the ioctl is used.  

A new 'detached' field is included in struct ppp_file, and the ppp
channel/interface is marked as detached when PPPIOCDETACH is invoked
instead of checking the f_count and failing the ioctl for 'if the fd was
dup'd' case. The ppp structure is freed on last close.  If there has
been new attaches to the fd which was earlier detached, then the detached
ppp structures are added at the end of the detached_list of the new ppp
structure.  All the ppp structure that were detached from an fd are freed on
last close of that fd.
 
Patch tested with ppp-2.4.0 and ppp-2.4.2.  I could actually dial out :)

Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>

---
diff -ruN linux-2.6.9/drivers/net/ppp_generic.c file_count-ppp-2.6.9/drivers/net/ppp_generic.c
--- linux-2.6.9/drivers/net/ppp_generic.c	2004-10-19 03:25:24.000000000 +0530
+++ file_count-ppp-2.6.9/drivers/net/ppp_generic.c	2004-11-29 19:02:56.899670664 +0530
@@ -82,6 +82,9 @@
 	int		hdrlen;		/* space to leave for headers */
 	int		index;		/* interface unit / channel number */
 	int		dead;		/* unit/channel has been shut down */
+	int		detached;	/* device has been detached */
+	struct ppp_file *detached_list; /* List of detached ppp channels to
+					   free on vfs last close on fd */
 };
 
 #define PF_TO_X(pf, X)		((X *)((char *)(pf) - offsetof(X, file)))
@@ -365,6 +368,21 @@
 	return 0;
 }
 
+static void pf_release(struct ppp_file *pf)
+{
+	if (atomic_dec_and_test(&pf->refcnt)) {
+		switch (pf->kind) {
+		case INTERFACE:
+			ppp_destroy_interface(PF_TO_PPP(pf));
+			break;
+		case CHANNEL:
+			ppp_destroy_channel(PF_TO_CHANNEL(pf));
+			break;
+		}
+	}
+
+}
+	
 static int ppp_release(struct inode *inode, struct file *file)
 {
 	struct ppp_file *pf = file->private_data;
@@ -372,21 +390,18 @@
 
 	if (pf != 0) {
 		file->private_data = NULL;
-		if (pf->kind == INTERFACE) {
+		if (!pf->detached && (pf->kind == INTERFACE)) {
 			ppp = PF_TO_PPP(pf);
 			if (file == ppp->owner)
 				ppp_shutdown_interface(ppp);
 		}
-		if (atomic_dec_and_test(&pf->refcnt)) {
-			switch (pf->kind) {
-			case INTERFACE:
-				ppp_destroy_interface(PF_TO_PPP(pf));
-				break;
-			case CHANNEL:
-				ppp_destroy_channel(PF_TO_CHANNEL(pf));
-				break;
-			}
-		}
+
+		do {
+			struct ppp_file *oldpf;
+			oldpf = pf->detached_list;
+			pf_release(pf);
+			pf = oldpf;
+		} while (pf);
 	}
 	return 0;
 }
@@ -401,7 +416,7 @@
 
 	ret = count;
 
-	if (pf == 0)
+	if (pf == 0 || (pf && pf->detached))
 		return -ENXIO;
 	add_wait_queue(&pf->rwait, &wait);
 	for (;;) {
@@ -447,7 +462,7 @@
 	struct sk_buff *skb;
 	ssize_t ret;
 
-	if (pf == 0)
+	if (pf == 0 || (pf && pf->detached))
 		return -ENXIO;
 	ret = -ENOMEM;
 	skb = alloc_skb(count + pf->hdrlen, GFP_KERNEL);
@@ -483,7 +498,7 @@
 	struct ppp_file *pf = file->private_data;
 	unsigned int mask;
 
-	if (pf == 0)
+	if (pf == 0 || (pf && pf->detached))
 		return 0;
 	poll_wait(file, &pf->rwait, wait);
 	mask = POLLOUT | POLLWRNORM;
@@ -546,34 +561,33 @@
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
 
-	if (pf == 0)
+	if (pf == 0 || (pf && pf->detached))
 		return ppp_unattached_ioctl(pf, file, cmd, arg);
 
 	if (cmd == PPPIOCDETACH) {
 		/*
+		 * This ioctl is deprecated and should not be used
+		 * ioctl is lying around for binary compatibility and
+		 * will be junked at 2.7. Userland can get the same
+		 * effect as PPPIOCDETACH by closing this fd and
+		 * reopening /dev/ppp
+		 *
 		 * We have to be careful here... if the file descriptor
 		 * has been dup'd, we could have another process in the
 		 * middle of a poll using the same file *, so we had
 		 * better not free the interface data structures -
-		 * instead we fail the ioctl.  Even in this case, we
-		 * shut down the interface if we are the owner of it.
-		 * Actually, we should get rid of PPPIOCDETACH, userland
-		 * (i.e. pppd) could achieve the same effect by closing
-		 * this fd and reopening /dev/ppp.
+		 * instead we mark the interface datastructure as detached
+		 * and shut down the interface if we are the owner of it.
 		 */
-		err = -EINVAL;
 		if (pf->kind == INTERFACE) {
 			ppp = PF_TO_PPP(pf);
 			if (file == ppp->owner)
 				ppp_shutdown_interface(ppp);
 		}
-		if (atomic_read(&file->f_count) <= 2) {
-			ppp_release(inode, file);
-			err = 0;
-		} else
-			printk(KERN_DEBUG "PPPIOCDETACH file->f_count=%d\n",
-			       atomic_read(&file->f_count));
-		return err;
+		pf->detached = 1;
+		printk(KERN_WARNING "PPPIOCDETACH ioctl is deprecated; "
+				"Upgrade to ppp-2.4.2 or above.\n");
+		return 0;
 	}
 
 	if (pf->kind == CHANNEL) {
@@ -759,6 +773,14 @@
 	return err;
 }
 
+static void add_detached_ppp(struct ppp_file *oldpf, struct file *file)
+{
+	struct ppp_file *pf = file->private_data;
+	while (pf->detached_list)
+		pf = pf->detached_list;
+	pf->detached_list = oldpf;
+}
+
 static int ppp_unattached_ioctl(struct ppp_file *pf, struct file *file,
 				unsigned int cmd, unsigned long arg)
 {
@@ -766,6 +788,7 @@
 	struct ppp *ppp;
 	struct channel *chan;
 	int __user *p = (int __user *)arg;
+	struct ppp_file *oldpf = file->private_data;
 
 	switch (cmd) {
 	case PPPIOCNEWUNIT:
@@ -777,6 +800,20 @@
 			break;
 		file->private_data = &ppp->file;
 		ppp->owner = file;
+		
+		/* 
+		 * Add the detached ppp interface/channel that is hanging
+		 * off this fd to detached_list of the new ppp structure's
+		 * ppp_file.  oldpf could be in use if the fd was duped, 
+		 * another process was in the middle of a poll and a
+		 * PPPIOCDETACH had been invoked on this fd.
+		 * Last close on this fd will free up the new ppp
+		 * structures as well as the ppp sturcures in the detached
+		 * list.
+		 */
+		if (oldpf && oldpf->detached)
+				add_detached_ppp(oldpf, file);
+
 		err = -EFAULT;
 		if (put_user(ppp->file.index, p))
 			break;
@@ -790,9 +827,11 @@
 		down(&all_ppp_sem);
 		err = -ENXIO;
 		ppp = ppp_find_unit(unit);
-		if (ppp != 0) {
+		if (ppp != 0 && !ppp->file.detached) {
 			atomic_inc(&ppp->file.refcnt);
 			file->private_data = &ppp->file;
+			if (oldpf && oldpf->detached)
+				add_detached_ppp(oldpf, file);
 			err = 0;
 		}
 		up(&all_ppp_sem);
@@ -804,9 +843,11 @@
 		spin_lock_bh(&all_channels_lock);
 		err = -ENXIO;
 		chan = ppp_find_channel(unit);
-		if (chan != 0) {
+		if (chan != 0 && !chan->file.detached) {
 			atomic_inc(&chan->file.refcnt);
 			file->private_data = &chan->file;
+			if (oldpf && oldpf->detached)
+				add_detached_ppp(oldpf, file);
 			err = 0;
 		}
 		spin_unlock_bh(&all_channels_lock);
