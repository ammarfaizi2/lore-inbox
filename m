Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263918AbRFHH4f>; Fri, 8 Jun 2001 03:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263917AbRFHH4Z>; Fri, 8 Jun 2001 03:56:25 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37563 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263881AbRFHH4O>;
	Fri, 8 Jun 2001 03:56:14 -0400
Message-ID: <3B208517.3D822AE@mandrakesoft.com>
Date: Fri, 08 Jun 2001 03:56:07 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Krowne <akrowne@vt.edu>
Cc: linux-kernel@vger.kernel.org, mj@ucw.cz,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Re: what's up with IRQ routing in 2.4.x ?
In-Reply-To: <200106080410.f584Aj021251@mailrtr04.ntelos.net>
	    <3B206954.CD461E00@mandrakesoft.com> <200106080651.f586pXj15998@mailrtr02.ntelos.net>
Content-Type: multipart/mixed;
 boundary="------------A382DAEC272DA100A8E6C15D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A382DAEC272DA100A8E6C15D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Aaron Krowne wrote:
> 
> On Fri, 08 Jun 2001 01:57:40 -0400, Jeff Garzik said:
> 
> > Aaron Krowne wrote:
> >  > I have an AMD KT133A system.  I have two friends with PIII-based laptops (one
> >  > toshiba, one thinkpad.)  We have all noticed the exact same strange behavior
> >  > despite our various hardware.  We're all running linux 2.4.4 or 2.4.5.  The
> >  > strange thing is that, whenever it has the opportunity to set an IRQ, linux
> >  > puts the device in question on the same IRQ which seems fixed for the system.
> >  > But it gets stranger.  This IRQ is always IRQ 11.  On all 3 systems.  On my
> >  > system, I can specify "assign IRQ for USB".  When I do this, USB gets its own
> >  > IRQ and works (sorta).  When I do not, USB goes on IRQ 11 too!  And, in this
> >  > case, lots of devices on USB refuse their addresses and such, which does not
> >  > happen when USB has its own IRQ.
> >
> >  I'm curious if the attached patch helps anything.
> >
> >  Also, note that I fixed some Via-mobo-related issues in the following
> >  patch:
> >  ftp://ftp.us.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.6/via-fixup-2.4.6.1.patch.gz
> 
> Ok, I applied both patches and rebooted.  Some error messages slightly changed
> regarding the USB, some devices were stubborn about accepting addresses
> (scanner and mouse still worked, digital cam didn't (as before)).  Network and
> sound card both went to IRQ 11 again.  Still PIRQ routing errors.

Ok, here's another patch for you to play with.  The previous patch did
dumb things because I forgot about pirq_penalty's reason for existence. 
You still want the 'via-fixup' patch, along with the attached one to
try.

This patch makes IRQ allocation even more likely to be spread, by
preferring to re-assign irqs to the one we selected.  This is untested,
so flyer beware...  It also adds better information to these warnings,
to make dmesg more helpful, and turns on PCI debugging, so you don't
have to do so manually.

For the most part, the kernel doing exactly what the BIOS is telling it
to do.  So, if the BIOS thinks its a good idea to put all the devices on
one IRQ, then the kernel will go right ahead and do so...

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
--------------A382DAEC272DA100A8E6C15D
Content-Type: text/plain; charset=us-ascii;
 name="irq-alloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irq-alloc.patch"

Index: arch/i386/kernel/pci-i386.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/arch/i386/kernel/pci-i386.h,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.292.1
diff -u -r1.1.1.2 -r1.1.1.2.292.1
--- arch/i386/kernel/pci-i386.h	2000/10/22 20:05:16	1.1.1.2
+++ arch/i386/kernel/pci-i386.h	2001/06/05 03:28:58	1.1.1.2.292.1
@@ -4,7 +4,7 @@
  *	(c) 1999 Martin Mares <mj@ucw.cz>
  */
 
-#undef DEBUG
+#define DEBUG 1
 
 #ifdef DEBUG
 #define DBG(x...) printk(x)
Index: arch/i386/kernel/pci-irq.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/arch/i386/kernel/pci-irq.c,v
retrieving revision 1.1.1.60
diff -u -r1.1.1.60 pci-irq.c
--- arch/i386/kernel/pci-irq.c	2001/06/05 02:40:23	1.1.1.60
+++ arch/i386/kernel/pci-irq.c	2001/06/08 07:50:29
@@ -552,9 +552,6 @@
 		irq = pirq & 0xf;
 		DBG(" -> hardcoded IRQ %d\n", irq);
 		msg = "Hardcoded";
-	} else if (r->get && (irq = r->get(pirq_router_dev, dev, pirq))) {
-		DBG(" -> got IRQ %d\n", irq);
-		msg = "Found";
 	} else if (newirq && r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
 		DBG(" -> assigning IRQ %d", newirq);
 		if (r->set(pirq_router_dev, dev, pirq, newirq)) {
@@ -564,6 +561,10 @@
 			irq = newirq;
 		}
 	}
+	if (!msg && r->get && (irq = r->get(pirq_router_dev, dev, pirq))) {
+		DBG(" -> got IRQ %d\n", irq);
+		msg = "Found";
+	}
 
 	if (!irq) {
 		DBG(" ... failed\n");
@@ -587,13 +588,14 @@
 		if (info->irq[pin].link == pirq) {
 			/* We refuse to override the dev->irq information. Give a warning! */
 		    	if (dev2->irq && dev2->irq != irq) {
-		    		printk(KERN_INFO "IRQ routing conflict in pirq table for device %s\n", dev2->slot_name);
+		    		printk(KERN_INFO "IRQ routing conflict for %s, have irq %d, want irq %d\n",
+				       dev2->slot_name, dev2->irq, irq);
 		    		continue;
 		    	}
 			dev2->irq = irq;
 			pirq_penalty[irq]++;
 			if (dev != dev2)
-				printk(KERN_INFO "PCI: The same IRQ used for device %s\n", dev2->slot_name);
+				printk(KERN_INFO "PCI: Sharing IRQ %d with %s\n", irq, dev2->slot_name);
 		}
 	}
 	return 1;

--------------A382DAEC272DA100A8E6C15D--

