Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSGMRvn>; Sat, 13 Jul 2002 13:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSGMRvm>; Sat, 13 Jul 2002 13:51:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50152 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315267AbSGMRvl>;
	Sat, 13 Jul 2002 13:51:41 -0400
Date: Sat, 13 Jul 2002 13:54:29 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Paul Menage <pmenage@ensim.com>
cc: LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [RFC] dcache scalability patch (2.4.17) 
In-Reply-To: <Pine.GSO.4.21.0207131328360.15574-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0207131346040.15574-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Jul 2002, Alexander Viro wrote:

> 
> 
> On Sat, 13 Jul 2002, Paul Menage wrote:
> 
> > - accessing foo/../bar, won't mark foo as referenced, even though it
> > might be being referenced frequently. Probably not a common case for foo
> > to be accessed exclusively in this way, but it could be fixed by marking
> > a dentry referenced when following ".."
> 
> It certainly will.  Look - until ->d_count hits zero referenced bit is
> not touched or looked at.  At all.
> 
> Look at the code.  There is _no_ aging for dentries with positive ->d_count.
> They start aging only when after they enter unused_list...

	On the second thought, I should apply that advice myself.  It's true
that they start aging only after they hit the unused list, but they are born
old.  Hrm...

	OK, it kills that variant and it really looks like there's no way
around dirtying dentry first time we find it on d_lookup().  Which means
that we probably want to put that |= under if - without any ifdefs...

