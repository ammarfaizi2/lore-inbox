Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265301AbUF1X6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUF1X6O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 19:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbUF1X6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 19:58:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:11403 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265301AbUF1X6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 19:58:12 -0400
Date: Mon, 28 Jun 2004 16:57:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: __setup()'s not processed in bk-current
Message-Id: <20040628165707.328cce15.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.33.0406281523340.25702-100000@sweetums.bluetronic.net>
References: <Pine.GSO.4.33.0406281523340.25702-100000@sweetums.bluetronic.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam <jfbeam@bluetronic.net> wrote:
>
> Do I smell some bad pointer math?  Yeap:
>  DEBUG: sizeof(obs_kernel_param): 24 (0x18)
> 
>  obsolete_checksetup(): line: ro
>  obsolete_checksetup(): checking: nosmp(5) @ ffffffff80593510
>  obsolete_checksetup(): checking: <NULL>(1) @ ffffffff80593528
> 
>  p++ moved the pointer sizeof(obs_kernel_param) ahead, but that's 8 bytes
>  short.

Thanks for working that out.  It's been handing around for ages.



We're now putting 24-byte structures into .init.setup via __setup.  But
x86_64's compiler is emitting a `.align 16' in there, so they end up on
32-byte boundaries and do_early_param()'s pointer arithmetic goes wrong.

Fix that up by forcing the compiler to align these structures to sizeof(long).



---

 25-akpm/include/linux/init.h |    1 +
 1 files changed, 1 insertion(+)

diff -puN include/linux/init.h~x86_64-setup-section-alignment-fix include/linux/init.h
--- 25/include/linux/init.h~x86_64-setup-section-alignment-fix	2004-06-28 16:47:41.000000000 -0700
+++ 25-akpm/include/linux/init.h	2004-06-28 16:47:41.000000000 -0700
@@ -119,6 +119,7 @@ struct obs_kernel_param {
 	static struct obs_kernel_param __setup_##unique_id	\
 		 __attribute_used__				\
 		 __attribute__((__section__(".init.setup")))	\
+		__attribute__((aligned((sizeof(long)))))	\
 		= { __setup_str_##unique_id, fn, early }
 
 #define __setup_null_param(str, unique_id)			\

_

