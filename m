Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265320AbUAZAEa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 19:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbUAZAEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 19:04:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:39059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265320AbUAZAE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 19:04:29 -0500
Date: Sun, 25 Jan 2004 16:04:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: eric@cisu.net, sboyce@blueyonder.co.uk, linux-kernel@vger.kernel.org,
       bunk@fs.tum.de, torvalds@osdl.org
Subject: Re: 2.6.2-rc1-mm2 kernel oops
Message-Id: <20040125160400.5b9d2e88.akpm@osdl.org>
In-Reply-To: <20040125152559.55165860.akpm@osdl.org>
References: <4013D0AA.8060906@blueyonder.co.uk>
	<16404.8968.349900.566999@gargle.gargle.HOWL>
	<4014283D.9040207@blueyonder.co.uk>
	<200401251714.57799.eric@cisu.net>
	<20040125152559.55165860.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Eric <eric@cisu.net> wrote:
> >  Now I get the test_wp_bit oops w/ 
> ...
> 
> init/main.c does
> 
> 	mem_init();
> 	kmem_cache_init();
> 	sort_main_extable();
> 
> but mem_init() calls test_wp_bit().  The exception tables haven't been
> sorted yet.
> 

Well I don't see any reason why the obvious should not work.  It boots OK
on i386 but whether other architectures do things in mem_init() which must
be done prior to exception table sorting, I know not.  It seems unlikely.

Can you see if this patch makes the test_wp_bit() oops go away?

 
diff -puN init/main.c~test_wp_bit-oops-fix init/main.c
--- 25/init/main.c~test_wp_bit-oops-fix	2004-01-25 15:29:53.000000000 -0800
+++ 25-akpm/init/main.c	2004-01-25 15:30:03.000000000 -0800
@@ -434,9 +434,9 @@ asmlinkage void __init start_kernel(void
 	}
 #endif
 	page_address_init();
+	sort_main_extable();
 	mem_init();
 	kmem_cache_init();
-	sort_main_extable();
 	if (late_time_init)
 		late_time_init();
 	calibrate_delay();

_

