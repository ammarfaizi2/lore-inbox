Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSIDWYu>; Wed, 4 Sep 2002 18:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSIDWYu>; Wed, 4 Sep 2002 18:24:50 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:32519
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S315709AbSIDWYt>; Wed, 4 Sep 2002 18:24:49 -0400
Subject: Re: Irq handler reentrancy ?
From: Robert Love <rml@tech9.net>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20020904221853.GB21494@bougret.hpl.hp.com>
References: <20020904221853.GB21494@bougret.hpl.hp.com>
Content-Type: multipart/mixed; boundary="=-p6UmFpr93PMqaNEKK12i"
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Sep 2002 18:29:28 -0400
Message-Id: <1031178569.24333.3685.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p6UmFpr93PMqaNEKK12i
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2002-09-04 at 18:18, Jean Tourrilhes wrote:

> 	Just a quick question : can an interrupt handler be preempted
> or reenter itself ?

It is not supposed to.

There is a bug in 2.5, with a fix from Linus currently in bitkeeper.  I
have attached the patch.

	Robert Love

--=-p6UmFpr93PMqaNEKK12i
Content-Disposition: attachment; filename=cset-1.611.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=cset-1.611.txt; charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.610   -> 1.611 =20
#	arch/i386/kernel/irq.c	1.17    -> 1.18  =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/04	torvalds@home.transmeta.com	1.611
# Fix IO-APIC edge IRQ handling. IRQ_INPROGRESS was cleared spuriously
# if a new edge happened while we were still processing the previous
# one.
#=20
# Then, if a _third_ edge came in, it would actually cause a reentrant
# irq handler invocation, because the original INPROGRESS bit was now
# lost.
#=20
# This was actually seen on IDE in PIO mode.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Wed Sep  4 12:00:11 2002
+++ b/arch/i386/kernel/irq.c	Wed Sep  4 12:00:11 2002
@@ -380,8 +380,9 @@
 			break;
 		desc->status &=3D ~IRQ_PENDING;
 	}
-out:
 	desc->status &=3D ~IRQ_INPROGRESS;
+
+out:
 	/*
 	 * The ->end() handler has to deal with interrupts which got
 	 * disabled while the handler was running.
@@ -768,7 +769,7 @@
=20
 	if (!shared) {
 		desc->depth =3D 0;
-		desc->status &=3D ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING);
+		desc->status &=3D ~(IRQ_DISABLED | IRQ_AUTODETECT | IRQ_WAITING | IRQ_IN=
PROGRESS);
 		desc->handler->startup(irq);
 	}
 	spin_unlock_irqrestore(&desc->lock,flags);

--=-p6UmFpr93PMqaNEKK12i--

