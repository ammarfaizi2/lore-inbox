Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVAOMWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVAOMWg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 07:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVAOMWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 07:22:35 -0500
Received: from main2.datacore.ch ([80.238.134.35]:34323 "EHLO mail.datacore.ch")
	by vger.kernel.org with ESMTP id S262266AbVAOMWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 07:22:08 -0500
Message-ID: <41E909E0.7000902@datacore.ch>
Date: Sat, 15 Jan 2005 13:17:36 +0100
From: Amir Guindehi <amir@datacore.ch>
Organization: DataCore GmbH
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jakma <paul@clubi.ie>
CC: =?ISO-8859-1?Q?J=FCri_P=F5ldre?= <jyri.poldre@artecdesign.ee>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ethernet driver link state propagation to ip stack
References: <JJEGJLLALGANNBPNAIMMOEGLDGAA.jyri.poldre@artecdesign.ee> <Pine.LNX.4.61.0501150507000.15839@sheen.jakma.org>
In-Reply-To: <Pine.LNX.4.61.0501150507000.15839@sheen.jakma.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> My question is:  Does the kernel handle the interface state/routing 
>> tables modifications due to link changing automatically
> 
> Not completely.
> 
> The biggest problem is that kernel does not remove its "connected" or 
> "subnet" route while link is down. This means that even though kernel 
> knows link is down, it will still try route packets out that interface.

I can confirm this.

>> or is there some external daemon required to do that. Any links are 
>> greatly appreciated.

Try the shell script below. It works for me (tm).

> There is "Netplug" - part of the net-tools package (On fedora core 3 at 
> least). You can use it to 'ip link set dev .... down' when carrier is 
> removed. However, you wont get notified of carrier being inserted back - 
> I dont know whether that holds true generally, or whether its an e1000 
> bug. So it's one-shot.
> 
> We're looking at adding support to the 'zebra' daemon in Quagga to 
> remove connected routes while link is down and add them back when 
> link-up again, and hence deal with this properly. Amir is very 
> interested in this..

Yes, I am. And I found out the following. If I add the following 
one-liner shell script daemon, I get it all working:

while /bin/true; do echo "Check of eth5 ..."; A=`ethtool eth5 | grep 
'Link detected'`; if [ "$A" != "$O" ] ; then C=`echo "$A" | grep 'yes'`; 
if [ -n "$C" ] ; then echo "Adding route";  route add -net 5.5.7.0 
netmask 255.255.255.0 dev eth5; else echo "Removing route"; route del 
-net 5.5.7.0 netmask 255.255.255.0 dev eth5; fi; O="$A"; fi; sleep 1; done

[I have to mention that eth5 is the interface where I pull and reinsert 
the cable]

As you can see I simply try to remove and re-add the connected route 
from user space. The above shell script works for me, and i can pull and 
re-insert my network cable as often as I want while still being able to 
reach the network on eth5 over different routes (received via ospf, I 
run Quagga) while the cable is pulled out and over the local interface 
while the cable is back in.

> /me grumbles about why oh why the "make kernel add connected routes"
>   feature was *ever* added in 2.3 in the first place (cause now
>   userspace has "forgotten" how to manage them, so we cant simply undo
>   this brain-damage[1] without breaking networking for everyone, sigh)

True.

I'm /not/ able to recreate the route as it was before my 'route del' the 
recreated route looks different from the route I remove at first (the 
connected one). I'm nor able to recreate the 'src xxx' flags and 
neighter is it a 'proto kernel' route ;)

So, in my eyes we need:
- A way to create connected routes from user space
or
- A kernel which removes the connected route on link loss and recreates 
it later when the link gets connected again.

Regards
- Amir
-- 
Amir Guindehi, nospam.amir@datacore.ch
DataCore GmbH, Witikonerstrasse 289, 8053 Zurich, Switzerland

