Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbWEKHiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbWEKHiv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 03:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWEKHiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 03:38:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30896 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965193AbWEKHiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 03:38:50 -0400
Date: Thu, 11 May 2006 00:35:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [PATCH-RFC] Improve randomness of hash_long on 64bit.
Message-Id: <20060511003556.5ba2e3d2.akpm@osdl.org>
In-Reply-To: <1060509065940.10406@suse.de>
References: <20060509165610.10378.patches@notabene>
	<1060509065940.10406@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.de> wrote:
>
> I'm still bothered by the poor showing on hash_long on 64bit
>  on number that differ only in the 3rd or 4th byte (as IP addresses might
>  on a little-endian host).
>  I hacked around the problem in net/sunrpc/svcauth_unix.c until this
>  issue got resolved, but it never did.  So I am pushing again.
> 
>  The problem is that the bit-spares prime that is close to the
>  golden ratio isn't really close enough.
> 
>  I propose 'fixing' it by using hash_u32 on the upper and lower halfs
>  of a 64bit value.  This is slightly less efficient, but most code would
>  probably be happy calling hash_u32 anyway.

We end up with

static inline u32 hash_u32(u32 val, unsigned int bits)
{
	u32 hash = val;

	/* On some cpus multiply is faster, on others gcc will do shifts */
	hash *= GOLDEN_RATIO_PRIME_32;

	/* High bits are more random, so use them. */
	return hash >> (32 - bits);
}

static inline u32 hash_u64(u64 val, unsigned int bits)
{
	u32 hi = val >> 32;
	return hash_u32(hash_u32(val, 32) ^ hi, bits);
}

So if one does

	hash_u64(foo, 44)

we have a negative shift distance.
