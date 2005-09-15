Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030542AbVIOVYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030542AbVIOVYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030547AbVIOVYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:24:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030542AbVIOVYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:24:08 -0400
Date: Thu, 15 Sep 2005 14:23:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
cc: linux-kernel@vger.kernel.org, rmk+serial@arm.linux.org.uk
Subject: Re: [PATCH] epca iomem annotations + several missing readw()
In-Reply-To: <20050915192704.GC25261@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0509151419160.26803@g5.osdl.org>
References: <20050915192704.GC25261@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gaah.

On Thu, 15 Sep 2005, Al Viro wrote:
>  { /* Begin post_fep_init */
>  
>  	int i;
> -	unsigned char *memaddr;
> -	struct global_data *gd;
> +	unsigned char __iomem *memaddr;
> +	struct global_data __iomem *gd;

Please don't use "[unsigned] char __iomem *".

Why? Two reasons:

 - it's pointless. You can't dereference it anyway, and unlike a struct or 
   an array, it has no addressing capabilities that "void __iomem *"  
   doesn't have (gcc extension that the kernel uses widely).

   Dereferencing needs "read/write[bwl]()" anyway.

 - it results in horrors like this:

	> -	bc = (struct board_chan *)(memaddr + CHANSTRUCT);
	> +	bc = (struct board_chan __iomem *)(memaddr + CHANSTRUCT);

  which could instead be nicely written as

	bc = memaddr + CHANSTRUCT;

  if "memaddr" were just a "void __iomem *".

I bet the patch would look like a nice cleanup if you did that. Hint, 
hint.

		Linus
