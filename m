Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269765AbTGOVw6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269773AbTGOVw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:52:58 -0400
Received: from ierw.net.avaya.com ([198.152.13.101]:35304 "EHLO
	ierw.net.avaya.com") by vger.kernel.org with ESMTP id S269765AbTGOVwy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:52:54 -0400
From: "Bhavesh P. Davda" <bhavesh@avaya.com>
To: <linux-kernel@vger.kernel.org>
Cc: <fischer@norbit.de>, <dahinds@users.sourceforge.net>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>
Subject: RE: [PATCH] AHA152x driver hangs on PCMCIA card eject, kernel 2.4.22-pre6
Date: Tue, 15 Jul 2003 16:07:44 -0600
Message-ID: <01e601c34b1d$84a88fc0$6e260987@rnd.avaya.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01E7_01C34AEB.3A0E1FC0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: 
X-OriginalArrivalTime: 15 Jul 2003 22:07:44.0925 (UTC) FILETIME=[84B75CD0:01C34B1D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_01E7_01C34AEB.3A0E1FC0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Whoops! Sent it without proof-reading. I AM SORRY! Please ignore the
previous patch, here is the correct patch ...

Thanks
- Bhavesh

--
Bhavesh P. Davda     E-mail    : bhavesh@avaya.com
Avaya Inc.           Phone/Fax : (303) 538-4438
Room B3-B03, 1300 West 120th Avenue
Westminster, CO 80234

> -----Original Message-----
> From: Bhavesh P. Davda
> Sent: Tuesday, July 15, 2003 3:57 PM
> To: linux-kernel@vger.kernel.org
> Cc: fischer@norbit.de; dahinds@users.sourceforge.net; Marcelo Tosatti
> Subject: [PATCH] AHA152x driver hangs on PCMCIA card eject, kernel
> 2.4.22-pre6
>
>
> Juergen, David; please review this patch, and recommend that
> Marcelo apply this patch if you think it is okay... Thanks!
>
> Attached is a patch against linux-2.4.22-pre6, to fix a hang
> problem when an Adaptec SlimSCSI (PCMCIA) adapter is ejected from
> a PCMCIA card reader (e.g. yenta/TI1225 based).
>
> The fix involves:
>
> 1. A change to the common aha152x driver to ignore an interrupt
> in the top-half handler if it cannot read valid data from the I/O
> ports (possibly due to a bad host-adapter chip or an ejected
> PCMCIA card). This way, a shared interrupt handler (e.g. yenta)
> can pick up the interrupt if the IRQ is really meant for it. This
> is where the original hang was taking place; the aha152x bottom
> half was getting into an infinite loop, though the SlimSCSI card
> had been ejected, and the actual IRQ was meant for yenta.
>
> 2. A change to the aha152x_cs stub driver to not use the SCSI
> error-handling thread code. The aha152x_cs driver calls
> scsi_unregister_module() as a queued timer task when it gets a
> CS_EVENT_CARD_REMOVAL event, which causes scsi_unregister_host()
> to do a down() on a semaphore, calling schedule(), when executing
> the timer_bh for the timer.
>
> Thanks!
>
> - Bhavesh
> --
> Bhavesh P. Davda     E-mail    : bhavesh@avaya.com
> Avaya Inc.           Phone/Fax : (303) 538-4438
> Room B3-B03, 1300 West 120th Avenue
> Westminster, CO 80234

------=_NextPart_000_01E7_01C34AEB.3A0E1FC0
Content-Type: application/octet-stream;
	name="linux-2.4.22-aha152x.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.4.22-aha152x.patch"

diff -Naur linux-2.4.22-pre6/drivers/scsi/aha152x.c =
linux-2.4.22-bpd/drivers/scsi/aha152x.c=0A=
--- linux-2.4.22-pre6/drivers/scsi/aha152x.c	2003-06-13 =
08:51:36.000000000 -0600=0A=
+++ linux-2.4.22-bpd/drivers/scsi/aha152x.c	2003-07-15 =
16:05:09.000000000 -0600=0A=
@@ -1930,12 +1930,30 @@=0A=
 static void intr(int irqno, void *dev_id, struct pt_regs *regs)=0A=
 {=0A=
 	struct Scsi_Host *shpnt =3D lookup_irq(irqno);=0A=
+	unsigned char rev, dmacntrl0;=0A=
 =0A=
 	if (!shpnt) {=0A=
 		printk(KERN_ERR "aha152x: catched interrupt %d for unknown =
controller.\n", irqno);=0A=
 		return;=0A=
 	}=0A=
 =0A=
+	/*=0A=
+	 * Read a couple of registers that are known to not be all 1's. If=0A=
+	 * we read all 1's (-1), that means that either:=0A=
+	 * a. The host adapter chip has gone bad, and we cannot control it,=0A=
+	 * OR=0A=
+	 * b. The host adapter is a PCMCIA card that has been ejected=0A=
+	 * In either case, we cannot do anything with the host adapter at=0A=
+	 * this point in time. So just ignore the interrupt and return.=0A=
+	 * In the latter case, the interrupt might actually be meant for=0A=
+	 * someone else sharing this IRQ, and that driver will handle it=0A=
+	 */=0A=
+	rev =3D GETPORT(REV);=0A=
+	dmacntrl0 =3D GETPORT(DMACNTRL0);=0A=
+	if ((rev =3D=3D 0xFF) && (dmacntrl0 =3D=3D 0xFF)) {=0A=
+		return;=0A=
+	}=0A=
+=0A=
 	/* no more interrupts from the controller, while we're busy.=0A=
 	   INTEN is restored by the BH handler */=0A=
 	CLRBITS(DMACNTRL0, INTEN);=0A=
diff -Naur linux-2.4.22-pre6/drivers/scsi/pcmcia/aha152x_stub.c =
linux-2.4.22-bpd/drivers/scsi/pcmcia/aha152x_stub.c=0A=
--- linux-2.4.22-pre6/drivers/scsi/pcmcia/aha152x_stub.c	2001-12-21 =
10:41:55.000000000 -0700=0A=
+++ linux-2.4.22-bpd/drivers/scsi/pcmcia/aha152x_stub.c	2003-07-15 =
14:41:20.000000000 -0600=0A=
@@ -244,6 +244,11 @@=0A=
 =0A=
     /* Configure card */=0A=
     driver_template.module =3D &__this_module;=0A=
+    /* =0A=
+     * Don't use the SCSI error handling thread. This causes schedule() =
to=0A=
+     * be called from the timer_bh when the AHA152x card is ejected=0A=
+     */=0A=
+    driver_template.use_new_eh_code =3D 0;=0A=
     link->state |=3D DEV_CONFIG;=0A=
 =0A=
     tuple.DesiredTuple =3D CISTPL_CFTABLE_ENTRY;=0A=

------=_NextPart_000_01E7_01C34AEB.3A0E1FC0--

