Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293739AbSCETP0>; Tue, 5 Mar 2002 14:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293734AbSCETPR>; Tue, 5 Mar 2002 14:15:17 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:64501 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293736AbSCETPE>; Tue, 5 Mar 2002 14:15:04 -0500
Date: Tue, 05 Mar 2002 11:16:25 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: Juan Quintela <quintela@mandrakesoft.com>, davej@suse.de,
        torvalds@transmeta.com, viro@math.psu.edu,
        linux-kernel@vger.kernel.org
cc: Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH] 2.5.5-dj2 - Fast Walk Dcache to Decrease Cacheline Bouncing
Message-ID: <15690000.1015355785@w-hlinder.des>
In-Reply-To: <m2sn7f8zev.fsf@localhost.mandrakesoft.com>
In-Reply-To: <33110000.1015293677@w-hlinder.des> <m2sn7f8zev.fsf@localhost.mandrakesoft.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, March 05, 2002 04:30:00 +0100 Juan Quintela <quintela@mandrakesoft.com> wrote:
>   
> hanna> struct dentry * d_lookup(struct dentry * parent, struct qstr * name)
> hanna> {
> hanna> +	struct dentry *dentry = NULL;
> 
> Not needed.

	Good catch. Changed.
> 
> Would you mean retest if the speed is the same using lik the old code

	Any tests people would like to see that might increase the chance 
	of it getting accepted. 
> 
> I think that it should not made difference, and code is IMHO, more
> readadble (and you don't duplicate walk_init_root).
> 
	There is a difference. The reviewer of the first submission also
	missed it. path_lookup duplicates walk_init_root because mntget 
	and dget are not called when the dcache_lock is held. So it is not
	an exact copy of walk_init_root. 

	The point of this is to find all the dentries in the path being 
	walked already in the dcache (aka the easy lookups) without bumping 
	the reference counter for every single dentry. On SMP this can lead 
	to cacheline bouncing. When a dentry is not found in the cache then
	call mntget and dget followed by releasing the dcache_lock to continue.
	Al Viro came up with this idea, I have implemented it.

	The lockmeter results and patch are here: http://lse.sf.net/locking

Hanna Linder (hannal@us.ibm.com)
IBM Linux Technology Center


