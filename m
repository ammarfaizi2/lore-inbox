Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSGPEht>; Tue, 16 Jul 2002 00:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317756AbSGPEhs>; Tue, 16 Jul 2002 00:37:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38299 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317755AbSGPEhr>;
	Tue, 16 Jul 2002 00:37:47 -0400
Date: Tue, 16 Jul 2002 00:40:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Rearranging struct dentry for cache affinity
In-Reply-To: <20020716135419.3a301947.rusty@rustcorp.com.au>
Message-ID: <Pine.GSO.4.21.0207160036460.24417-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Jul 2002, Rusty Russell wrote:

> On Sat, 13 Jul 2002 05:11:46 -0400 (EDT)
> Alexander Viro <viro@math.psu.edu> wrote:
> 
> > futex.c is seriously b0rken.
> 
> Really?  Other than changing over to get_sb_psuedo(), what does your patch
> fix?  As the filesystem should never be unmounted, what am I missing?
> >  	filp->f_op = &futex_fops;
> > -	filp->f_dentry = dget(futex_dentry);
> > +	filp->f_vfsmnt = mntget(futex_mnt);
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +	filp->f_dentry = dget(futex_mnt->mnt_root);

Uninitialized ->f_vfsmnt == quite a few places in the tree very unhappy.
E.g. any access to /proc/<pid>/fd/<n>.

I'd say that "any user can oops the kernel in a couple of lines" does
qualify for serious breakage...

