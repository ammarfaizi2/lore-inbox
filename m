Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269645AbUJAA6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269645AbUJAA6v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 20:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269650AbUJAA6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 20:58:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:34009 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269645AbUJAA6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 20:58:48 -0400
Date: Thu, 30 Sep 2004 17:58:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mlockall(MCL_FUTURE) unlocks currently locked mappings
Message-ID: <20040930175846.Z1924@build.pdx.osdl.net>
References: <20040929114244.Q1924@build.pdx.osdl.net> <20040930164744.30db3fdc.akpm@osdl.org> <20040930172259.Y1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040930172259.Y1924@build.pdx.osdl.net>; from chrisw@osdl.org on Thu, Sep 30, 2004 at 05:22:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > I've always assumed that mlockall(MCL_FUTURE) pins all your current pages
> > as well as future ones.  But no, that's what MCL_CURRENT|MCL_FUTURE does.
> > 
> > So when we fix this bug, we'll break my buggy test apps.
> > 
> > I wonder what other apps we'll break?
> 
> I don't think it will break apps.  The only difference is that it won't
> unlock already locked mappings.

For example, I have a test that locks some pages, then calls
mlockall(MCL_FUTURE).  Resutls in unlocking all locked pages.

# pages locked, before MCL_FUTURE
$ cat /proc/`pidof mlockall`/status | grep VmLck
VmLck:      1244 kB
# after MCL_FUTURE
$ cat /proc/`pidof mlockall`/status | grep VmLck
VmLck:         0 kB

And, with just a simple call to MCL_FUTURE:
# before MCL_FUTURE
$ cat /proc/`pidof mlockall`/status | grep VmLck
VmLck:         0 kB
# after MCL_FUTURE
$ cat /proc/`pidof mlockall`/status | grep VmLck
VmLck:         0 kB

Now with the patch:

# pages locked, before MCL_FUTURE
$ cat /proc/`pidof mlockall`/status | grep VmLck
VmLck:      1244 kB
# after MCL_FUTURE
$ cat /proc/`pidof mlockall`/status | grep VmLck
VmLck:      1244 kB
	    ^^^^^^^
That's the only differenece, and I believe fixes a real bug whose
existance is more likely to surprise apps than it's squashing ;-)

And, again (unchanged) with just a simple call to MCL_FUTURE:
# before MCL_FUTURE
$ cat /proc/`pidof mlockall`/status | grep VmLck
VmLck:         0 kB
# after MCL_FUTURE
$ cat /proc/`pidof mlockall`/status | grep VmLck
VmLck:         0 kB

The crux of the problem is in do_mlockall() in the for loop:

                newflags = vma->vm_flags | VM_LOCKED;
                if (!(flags & MCL_CURRENT))
                        newflags &= ~VM_LOCKED;
                mlock_fixup(vma, vma->vm_start, vma->vm_end, newflags);

So, for flags == MCL_FUTURE only, might as well bail out before the loop,
since MCL_FUTURE does nothing w.r.t. current mappings.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
