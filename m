Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbWCPFrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbWCPFrx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 00:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbWCPFrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 00:47:53 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:15852 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932656AbWCPFrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 00:47:52 -0500
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
In-Reply-To: Your message of "Wed, 15 Mar 2006 16:02:57 +0800."
             <3ACA40606221794F80A5670F0AF15F840B32AC5E@pdsmsx403> 
Date: Thu, 16 Mar 2006 05:47:49 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FJlKv-00081K-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here the test results on the DSDT variants, as a tree.  THM0 is the
root (meaning a DSDT with only THM0).  -XYZ means 'fake the method XYZ
in THM0, relative to the situation in the parent DSDT':

hang:	 THM0
okay:		-TMP
hang:		-PSV
okay:			-AC0 (i.e. THM0 methods but no PSV, no AC0)
hang:			-SCP
hang:		-AC0

The first two results are consistent with the view that TMP is the
problem.  

>From the first five results, I convinced myself that TMP needed AC0
around to cause a problem, and vice versa: hang iff (TMP & AC0).  But
the last result (-AC0) surprised me.  Now I think: 
   hang iff (TMP & (PSV | AC0)).

The -PSV-AC0 DSDT, which did not hang, seemed close to hanging.  After
a few cycles, it became very sluggish and the load was 8.2 on wakeup.
But the sluggishness disappeared after a couple more cycles, and I
couldn't produce a hang (tried two reboots, each with different
permutations of sleep.sh or "echo 1 > THM0/polling_frequency").

The -AC0 DSDT hung upon doing 

 echo 1 > THM0/polling_frequency ; sleep.sh; sleep.sh

and it got in an endless loop that showed it sluggishly executing
(over and over again) THM0._TMP.

It's probably not coincidence that TMP and AC0 both use the EC.
Although PSV doesn't.

I didn't make any tests on the MODP method.  And the TC1, TC2, and TSP
methods seemed to trivial (just returning a constant) that it didn't
seem worth testing them.

I keep the kernels around for each permutation, so I can retest any of
the above, or send the THM0 portions of the .dsl files.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
