Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWAPUPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWAPUPf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWAPUPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:15:35 -0500
Received: from ebb.errno.com ([69.12.149.25]:57348 "EHLO ebb.errno.com")
	by vger.kernel.org with ESMTP id S1751182AbWAPUPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:15:34 -0500
Message-ID: <43CBFE90.8070208@errno.com>
Date: Mon, 16 Jan 2006 12:14:08 -0800
From: Sam Leffler <sam@errno.com>
Organization: Errno Consulting
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: pizza@shaftnet.org, Jeff Garzik <jgarzik@pobox.com>,
       Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
References: <20060113212605.GD16166@tuxdriver.com> <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost> <20060114011726.GA19950@shaftnet.org> <43C97605.9030907@pobox.com> <20060115152034.GA1722@shaftnet.org> <43CAA853.8020409@errno.com> <20060116172817.GB8596@shaftnet.org> <43CBDDC7.9060504@errno.com> <20060116194013.GA12748@shaftnet.org>
In-Reply-To: <20060116194013.GA12748@shaftnet.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuffed Crust wrote:
> On Mon, Jan 16, 2006 at 09:54:15AM -0800, Sam Leffler wrote:
>> The way you implement bg scanning is to notify the ap you are going into 
>> power save mode before you leave the channel (in sta mode).  Hence bg 
>> scanning and power save operation interact.
> 
> That is not "powersave operation" -- that is telling the AP we are going
> into powersave, but not actually going into powersave -- Actual
> powersave operation would need to be disabled if we go into a scan, as
> we need to have the rx path powered up and ready to hear anything out
> there for the full channel dwell time.

Please read what I wrote again.  Station mode power save work involves 
communicating with the ap and managing the hardware.  The first 
interacts with bg scanning.  We haven't even talked about how to handle 
sta mode power save.

> 
>> See above.  Doing bg scanning well is a balancing act and restoring 
>> hardware state is the least of your worries (hopefully); e.g. what's the 
>> right thing to do when you get a frame to transmit while off-channel 
>> scanning, how often should you return to the bss channel?
> 
> Disallow all other transmits (either by failing them altogether, or by 
> buffering them up, which I think is better) while performing the scan.

Not necessarily in my experience.

> 
> If we are (continually) scanning because we don't have an association, 
> then we shouldn't be allowing any traffic through the stack anyway.

If you do not have an association you are not doing bg scanning.

> 
> At the end of each scan pass, you return to the original channel, then 
> return "scan complete" to the stack/userspace.  at this point any 
> pending transmits can go out, and if another scan pass is desired, it 
> will happen then.

If you wait until the end of the scan to return to the bss channel then 
you potentially miss buffered mcast frames.  You can up the station's 
listen interval but that only gets you so far.  As I said there are 
tradeoffs in doing this.

> 
>> Er, you need to listen to at least beacons from other ap's if you're in 
>> 11g so you can detect overlapping bss and enable protection.  There are 
>> other ways to handle this but that's one.
> 
> If you can't hear the traffic, then it doesn't count for purposes of ER
> protection -- but that said, this only matters for AP operation, so APs
> shouldn't filter out anyone else's becacons.  STAs should respect the
> "use ER Protection" bit in the AP's beacon, so can filter out traffic 
> that doesn't match the configured BSSID.

Sorry I meant this was needed for ap operation.

> 
>>> Oh, I know.  I've burned out many brain cells trying to build 
>>> supportable solutions for our customers.   
>> I don't recall seeing well-developed scanning code in either of the 
>> proposed stacks.
> 
> I've only looked into the pre-2.6-merged HostAP stack, so I can't 
> comment on what's publically available.  I'll have a look at the GPL'ed 
> DeviceScape stack when I have more time.
> 
> Most of what I've going on about is derived from my experience from
> commercial 802.11 work I've done over the past few years.

Ditto.

	Sam

