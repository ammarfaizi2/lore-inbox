Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbWJXUxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbWJXUxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 16:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbWJXUxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 16:53:12 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:48901 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965191AbWJXUxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 16:53:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jikbz3wu6ApgH2jPFOf8+wznb40KTYt8ivg3NKOVAtAOH7BDvZrQVY1CFf7cc/+9r/Z8GVvRlYEcHswa+eMS+n23Hv46t8ttMRjDxcG813/m/eE5GC9rxcTx5gRj8X4m4A8JNr2VrHB0CVZXUORcdbbxpgiOOFBQ2MyotxP4GsE=
Message-ID: <aa4884ff0610241353m4bc1ebebh92191fbf8aef9178@mail.gmail.com>
Date: Tue, 24 Oct 2006 22:53:10 +0200
From: "Lehner franz" <hamtitampti@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: BUG: Network: Duplicate MAC adress response in multihomed system : All Kernels
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe it is a setting, i have searched everywhere, but this is really mysterious

take a linux, configure this kind

eth0: 192.168.10.200 / 255.255.255.0
eth1: 192.168.10.201 / 255.255.255.0

Both Interfaces are "real ethernet cards" and are connected to same switch

if you take now a 3'rd machine, and do a

arping  -c 1 192.168.10.200
>60 bytes from 00:0c:29:bc:96:fe ( 192.168.10.200): index=0 time=645.876 usec
>60 bytes from 00:0c:29:bc:96:f4 ( 192.168.10.200): index=1 time=1.472 msec

arping  -c 1 192.168.10.201
>60 bytes from 00:0c:29:bc:96:fe (192.168.10.201 ): index=0 time=833.988 usec
>60 bytes from 00:0c:29:bc:96:f4 (192.168.10.201): index=1 time=1.211 msec

in fact, this is "fuck" as arp table of switches and other machines
are not knowing what to do

compared to Windows2000, Windows just gives you "one" entry back, (and
YES: the real too...)

This "bug" is in 2.4.x ( i tested may of them) and 2.6.x (not tested
all, but it is exisintg in ubuntu with 2.6.15) ,  not sure about 2.x

from my reading of RFC, this is "not legal" and even made it possible,
that my switch killed the server, because as he thought, i am spoofing
him.

It gets much more funny, when you have 3 network cards running :-)
then you get 3 replys :-)

# arping  -c 1 192.168.10.200
ARPING 192.168.10.200
60 bytes from 00:0c:29:bc:96:08 (192.168.10.200 ): index=0 time=499.010 usec
60 bytes from 00:0c:29:bc:96:fe (192.168.10.200): index=1 time=878.096 usec
60 bytes from 00:0c:29:bc:96:f4 ( 192.168.10.200 ): index=2 time=1.163 msec

--- 192.168.10.200 statistics ---
1 packets transmitted, 3 packets received, -200% unanswered

.....

btw:
control, if you have spoofing filter active
if you have a spoofing filter active, like in debian, kill ist
echo 0 > /proc/sys/net/ipv4/conf/all/rp_filter

the system answers on both IP (or 3 ipadresse) always with the same mac address
with filter disabled, the above phaenomn will come again.

Yes, i think this is a bug.

Personally, i think, it is a bug in the IP stack, as "all interfaces"
receive the Broadcast, and then,
arp_send(ARPOP_REPLY,ETH_P_ARP,sip,dev,tip,sha,dev->dev_addr,sha);
answers
but it answers the request on all interfaces, with the "MAC" of the
interface, which comes from dev->dev_addr


regards
Lehner Franz
