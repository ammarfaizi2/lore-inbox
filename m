Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWAOTzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWAOTzI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 14:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWAOTzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 14:55:07 -0500
Received: from ebb.errno.com ([69.12.149.25]:56592 "EHLO ebb.errno.com")
	by vger.kernel.org with ESMTP id S932123AbWAOTzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 14:55:06 -0500
Message-ID: <43CAA853.8020409@errno.com>
Date: Sun, 15 Jan 2006 11:53:55 -0800
From: Sam Leffler <sam@errno.com>
Organization: Errno Consulting
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>, Johannes Berg <johannes@sipsolutions.net>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost> <20060114011726.GA19950@shaftnet.org> <43C97605.9030907@pobox.com> <20060115152034.GA1722@shaftnet.org>
In-Reply-To: <20060115152034.GA1722@shaftnet.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuffed Crust wrote:
> On Sat, Jan 14, 2006 at 05:07:01PM -0500, Jeff Garzik wrote:
>>> This can be accomplished by passing a static table to the 
>>> register_wiphy_device() call (or perhaps via a struct wiphy_dev 
>>> parameter) or through a more explicit, dynamic interface like:
>>>
>>>  wiphy_register_supported_frequency(hw, 2412). 
>> For completely programmable hardware, the stack should interact with a 
>> module like ieee80211_geo, to help ensure the hardware stays within 
>> legal limits.
> 
> While there is much to debate about where to draw the functionality 
> line, completely programmable hardware is the norm these days.
> 
> ... and said code would be responsible for driving the scanning state
> machines, and also for more esoteric functions like handling RADAR
> traps, automatic channel switching, etc.
> 
> Handling scans is quite interesting -- I've seen hardware which requires 
> manual channel changing (including full RF parameter specification), 
> host timing for the channel dwell time, and manual probe request 
> issuance.. and on the other end of the spectrum, a simple "issue scan" 
> command that takes few, if any, parameters.
> 
> And unfortunately, many things in between.
> 
> This leads me to belive that the internal scan workflow should work
> something like this:
> 
>  * Userspace app issues scan request (aka "refresh AP list")
> 
>  * Knowing the hardware frequency capabilities, the 802.11 stack applies 
>    802.11d and regdomain rules to the available frequency set, and
>    issues multiple internal "scan request" commands to the hardware 
>    driver.  (eg "perform an initial passive sweep across the entire 
>    2.4G band", "perform an active scan on frequencies 2412->2437 
>    looking for ssid "HandTossed", "perform an active scan on 
>    frequencies 5200-5400 looking for ssid "HandTossed", etc)
> 
>    (note that ideally, userspace apps/libs would be at least partially
>     aware of 802.11d rules, but the kernel must do the RightThing if 
>     told to "scan all available channels for any access points")
>   
>  * The hardware driver takes this scan request, and maps it into the 
>    capabilities of the hardware:
> 
>    Hardware A: (very thin MAC)
>     - Using library code, generates an appropriate probe request frame, 
>       translates it into a format the hardware expects/needs, 
>       and schedules it appropriately.
>     - Loops through the frequency set specified, and for each:
> 	- Issues a channel change command
> 	- Immediately transmits the probe request (for active scans)
> 	- Dwells for an appropriate time
>         - RX'ed beacon/probe response frames come down as regular 802.11 
>           frames into the stack
>         - Moves to the next channel
> 
>    Hardware B: (thinner MAC)
>     - Using library code, generates an appropriate probe request frame, 
>       and translate it into a format the hardware expects.
>     - Program the probe request frame into the hardware as a probe 
>       template.
>     - Loops through the frequency set specified, and for each:
> 	- Issues a channel change command
>         - Wait for a scan complete signal
>         - RX'ed beacon/probe response frames come down as regular 802.11 
>           frames into the stack
>         - Moves to the next channel
>     
>    Hardware C: (thick MAC, ala prism2 or prism54)
>      - Issues a hardware "scan request"
>      - Waits for the hardware to signal "scan complete"
>      - Requests hardware scan results
>      - For each scan result, the hardware returns:
>         - Translate result into an 802.11 probe response frame and
>           pass down the regular RX path.
> 
>    So as you can see, I think the channel iteration, dwell, etc should 
>    be performed by the hardware driver itself, as the variation at the 
>    logical "tell the hardware perform a scan" step is so extreme.
> 
>  * Meanwhile, the 802.11 stack is receiving the beacons/probe responses 
>    from the hardware via the regular rx path.  It diverts these (and 
>    other 802.11 management/control) frames, decodes them, and then adds 
>    them to the stack's internal list of available stations, updating any 
>    internal states/counters as necessary.  (These frames could also be 
>    echoed to a special netdev interface if desired)
> 
>    (stuff like detecting an AP going away depends on us noticing a lack 
>     of beacons arriving, for example.  Most hardware does not 
>     notify us of this event.  Likewise, we should expire other 
>     APs from our list if they go away.. etc.  For AP operation we need 
>     to maintain this STA list, period -- so why not use it across the 
>     board?  But this is another discussion for another time..)
> 
>  * The 802.11 stack issues a MLME-Scan-Complete notification to 
>    userspace.
> 
>  * Interested userspace apps see this event, then query the 
>    scan results and presents them to the user in some pretty format, or 
>    alternatively perform automatic roaming based on scan results.

The above is a great synopsis but there is more.  For example to support 
roaming (and sometimes for ap operation) you want to do background 
scanning; this ties in to power save mode if operating as a station. 
Further you want to order your channel list to hit the most likely 
channels first in case you are scanning for a specific ap--e.g. so you 
can stop the foreground scan and start to associate.  In terms of beacon 
miss processing some parts have a hardware beacon miss interrupt based 
on missed consecutive beacons but others require you to detect beacon 
miss in software.  Other times you need s/w bmiss detection because 
you're doing something like build a repeater when the station virtual 
device can't depend on the hardware to deliver a bmiss interrupt.

Then of course there's whole issue of interacting with firmware-based 
cards that have limited and/or funkiness in their scanning support.

Scanning (and roaming) is really a big can 'o worms.

	Sam
