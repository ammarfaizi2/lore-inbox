Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267406AbUG2B56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267406AbUG2B56 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 21:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUG2B56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 21:57:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6073 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267406AbUG2B5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 21:57:46 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: suparna@in.ibm.com, fastboot@osdl.org, mbligh@aracnet.com,
       jbarnes@engr.sgi.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay>
	<m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	<20040728133337.06eb0fca.akpm@osdl.org>
	<1091044742.31698.3.camel@localhost.localdomain>
	<m1llh367s4.fsf@ebiederm.dsl.xmission.com>
	<20040728164457.732c2f1d.akpm@osdl.org>
	<m1d62f6351.fsf@ebiederm.dsl.xmission.com>
	<20040728180954.1f2baed9.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2004 19:56:47 -0600
In-Reply-To: <20040728180954.1f2baed9.akpm@osdl.org>
Message-ID: <m1u0vr4luo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
> >
> > Andrew Morton <akpm@osdl.org> writes:
> 
> OK.  But some (most) of them will sleep, too.  And we shouldn't sleep in a
> dead kernel.

Probably not.  And that is legitimate...

> > I agree.  However the gymnastics for doing that have not been worked out.
> > The drivers cannot clean up stuff yet, nor do we have a good way to run
> > in memory where DMA transfers on not ongoing.
> 
> Don't we?  The 16M of memory was allocated up-front at kexec load time[*],
> so nobody will be pointing DMA hardware at it.  And the dump kernel won't
> be pointing DMA hardware at the crashed kernel's pages.

No but we will be running in the first 16M of memory.  The 16M that
is allocated is currently used to hold a copy of the low 16M.
 
> > So for a first pass I think calling the shutdown methods make sense.
> 
> Well.  There aren't any.

Which makes them both safe and worthless.  On the normal kexec path
they we will need to get them written though.

> > But the first pass is worth it (at least in the kexec tree) to sort out all
> > of the interface issues and catch the low hanging fruit.
> 
> A significant proportion of kernel crashes happen from [soft]irq context,
> from which we cannot call shutdown methods.  So we need to be able to bring
> up the dump kernel without having run driver shutdown functions anwyay..

Well if calling shutdown is not really usable, then I we had better
transition quickly beyond using it...
 
> [*] At least, I _assume_ the 16MB will be prereserved,
>     physically-contiguous and wholly within ZONE_NORMAL.  Is this wrong?

The problem is that we really won't be using it for running code out
of because of i386 kernel limitations.  Unless someone can tell
my why 0 -16MB won't have DMA traffic in them.  Or how to run a kernel
at an address other than 1MB.

I suspect we can play with the initial page tables and how virtual
addresses map to physical addresses and fairly simply generate a
relocatable kernel.  I have not had a chance to investigate that
though.  Once we have that it will be trivial to run out of the
reserved 16M and many of the practical problems melt away.

Eric
