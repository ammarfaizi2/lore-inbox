Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUBNV7n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 16:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUBNV7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 16:59:43 -0500
Received: from mout1.freenet.de ([194.97.50.132]:61675 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S263448AbUBNV7m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 16:59:42 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Simon Gate <simon@noir.se>
Subject: Re: psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
Date: Sat, 14 Feb 2004 22:59:26 +0100
User-Agent: KMail/1.6.50
References: <20040214224348.67102cfd.simon@noir.se>
In-Reply-To: <20040214224348.67102cfd.simon@noir.se>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200402142259.34836.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 14 February 2004 22:43, you wrote:
> Changed from kernel 2.6.1 to 2.6.2 an get this error in dmesg
> 
> psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
> 
> My mouse goes crazy for a few secs and then returns to normal for a while. Is this a 2.6.2 problem or is this is something old?

here's the fix:

- --- linux-2.6.3-rc2/drivers/input/serio/i8042.c.orig	2004-02-10 21:33:21.000000000 +0100
+++ linux-2.6.3-rc2/drivers/input/serio/i8042.c	2004-02-10 21:37:03.000000000 +0100
@@ -379,6 +379,8 @@
 	unsigned int dfl;
 	int ret;
 
+	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
+
 	spin_lock_irqsave(&i8042_lock, flags);
 	str = i8042_read_status();
 	if (str & I8042_STR_OBF)
@@ -433,7 +435,6 @@
 irq_ret:
 	ret = 1;
 out:
- -	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 	return IRQ_RETVAL(ret);
 }
 

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFALppFFGK1OIvVOP4RAtHeAKDWzyU7PgdkwhhYrY3t+Zvqmv4aagCdHbNv
VUwVin8INy2JiK9+x6VMFr0=
=qV4u
-----END PGP SIGNATURE-----
