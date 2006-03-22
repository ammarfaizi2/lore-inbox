Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWCVHPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWCVHPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 02:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWCVHPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 02:15:41 -0500
Received: from smtpauth08.mail.atl.earthlink.net ([209.86.89.68]:33412 "EHLO
	smtpauth08.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1750998AbWCVHPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 02:15:30 -0500
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
In-Reply-To: Your message of "Wed, 22 Mar 2006 09:30:04 +0800."
             <3ACA40606221794F80A5670F0AF15F840B417B9D@pdsmsx403> 
X-Mailer: MH-E 7.91; nmh 1.1; GNU Emacs 21.4.1
Date: Wed, 22 Mar 2006 02:15:09 -0500
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FLxYj-00011i-Px@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478a122c03f3aaf2a20d7e8541fd6a15496d16eadd309c7c8a3350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So the kernel with this UPDT() hung at the 2nd sleep:

                    Method (UPDT, 0, NotSerialized)
                    {
                        If (IGNR)
                        {
                            Decrement (IGNR)
                        }
                        Else
                        {
                            If (H8DR)
                            {
                                If (Acquire (I2CM, 0x0064)) {}
                                Else
                                {
                                    Store (I2RB (Zero, 0x01, 0x04), Local7)
                                    If (Local7)
                                    {
                                        Fatal (0x01, 0x80000003, Local7)
                                    }

                                    Release (I2CM)
                                }
                            }
                        }
                    }

Relative to a working kernel (well, a kernel that I could get to hang
only once, and then all reboots afterwards it never would hang), these
are the extra lines:

                                    Store (I2RB (Zero, 0x01, 0x04), Local7)
                                    If (Local7)
                                    {
                                        Fatal (0x01, 0x80000003, Local7)
                                    }

Since I don't think Fatal() isn't being called, I guess the problem is
in I2RB.  But all those magic numbers in I2RB make me recultant to take
out lines, unless you tell me which changes won't harm the hardware.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
