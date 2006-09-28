Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161402AbWI2AAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161402AbWI2AAP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161394AbWI2AAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:00:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9877 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161402AbWI2AAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:00:12 -0400
Date: Thu, 28 Sep 2006 16:59:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] More USB patches for 2.6.18
Message-Id: <20060928165951.2c5bd4c7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609281639040.3952@g5.osdl.org>
References: <20060928224250.GA23841@kroah.com>
	<Pine.LNX.4.64.0609281639040.3952@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 16:40:23 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Thu, 28 Sep 2006, Greg KH wrote:
> >
> > Here are some more USB bugfixes and device ids 2.6.18.  They should all
> > fix the reported problems in your current tree (if not, please let me
> > know.)
> > 
> > All of these changes have been in the -mm tree for a while.
> 
> Maybe I shouldn't have hurried you.
> 
> 	In file included from drivers/usb/host/ohci-hcd.c:140:
> 	drivers/usb/host/ohci-hub.c: In function 'ohci_rh_resume':
> 	drivers/usb/host/ohci-hub.c:184: error: invalid storage class for function 'ohci_restart'
> 	drivers/usb/host/ohci-hub.c:188: warning: implicit declaration of function 'ohci_restart'
> 	drivers/usb/host/ohci-hcd.c: At top level:
> 	drivers/usb/host/ohci-hcd.c:815: error: static declaration of 'ohci_restart' follows non-static declaration
> 	drivers/usb/host/ohci-hub.c:188: error: previous implicit declaration of 'ohci_restart' was here
> 	make[3]: *** [drivers/usb/host/ohci-hcd.o] Error 1
> 	make[2]: *** [drivers/usb/host] Error 2
> 	make[1]: *** [drivers/usb] Error 2
> 	make: *** [drivers] Error 2
> 

That's the "some gccs dont like static function decls in that scope" thing.

I fixed it (unpleasantly) like this:


diff -puN drivers/usb/host/ohci-hub.c~ohci-add-auto-stop-support-hack-hack drivers/usb/host/ohci-hub.c
--- a/drivers/usb/host/ohci-hub.c~ohci-add-auto-stop-support-hack-hack
+++ a/drivers/usb/host/ohci-hub.c
@@ -132,6 +132,10 @@ static inline struct ed *find_head (stru
 	return ed;
 }
 
+#ifdef CONFIG_PM
+static int ohci_restart(struct ohci_hcd *ohci);
+#endif
+
 /* caller has locked the root hub */
 static int ohci_rh_resume (struct ohci_hcd *ohci)
 __releases(ohci->lock)
@@ -181,8 +185,6 @@ __acquires(ohci->lock)
 #ifdef	CONFIG_PM
 	if (status == -EBUSY) {
 		if (!autostopped) {
-			static int ohci_restart (struct ohci_hcd *ohci);
-
 			spin_unlock_irq (&ohci->lock);
 			(void) ohci_init (ohci);
 			status = ohci_restart (ohci);
_

