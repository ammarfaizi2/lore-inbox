Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWCVFOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWCVFOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 00:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWCVFOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 00:14:04 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:16554 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750766AbWCVFOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 00:14:02 -0500
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
In-Reply-To: Your message of "Wed, 22 Mar 2006 12:58:36 +0800."
             <3ACA40606221794F80A5670F0AF15F840B417DFC@pdsmsx403> 
Date: Wed, 22 Mar 2006 05:13:54 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FLvfO-00014M-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please don't give up . :-)

I haven't!

> I need to know which statement in EC0.UPDT that could trigger the
> problem.  That is very important to understand the problem
> correctly.

> This is still my assumption that some AML code needed to be avoided
> in suspend/resume, I need data support. So, we need to dig more in
> EC0.UPDT.

You've convinced me!

> If we cannot find out that statement , then, I will dout the testing
> results that guiding us to here.

Yes, the testing is often frustrating and unreliable because the bug
is not 100% reproducible, which is why I think it's more than 1 bug
(one reliable bug, related to THM0, and one or more flakey ones).

>> However, we do have one more piece of data.  When it hangs, it hangs in
>> \_SI._SST, because I see that line on successful sleeps (as the last

> I don't know this. I always assume the hang is at _PTS.SMPI

Oh, I think you're right.  Robert Moore's comment at the bugzilla
entry agrees with what you say.  I was (I don't know why) assuming
that the ACPI system printed "Execute Method ..." after it finished
executing the method.  In which case, seeing the PTS but not the SST
made me think that PTS worked but SST failed.  However, what you say
is consistent with ACPI printing "Execute Method" as it begins a
method -- in which case seeing the PTS but not the SST means it fails
in PTS (and in PTS.SMPI).

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.


http://bugzilla.kernel.org/show_bug.cgi?id=5989





------- Additional Comments From Robert.Moore@intel.com  2006-02-06 14:46 

You are stuck in the loop in the method below. I would guess that the
code is 
waiting for a response from the SMI bios and it never happens.

    Method (SMPI, 1, NotSerialized)
    {
        Store (S_AX, Local0)
        Store (0x81, APMD)
        While (LEqual (S_AH, 0xA6))
        {
            Sleep (0x64)
            Store (Local0, S_AX)
            Store (0x81, APMD)
        }
    }

    OperationRegion (MNVS, SystemMemory, 0x23FDF000, 0x1000)
    Field (MNVS, DWordAcc, NoLock, Preserve)
    {
        Offset (0xFC0), 
        S_AX,   16, 

    OperationRegion (APMC, SystemIO, 0xB2, 0x01)
    Field (APMC, ByteAcc, NoLock, Preserve)
    {
        APMD,   8


Store (Local0, S_AX)

exregion-0182 [29] ex_system_memory_space: system_memory 0 (32 width) 
Address=0000000023FDFFC0


Store (0x81, APMD)

exregion-0287 [30] ex_system_io_space_han: system_iO 1 (8 width) 
Address=00000000000000B2
