Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263851AbRFHF6I>; Fri, 8 Jun 2001 01:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263852AbRFHF57>; Fri, 8 Jun 2001 01:57:59 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33466 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263851AbRFHF5q>;
	Fri, 8 Jun 2001 01:57:46 -0400
Message-ID: <3B206954.CD461E00@mandrakesoft.com>
Date: Fri, 08 Jun 2001 01:57:40 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Krowne <akrowne@vt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what's up with IRQ routing in 2.4.x ?
In-Reply-To: <200106080410.f584Aj021251@mailrtr04.ntelos.net>
Content-Type: multipart/mixed;
 boundary="------------7AA9EC7640022C6E617BD774"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7AA9EC7640022C6E617BD774
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Aaron Krowne wrote:
> I have an AMD KT133A system.  I have two friends with PIII-based laptops (one
> toshiba, one thinkpad.)  We have all noticed the exact same strange behavior
> despite our various hardware.  We're all running linux 2.4.4 or 2.4.5.  The
> strange thing is that, whenever it has the opportunity to set an IRQ, linux
> puts the device in question on the same IRQ which seems fixed for the system.
> But it gets stranger.  This IRQ is always IRQ 11.  On all 3 systems.  On my
> system, I can specify "assign IRQ for USB".  When I do this, USB gets its own
> IRQ and works (sorta).  When I do not, USB goes on IRQ 11 too!  And, in this
> case, lots of devices on USB refuse their addresses and such, which does not
> happen when USB has its own IRQ.

I'm curious if the attached patch helps anything.

Also, note that I fixed some Via-mobo-related issues in the following
patch:
ftp://ftp.us.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.6/via-fixup-2.4.6.1.patch.gz

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
--------------7AA9EC7640022C6E617BD774
Content-Type: text/plain; charset=us-ascii;
 name="irq-alloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="irq-alloc.patch"

Index: arch/i386/kernel/pci-irq.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/arch/i386/kernel/pci-irq.c,v
retrieving revision 1.1.1.60
diff -u -r1.1.1.60 pci-irq.c
--- arch/i386/kernel/pci-irq.c	2001/06/05 02:40:23	1.1.1.60
+++ arch/i386/kernel/pci-irq.c	2001/06/08 05:43:34
@@ -498,6 +498,7 @@
 	struct irq_info *info;
 	int i, pirq, newirq;
 	int irq = 0;
+	int retried = 0;
 	u32 mask;
 	struct irq_router *r = pirq_router;
 	struct pci_dev *dev2;
@@ -534,16 +535,24 @@
 	 * reported by the device if possible.
 	 */
 	newirq = dev->irq;
+
+assign_retry:
 	if (!newirq && assign) {
 		for (i = 0; i < 16; i++) {
 			if (!(mask & (1 << i)))
 				continue;
 			if (pirq_penalty[i] < pirq_penalty[newirq] &&
-			    !request_irq(i, pcibios_test_irq_handler, SA_SHIRQ, "pci-test", dev)) {
+			    !request_irq(i, pcibios_test_irq_handler,
+			    		 retried ? SA_SHIRQ : 0,
+					 "pci-test", dev)) {
 				free_irq(i, dev);
 				newirq = i;
 			}
 		}
+	}
+	if (!newirq && !retried) {
+		retried = 1;
+		goto assign_retry;
 	}
 	DBG(" -> newirq=%d", newirq);
 

--------------7AA9EC7640022C6E617BD774--

