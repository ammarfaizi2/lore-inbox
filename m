Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTJLL0g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 07:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTJLL0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 07:26:36 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:40611 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263452AbTJLL0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 07:26:33 -0400
To: Carsten Jacobi <carsten@ccac.rwth-aachen.de>
Cc: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lne390 and Jensen Alphas
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <20031010221723.GA12615@ccac.rwth-aachen.de>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Sun, 12 Oct 2003 13:24:30 +0200
Message-ID: <wrp1xtir95d.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20031010221723.GA12615@ccac.rwth-aachen.de> (Carsten Jacobi's
 message of "Sat, 11 Oct 2003 00:17:23 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten,

+#ifdef CONFIG_ALPHA_JENSEN
+	/* On the Jensen board EISA cards will see their own address
+	 * space */
+#else

[...]

+#ifndef CONFIG_ALPHA_JENSEN
 	isa_memcpy_toio(shmem, buf, count);
+#else
+	/* The mylex lne390 adapter requires 32bit access (see above) for every
+	 * operation to the shared mem buffer. Since the block buffer is hardly
+	 * aligned to a 32bit boundary isa_memcpy_toio() will use 16bit
+	 * operations to access the buffer ... we must use something else here. */
+
+	const void *from = buf;
+	count -= 4;
+	do {
+		__raw_writel(*(const u16 *)from | (*(const u16 *)(from+2))<<16, (unsigned long) shmem);
+		count -= 4;
+		(unsigned long) shmem += 4;
+		from += 4;
+	} while (count >= 0);
+#endif
+

This doesn't look to me like a proper fix. You should unconditionally
use ioremap and memcpy_{from,to}io (not the isa_* version). No need to
have a special Jensen case here.

Please look at the way ne3210.c was fixed in 2.6.0-test7.

	M.
-- 
Places change, faces change. Life is so very strange.
