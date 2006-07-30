Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWG3Aws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWG3Aws (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 20:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWG3Aws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 20:52:48 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:35076 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750898AbWG3Awr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 20:52:47 -0400
Date: Sat, 29 Jul 2006 20:48:50 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Andrew Morton <akpm@osdl.org>
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, marcel@holtman.org, fpavlic@de.ibm.com,
       paulus@au.ibm.com, bcollins@debian.org, tony.luck@intel.com
Subject: Re: [KJ] (re) audit return code handling for kernel_thread [1/3]
Message-ID: <20060730004850.GA9344@localhost.localdomain>
References: <20060729201139.GA8574@localhost.localdomain> <20060729201555.GB8574@localhost.localdomain> <20060729170333.a45efeaf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729170333.a45efeaf.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 05:03:33PM -0700, Andrew Morton wrote:
> On Sat, 29 Jul 2006 16:15:55 -0400
> Neil Horman <nhorman@tuxdriver.com> wrote:
> 
> > Patch to audit return code checking of kernel_thread.  These fixes correct those
> > callers who fail to check the return code of kernel_thread at all
> > 
> > 
> 
> Various people are running around converting open-coded kernel_thread
> callers over to the kthread API.  Generally that's a good thing, and error
> checking should be incorporated at that time.
> 
> So there's probably not a lot of point in making these changes now - it'd
> be better to work with the various subsystem owners on doing the kthread
> conversion.
> 
> > --- a/arch/s390/mm/cmm.c
> > +++ b/arch/s390/mm/cmm.c
> > @@ -161,7 +161,11 @@ cmm_thread(void *dummy)
> >  static void
> >  cmm_start_thread(void)
> >  {
> > -	kernel_thread(cmm_thread, NULL, 0);
> > +	if (kernel_thread(cmm_thread, NULL, 0) < 0) {
> > +		printk(KERN_WARNING "Could not start kernel thread at %s:%d\n",
> > +			__FUNCTION__,__LINE__);
> > +		clear_bit(0,&cmm_thread_active);
> > +	}
> >  }
> 
> This is OK as far as it goes.  But really we should propagate any failure
> back up to cmm_init() and fail the whole thing, rather than leaving the
> driver hanging around in a loaded-but-useless state.


Understood, new patch attached, that removes most of the additional failure to
check return code cases.  I've left the cmm_start_thread case and the
rfcomm_init cases as is, because the cmm_start_thread case is called
asynchronously from a work queue, fired from a timer, meaning we cannot
propogate the error to prevent the module from loading, and the rfcomm_init case
does precisely what you ask, in that it detects a failure to start the kernel
thread, and fails the module load if the thread creation fails.

Thanks & Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 arch/s390/mm/cmm.c          |    6 +++++-
 net/bluetooth/rfcomm/core.c |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)


--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -161,7 +161,11 @@
 static void
 cmm_start_thread(void)
 {
-	kernel_thread(cmm_thread, NULL, 0);
+	if (kernel_thread(cmm_thread, NULL, 0) < 0) {
+		printk(KERN_WARNING "Could not start kernel thread at %s:%d\n",
+			__FUNCTION__,__LINE__);
+		clear_bit(0,&cmm_thread_active);
+	}
 }
 
 
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2052,11 +2052,15 @@
 /* ---- Initialization ---- */
 static int __init rfcomm_init(void)
 {
+	int ret;
 	l2cap_load();
 
 	hci_register_cb(&rfcomm_cb);
 
-	kernel_thread(rfcomm_run, NULL, CLONE_KERNEL);
+	ret = kernel_thread(rfcomm_run, NULL, CLONE_KERNEL);
+	
+	if (ret < 0)
+		return ret;
 
 	class_create_file(bt_class, &class_attr_rfcomm_dlc);
 
