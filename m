Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbUJ1B1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbUJ1B1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 21:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbUJ1B1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 21:27:10 -0400
Received: from ozlabs.org ([203.10.76.45]:999 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262627AbUJ1B1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 21:27:01 -0400
Date: Thu, 28 Oct 2004 11:16:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andrew Morton <akpm@osdl.org>, James Cloos <cloos@jhcloos.com>,
       linux-kernel@vger.kernel.org
Subject: Re: MAP_SHARED bizarrely slow
Message-ID: <20041028011618.GB2216@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Bill Davidsen <davidsen@tmr.com>, Andrew Morton <akpm@osdl.org>,
	James Cloos <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
References: <20041027010659.15ec7e90.akpm@osdl.org> <41800B12.5020405@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41800B12.5020405@tmr.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 04:54:42PM -0400, Bill Davidsen wrote:
> Andrew Morton wrote:
> >James Cloos <cloos@jhcloos.com> wrote:
> >
> >>>>>>>"David" == David Gibson <david@gibson.dropbear.id.au> writes:
> >>
> >>David> http://www.ozlabs.org/people/dgibson/maptest.tar.gz
> >>
> >>David> On a number of machines I've tested - both ppc64 and x86 - the
> >>David> SHARED version is consistently and significantly (50-100%)
> >>David> slower than the PRIVATE version.
> >>
> >>Just gave it a test on my laptop and server.  Both are p3.  The
> >>laptop is under heavier mem pressure; the server has just under
> >>a gig with most free/cache/buff.  Laptop is still running 2.6.7
> >>whereas the server is bk as of 2004-10-24.
> >>
> >>Buth took about 11 seconds for the private and around 30 seconds
> >>for the shared tests.
> >>
> >
> >
> >I get the exact opposite, on a P4:
> >
> >vmm:/home/akpm/maptest> time ./mm-sharemmap 
> >./mm-sharemmap  10.81s user 0.05s system 100% cpu 10.855 total
> >vmm:/home/akpm/maptest> time ./mm-sharemmap
> >./mm-sharemmap  11.04s user 0.05s system 100% cpu 11.086 total
> >vmm:/home/akpm/maptest> time ./mm-privmmap 
> >./mm-privmmap  26.91s user 0.02s system 100% cpu 26.903 total
> >vmm:/home/akpm/maptest> time ./mm-privmmap
> >./mm-privmmap  26.89s user 0.02s system 100% cpu 26.894 total
> >vmm:/home/akpm/maptest> uname -a
> >Linux vmm 2.6.10-rc1-mm1 #14 SMP Tue Oct 26 23:23:23 PDT 2004 i686 i686 
> >i386 GNU/Linux
> >
> >It's all user time so I can think of no reason apart from physical page
> >allocation order causing additional TLB reloads in one case.  One is using
> >anonymous pages and the other is using shmem-backed pages, although I can't
> >think why that would make a difference.
> 
> I think the cause was covered in another post, I'm surprised that the 
> page overhead is reported as user time. It would have been a good hint 
> if the big jump were in system time.

The cause isn't page overhead.  The problem is that the SHARED version
actually uses a whole lot more real memory, so cache performance is
much worse.  So the time really is in userland.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
