Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUGFRv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUGFRv1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 13:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUGFRv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 13:51:27 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:44727 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264246AbUGFRvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 13:51:21 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
Date: Tue, 6 Jul 2004 12:51:16 -0500
User-Agent: KMail/1.6.2
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>
References: <20040705023120.34f7772b.akpm@osdl.org> <20040706125438.GS21066@holomorphy.com>
In-Reply-To: <20040706125438.GS21066@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407061251.18702.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 July 2004 07:54 am, William Lee Irwin III wrote:
> On Mon, Jul 05, 2004 at 02:31:20AM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm6/
> > - Added the DVD-RW/CD-RW packet writing patches.  These need more work.
> > - The USB update seems deadlocky.  I fixed one bug but it still causes my
> >   ia64 test box to lock up on boot.  If it goes bad, please revert
> >   usb-locking-fix.patch and then revert bk-usb.patch.  Retest and send a report
> >   to linux-kernel and linux-usb-devel@lists.sourceforge.net.
> 
> Uneventful on alpha, needed a make rpm compilefix Andi's got queued for
> the next merge on x86-64 and otherwise uneventful there.
> 
> OTOH, various things made sparc64 a living Hell that took about 9
> hours of solid compile/boot/crash drudgery to carry out bisection
> search on to find the offending patches.
> 
> First, I had to back out bk-input because it has a sysfsification patch
> that deadlocks sunzilog.c at boot.
>
 
Ok, I think I know what the problem is - it should be an oops rather than a
deadlock though - serial drivers are initialized before serio core when serio
bus structure is not registered with driver core yet. Could you please try
the patch below - I do not have hardware to test it:

===== drivers/Makefile 1.43 vs edited =====
--- 1.43/drivers/Makefile	2004-06-28 23:00:49 -05:00
+++ edited/drivers/Makefile	2004-07-06 12:46:54 -05:00
@@ -15,6 +15,9 @@
 # char/ comes before serial/ etc so that the VT console is the boot-time
 # default.
 obj-y				+= char/
+# we also need input/serio early so seio bus is initialized by the time
+# serial drivers start registering their serio ports
+obj-$(CONFIG_SERIO)		+= input/serio/
 obj-y				+= serial/
 obj-$(CONFIG_PARPORT)		+= parport/
 obj-y				+= base/ block/ misc/ net/ media/
@@ -37,7 +40,6 @@
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_USB)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
-obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_I2O)		+= message/
