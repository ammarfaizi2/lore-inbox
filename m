Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755689AbWK0BV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbWK0BV3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 20:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755691AbWK0BV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 20:21:29 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:58446 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1755681AbWK0BV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 20:21:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=wWLJXTO3cHv9PNYjixZkmGgcuddVPE0xdbYK7B+RW+0h0rC3nJPwdkrZNmYf0etH0UMlPUfzdkanL8pVg88w825yAI4ufXQdxZUMBnKgiUML1Kg21oUYDRQdMtf2Hf6TB4VhumdgpxUdaLjBqmFXfl+m4fT8vlHZssEhqUx39zo=  ;
X-YMail-OSG: Lvmwyp8VM1mzt7Gr0HJTzdkLuAhpvGUgmqm4snv_Fo0NTlMHHVXP7BoxlA3mbL.q5PZ.rG4yG44IoSIhArqn9pKKbjpcpbn__N1TFJAqyUlBug9jOo5H7g--
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [Bulk] Re: NTP time sync
Date: Sun, 26 Nov 2006 17:21:23 -0800
User-Agent: KMail/1.7.1
Cc: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>,
       "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>, akpm@osdl.org,
       linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       ralf@linux-mips.org, "'Andi Kleen'" <ak@muc.de>, paulus@samba.org,
       rmk@arm.linux.org.uk, davem@davemloft.net, kkojima@rr.iij4u.or.jp
References: <20061126202148.190d5b4b@inspiron> <00b301c711a3$07cf3530$020120ac@Jocke> <20061126235317.5d40d22c@inspiron>
In-Reply-To: <20061126235317.5d40d22c@inspiron>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611261721.25473.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 November 2006 2:53 pm, Alessandro Zummo wrote:
> On Sun, 26 Nov 2006 22:37:10 +0100
> "Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:
> 
> > >  the concept of static numbers is quite old...
> > 
> > Yes it is old, but is the old way unsupported now? I have an embedded target
> > which is using the old static /dev directory, do I need to make
> > it udev aware to use newer features like the rtc subsystem?
> 
>  That can be a good option. 

And it's simple enough.  You might not even need to run "udevd"
if you don't have hotpluggable devices ... just the startup stuff,
which you might not need after the first boot.  (Since the set of
devices will be stable, /dev/* won't change, and you can speed up
system boot by that small delta.)

I certainly run udev on some small systems, with /sbin/hotplug as
appended.  Getting udev set up, and handling coldplug, is left as
an exercise for the reader.  :)

- Dave

#!/bin/ash
#
# "hotplug" initializes devices ... hardware drivers get modprobed and
# create class devices.  then later udev handles /dev node creation and
# invokes programs that make userspace aware of the new device node.
#
# install as /sbin/hotplug

if [ ! -d /sys ]
then
	exit 1
fi
cd /sys

if [ "$ACTION" = "add" -a "$SUBSYSTEM" = "mmc" ]
then
	# MMC doesn't support modalias yet, but this is
	# the only choice until we have SDIO support.
	MODALIAS=mmc_block
fi

if [ "$ACTION" = "add" -a -n "$MODALIAS" -a ! -L $DEVPATH/driver ]
then
	# most important subsystems now have $MODALIAS support:
	modprobe -q $MODALIAS
fi

if [ -n "$DEVPATH" ]
then
	/sbin/udevsend $1
fi

