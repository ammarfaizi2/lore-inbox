Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUDHOWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 10:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbUDHOWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 10:22:54 -0400
Received: from ozlabs.org ([203.10.76.45]:22664 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261741AbUDHOWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 10:22:52 -0400
Date: Fri, 9 Apr 2004 00:19:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Zoltan.Menyhart@bull.net
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
Message-ID: <20040408141925.GB16928@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Zoltan.Menyhart@bull.net, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev@lists.linuxppc.org
References: <20040407074239.GG18264@zax> <4073C33B.7B7808E7@nospam.org> <20040408015327.GB20320@zax> <4075333B.4C90934C@nospam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4075333B.4C90934C@nospam.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 01:10:51PM +0200, Zoltan Menyhart wrote:
> David Gibson wrote:
> 
> > > Why not just add a flag for a VMA telling if you want / do not want to
> > > copy it on "fork()" ? E.g.:
> > >
> > > dup_mmap():
> > >
> > >       for (mpnt = current->mm->mmap ; mpnt ; mpnt = mpnt->vm_next) {
> > >
> > >               if (mpnt->vm_flags & VM_HUGETLB_DONT_COPY)
> > >                       <do nothing>
> > >       }
> > >
> > 
> > Um.. why would that be useful?
> 
> I think there are 2 major cases:
> 
> - A big hugepage-using program creates threads to take advantage
>   of all of the CPUs => use clone2(...CLONEVM...), it works today.
> - Another big hugepage-using program calling a little shell function
>   with system() => just skip the VMA of the huge page area in
> 	do_fork():
> 		copy_process():
> 			copy_mm():
> 				dup_mmap()
>   The child will have no copy of the huge page area. No problem, it will
>   exec() soon, and the stack, the usual data, the malloc()'ed data, etc.
>   are not in the huge page area => exec() will will work correctly.

> I do not think we need a COW of the huge pages.

Both of these two cases work already.  The fork() will copy the huge
PTEs, but that's no big deal since all the actual pages are shared.
COW isn't supposed to help either case - it's for cases where we
really do need MAP_PRIVAT semantics.  That's particularly important
for things we might do in the future where large pages are allocated
automatically according to certain heuristics.  In this case we
certainly can't make the pages silently have different semantics to
normal anonymous memory.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
