Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVAXV7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVAXV7v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVAXV7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:59:17 -0500
Received: from waste.org ([216.27.176.166]:53952 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261689AbVAXV6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:58:08 -0500
Date: Mon, 24 Jan 2005 13:57:36 -0800
From: Matt Mackall <mpm@selenic.com>
To: Horst von Brand <vonbrand@laptop11.inf.utfsm.cl>
Cc: Andi Kleen <ak@muc.de>, Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050124215736.GF12076@waste.org>
References: <20050123042930.GI3867@waste.org> <200501240402.j0O42iOn010758@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501240402.j0O42iOn010758@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 01:02:44AM -0300, Horst von Brand wrote:
> Matt Mackall <mpm@selenic.com> said:
> > On Sun, Jan 23, 2005 at 03:39:34AM +0100, Andi Kleen wrote:
> 
> [...]
> 
> > > -Andi (who thinks the glibc qsort is vast overkill for kernel purposes
> > > where there are only small data sets and it would be better to use a 
> > > simpler one optimized for code size)
> 
> > Mostly agreed. Except:
> > 
> > a) the glibc version is not actually all that optimized
> > b) it's nice that it's not recursive
> > c) the three-way median selection does help avoid worst-case O(n^2)
> > behavior, which might potentially be triggerable by users in places
> > like XFS where this is used
> 
> Shellsort is much simpler, and not much slower for small datasets. Plus no
> extra space for stacks.
> 
> > I'll probably whip up a simpler version tomorrow or Monday and do some
> > size/space benchmarking. I've been meaning to contribute a qsort for
> > doubly-linked lists I've got lying around as well.
> 
> Qsort is OK as long as you have direct access to each element. In case of
> lists, it is better to just use mergesort.

Qsort does not need to do random access. I posted an efficient
doubly-linked list version here four years ago:

template<class T>
void list<T>::qsort(iter l, iter r, cmpfunc *cmp, void *data)
{
        if(l==r) return;

        iter i(l), p(l);

        for(i++; i!=r; i++)
                if(cmp(*i, *l, data)<0)
                        i.swap(++p);

        l.swap(p);
        qsort(l, p, cmp, data);
        qsort(++p, r, cmp, data);
}

-- 
Mathematics is the supreme nostalgia of our time.
