Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267968AbUGaQSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267968AbUGaQSv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 12:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUGaQSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 12:18:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53649 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266201AbUGaQSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 12:18:45 -0400
Message-ID: <410BC655.4040509@pobox.com>
Date: Sat, 31 Jul 2004 12:18:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: Willy Tarreau <willy@w.ods.org>, Herbert Xu <herbert@gondor.apana.org.au>,
       greearb@candelatech.com, akpm@osdl.org, alan@redhat.com,
       jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com> <20040731101152.GG1545@alpha.home.local> <20040731141222.GJ2429@mea-ext.zmailer.org>
In-Reply-To: <20040731141222.GJ2429@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> On Sat, Jul 31, 2004 at 12:11:52PM +0200, Willy Tarreau wrote:
>>Ok, sorry, I've just checked, they are 6. But I incidentely used the feature
>>on 2 of them (dl2k and starfire). But more drivers still have the
>>'static int mtu=1500' preceeded by a comment stating "allow the user to change
>>the mtu". Why is it not a #define then, if nobody can change it anymore ?
> 
> 
> In the older kernels that allowed for module parameter loading
> sufficiently, I recall.  Now couple additional macroes are needed
> to publish such parameters.  APIs do change in Linux kernel.
> 
> I have been pondering on the issue of usefullness of ->change_mtu
> for this use.   One of the bigger issues is, like Willy notes, that
> the MTU change information is given to the driver after it is already
> up and about, which requires then running setup magics which usually
> need running reset...

First, MTU change need not occur while the interface is up.

Second, modern hardware deals a lot better with MTU changes.  Some only 
need a write into a register.  Some need no reset at all, as long as you 
don't exceed the hardware limit.


> Also the Linux kernel isn't very well happy with multi-path stacking
> of layer-2 driver modules.  A side-effect from all of these things might

Elaboration?  The 2.6.x net drivers do proper refcounting, unlike a lot 
of other drivers.


> To prevent that from happening, it is sufficient in the eth driver to
> not to shrink its MTU except via card shutdown -- but then, IFCONFIG
> data for e.g. IP layer needs separation from the hardware driver layer.

In general ifconfig data should definitely -not- be separate from the 
driver.  In particular changing MTU definitely needs to be tightly 
integrated with the driver.


> For this IFCONFIG MTU issue, I would rather have the VLAN code to ask
> the underlaying driver of what MTU can be supported, than just blindly
> presume that 1500 will be functional for e.g. eth0.2  (like it does now)

The VLAN code could certainly be updated to poke at the lower level 
driver MTU.


>>>For VLAN support you definitely want to let the user increase the size 
>>>above 1500, and for that you need ->change_mtu
>>
>>I agree, but my point was that adding MODULE_PARM was only a one liner and
>>would have done the job too. But since everyone prefers a change_mtu(), I'll
>>do it.
>>
>>Jeff, do you know the absolute hardware limit on the tulip ? I've seen the
>>limitation to PKT_BUF_SZ (1536), but I don't know for example if the
>>hardware stores the FCS in the buffer or not, nor if the IP headers risk
>>being aligned or not (which would consume 2 more bytes).
>>Or does 1536 - 14 (ethernet) - 2 (iphdr alignment) - 4 (FCS) = 1516 seem a
>>reasonable conservative higher bound ?
> 
> 
> The Tulip (21143 at least) can do chained block receive; if first memory
> block is too short, it can continue to next one.  This way maximum frame

Yes, but receiving packets not wholly contained in a single frame is SO 
sub-optimal that it is to be avoided at all costs.

Maybe when receive scatter-gather is fully supported this can change, 
but for now the driver should not be returning multi-frag frames to the 
kernel.


> size is at least 2560 bytes.  For transmit the Jabber timer seems to
> trip at 2560, including preamples and crcs.  Also, there is a receive 
> watchdog, that is guaranteed to pass 2048 byte frames, and timeout at
> 2560 byte frames.  (When the watchdog is not disabled, that is.) See 
> CSR15<4>.  For transmit the Jabber-Clock bites at 2048-2560 bytes,
> OR at timer of 2.6-3.3 ms (of 100 Mbps) which means at least 32 000 bytes.
> ( CSR15<2> )
> 
> In the receive descriptors there might appear a TL bit (Frame Too Long),
> which is just telling that frame size exceeds 1518 bytes.
> If RW (Receive Watchdog; RDES0<4>) has tripped, then there is at least
> 2048 bytes long frame, most likely longer than 2560 bytes.
> 
> Based on my reading of  ds21143hrm.pdf  (copy of which I have), I do
> think it is safe to just receive larger frames with Tulip, and IGNORE
> the "TL" bit.

That covers one of seven or eight tulip chips driven by the driver.

Once you exceed the ethernet norm there are tons of chip-specific quirks 
and details to deal with.  In addition to the details you mention, the 
on-chip FIFO sizes and behaviors become important.  As does the 
multi-fragment frame issue.  Some chips with checksumming features only 
work when the MTU is less than an unknown magic number (less than you 
would think, but higher than 1500).

All these reasons are why I want to dive into the 3c59x documentation, 
and also do some testing on older models, before we merge Alan's patch 
from $subject.

	Jeff


