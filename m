Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbWILUOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWILUOy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 16:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWILUOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 16:14:54 -0400
Received: from outbound-res.frontbridge.com ([63.161.60.49]:44729 "EHLO
	outbound1-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1030399AbWILUOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 16:14:52 -0400
X-BigFish: VP
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Date: Tue, 12 Sep 2006 14:18:05 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Jim Gettys" <jg@laptop.org>
cc: "Pavel Machek" <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>,
       "Dominik Brodowski" <linux@dominikbrodowski.net>,
       "ACPI ML" <linux-acpi@vger.kernel.org>,
       "Adam Belay" <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Arjan van de Ven" <arjan@linux.intel.com>, devel@laptop.org,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Subject: Re: ACPI: Idle Processor PM Improvements
Message-ID: <20060912201805.GK14885@cosmic.amd.com>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
 <20060830194317.GA9116@srcf.ucam.org>
 <200608311713.21618.bjorn.helgaas@hp.com>
 <1157070616.7974.232.camel@localhost.localdomain>
 <20060904130933.GC6279@ucw.cz>
 <1157466710.6011.262.camel@localhost.localdomain>
 <20060906103725.GA4987@atrey.karlin.mff.cuni.cz>
 <20060906145849.GE2623@cosmic.amd.com>
 <20060912092100.GC19482@elf.ucw.cz>
 <1158084871.28991.489.camel@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <1158084871.28991.489.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 12 Sep 2006 20:14:43.0131 (UTC)
 FILETIME=[1590F8B0:01C6D6A8]
X-WSS-ID: 6919CAB91L82820840-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/06 14:14 -0400, Jim Gettys wrote:
> > Alternatively, hack kernel to take control from X without actually
> > switching consoles. That should be possible even with current
> > interface.
> 
> This would require saving/restoring all graphics state in the kernel
> (and X already has that state internally).  Feasible, but seems like
> duplication of effort.  I haven't checked if there are any write-only
> registers in the Geode (though, thankfully, this kind of brain damage is
> rarer than it once was).  This then begs interesting kernel/X
> synchronization issues, of course.

We don't need any kernel output during suspend or resume.  Thus, if the VT
doesn't change, then the kernel doesn't need worry about saving or restoring 
the graphics state, and thats the way it should be, IMHO.
Whoever owns the current VT should be in charge of saving and restoring 
the registers.

So, we would need some way of indicating the "ownership" of the VT.  And
in reality, we really only to know if the framebuffer console owns it or
not, so a boolean would suffice.  In the past, I've used KD_TEXT and 
KD_GRAPHICS for this purpose.  As an example, on the Geode LX, I assume
that if the vc_mode is KD_GRAPHICS, then we don't own it, and we don't
do 2D accelerations.  If the mode is KD_TEXT then we are free to use the
2D engine.   All I needed to add ws a notifier chain to let the framebuffer
know when the mode switched, and I was happy.  I'm not sure if thats the
smartest way to handle it permanently, but it works in a pinch.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>


