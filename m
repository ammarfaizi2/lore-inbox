Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbSL3IrQ>; Mon, 30 Dec 2002 03:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbSL3IrP>; Mon, 30 Dec 2002 03:47:15 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:8423
	"EHLO localhost") by vger.kernel.org with ESMTP id <S264657AbSL3IrN>;
	Mon, 30 Dec 2002 03:47:13 -0500
Date: Mon, 30 Dec 2002 00:55:29 -0800
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA and hermer/orinoco_cs drivers b0rken?
Message-ID: <20021230085529.GA12575@localhost>
References: <87u1h3fim2.fsf@lapper.ihatent.com> <20021226003405.014f0638.joshk@mspencer.net> <87u1gwuomh.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u1gwuomh.fsf@lapper.ihatent.com>
User-Agent: Mutt/1.4i
From: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Warning: Driver for device eth1 has been compiled with version 14
> of Wireless Extension, while this program is using version 13.
> Some things may be broken...

First of all, what kernel are you using? That's an ancient version of 
the WE. If this is 2.4.2[01], download the following diffs from Jean's 
fine site:

* http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/iw240_we15-6.diff
* http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/iw241_we16-3.diff

Patch these against the top of your source tree with -p1. This might fix 
your problem, otherwise it's just eliminating one potential cause of the 
problem. Then copy include/linux/wireless.h to 
/usr/include/linux/wireless.h, so that things that require WE to compile 
(notably pcmcia-cs' wireless modules) will be using the right version.

Next of all, try upgrading the firmware on your card.

The error writing packet to BAP error always seemed just like a small 
nuisance to me during large file transfers. It did not correlate with 
any connectivity problems, so I just commented it out in the 
orinoco/hermes/orinoco_cs source (it's in one of those files.)

Yes, rebuild wireless-tools once you have patched to WE16 and copied it 
to /usr/include. If you use debian, the easiest way is to apt-get source 
wireless-tools and just tweak it to look at wireless.h v16, then 
fakeroot debian/rules binary and replace your package with that. This is 
probably feasible with SRPMs too, but I don't know how.

Hope your wireless endeavors succeed - I just spent all week getting 
hostap_plx to work (and I'm now reaping the benefits because I now have 
wifi access all over my house) :)

Regards
-Josh

On Mon, Dec 30, 2002 at 05:17:26AM +0100, Alexander Hoogerhuis wrote:
> Joshua Kwan <joshk@mspencer.net> writes:
> 
> > Hi,
> > 
> > Are you using the modules from the kernel source or from pcmcia-cs? Are
> > you using yenta_socket or pcmcia-cs? pcmcia-cs has given me a lot more
> > positive results than trying to use yenta_socket and the built in kernel
> > modules. Also, try binding your card IDs to use wavelan_cs instead and
> > see if it works (maybe those cards are a bit older and as such need
> > older drivers.)
> > 
> 
> Avoiding the kernel-side PCMCIA-stuff and using the standalone package
> got me a lot further. After a few tweaks int he config files I get the
> interface up and things startes to happen:
> 
> lapper root # ifconfig eth1
> eth1      Link encap:Ethernet  HWaddr 00:09:5B:27:DC:F9  
>           inet addr:172.31.255.242  Bcast:172.31.255.247  Mask:255.255.255.248
>           inet6 addr: fe80::209:5bff:fe27:dcf9/10 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:3 errors:8 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100 
>           RX bytes:0 (0.0 b)  TX bytes:516 (516.0 b)
>           Interrupt:11 Base address:0x100 
> 
> lapper root # iwconfig eth1
> Warning: Driver for device eth1 has been compiled with version 14
> of Wireless Extension, while this program is using version 13.
> Some things may be broken...
> 
> eth1      IEEE 802.11-DS  ESSID:"humbug"  Nickname:"lapper.ihatent.com"
>           Mode:Ad-Hoc  Frequency:2.417GHz  Cell: 02:09:A7:FB:DC:F9  
>           Bit Rate:11Mb/s   Tx-Power=15 dBm   Sensitivity:1/3  
>           Retry min limit:8   RTS thr:off   Fragment thr:off
>           Encryption key:6875-6262-61   Encryption mode:open
>           Power Management:off
>           Link Quality:0  Signal level:0  Noise level:0
>           Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
>           Tx excessive retries:0  Invalid misc:0   Missed beacon:0
> 
> Seems I need to get the wireless tools rebuilt and I'll be in touch
> with a WLAN in a few hours, but this all seems swell now.
> 
> After inserting the card (NetGear MA401) I get this in my log tho:
> 
> eth1: Station identity 001f:0006:0001:0003
> eth1: Looks like an Intersil firmware version 1.03
> eth1: Ad-hoc demo mode supported
> eth1: IEEE standard IBSS ad-hoc mode supported
> eth1: WEP supported, 104-bit key
> eth1: MAC address 00:09:5B:27:DC:F9
> eth1: Station name "Prism  I"
> eth1: ready
> eth1: index 0x01: Vcc 5.0, irq 11, io 0x0100-0x013f
> eth1: Error -110 setting multicast list.
> eth1: Error -110 setting multicast list.
> eth1: Error -110 setting multicast list.
> eth1: Error -110 setting multicast list.
> eth1: Error -110 setting multicast list.
> eth1: This firmware requires an ESSID in IBSS-Ad-Hoc mode.
> eth1: This firmware requires an ESSID in IBSS-Ad-Hoc mode.
> eth1: This firmware requires an ESSID in IBSS-Ad-Hoc mode.
> eth1: Error -110 writing packet to BAP
> eth1: Error -110 writing Tx descriptor to BAP
> eth1: Error -110 writing Tx descriptor to BAP
> eth1: Error -110 writing Tx descriptor to BAP
> eth1: Error -110 writing Tx descriptor to BAP
> eth1: Error -110 writing Tx descriptor to BAP
> eth1: Error -110 writing Tx descriptor to BAP
> eth1: This firmware requires an ESSID in IBSS-Ad-Hoc mode.
> 
> If you have an idea about the errors, drop me a line, and if not I'll
> dig into it :)
> 
> mvh,
> A
> 
> > Hope this helps you.
> > Regards
> > 
> > -Josh
> > 
> 
> Sure did :)
> 
> -A
> 
> -- 
> Alexander Hoogerhuis                               | alexh@ihatent.com
> CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
> "You have zero privacy anyway. Get over it."  --Scott McNealy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
