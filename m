Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282234AbRKWTof>; Fri, 23 Nov 2001 14:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282217AbRKWTo1>; Fri, 23 Nov 2001 14:44:27 -0500
Received: from ns.xdr.com ([209.48.37.1]:13463 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id <S282215AbRKWToH>;
	Fri, 23 Nov 2001 14:44:07 -0500
Date: Fri, 23 Nov 2001 11:44:11 -0800
From: Dave Ashley (linux mailing list) <linux@xdr.com>
Message-Id: <200111231944.fANJiBX30625@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: bd_t structure + net configuration
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on bringing up linux in an embedded environment, and the box
is diskless and uses bootp to get its kernel + ramdisk. It uses ppcboot
to get that information. We've modified ppcboot to pass more information
to linux in the bd_t (board info) structure, specifically
ip address
netmask
default gateway
dns server
hostname

The question is how to get linux to use this information? I couldn't find
anything in the kernel source to do that. I had a temporary solution where
linux invokes dhcpcd to get the information again, but the problem there is
there are 2 dhcp servers on our network and the ip addresses assigned didn't
match between the bootp stage and the dhcp stage later. And there is an
efficiency problem--since the information is already in the box at the bootp
time, why bother with dhcp later?

I was surprised to find no built in mechanism to configure networking from
the boardinfo information.

Anyway what I ended up doing was modifying fs/proc/proc_misc.c to add a
file /proc/boardinfo, which has the information visible. Then during booting,
when networking would be initialized, I examine that file to know how to
set everything up.

What I did was have the /proc/boardinfo file appear like an sh script, so
when cat'd it looks like this:
ifconfig eth0 192.168.0.20 netmask 255.255.255.0
route add default gw 192.168.0.75
echo nameserver 192.168.0.76 > /etc/resolv.conf
hostname box1102

(The numbers here are just examples, they change depending on the bootp
information).

I modified one of the startup scripts to configure networking:
cat /proc/boardinfo > /tmp/bi
sh /tmp/bi
rm /tmp/bi

The only information used from the bd_t structure was the mac address of
the ethernet card, originally. The bd_t structure appears as the global
__res pointer.

I'm wondering if there is a prefered way of doing this? Also why does it
seem like setting up networking from the bd_t structure hasn't been done
before?

Thoughts? Comments? Anything welcome.

-Dave
