Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVC0ATU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVC0ATU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 19:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVC0ATU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 19:19:20 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:32231 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261371AbVC0ATN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 19:19:13 -0500
Subject: [PATCH] Fix preemption off of irq context on x86-64 with
	PREEMPT_BKL
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1111778785.14840.13.camel@leto.cs.pocnet.net>
References: <20050324044114.5aa5b166.akpm@osdl.org>
	 <1111778785.14840.13.camel@leto.cs.pocnet.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-V5VGUtGxFNBksizjpzBA"
Date: Sun, 27 Mar 2005 01:19:06 +0100
Message-Id: <1111882746.32348.6.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-V5VGUtGxFNBksizjpzBA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> x86_64-fix-config_preempt.patch
>   x86_64: Fix CONFIG_PREEMPT

This patch causes another bug to show up some lines below with
CONFIG_PREEMPT_BKL. schedule releases the BKL which it shouldn't do.

Call preempt_schedule_irq instead (like for i386). This seems to fix the
easily reproducible filesystem errors I've seen (with reiserfs, which
heavily relies on the BKL).

Signed-off-by: Christophe Saout <christophe@saout.de>

--- linux-2.6.12-rc1-mm2.orig/arch/x86_64/kernel/entry.S	2005-03-24 17:32:2=
2.000000000 +0100
+++ linux-2.6.12-rc1-mm2/arch/x86_64/kernel/entry.S	2005-03-26 23:40:30.000=
000000 +0100
@@ -517,12 +517,7 @@
 	jnc  retint_restore_args
 	bt   $9,EFLAGS-ARGOFFSET(%rsp)	/* interrupts off? */
 	jnc  retint_restore_args
-	movl $PREEMPT_ACTIVE,threadinfo_preempt_count(%rcx)
-	sti
-	call schedule
-	cli
-	GET_THREAD_INFO(%rcx)
-	movl $0,threadinfo_preempt_count(%rcx)=20
+	call preempt_schedule_irq
 	jmp exit_intr
 #endif=09
 	CFI_ENDPROC


--=-V5VGUtGxFNBksizjpzBA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCRfv6ZCYBcts5dM0RAgf4AJ45APs3unr6B1LpLka0WDzSmP6yhACfcCFz
djlt+BPU3bdA5r9saPgPsTc=
=En3l
-----END PGP SIGNATURE-----

--=-V5VGUtGxFNBksizjpzBA--

