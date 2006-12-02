Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936127AbWLBHT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936127AbWLBHT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 02:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759405AbWLBHT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 02:19:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:36819 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1759404AbWLBHTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 02:19:55 -0500
X-Authenticated: #24128601
Date: Sat, 2 Dec 2006 08:15:03 +0100
From: Sebastian Kemper <sebastian_ml@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, thockin@hockin.org
Subject: Re: [OHCI] BIOS handoff failed (BIOS bug?)
Message-ID: <20061202071503.GA6184@section_eight>
Mail-Followup-To: Sebastian Kemper <sebastian_ml@gmx.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Pete Zaitcev <zaitcev@redhat.com>, thockin@hockin.org
References: <20061201130359.GA3999@section_eight> <20061201182855.GA7867@section_eight> <20061201150201.4e8c9edb.zaitcev@redhat.com> <20061201232339.GA25645@hockin.org> <20061201152922.93cc59a4.zaitcev@redhat.com> <20061201233247.GA27014@hockin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201233247.GA27014@hockin.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 03:32:47PM -0800, thockin@hockin.org wrote:
> On Fri, Dec 01, 2006 at 03:29:22PM -0800, Pete Zaitcev wrote:
> > On Fri, 1 Dec 2006 15:23:39 -0800, thockin@hockin.org wrote:
> > 
> > > BIOS handoff assumes an SMI, right?  Could SMI be masked?
> > 
> > That might be a bad idea, because things like fans may be controlled
> > by SMM BIOS. The best thing we can do is to follow the published
> > procedure, and maybe insert a workaround if Sebastian can identify it.
> 
> Sorry, I don't mean "could we mask it" but rather "is it possible that it
> is already masked"?
> 
> Tim

Hi,

I can't see any negative effects when the handoff fails. But if any of
you think it's worth to get to the bottom of this I'm more than willing
to help the best I can. But I don't know what SMI nor SMM BIOS is, just
so you know that I can't figure out these things on my own.

I extracted my BIOS' dsdt and disassembled it (on a hunch). I grepped
it for strings like "Microsoft" and "Windows" and found three:

           Method (_INI, 0, NotSerialized)
            {
                If (STRC (_OS, "Microsoft Windows"))
                {
                    Store (0x56, SMIP)
                }
                Else
                {
                    If (STRC (_OS, "Microsoft Windows NT"))
                    {
                        If (CondRefOf (_OSI, Local0))
                        {
                            If (_OSI ("Windows 2001"))
                            {
                                Store (0x59, SMIP)
                                Store (Zero, OSFL)
                                Store (0x03, OSFX)
                            }
                        }
                        Else
                        {
                            Store (0x58, SMIP)
                            Store (Zero, OSFL)
                        }
                    }
                    Else
                    {
                        Store (0x57, SMIP)
                        Store (0x02, OSFL)
                    }
                }
            }

So I tried all possible combinations of acpi_os_name and acpi_osi
(allthough the latter seemed to be ignored by the ACPI system). But this
didn't change the OHCI handoff behaviour. At least we can rule this one
out. But probably disassembling the dsdt was a waste of time :-)

Regards
Sebastian
