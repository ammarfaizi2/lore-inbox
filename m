Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268762AbTBZMdk>; Wed, 26 Feb 2003 07:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268758AbTBZMdj>; Wed, 26 Feb 2003 07:33:39 -0500
Received: from daimi.au.dk ([130.225.16.1]:3305 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S268762AbTBZMdf>;
	Wed, 26 Feb 2003 07:33:35 -0500
Message-ID: <3E5CB684.5A26BCA6@daimi.au.dk>
Date: Wed, 26 Feb 2003 13:43:48 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic in i810
References: <3E595ED3.5D86FE45@daimi.au.dk>
Content-Type: multipart/mixed;
 boundary="------------90F5A754A937CFCB63F8E7B6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------90F5A754A937CFCB63F8E7B6
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Kasper Dupont wrote:
> 
> I have a reproducable kernel panic with different 2.4.x kernels.
> I'm using XFree86-4.2.0-8 with a i810 onboard chipset. Sometimes
> when I log off X the kernel panics. This can be reproduced by
> loging in on a VC as root and typing:
> 
> while [ ! -f /tmp/stopit ] ; do
> killall gdmlogin || killall gdm ; sleep 7 ; deallocvt
> done

I made a patch, that at least prevents the system from panicing.
This is just a workaround, probably the problem is really
somewhere else. My guess is that something in the driver cleanup
is being done in an incorrect order, but I do have some problems
following this code.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
--------------90F5A754A937CFCB63F8E7B6
Content-Type: text/plain; charset=us-ascii;
 name="i810.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i810.patch"

diff -Nur linux.old/drivers/char/drm/i810_dma.c linux.new/drivers/char/drm/i810_dma.c
--- linux.old/drivers/char/drm/i810_dma.c	Wed Feb 26 13:36:14 2003
+++ linux.new/drivers/char/drm/i810_dma.c	Wed Feb 26 13:36:20 2003
@@ -894,6 +894,7 @@
 void i810_dma_service(int irq, void *device, struct pt_regs *regs)
 {
 	drm_device_t	 *dev = (drm_device_t *)device;
+	if (dev && dev->dev_private && dev->counts) {
       	drm_i810_private_t *dev_priv = (drm_i810_private_t *)dev->dev_private;
    	u16 temp;
 
@@ -907,6 +908,9 @@
 
    	queue_task(&dev->tq, &tq_immediate);
    	mark_bh(IMMEDIATE_BH);
+	} else {
+	  printk(KERN_CRIT __FUNCTION__ ": NULL pointer\n");
+	}
 }
 
 void i810_dma_immediate_bh(void *device)

--------------90F5A754A937CFCB63F8E7B6--

