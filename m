Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266277AbTGKUyP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbTGKUyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:54:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:63142 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266277AbTGKUyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:54:12 -0400
Date: Fri, 11 Jul 2003 14:01:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: axboe@suse.de, bernie@develer.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.75 as-iosched.c & asm-generic/div64.h breakage
Message-Id: <20030711140158.0b27117e.akpm@osdl.org>
In-Reply-To: <200307112048.h6BKmUQj003987@harpo.it.uu.se>
References: <200307112048.h6BKmUQj003987@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> drivers/block/as-iosched.c: In function `as_update_iohist':
> drivers/block/as-iosched.c:840: warning: right shift count >= width of type
> drivers/block/as-iosched.c:840: warning: passing arg 1 of `__div64_32' from incompatible pointer type

You mean that code was in -mm for all those months and no ppc32 person
bothered testing it?  Bah.

Something like this?  (Could be sped up for 32-bit sector_t)

diff -puN drivers/block/as-iosched.c~as-do_div-fix drivers/block/as-iosched.c
--- 25/drivers/block/as-iosched.c~as-do_div-fix	Fri Jul 11 14:00:55 2003
+++ 25-akpm/drivers/block/as-iosched.c	Fri Jul 11 14:00:58 2003
@@ -836,8 +836,10 @@ static void as_update_iohist(struct as_i
 		aic->seek_samples += 256;
 		aic->seek_total += 256*seek_dist;
 		if (aic->seek_samples) {
-			aic->seek_mean = aic->seek_total + 128;
-			do_div(aic->seek_mean, aic->seek_samples);
+			u64 seek_mean = aic->seek_total + 128;
+
+			do_div(seek_mean, aic->seek_samples);
+			aic->seek_mean = seek_mean;
 		}
 		aic->seek_samples = (aic->seek_samples>>1)
 					+ (aic->seek_samples>>2);

_

