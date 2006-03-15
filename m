Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWCOHG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWCOHG5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 02:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbWCOHG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 02:06:57 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:35715 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751191AbWCOHG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 02:06:56 -0500
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
In-Reply-To: Your message of "Wed, 15 Mar 2006 14:47:48 +0800."
             <3ACA40606221794F80A5670F0AF15F840B32AB0B@pdsmsx403> 
Date: Wed, 15 Mar 2006 07:06:53 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FJQ5t-0005f8-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry, forgot to reply to all the first time.]

How about this plan (basically what you suggested, but I want to
confirm its sensibility since these tests take a while):

Since I know (or think I know) that just THM0 with just _TMP causes
problems when investigating it by modifying the kernel, I'll instead
use a vanilla kernel but modify the DSDT as follows:

Remove the THM2, THM6, and THM7 code blocks.  See whether the DSDT
even compiles (e.g. TWAK might complain because of the "Notify
(\_TZ.THM7, 0x81)").  If it does, see if the resulting kernel hangs.
If it hangs (which I expect), then I'll bisect within THM0 to find at
least one method that causes a problem.

So, before I begin that search, which THM0 methods can I safely get
rid of?  All of PSL, TC1, TC2, TSP, MODP?  That'll leave _TMP, _AC0,
_SCP, PSV to bisect among.  I'll assume that the NAME statements are
okay.

Here's the THM0 code:

        ThermalZone (THM0)
        {
            Name (MODE, 0x00)
            Name (AC0M, 0x00)
            Name (AC1M, 0x00)
            Name (TBL0, Package (0x02)
            {
                Package (0x03)
                {
                    Package (0x02)
                    {
                        0x0E62, 
                        0x0E49
                    }, 

                    Package (0x02)
                    {
                        0x0E30, 
                        0x0DBD
                    }, 

                    Package (0x02)
                    {
                        0x0E26, 
                        0x0DB3
                    }
                }, 

                Package (0x03)
                {
                    Package (0x02)
                    {
                        0x0E26, 
                        0x0DB3
                    }, 

                    Package (0x02)
                    {
                        0x0E62, 
                        0x0E49
                    }, 

                    Package (0x02)
                    {
                        0x0E30, 
                        0x0DBD
                    }
                }
            })
            Method (MODP, 1, NotSerialized)
            {
                Return (Index (DerefOf (Index (TBL0, MODE)), Arg0))
            }

            Method (_TMP, 0, NotSerialized)
            {
                \_SB.PCI0.ISA0.EC0.UPDT ()
                Store (\_SB.PCI0.ISA0.EC0.TMP0, Local0)
                If (LGreater (Local0, 0x0AAC))
                {
                    Return (Local0)
                }
                Else
                {
                    Return (0x0BB8)
                }
            }

            Method (_AC0, 0, NotSerialized)
            {
                If (H8DR)
                {
                    Store (\_SB.PCI0.ISA0.EC0.HT00, Local1)
                }
                Else
                {
                    And (\_SB.RBEC (0x20), 0x01, Local1)
                }

                Store (Local1, \_TZ.THM0.AC0M)
                Store (DerefOf (Index (DerefOf (MODP (0x01)),
                Local1)), Local0)
                Return (Local0)
            }

            Name (_CRT, 0x0E80)
            Method (_SCP, 1, NotSerialized)
            {
                Notify (\_TZ.THM0, 0x81)
            }

            Name (_AL0, Package (0x01)
            {
                FN00
            })
            Method (_PSV, 0, NotSerialized)
            {
                Store (DerefOf (Index (DerefOf (MODP (0x00)), 0x01)),
            Local0)
                Return (Local0)
            }

            Name (_PSL, Package (0x01)
            {
                \_PR.CPU0
            })
            Method (_TC1, 0, NotSerialized)
            {
                Return (TTC1)
            }

            Method (_TC2, 0, NotSerialized)
            {
                Return (TTC2)
            }

            Method (_TSP, 0, NotSerialized)
            {
                Return (TTSP)
            }
        }

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
