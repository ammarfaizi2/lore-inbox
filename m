Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293308AbSBYDlg>; Sun, 24 Feb 2002 22:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293310AbSBYDl0>; Sun, 24 Feb 2002 22:41:26 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:12306 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S293309AbSBYDlH>; Sun, 24 Feb 2002 22:41:07 -0500
Date: Sun, 24 Feb 2002 22:41:07 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Dan Hopper <dbhopper@austin.rr.com>, lkml <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.5.5-pre1 rmmod usb-uhci hangs
Message-ID: <20020224224107.D17788@sventech.com>
In-Reply-To: <fa.n7cofbv.1him3j@ifi.uio.no> <fa.dsb79pv.on84ii@ifi.uio.no> <20020224025411.GA2418@yoda.dummynet> <20020224062124.GB15060@kroah.com> <20020224063915.GA2799@yoda.dummynet> <20020224064931.GD15060@kroah.com> <20020224173711.GA2355@yoda.dummynet> <20020224125055.A5232@sventech.com> <20020224184943.GA2492@yoda.dummynet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020224184943.GA2492@yoda.dummynet>; from dbhopper@austin.rr.com on Sun, Feb 24, 2002 at 12:49:43PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 24, 2002, Dan Hopper <dbhopper@austin.rr.com> wrote:
> Johannes Erdfelt <johannes@erdfelt.com> remarked:
> > Hmm, that is interesting. I wonder what is going on with it. Are you
> > using the scanner kernel driver?
> 
> Yes.  And sane 1.0.5.  FWIW, the command I'm using that stutters
> with uhci and not usb-uhci is:
> 
> scanimage --mode lineart --resolution 600 -x 203.2 -y 271.0 \
> 	--contrast 0 --brightness 0  > /tmp/copy.pbm
> 
> That results in a 3848837 byte file in about 37 seconds with
> usb-uhci.  Not exactly pushing the USB 1.1 bandwidth.  (unless
> there's a significant discrepancy between the bits coming from the
> scanner and those scanimage dumps to the file, I suppose)

Can you give this patch a whirl? It's relative to 2.4.18-rc2-gregkh-1

JE


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="uhci-2.4.18-rc2-gregkh-1-fsbr.patch"

diff -ur linux-2.4.18-rc2-gregkh-1.orig/drivers/usb/uhci.c linux-2.4.18-rc2-gregkh-1/drivers/usb/uhci.c
--- linux-2.4.18-rc2-gregkh-1.orig/drivers/usb/uhci.c	Sun Feb 24 15:13:59 2002
+++ linux-2.4.18-rc2-gregkh-1/drivers/usb/uhci.c	Sun Feb 24 15:14:43 2002
@@ -57,7 +57,6 @@
 
 #include <linux/pm.h>
 
-
 /*
  * Version Information
  */
@@ -65,7 +64,6 @@
 #define DRIVER_AUTHOR "Linus 'Frodo Rabbit' Torvalds, Johannes Erdfelt, Randy Dunlap, Georg Acher, Deti Fliegl, Thomas Sailer, Roman Weissgaerber"
 #define DRIVER_DESC "USB Universal Host Controller Interface driver"
 
-
 /*
  * debug = 0, no debugging messages
  * debug = 1, dump failed URB's except for stalls
@@ -100,6 +98,7 @@
 
 /* If a transfer is still active after this much time, turn off FSBR */
 #define IDLE_TIMEOUT	(HZ / 20)	/* 50 ms */
+#define FSBR_DELAY	(HZ / 20)	/* 50 ms */
 
 #define MAX_URB_LOOP	2048		/* Maximum number of linked URB's */
 
@@ -766,7 +765,7 @@
 	if ((!(urb->transfer_flags & USB_NO_FSBR)) && urbp->fsbr) {
 		urbp->fsbr = 0;
 		if (!--uhci->fsbr)
-			uhci->skel_term_qh->link = UHCI_PTR_TERM;
+			uhci->fsbrtimeout = jiffies + FSBR_DELAY;
 	}
 
 	spin_unlock_irqrestore(&uhci->frame_list_lock, flags);
@@ -2021,6 +2020,12 @@
 
 		u->transfer_flags |= USB_ASYNC_UNLINK | USB_TIMEOUT_KILLED;
 		uhci_unlink_urb(u);
+	}
+
+	/* Really disable FSBR */
+	if (!uhci->fsbr && uhci->fsbrtimeout && time_after_eq(jiffies, uhci->fsbrtimeout)) {
+		uhci->fsbrtimeout = 0;
+		uhci->skel_term_qh->link = UHCI_PTR_TERM;
 	}
 
 	/* enter global suspend if nothing connected */
diff -ur linux-2.4.18-rc2-gregkh-1.orig/drivers/usb/uhci.h linux-2.4.18-rc2-gregkh-1/drivers/usb/uhci.h
--- linux-2.4.18-rc2-gregkh-1.orig/drivers/usb/uhci.h	Sun Feb 24 15:13:59 2002
+++ linux-2.4.18-rc2-gregkh-1/drivers/usb/uhci.h	Sun Feb 24 14:46:38 2002
@@ -309,6 +309,7 @@
 	spinlock_t frame_list_lock;
 	struct uhci_frame_list *fl;		/* P: uhci->frame_list_lock */
 	int fsbr;				/* Full speed bandwidth reclamation */
+	unsigned long fsbrtimeout;		/* FSBR delay */
 	int is_suspended;
 
 	/* Main list of URB's currently controlled by this HC */

--vtzGhvizbBRQ85DL--
