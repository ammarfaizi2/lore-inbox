Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVLIJIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVLIJIE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 04:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVLIJIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 04:08:02 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:36968
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751295AbVLIJIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 04:08:01 -0500
Message-Id: <439957A7.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Dec 2005 10:08:39 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Andrew Morton" <akpm@osdl.org>, "Rafael Wysocki" <rjw@sisk.pl>,
       <linux-kernel@vger.kernel.org>, "Discuss x86-64" <discuss@x86-64.org>
Subject: Re: [discuss] Re: 2.6.15-rc5-mm1 (x86_64-hpet-overflow.patch
	breaks resume from disk)
References: <20051204232153.258cd554.akpm@osdl.org>  <200512070146.50221.rjw@sisk.pl>  <200512080015.01444.rjw@sisk.pl>  <43980058.76F0.0078.0@novell.com> <20051208224735.GV11190@wotan.suse.de>
In-Reply-To: <20051208224735.GV11190@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 08.12.05 23:47:35 >>>
>On Thu, Dec 08, 2005 at 09:43:52AM +0100, Jan Beulich wrote:
>> I don't know how resume normally handles the re-syncing of the wall
>> clock, but the problem here is obvious: do_timer runs a loop to
>> increment jiffies, which may require significant amounts of time
>> (depending how long the system was sleeping).
>
>It would be good if someone could submit a patch to fix
>this up properly. It indeed sounds wrong.

With the nlkd patches I actually submitted code that does deal with the
calculation when significant amounts of ticks have been missed. However,
this is only part of the problem. What is more important first is for
the resume code to tell the timer interrupt handlers that it shouldn't
consider the last TSC (or other time stamp) value read prior to suspend,
but rather start anew.

>The HPET patch seems to be generally unhappy. With it applied
>I get lots of obviously wrong softlockup warnings from the
>softlockup watchdog thread on a dual NForce4 system. So something
>goes wrong with the timing there. The strange thing 
>is that the system doesn't even have a HPET table so HPET code
shouldn't
>be executed - but it goes away when I revert the patch. Very
>mysterious.

It doesn't only change the HPET code, the TSC code was suffering from
overflow problems, too, which the patch also tries to address. I can't,
however, see where or how it would cause softlockup reports. Do the
printed call stacks provide any useful information?

>Also I think vgettimeofday doesn't handle 64bit HPET correctly
>yet. Also why does it not use hpet_readq? 

For the simple reason that there is no way to know whether the entire
interconnect from CPU to HPET is (at least) 64 bits wide. At least
theoretically implementations are permitted to use 32-bit components;
the HPET spec specifically warns about that.

>I suspect the 64bit HPET patch needs some more cooking. I think
>I will drop it for now.
>
>I would suggest you submit the cleanups in there separately
>(without changing semantics yet) 
>then it will be easier to test in the future too.

What cleanups are you referring to here?

Jan

