Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbWCOGgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbWCOGgB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 01:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWCOGgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 01:36:01 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:36994 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932119AbWCOGgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 01:36:00 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Wed, 15 Mar 2006 14:16:02 +0800."
             <3ACA40606221794F80A5670F0AF15F840B32AA80@pdsmsx403> 
Date: Wed, 15 Mar 2006 06:35:56 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FJPbw-0005IG-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you do it in this way, all thermal zone's _TMP will be faked.

Loading 'thermal' with zone_to_keep=0 meant that it skipped THM{2,6,7}
(the only other zones).  But only THM0 was loaded, so any path that
included, say, THM2._TMP wouldn't get executed because of lines like:

     if (!tz)
	return_VALUE(-EINVAL);

Plus the dmesgs show all cases when _TMP was faked (each fakery
produces a printk).  In the experiment with zone_to_keep=0, the only
cases were with THM0.

> If you remove the real THM0._TMP, and fake a dummy THM0._TMP in
> DSDT, and don't change anything in kernel, then if S3 works well, I
> will be convinced that THM0._TMP was causing trouble.

I'll try it, to test my theory above!  But one clarification first: Do
you mean that I use a vanilla thermal.c, or should I keep using the
modified thermal.c with zone_to_keep=0 as the module parameter?  I
don't think I revert to the vanilla thermal.c.  Suppose that there are
two bugs, which I think is likely (see previous email).  Commenting
out only THM0._TMP but preserving everything else in the DSDT & kernel
might eliminate any bug caused by THM0._TMP.  But if it still hangs --
and I'm pretty sure it will -- it means there's a another bug
somewhere else.

Here's why I'm sure it will hang.  When I commented out all
evaluations of _TMP (modifying utils.c), but used a vanilla thermal.c,
it still hung.  And commenting out all _TMP's means I commented out
THM0._TMP.  So vanilla thermal.c + no THM0._TMP should hang too.

> Ok, Let's change the way of hacking. Let's start bisection without
> touching kernel, instead with DSDT.

No problem I think.

> Firstly, you need to find out which THM.

The zone_to_keep=0 tests show that THM0 causes a problem, don't they?
Other zones may also cause a problem, but THM0 can do it all alone.

> Then, which Methods.  

The test that hung on the first S3 sleep, with zone_to_keep=0 and
bisect_get_info=1, shows that just THM0._TMP can cause a problem --
since no other methods got executed.

As with figuring out which zones cause problems, other methods may
also cause the problem.  So I want to make sure I use a bisection
method that will work even if there is more than one bug, whether in
multiple zones or in multiple methods in the same zone.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
