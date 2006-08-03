Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWHCQLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWHCQLJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWHCQLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:11:09 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:16268 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964836AbWHCQLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:11:06 -0400
Date: Thu, 3 Aug 2006 20:10:47 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Chris Leech <chris.leech@gmail.com>
Cc: Krzysztof Oledzki <olel@ans.pl>, Arnd Hannemann <arnd@arndnet.de>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
Message-ID: <20060803161046.GA703@2ka.mipt.ru>
References: <44D1FEB7.2050703@arndnet.de> <20060803135925.GA28348@2ka.mipt.ru> <44D20A2F.3090005@arndnet.de> <20060803150330.GB12915@2ka.mipt.ru> <Pine.LNX.4.64.0608031705560.8443@bizon.gios.gov.pl> <20060803151631.GA14774@2ka.mipt.ru> <41b516cb0608030857h1d55820rfd4ccd0cc56dd71d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <41b516cb0608030857h1d55820rfd4ccd0cc56dd71d@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 03 Aug 2006 20:10:48 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 08:57:36AM -0700, Chris Leech (chris.leech@gmail.com) wrote:
> On 8/3/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> >> Strange, why this skb_shared_info cannon be added before first alignment?
> >> And what about smaller frames like 1500, does this driver behave similar
> >> (first align then add)?
> >
> >It can be.
> >Could attached  (completely untested) patch help?
> 
> Note that e1000 uses power of two buffers because that's what the
> hardware supports.  Also, there's no program able MTU - only a single
> bit for "long packet enable" that disables frame length checks when
> using jumbo frames.  That means that if you tell the e1000 it has a
> 16k buffer, and a 16k frame shows up on the wire, it's going to write
> to the entire 16k regardless of your 9k MTU setting.  If a 32k frame
> shows up, two full 16k buffers get written to (OK, assuming the frame
> can fit into the receive FIFO)

Maximum e1000 frame is 16128 bytes, which is enough before being rounded
to 16k to have a space for shared info.
My patch just tricks refilling logic to request to allocate slightly less
than was setup when mtu was changed.

> That's why I've always been against trying to optimize the allocation
> sizes in the driver, even with your small change the skb_shinfo area
> can get corrupted.  It may be unlikely, because the frame still has to
> be valid, but some switches aren't real picky about what sized frame
> they'll forward on if you enable jumbo support either.  So any box on
> the LAN could send you larger than MTU frames in an attempt to corrupt
> memory.

It is trivial patch and it can be incorrect (especially for small sized
packets), but it is a hint, that 9k jumbo frame should not require 32k
allocation.

> I believe that if you tell a hardware device it has a buffer of a
> certain size, you need to be prepared for that entire buffer to get
> written to.  Unfortunately that means wasteful allocations for e1000
> if a single buffer per frame is going to be used.

Hardware is not affected, second patch just checks if there is enough
space (e1000 stores real mtu). I can not believe that such modern NIC
like e1000 can not know in receive interrupt size of the received
packet, if it is true, than in generel you are right and some more 
clever mechanisms shoud be used (at least turn hack off for small
packets and only enable it for less than 16 jumbo frames wheere place 
always is), if size of the received packet is known, then it is enough
to compare aligned size and size of the packet to make a decision for
allocation.

> - Chris

-- 
	Evgeniy Polyakov
