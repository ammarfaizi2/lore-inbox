Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289941AbSAWSDa>; Wed, 23 Jan 2002 13:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289950AbSAWSDV>; Wed, 23 Jan 2002 13:03:21 -0500
Received: from hermes.cicese.mx ([158.97.1.34]:32196 "EHLO hermes.cicese.mx")
	by vger.kernel.org with ESMTP id <S289941AbSAWSDI>;
	Wed, 23 Jan 2002 13:03:08 -0500
Message-ID: <3C4EFACB.EE1FEB91@cicese.mx>
Date: Wed, 23 Jan 2002 10:02:51 -0800
From: Serguei Miridonov <mirsev@cicese.mx>
Organization: CICESE Research Center, Ensenada, B.C., Mexico
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Console output for debugging
In-Reply-To: <3C4DF2AD.66BC3F6C@cicese.mx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, thanks to everybody who replied to my post.

Now I would like to clarify why I don't want to use printk...

1. This output is not intended to be logged at all. I just want to catch the
event which locks the system.

2. This console print must be very fast and atomic, so I will be sure that
some particular checkpoint in the driver passed.

3. This is not intended to be in production code, so I think that it is OK
even if it is very i386 specific.

4. I don't want to spend much time in printk, I prefer to have something like
direct VGA display memory writing. I know it can be done with something like
a solution proposed by Keith Owens
(http://www.kernelnewbies.org/documents/videochar.txt) but with additional
phys_to_virt macro. The only problem is that I need to find a way to switch
console VGA to a mode compatible with this.

Why do I need this? Well, I'm one of maintainers of driver for Zoran MJPEG
chipset based video capture cards
(http://www.cicese.mx/~mirsev/Linux/DC10plus/). The driver seems to work with
almost any platform but has a lot of problems with my new Soyo Dragon Plus
motherboard (KT266A chipset). At the beginning I had everything like
filesystem corruptions, lockups, etc. Many problems were solved by so called
PCI latency patch
http://www.cicese.mx/~mirsev/Linux/VIA/VIA-latency-linux.html and now the
system is very stable unless I run a program which uses MJPEG hardware codec
of DC10plus card (Zoran 36067/36060 chipset). After a few seconds (sometimes
immediately) the system locks up completely. Other user who has similar
hardware also has this problem.

I wrote to VIA support, to Pinnacle Systems (DC10plus card maker) but they
remain silent. I was asking people who run these cards successfully on
systems based on KT266A chipset to send their lspci outputs to try the same
registers settings myself. However I have received only one from someone who
indeed successfully runs Iomega Buz on this VIA chipset. But the Iomega Buz
card is a little bit different, it has its own PCI bridge which controls
motherboard PCI bus, not like in DC10plus where PCI bus is controlled by
ZR36067 chip.

So, what I intend to do is to add these checkpoints in the driver to see some
data supplied to the card (fragmentation table, MJPEG buffer addresses, size,
etc.) and return back to look for any clue which leads to the system failure.
May be there is some boundary crossing in PCI bus master mode which
VIA chipset may not like or anything else...

This debug output must be very fast. It would be nice if I can catch starting
PCI master transaction which locks the system...

So, that's the story...

--
Serguei Miridonov                CICESE, Research Center,
CICESE, Optics Dept.             Ensenada B.C., Mexico
PO Box 434944                    E-mail: mirsev@cicese.mx
San Diego, CA 92143-4944         FAX: +52 (646) 1750553
U.S.A.



