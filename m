Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267454AbTBRKpv>; Tue, 18 Feb 2003 05:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbTBRKpv>; Tue, 18 Feb 2003 05:45:51 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:58350 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267454AbTBRKps>; Tue, 18 Feb 2003 05:45:48 -0500
Date: Tue, 18 Feb 2003 16:29:54 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net,
       fastboot@osdl.org, anton@samba.org
Subject: Re: [Fastboot] Re: Kexec on 2.5.59 problems ?
Message-ID: <20030218162954.B2808@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030210164401.A11250@in.ibm.com> <1044896964.1705.9.camel@andyp.pdx.osdl.net> <m13cmwyppx.fsf@frodo.biederman.org> <20030211125144.A2355@in.ibm.com> <1044983092.1705.27.camel@andyp.pdx.osdl.net> <1045007213.1959.2.camel@andyp.pdx.osdl.net> <m1k7g6xgs8.fsf@frodo.biederman.org> <1045089117.1502.5.camel@andyp.pdx.osdl.net> <20030213152033.A14278@in.ibm.com> <m1d6lww70u.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1d6lww70u.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Thu, Feb 13, 2003 at 08:10:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the explanation from Anton about why using init_mm is
a problem on ppc64.

Regards
Suparna

----- Forwarded message from Anton Blanchard <anton@samba.org> -----

Date: Tue, 18 Feb 2003 20:56:23 +1100
From: Anton Blanchard <anton@samba.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: Fw: Re: [Fastboot] Re: Kexec on 2.5.59 problems ?


On Thu, Feb 13, 2003 at 08:10:41AM -0700, Eric W. Biederman wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> writes:
> 
> > Great !
> > Eventually we should probably avoid init_mm altogether (on ppc64
> > at least, init_mm can't be used as Anton pointed out to me) and
> > setup a spare mm instead. 
> 
> What is the problem with init_mm?  Besides the fact that using it
> is now failing?
> 


Hi Suparna,

On ppc64 we have many 2^41B (2 TB) regions:

USER
KERNEL
VMALLOC
IO

Why 2TB? Well our three level linux pagetables can map 2TB. The kernel has
no pagetables, so we only need three sets of pagetables. As usual each
user task has its own set of pagetables. So that leaves vmalloc and IO.

For IO we create our own pgd, ioremap_pgd and for vmalloc we use init_mm.
Why not? Its not being used anywhere else... except for kexec.

So init_mm covers the region of:

0xD000000000000000 to 0xD000000000000000+2^41

And what kexec wants is a page under 4GB :)

Thats why we created another mm.


Could you please forward it on to the list?

Thanks!
Anton

----- End forwarded message -----

--
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India
