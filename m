Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266011AbUGaRGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUGaRGm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 13:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUGaRGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 13:06:42 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:6115 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S266011AbUGaRGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 13:06:17 -0400
Message-ID: <410BD0E3.2090302@candelatech.com>
Date: Sat, 31 Jul 2004 10:03:31 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: Willy Tarreau <willy@w.ods.org>, Jeff Garzik <jgarzik@pobox.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org,
       alan@redhat.com, jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com> <20040731101152.GG1545@alpha.home.local> <20040731141222.GJ2429@mea-ext.zmailer.org>
In-Reply-To: <20040731141222.GJ2429@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:

> Also the Linux kernel isn't very well happy with multi-path stacking
> of layer-2 driver modules.  A side-effect from all of these things might
> be, that setting up some dozen VLANs to an ethernet with result in
> two, or in worst case, a dozen+1 setup runs.  And if last VLAN setup
> is (for any reason) smaller MTU value than 1500, it might even result
> in entire driver to be configured for e.g. 1280+4 byte MTU..

If the VLAN code shrinks the MTU on the underlying device, I'd
consider that a bug.


> For this IFCONFIG MTU issue, I would rather have the VLAN code to ask
> the underlaying driver of what MTU can be supported, than just blindly
> presume that 1500 will be functional for e.g. eth0.2  (like it does now)
> 
> Things would just magically work, if the uping of  eth0.2  would setup
> itself to MTU 1496, unless the underlaying eth0 can handle real 1504 byte
> 802.1q frames.

Things would not magically work.  Sending larger frames almost always
works, it is receiving the larger frames that fails.  So you really
need to change the MTU of the peer device instead (and everything else
on the local VLAN).

>>>For VLAN support you definitely want to let the user increase the size 
>>>above 1500, and for that you need ->change_mtu
>>
>>I agree, but my point was that adding MODULE_PARM was only a one liner and
>>would have done the job too. But since everyone prefers a change_mtu(), I'll
>>do it.

VLAN allows you to continue using the ethX interface as a regular
ethernet interface, so you do not generally want it's MTU to be set
to 1504 because then the other peer ethernet interfaces would also
have to be set to 1504.  I believe it is much better to silently let
the extra 4 bytes pass but NOT advertise this extra 4 bytes to
anything that actually cares about MTU.


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

