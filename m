Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268081AbUHZKus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268081AbUHZKus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267859AbUHZKus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:50:48 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:60605 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S268420AbUHZKuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 06:50:01 -0400
Message-ID: <412DC055.4070401@sun.com>
Date: Thu, 26 Aug 2004 11:49:57 +0100
From: Brian Somers <brian.somers@sun.com>
Organization: Sun Microsystems
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.4) Gecko/20040414
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Mike Waychison <Michael.Waychison@sun.com>, linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>	<200408162049.FFF09413.8592816B@anet.ne.jp>	<20040816143824.15238e42.davem@redhat.com>	<412CD101.4050406@sun.com>	<20040825120831.55a20c57.davem@redhat.com>	<412CF0E9.2010903@sun.com> <20040825175805.6807014c.davem@redhat.com>
In-Reply-To: <20040825175805.6807014c.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

David S. Miller wrote:
> On Wed, 25 Aug 2004 16:04:57 -0400
> Mike Waychison <Michael.Waychison@Sun.COM> wrote:
> 
> 
>>If I understand it correctly, the problem we were seeing is that the
>>chip was getting framing errors in high-traffic scenarios.  Setting it
>>to use hardware autoneg made these errors disappear.  It's possible we
>>need some other work-around.. :\
> 
> 
> So what rev 5704 chips were in Sun's Opteron boxes where you
> saw the problem?  A0/A1 chips?

First, forgive the lack of specifics here, I haven't got access to any
of the hardware in question right now...

The issue was actually seen in Sun's x86 blades - the B200x boxes.  They
were using A3 parts (2 of them per box == 4 interfaces), although a
comment was added with one of the last modifications (unrelated to the
autoneg stuff) that said it was tested on an A2 part, so I guess there
were a number of them about too.  The machine had a PCI-X bus running at
64bits and either 66 or 133MHz (I think it was 133MHz, but I may be
wrong!).

The issue was that the frame error count was being bumped and we were
losing traffic under load.  From what I can remember it averaged
something like one in 30000 packets being dropped, but it may have
been slighly less frequent than that.

After the hardware guys here had ruled out any cross-talk possibilities,
I talked to Broadcom about it and they suggested that we enable
hardware autoneg.  The reasoning was that when hw autoneg is enabled,
the chip has a completely different code path for incoming traffic
where it doesn't have to look inside every packet to see if it's a
negotiation frame.  This increased throughput enough to defeat the
framing errors we were seeing.

The changes I made were reviewed by Broadcom and they seemed happy
that hw autoneg was enabled for all 5704 silicon revisions...


It's a bit strange that it stopped working only with the latest 2.4
version of tg3 - I wonder if the driver's actually coming back with
``HW autoneg failed'' in this scenario?  Perhaps there's a compat
issue between the switch and the Broadcom hw autoneg engine?

Can we get this guy to try running an older version of tg3 to see
what change introduce the issue?

Another interesting point was that the guy who wrote the bcm driver
for Solaris had problems enabling hw autoneg.  AFAIR he said that
when he enabled it, MAC_STATUS_PCS_SYNCED never turned up again.  I
don't know if this issue was ever resolved, and he no longer works
for Sun.  I never saw this issue under Linux.

-- 
Brian Somers                                            Sun Microsystems
                                             Sparc House, Guillemont Park
Software Engineer - LSE                          Minley Road, Blackwater
Tel: +44 1252 421 263   Ext: 21263                    Camberley GU17 9QG

