Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261997AbREPT63>; Wed, 16 May 2001 15:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262012AbREPT6T>; Wed, 16 May 2001 15:58:19 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:54838 "EHLO
	phenoxide.engr.valinux.com") by vger.kernel.org with ESMTP
	id <S261997AbREPT6H>; Wed, 16 May 2001 15:58:07 -0400
Date: Wed, 16 May 2001 12:56:55 -0700
From: Johannes Erdfelt <jerdfelt@valinux.com>
To: Shane Wegner <shane@cm.nu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.20pre1: Problems with SMP
Message-ID: <20010516125655.S906@valinux.com>
In-Reply-To: <20010506175050.A1968@cm.nu> <E14wiNn-0003JF-00@the-village.bc.nu> <20010507102053.A2276@cm.nu> <20010507110250.H903@valinux.com> <20010507111436.A17314@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010507111436.A17314@cm.nu>; from shane@cm.nu on Mon, May 07, 2001 at 11:14:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001, Shane Wegner <shane@cm.nu> wrote:
> On Mon, May 07, 2001 at 11:02:50AM -0700, Johannes Erdfelt wrote:
> > On Mon, May 07, 2001, Shane Wegner <shane@cm.nu> wrote:
> > > 
> > > That does indeed correct the problem.  2.2.20pre1 now works
> > > as expected.
> > 
> > Hmm, that uses a VIA based chipset. I didn't know they did SMP yet. Does
> > 2.4 work on this system?
> 
> The last 2.4 kernel I tried was 2.4.3 I believe and it
> worked fine more or less.  I haven't tried any later 2.4
> kernels yet.

Could you try this patch? It applies on top of 2.2.20pre1

It also cleans up a couple of comments

JE

--- arch/i386/kernel/io_apic.c.old	Wed May 16 12:48:03 2001
+++ arch/i386/kernel/io_apic.c	Wed May 16 12:55:30 2001
@@ -204,6 +204,8 @@
 /*
  * We disable IO-APIC IRQs by setting their 'destination CPU mask' to
  * zero. Trick by Ramesh Nalluri.
+ * Not anymore. This causes problems on some IO-APIC's, notably AMD 760MP's
+ * So we do it a more 2.4 kind of way now which should be safer -jerdfelt
  */
 DO_ACTION( mask,    0, |= 0x00010000, io_apic_sync(entry->apic))/* mask = 1 */
 DO_ACTION( unmask,  0, &= 0xfffeffff, )				/* mask = 0 */
@@ -646,8 +648,8 @@
 
 		entry.delivery_mode = dest_LowestPrio;
 		entry.dest_mode = 1;			/* logical delivery */
-		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = 0xff;	/* but no route */
+		entry.mask = 1;				/* disable IRQ */
+		entry.dest.logical.logical_dest = 0xff;
 
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {
