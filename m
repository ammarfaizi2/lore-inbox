Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbTAZLDo>; Sun, 26 Jan 2003 06:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266809AbTAZLDo>; Sun, 26 Jan 2003 06:03:44 -0500
Received: from dp.samba.org ([66.70.73.150]:26015 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266806AbTAZLDo>;
	Sun, 26 Jan 2003 06:03:44 -0500
Date: Sun, 26 Jan 2003 22:11:08 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org, hch@lst.de,
       jack@suse.cz, mason@suse.com, Stephen Hemminger <shemminger@osdl.org>
Subject: Re: ext2 FS corruption with 2.5.59.
Message-ID: <20030126111108.GB25001@krispykreme>
References: <20030123153832.A860@namesys.com> <20030124023213.63d93156.akpm@digeo.com> <20030124153929.A894@namesys.com> <20030124225320.5d387993.akpm@digeo.com> <20030125153607.A10590@namesys.com> <20030125190410.7c91e640.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030125190410.7c91e640.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> +static inline void i_size_write(struct inode * inode, loff_t i_size)
> +{
> +#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
> +#ifdef __ARCH_HAS_GET_SET_64BIT
> +	set_64bit((unsigned long long *) &inode->i_size, (unsigned long long) i_size);
> +#else
> +	inode->i_size_version2++;
> +	wmb();
> +	inode->i_size = i_size;
> +	wmb();
> +	inode->i_size_version1++;
> +	wmb(); /* make it visible ASAP */
> +#endif
> +#elif BITS_PER_LONG==64 || !defined(CONFIG_SMP)
> +	inode->i_size = i_size;
> +#endif
> +}

That last wmb is suspect. We dont put an wmb after a spinlock to "make it
visible". If you think of an wmb as an ordering tag that propagates out
through the cpu and storage hierarchy then wmb is not going to help us here.

I guess the store could get reordered (and so delayed) a bit, but an wmb
is relatively expensive on some architectures.

> This is actually fairly pointless, because these fields are write-mostly and
> read-rarely.  But we need a spinlock anyway because of the concurrent
> modifiers problem.

It would be interesting to compare a spinlock or rwlock against a frlock
in a write mostly situation. Actually isnt it going to be slower because
we have to take a spinlock to serialise around the frlock write path?

Anton
