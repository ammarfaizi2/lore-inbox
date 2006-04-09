Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWDIPEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWDIPEq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWDIPEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:04:46 -0400
Received: from mx1.suse.de ([195.135.220.2]:2021 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750762AbWDIPEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:04:45 -0400
From: Andi Kleen <ak@suse.de>
To: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Black box flight recorder for Linux
Date: Sun, 9 Apr 2006 17:04:47 +0200
User-Agent: KMail/1.9.1
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <5ZjEd-4ym-37@gated-at.bofh.it> <200604080917.39562.ak@suse.de> <4437E4B7.40208@superbug.co.uk>
In-Reply-To: <4437E4B7.40208@superbug.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604091704.47566.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 April 2006 18:28, James Courtier-Dutton wrote:
> Andi Kleen wrote:
> > On Saturday 08 April 2006 16:05, Robert Hancock wrote:
> >> Andi Kleen wrote:
> >>> James Courtier-Dutton <James@superbug.co.uk> writes:
> >>>> Now, the question I have is, if I write values to RAM, do any of those
> >>>> values survive a reset?
> >>> They don't generally.
> >>>
> >>> Some people used to write the oopses into video memory, but that
> >>> is not portable.
> >> I wouldn't think most BIOSes these days would bother to clear system RAM
> >> on a reboot. Certainly Microsoft was encouraging vendors not to do this
> >> because it slowed down system boot time.to
> > 
> > Reset button is like a cold boot and it generally ends up with cleared 
> > RAM.
> > 
> > -Andi
> 
> Thank you. That saved me 30mins hacking. :-)

Sorry for having discouraged you.

Actually there is a rare special case - triple fault - where you
might be ok if the BIOS correctly supports the ACPI "bootflag" standard,
but triple faults are relatively rare. They happen when the 
kernel screws up so badly that the CPU cannot even run exception
handlers anymore. But I suspect it's too special for this.

First if you're not aware of this - the "official" way right now
to solve this problem is kexec + kdump + a preloaded crash kernel. But in 
practice it still has many problems because a lot of drivers cannot 
reinitialize the hardware properly. And of course it will users need
to load the crash kernel in advance and lose about 64MB of RAM.

My personal solution to the problem is firescope, but it also has its
drawbacks (needs ohci1394 loaded first, requires a firewire cable)

What I would do for this if you want to hack.- define a generic interface that allows
drivers to register memory storage handlers. Add a entry into the oops die 
and panic notifiers that saves the kernel log into these backends.

Then write some Documentation file for it and add a proof of comcept e.g. to the  
Nvidia/ATI frame buffer drivers. Then driver writers could expose this functionality 
if their hardware supports it or if someone has an embedded platform that
guarantees it they could also use it.

For Nvidia/ATI it might be tricky to get the
X server to keep its hands off the memory, but I assume most graphic cards
these days have more memory than the X server uses at least without 3d (?).
If you're unlucky it will fill up everything with mozilla pixmaps over time though.
In the worst case you would need to define a new interface between X server
and kernel to tell the X server to leave some memory alone.

The generic driver could also do the high level work, like adding proper
checksums and magic values to make sure the data is sane after reboot.
You would also need another driver that allows the boot process to read that
data.

Hope this helps,

-Andi
