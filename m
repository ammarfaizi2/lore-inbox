Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267951AbUGaOMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267951AbUGaOMb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 10:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267956AbUGaOMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 10:12:31 -0400
Received: from mail.zmailer.org ([62.78.96.67]:50123 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S267951AbUGaOM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 10:12:27 -0400
Date: Sat, 31 Jul 2004 17:12:22 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Herbert Xu <herbert@gondor.apana.org.au>,
       greearb@candelatech.com, akpm@osdl.org, alan@redhat.com,
       jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040731141222.GJ2429@mea-ext.zmailer.org>
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com> <20040731101152.GG1545@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731101152.GG1545@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 12:11:52PM +0200, Willy Tarreau wrote:
> Hi Jeff,
> 
> On Sat, Jul 31, 2004 at 05:34:41AM -0400, Jeff Garzik wrote:
> > Willy Tarreau wrote:
> > >  - many (all ?) other drivers already have an MTU parameter, and many
> > 
> > s/many/almost none/
> 
> Ok, sorry, I've just checked, they are 6. But I incidentely used the feature
> on 2 of them (dl2k and starfire). But more drivers still have the
> 'static int mtu=1500' preceeded by a comment stating "allow the user to change
> the mtu". Why is it not a #define then, if nobody can change it anymore ?

In the older kernels that allowed for module parameter loading
sufficiently, I recall.  Now couple additional macroes are needed
to publish such parameters.  APIs do change in Linux kernel.

I have been pondering on the issue of usefullness of ->change_mtu
for this use.   One of the bigger issues is, like Willy notes, that
the MTU change information is given to the driver after it is already
up and about, which requires then running setup magics which usually
need running reset...

I do myself prefer MODULE_PARAM.

Also the Linux kernel isn't very well happy with multi-path stacking
of layer-2 driver modules.  A side-effect from all of these things might
be, that setting up some dozen VLANs to an ethernet with result in
two, or in worst case, a dozen+1 setup runs.  And if last VLAN setup
is (for any reason) smaller MTU value than 1500, it might even result
in entire driver to be configured for e.g. 1280+4 byte MTU..

To prevent that from happening, it is sufficient in the eth driver to
not to shrink its MTU except via card shutdown -- but then, IFCONFIG
data for e.g. IP layer needs separation from the hardware driver layer.

The way that VLAN (the 8021q module) is implemented in Linux does allow
the primary card to be downed (stopped), but not unloaded without downing
all vlans attached on it (and this preventing pointers to point into 
junk.. preventing chaos, madness and PANIC from such..)


For this IFCONFIG MTU issue, I would rather have the VLAN code to ask
the underlaying driver of what MTU can be supported, than just blindly
presume that 1500 will be functional for e.g. eth0.2  (like it does now)

Things would just magically work, if the uping of  eth0.2  would setup
itself to MTU 1496, unless the underlaying eth0 can handle real 1504 byte
802.1q frames.

> > For VLAN support you definitely want to let the user increase the size 
> > above 1500, and for that you need ->change_mtu
> 
> I agree, but my point was that adding MODULE_PARM was only a one liner and
> would have done the job too. But since everyone prefers a change_mtu(), I'll
> do it.
> 
> Jeff, do you know the absolute hardware limit on the tulip ? I've seen the
> limitation to PKT_BUF_SZ (1536), but I don't know for example if the
> hardware stores the FCS in the buffer or not, nor if the IP headers risk
> being aligned or not (which would consume 2 more bytes).
> Or does 1536 - 14 (ethernet) - 2 (iphdr alignment) - 4 (FCS) = 1516 seem a
> reasonable conservative higher bound ?

The Tulip (21143 at least) can do chained block receive; if first memory
block is too short, it can continue to next one.  This way maximum frame
size is at least 2560 bytes.  For transmit the Jabber timer seems to
trip at 2560, including preamples and crcs.  Also, there is a receive 
watchdog, that is guaranteed to pass 2048 byte frames, and timeout at
2560 byte frames.  (When the watchdog is not disabled, that is.) See 
CSR15<4>.  For transmit the Jabber-Clock bites at 2048-2560 bytes,
OR at timer of 2.6-3.3 ms (of 100 Mbps) which means at least 32 000 bytes.
( CSR15<2> )

In the receive descriptors there might appear a TL bit (Frame Too Long),
which is just telling that frame size exceeds 1518 bytes.
If RW (Receive Watchdog; RDES0<4>) has tripped, then there is at least
2048 bytes long frame, most likely longer than 2560 bytes.

Based on my reading of  ds21143hrm.pdf  (copy of which I have), I do
think it is safe to just receive larger frames with Tulip, and IGNORE
the "TL" bit.

Receiving 1522 byte frames from ethernet with Tulip should be trivial.
Will that be true with 21140 -- oddly I don't have a copy of 21140 HRM
in PDF form...  Possibly I got it in paper long ago.

> Cheers,
> Willy

/Matti Aarnio
