Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264800AbUELAwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264800AbUELAwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUELAwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:52:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:34510 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265080AbUELAsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:48:31 -0400
Date: Tue, 11 May 2004 17:51:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH} H8/300 update (2/9) ldscripts fix
Message-Id: <20040511175105.7d669535.akpm@osdl.org>
In-Reply-To: <m2zn8erkdv.wl%ysato@users.sourceforge.jp>
References: <m2zn8erkdv.wl%ysato@users.sourceforge.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoshinori Sato <ysato@users.sourceforge.jp> wrote:
>
> +#if defined(CONFIG_H8300) || defined(CONFIG_V850)
> +#define SYMBOL(_sym_) _##_sym_
> +#else
> +#define SYMBOL(_sym_) _sym_
> +#endif
> +

Adding arch-specific stuff to an include/asm-generic/ header file is
not nice.

However, having to create an arch-specific version of the header
just becasue you need this wrapper is also not nice.

And "SYMBOL" is a too generic identifier: it may clash with other things.


Could I suggest that you change asm-generic/vmlinux.lds.h to do:

#ifndef VMLINUX_SYMBOL
#define VMLINUX_SYMBOL(_sym_) _sym_
#endif

	...

-		__start___ksymtab = .;					\
+		VMLINUX_SYMBOL(__start___ksymtab) = .;			\


Then, in some h8300-specific file, do:

	#define VMLINUX_SYMBOL(_sym_) _##_sym_
	#include <asm-generic/vmlinux.lds.h>

and include that file instead of asm-generic/vmlinux.lds.h?

(I am unable to find where h8300 actually includes vmlinux.lds.h. 
Confused).

