Return-Path: <linux-kernel-owner+w=401wt.eu-S932948AbWLSVWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbWLSVWS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933004AbWLSVWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:22:18 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:46474 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932948AbWLSVWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:22:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=broZXNCJA4DG150Tu84HkmDnqYfNCGBDKFE3gUvGhFvCxy6Kxv/b0dohIAEFHcp62C0FoZN7g/VsKpZjPWmFzSf/Na5G+B07IwLu6NYSuOvegdmMSkQwjrHYrPzVfxv3wVSLE/XSe8RZMdO2MfdmkLtN4GWeXaPBKvSVOhqs/nI=  ;
X-YMail-OSG: Gez7CFoVM1kb5SPDZNGw7TRuNuEQ0D4hgXH2DBp15Ug0hvllQ1S3O6EolQZNLZnGSaOOL5sooKbqPIZkN2simMdFcaWVJcAGdjSrPEgCbuIuNw.f.xXG.lxbdGckLpMm0z.y45eZVHYOHHu6cT1vUADl53fSl5tryJJREyCHJlUv4w--
From: David Brownell <david-b@pacbell.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Changes to sysfs PM layer break userspace
Date: Tue, 19 Dec 2006 13:22:12 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org>
In-Reply-To: <20061219185223.GA13256@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612191322.13378.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 10:52 am, Matthew Garrett wrote:
> Commit 047bda36150d11422b2c7bacca1df324c909c0b3 broke userspace.

Actually, no ... that just prevented breakage enabled by
commit cbd69dbbf1adfce6e048f15afc8629901ca9dae5 which taught
PCI how to use the new irqs-off suspend_late()/resume_early()
driver model calls.


> Previously, /sys/bus/pci/devices/foo/power/state could have values 
> echoed into it for triggering suspend/resume calls in the driver.

In general, it still can; though not for PCI, because of the change
I pointed out above.  What the patch you mentioned changes is something
else:  it refuses to do so when those calls should require leaving
the system in an IRQs-off mode.

Rather obviously, IRQs-off is fine for entering system-wide suspend
states.  But Linux can't stay in that mode for normal operations ...


> The  
> breakage is handily mentioned in the comment:
> 
> "Devices with bus.suspend_late(), or bus.resume_early() methods fail 
> this operation; those methods couldn't be called."

And the reason they couldn't be called is:  that they guarantee IRQs
would stay off between suspend_late() and resume_early().

 
> but there's no mention of what previously working code is supposed to do 
> now. 

Stop trying to use broken and deprecated APIs; and realize that "previously
working" meant you just hadn't tripped over the serious bugs yet.

Work with driver framework developers to come up with a solution for
the _real_ problem, which IMO will look more like "teach <x> stack about
power management" than "bypass all the driver layers and go right to a
PCI-specific mechanism, even for non-PCI drivers".


>> Ubuntu uses it to disable wireless hardware under certain circumstances. 
>> I believe that Suse's powernowd uses it to power down wired ethernet 
>> hardware when it's not in use.

Drivers can and should know how to do that sort of stuff themselves,
so the power savings are reliable and consistent no matter what user
space tools are (or aren't) used.

Drivers know how to get power savings a lot better than any userspace
code ever could ... with the exception of hints like "ifdown eth0"
letting the driver know that right now is a good time to power down
almost everything, since it's not going to be used until "ifup".
(Agreed that other hints may be desirable, but that's a different
issue ... probably best addressed at the framework level, e.g. WLAN,
rather than by hacks to individual drivers.)


> That's the second time in the past year or so that this interface  
> has been broken - can we have it working again, please, especially as 
> there doesn't appear to be an alternative yet?

As a generic mechanism, that interface has *ALWAYS* been "broken
by design"; I'd call it unfixable.  It's deprecated, and scheduled
to vanish; see Documentation/feature-removal-schedule.txt ...

- Dave
