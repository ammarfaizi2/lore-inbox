Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423084AbWAMWtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423084AbWAMWtL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423082AbWAMWtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:49:11 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:41706 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1423078AbWAMWtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:49:10 -0500
Message-ID: <43C82E63.80000@candelatech.com>
Date: Fri, 13 Jan 2006 14:49:07 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues
References: <20060113195723.GB16166@tuxdriver.com> <43C80F9A.8020203@candelatech.com>
In-Reply-To: <43C80F9A.8020203@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a re-send since the lists ate my reply.  I've also
trimmed out all but netdev and lkml email addresses.

 > Do "global" config requests go to any associated wlan device?
 > Or must they be directed to the WiPHY device?  Does it matter?
 > I think we should require "global" configuration to target the WiPHY
 > device, while "local" configuration remains with the wlan device.
 > (I'm not sure how important this point is?)  Either way, the WiPHY
 > device will need some way to be able to reject configuration requests
 > that are incompatible among its associated wlan devices.  Since the
 > wlan interface implementations should not be device specific, perhaps
 > the 802.11 stack can be smart enough to filter-out most conflicting
 > config requests before they get to the WiPHY device?


I'd create a generic function that handles most things, but allow the
driver to over-ride this method if it knows better.  Something like
is_ok_to_add(new wlan device info);
might need an is_ok_to_remove(foo); as well.

 > We need an ethernet<->802.11 translational bridging interface for
 > compatibility, and to enable 802.1 bridging with ethernet.  This could
 > be a configuration setting for a wlan interface.  It might be limited
 > to wlan interfaces in station (or WDS) mode?


If we can send a raw ethernet frame at the driver/stack, then it can
reject or send as needed.  For instance, you should be able to 'bridge'
to a regular station interface _IF_ the source MAC matches the station's
source MAC.  This would also allow the packet-socket code to work with
wifi just like it does with wired ethernet (and 802.1Q VLANs, for that matter.)

 > Should a default wlan device be created at WiPHY init?  Should it
 > enable translational bridging?  I'm inclined against this, but is it
 > worthwhile for compatibility?  Could/should this be a configuration
 > option for the stack?


I wouldn't...can't see how it helps anything.

 > Stack
 > =====
 >
 > Is the in-kernel stack up-to-date w/ SourceForge?  No.  Why not?
 > Can this development be brought into wireless development kernels?
 >
 > Can the in-kernel stack be saved?  With the addition of softmac?
 > Is it possible to extend softmac to support virtual wlan devices?
 > If not, how do we proceed?
 >
 > How do we get more drivers in-kernel?  (Multiple stacks probably
 > don't help beyond the short-term timeframe.)


One thing multiple in-kernel stacks might give us would be an easier way for
developers (especially those not fully versed in wifi)
to try out features of both stacks and make merging between
the stacks easier (with the goal of having only one stack).  It would probably
allow more drivers to get in immediately as well, which should get
more developers working on the same core logic.

 > Other Issues
 > ============
 >
 > Radiotap headers make sense for an rfmon virtual device.  I don't
 > think it makes sense for "normal" usage.  Should there be an option
 > for radiotap headers on non-rfmon links?
 >
 > Rfmon interferes w/ other interfaces, but may be handy to enter/leave
 > w/ little effort.  Perhaps a config option for physical device to
 > suspend/resume all (non-rfmon) virtual devices before/after enabling
 > rfmon virtual device?  (Would multiple rfmon devices even make sense?
 > If not, is it worth restricting that?)


With regard to conflicting virtual devices:  How about treat all 'DOWN'
devices as irrelevent to the physical device.  That way, you can have
rfmon, AP, station, etc devices all configured at once, and just ifdown/ifup
the one(s) you want to use at any given point.  The virtual interfaces can
keep all config info needed to bring themselves back online.

 > What about old hardware w/ inactive maintenance?  Deprecate/remove?
 > Grandfather them w/ treatment as ethernet devices?  Probably don't
 > need a pronouncement on this at this time...


Ignore for now..maybe it will get more active maintenance when the
stack solidifies enough to make developing wifi less complex.


 > Since we are toying with the issue of multiple stacks (at least in the
 > wireless development kernels), some thought needs to be done w.r.t. how
 > to make a final decision between the two stacks.  An objective lists
 > of functional feature requirements seems like a good place to start.
 > IOW, I would like to have a list of features that would trigger the
 > removal of one stack shortly after the other stack achieves support
 > for the list.  Is this feasible?


Would it be possible to write a very thin 'shim' stack that could
sit over either device-scape or the current stack?  This shim could
start solidifying the API with user-space somewhat independently of
the lower levels.  If one stack did not support a particular feature,
then it just returns a failure code.  If this is not too much work,
it might allow the stack merge to happen gradually.  Of course, this
might be more work than it's worth...

Thanks for all the work you're doing!

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

