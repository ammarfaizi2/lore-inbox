Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267851AbTBRO45>; Tue, 18 Feb 2003 09:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbTBRO45>; Tue, 18 Feb 2003 09:56:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60255 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267851AbTBRO4z>; Tue, 18 Feb 2003 09:56:55 -0500
To: suparna@in.ibm.com
Cc: linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net,
       fastboot@osdl.org, anton@samba.org
Subject: Re: [Fastboot] Re: Kexec on 2.5.59 problems ?
References: <20030210164401.A11250@in.ibm.com>
	<1044896964.1705.9.camel@andyp.pdx.osdl.net>
	<m13cmwyppx.fsf@frodo.biederman.org> <20030211125144.A2355@in.ibm.com>
	<1044983092.1705.27.camel@andyp.pdx.osdl.net>
	<1045007213.1959.2.camel@andyp.pdx.osdl.net>
	<m1k7g6xgs8.fsf@frodo.biederman.org>
	<1045089117.1502.5.camel@andyp.pdx.osdl.net>
	<20030213152033.A14278@in.ibm.com>
	<m1d6lww70u.fsf@frodo.biederman.org> <20030218162954.B2808@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Feb 2003 08:06:42 -0700
In-Reply-To: <20030218162954.B2808@in.ibm.com>
Message-ID: <m1n0ktljb1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> Here's the explanation from Anton about why using init_mm is
> a problem on ppc64.

Thanks.

> Hi Suparna,
> 
> On ppc64 we have many 2^41B (2 TB) regions:
> 
> USER
> KERNEL
> VMALLOC
> IO
> 
> Why 2TB? Well our three level linux pagetables can map 2TB. The kernel has
> no pagetables, so we only need three sets of pagetables. As usual each
> user task has its own set of pagetables. So that leaves vmalloc and IO.
> 
> For IO we create our own pgd, ioremap_pgd and for vmalloc we use init_mm.
> Why not? Its not being used anywhere else... except for kexec.
> 
> So init_mm covers the region of:
> 
> 0xD000000000000000 to 0xD000000000000000+2^41
> 
> And what kexec wants is a page under 4GB :)

In this case it definitely wants something identity mapped, which would
mean in the first 2TB region.  On x86 the limit is 4GB because I only have
32bit pointers.  On a 64bit arch that limit should go away.

> Thats why we created another mm.

That makes sense.    I guess it boils down to the fact that init_mm
is special cased in a number of places and using it I am likely to get
me into trouble...

You would not happen to have code that creates a separate mm so I can
be lazy would you?

Eric
