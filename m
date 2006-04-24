Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWDXRIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWDXRIo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWDXRIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:08:44 -0400
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:18134 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S1750812AbWDXRIn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:08:43 -0400
To: "Gross, Mark" <mark.gross@intel.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       <bluesmoke-devel@lists.sourceforge.net>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
Subject: Re: Problems with EDAC coexisting with BIOS
References: <5389061B65D50446B1783B97DFDB392DA23445@orsmsx411.amr.corp.intel.com>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: Mon, 24 Apr 2006 11:08:17 -0600
In-Reply-To: <5389061B65D50446B1783B97DFDB392DA23445@orsmsx411.amr.corp.intel.com> (Mark
 Gross's message of "Mon, 24 Apr 2006 08:57:53 -0700")
Message-ID: <m3vesyj3zy.fsf@maxwell.lnxi.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Gross, Mark" <mark.gross@intel.com> writes:


> Yes, EDAC should not have existed without first working more closely
> with the BIOS folks.  It's too bad we (Intel) didn't catch this.  The
> BIOS folks where not in the loop with the driver folks making
> contributions to EDAC previously.

Isn't the real world a great place where people do things because
they work and not because they were designed to be that way?

There were BIOS folk involved but not the AMI BIOS folk.  Beyond
that Intel is not known for having conversations with technical people
who want to do creative and useful things.

> I think what I'm saying is pretty clear and I don't think it is related
> to whatever workarounds where done earlier.

Alan appears to be asking because we seem to be breaking the same
set of rules.

>
> I don't know of any technote.  It took me working with Soo Keong for a
> few weeks to chase this issue down to the level I have.  The short
> answer is that the BIOS assumes the payload OS would not be fighting it
> for hidden device access and the EDAC driver violates this
> assumption.

If this is supposed to be an SMM mode only device why can the OS
enable it?  If the BIOS prevents the OS from enabling that device
that probe routing will fail.  But instead the BIOS in SMM mode is
allowing the device to be seen and probed, and then it is disabling
it.  So there is not an SMM trap firing when the enable bit is set.

>>> I think the best thing to do is to have the driver error out in its
> init
>>> or probe code if the dev0:fun1 is hidden at boot time.
>>>
>>> Comments?
>>
>>Why did Intel bother implementing this functionality and then screwing
>>it up so that OS vendors can't use it ? It seems so bogus.
>>
>
> It was just a screw up not to have identified this issue sooner.  

Now that the issue is identified hopefully we can work together
to successfully get useful information out of the hardware, about
it's health. 

>>At the very least we should print a warning advising the user that the
>>BIOS is incompatible and to ask the BIOS vendor for an update so that
>>they can enable error detection and management support.
>
> I would place the warning in the probe or init code.

Placing a warning when we enable the device in the probe code sounds
reasonable.

> Attached is a test patch I'm testing now.  I don't like it, but it seems
> to be working so far.  It basically fails the probe call leaving the
> driver loaded.  I'm going to move the test to e752x_int so the driver
> fails at init this am at restart my tests.

The probe will already fail if we can't actually find this device.

Simply ignoring the device if it isn't there is not enough, as there
are BIOS's that simply disable the device on Intel's recommendation
but don't seem to be doing anything interesting with it.

A check to see if we have actually enabled the device would be
reasonable.  Of course the code already copes gracefully with
the situation where we enable the device and it doesn't show
up.

It is quite reasonable to make the code more careful in this
case but there is already a chance for the firmware to take
an SMI trap and not allow the OS to do something.

>>Is only the AMI BIOS this braindamaged, should we just blacklist AMI
>>bioses in EDAC or is this shared Intel supplied code that may be found
>>in other vendors systems.
>>
>
> Unknown.  Also the BOIS teams for various platforms can modify the base
> AMI functionality.  I know that at least one Intel e7520 based system
> with AMI based bios seems to not expose this issue.  The point is that
> without working out a handshake between the OS and the platform / BIOS
> for this type of thing, loading EDAC without a patch like mine is
> equivalent to playing Russian roulette.  You can't know which platform /
> bios will blow up on you if you load the thing.

Several pieces here. 
- SMM mode is deeply deprecated.  There is no reason to expect it
  to be used on a server platform.  Isn't that what them AML in ACPI is for?

  Having the firmware doing anything while the system is running is
  deeply troubling.  Since there is not an OS/firmware handshake by
  your own line of reasoning running an OS on the platform is playing
  Russian roulette with the hardware.

- A check in the probe routine to see if we fail to enable the device
  is reasonable.  Warning if we need to enable the device is also reasonable.
  Not enabling the device if we can enable the device is not reasonable.

- This code represents a huge amount of pent up demand, Intel has
  had years to propose something better that people can actually use.

- The question was asked why these devices were hidden and at the time
  the only answer that could be obtained was that Intel recommended
  it, but no reason was given.  So there was no reason to expect a
  conflict with the firmware.

If the system event log actually captures all of the error events
that are reported by the hardware, so we can write an equivalent
driver by reading the SEL there may be a reasonable alternative
route.  Otherwise as it appears likely the SEL filters the data
it appears to be yet another case of reducing the value of the
hardware by putting an unreliable firmware interface in front
of it.

Eric
