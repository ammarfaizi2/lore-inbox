Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132015AbQLIA73>; Fri, 8 Dec 2000 19:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132832AbQLIA7U>; Fri, 8 Dec 2000 19:59:20 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:28635 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S132015AbQLIA7D>;
	Fri, 8 Dec 2000 19:59:03 -0500
Date: Fri, 8 Dec 2000 16:28:35 -0800
To: "lists@cyclades.com" <IvanPassos@bougret.hpl.hp.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: "romieu@cogenit.fr" <Francoisromieu@bougret.hpl.hp.com>,
        "cw@f00f.org" <ChrisWedgwood@bougret.hpl.hp.com>,
        "becker@scyld.com" <DonaldBecker@bougret.hpl.hp.com>
Subject: Re : Configuring synchronous interfaces in Linux
Message-ID: <20001208162835.E26305@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Passos wrote :
> For synchronous network interfaces, besides configuring network parameters 
> such as IP address, netmask, MTU, etc., the system should also configure 
> parameters specific to these sync i/f's, such as media (e.g V.35, X.21, 
> T1, E1), clock (internal or external, and value if int.), protocol (e.g 
> PPP, HDLC, Frame Relay), etc. 
> 
> What I noticed was that each synchronous board in Linux provides a 
> different way of doing this, and it would be good for users to have a 
> single, standard interface (such as ifconfig) to do this type of 
> configuration. Maybe even patch ifconfig itself, I don't know ... 

	Sorry to be late to the flame war, but I'll just add my 2 cents...

	In 96, I was exactly in the same situation, but with Wireless
LAN cards. I had 3 Wireless LAN cards, and each had a different
interface to configure various parameters and report statistics.
	I did solve that by creating the Wireless Extensions. It has
grown slowly over the years, but kept the original attributes. I'll
tell you what I've learned from this experience.

	The most problematic part of the whole exercise is
acceptance. Driver writers tend to overlook those details and do their
own stuff. This may be because they can't be bothered to learn it, or
because they beleive that they can do a better job, or they don't see
the value in standardising these stuff.
	The end result is that currently there is only half of the
Wireless LANs drivers supporting Wireless Extensions. Of this half,
half have *minimalistic* support for it (less than 10% of the
interface exposed). The other half are the driver that I've patched
myself ;-)
	In fact, as you as noticed, many people on the list have
commented that "we have this interface, XXX, but no driver use
it". That's exactly what I'm talking about...
	If you can manage to overcome this big hurdle, tell me how you
did it ;-)

	The second issue is to strike a balance on what to standardise
and how to evolve. Other type of configuration goes into a single
place (like the TCP/IP stack), so things are very easy to define and
evolve. On the other hand, most of this configuration is handled in
the device driver, and all those devices are different and present
unique configuration options.
	You can't offer everyting in your interface, but you must
offer enough to be able to configure it. The goal there is to find the
most usefull common subset. For additional parameters too specific,
let the driver use a private interface.
	Then, you also need flexibility, and you need to standardise
the representation of values. And you need to foresee what new devices
could need, to make sure that the API is stable enough... But don't
overengineer, because nobody likes complex APIs.
	In other words, don't rush, and learn about what all those
devices need.

	Then, the actual way of implementing it is only technical
issues. I can see the following options :
	o module parameters : the easiest, but not dynamic and write only
	o /proc interface : nice looking, but heavy on driver side
	o sysctl : quite simple, but tricky for multiple interfaces
	o ioctl : most standard, but require user tools
	Most drivers end up having a combination of module parameters
and /proc interface, the most important setting available through
both.

	If you want, you can check what I did for Wireless
Extensions. I did use ioctl because at that time sysctl didn't exist
and /proc was read only. Actually, ioctl *enforce* standardisation...
	Check :
		/usr/src/linux/include/wireless.h
		http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html

	You are welcome to reuse any of the stuff already defined, but
I will strongly resist any changes to Wireless Extensions unless it
fits neatly in it and don't disturb any driver.
	In particular, have a look at the 'iwpriv' stuff. This is
generic, and you could reuse it...

	Otherwise, have fun, be patient, and don't despair...

	Jean
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
