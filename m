Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161124AbWJRPEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbWJRPEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWJRPEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:04:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41370 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161121AbWJRPEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:04:36 -0400
Date: Wed, 18 Oct 2006 08:04:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
In-Reply-To: <20061018093126.GM29920@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org>
References: <20061017005025.GF29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk>
 <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk>
 <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Oct 2006, Al Viro wrote:
>
> +#define lock_super(x) do {		\
> +	struct super_block *sb = x;	\
> +	get_fs_excl();			\
> +	mutex_lock(&sb->s_lock);	\
> +} while(0)

Don't do this. The "x" passed in may be "sb", and then you end up with 
bogus code.

I think the solution to these kinds of things is either
 - just bite the bullet, and make it out-of-line. A function call isn't 
   that expensive, and is sometimes actually cheaper due to I$ issues.
 - have a separate trivial header file, and only include it for people who 
   actually need these things (very few files, actually - it's usually 
   just one file per filesystem)

In this case, since it's _so_ simple, and since it's _so_ specialized, I 
think #2 is the right one. Normally, uninlining would be.

		Linus
