Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUBPKpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 05:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUBPKpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 05:45:23 -0500
Received: from adsl60.dyn250.pacific.net.sg ([210.24.250.60]:10244 "EHLO
	firewall.villa-emerald-garden.com") by vger.kernel.org with ESMTP
	id S263609AbUBPKpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 05:45:11 -0500
Message-ID: <40309F2F.9020901@wanadoo.nl>
Date: Mon, 16 Feb 2004 18:45:03 +0800
From: Arnaud <arnaud.kleinveld@wanadoo.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, nl, nl-be
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: iptunnel: ioctl: Operation not supported
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

Short:
Trying to start a tunnel with iptunnel and module ipip I ran into the 
message "ioctl: Operation not supported"

Full description:
Every command on one of my hosts from iptunnel results in "Operation not 
supported". Command example: 'iptunnel show'
I built ipip.o for both systems on a development host:
AMD Athlon(TM) XP 2400+
RH 9, kernel 2.4.20-8, gcc 3.2.2

On the following system (A) I can set up the tunnel and a tcpdump on the 
second system (B) shows ecapsulated packages comming in:
Pentium MMX
RH 9, kernel 2.4.20-8, gcc 3.2.2

system B:
Cx486DX2
RH7.2, kernel 2.4.19, gcc 2.96

The PROBLEM is on system B. When I start the iptunnel command, no matter 
what function, I always get a message "ioctl: Operation not supported". 
So I entered some printk statements into ipip.c to see what command this 
module is receiving from iptunnel and to see if the module could 
register the device 'tunl0'. The registration goes well but the printk 
statement I entered into the case statement that handels the ioctl 
commands is never called! For me it looks like the ioctl is adressing 
the wrong net driver.
I also noticed a difference between the output of a 'strace iptunnel' on 
both systems:
system A (goes well):
<snip>
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
ioctl(4, 0x8927, 0xbfffe7e0) = 0
close(4) = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
ioctl(4, 0x89f0, 0xbfffe7e0)  = 0
close(4)  = 0
<snip>

system B (goes wrong):
<snip>
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
ioctl(4, 0x8927, 0xbffff790) = 0
close(4) = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
ioctl(4, 0x89f0, 0xbffff780)            = -1 EOPNOTSUPP (Operation not 
supported)
<snip>

I see that the command is a private ioctl '89f0' which is equal to 
'GETTUNNEL' and that's oke because I did a 'strace iptunnel show' to 
create this output. I also see a difference on the reference to the 
ifreq struct. On system A it stays the same for all commands done by 
iptunnel and on system B only the last command has a different 
reference. The struct is private by the routines so they are recreated 
every time, so I guess this difference could happen?
I checked the bugfixes between 2.4.19 and 2.4.20 but I didn't find 
anything about ioctl adressing wrong drivers.
I would like to debug this further more but I don't know where to go 
from this point. Any help is really appreciated. Maybe I am doing 
something wrong  by compiling on the other system?

Best Regards,
Arnaud

Some addional information on the two systems:
system A (goes well):

MODULES:
ipip
hostap_crypt_wep
hostap_pci
hostap
ppp_synctty
ppp_async
ppp_generic
slhc
8139too
mii
af_packet
ipt_LOG
ipt_state
ipt_MASQUERADE
iptable_nat
ip_conntrack
iptable_filter
ip_tables
ext3
jbd
usb-uhci
usbcore
rtc

system B (goes wrong):

MODULES:
ipip
ipt_state
8139too
mii
ppp_synctty
ppp_async
ppp_generic
slhc
ne2k-pci
8390
3c509
isa-pnp
af_packet
ipt_LOG
ipt_MASQUERADE
iptable_nat
ip_conntrack
iptable_filter
ip_tables
ext3
jbd
rtc


