Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267286AbTAHNCJ>; Wed, 8 Jan 2003 08:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267393AbTAHNCJ>; Wed, 8 Jan 2003 08:02:09 -0500
Received: from home.wiggy.net ([213.84.101.140]:58592 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S267286AbTAHNCH>;
	Wed, 8 Jan 2003 08:02:07 -0500
Date: Wed, 8 Jan 2003 14:08:50 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: ipv6 stack seems to forget to send ACKs
Message-ID: <20030108130850.GQ22951@wiggy.net>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently a few friends setup an ipv6 icecast server to play with ipv6
and encourage people to use ipv6 more. When using linux this does
not work perfectly though: after a certain period (usually a bit
over 10 minutes) of listening to the stream traffic suddenly stops and
one has to reconnect. A tcpdump of the traffic seems to indicate that
the linux client suddenly stops sending ACKs and as a result the server
stops sending us data:

13:57:39.812123 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9352713 win 32616 <nop,nop,timestamp 846062 369670698>
13:57:39.823581 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9352713:9353921(1208) ack 1 win 5712 <nop,nop,timestamp 369670698 846028> [class 0x2]
13:57:39.823636 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9353921 win 32616 <nop,nop,timestamp 846063 369670698>
13:57:39.835144 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9353921:9355129(1208) ack 1 win 5712 <nop,nop,timestamp 369670698 846028> [class 0x2]
13:57:39.835197 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9355129 win 32616 <nop,nop,timestamp 846064 369670698>
13:57:39.844277 2001:968:1::2.8000 > tornado.wiggy.net.33035: P 9355129:9355601(472) ack 1 win 5712 <nop,nop,timestamp 369670701 846062> [class 0x2]
13:57:39.844326 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9355601 win 32616 <nop,nop,timestamp 846065 369670701>
13:57:40.221776 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9355601:9356809(1208) ack 1 win 5712 <nop,nop,timestamp 369670739 846065> [class 0x2]
13:57:40.221846 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9356809 win 32616 <nop,nop,timestamp 846103 369670739>
13:57:40.233558 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9356809:9358017(1208) ack 1 win 5712 <nop,nop,timestamp 369670739 846065> [class 0x2]
13:57:40.233613 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9358017 win 32616 <nop,nop,timestamp 846104 369670739>
13:57:40.245110 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9358017:9359225(1208) ack 1 win 5712 <nop,nop,timestamp 369670739 846065> [class 0x2]
13:57:40.245160 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9359225 win 32616 <nop,nop,timestamp 846105 369670739>
13:57:40.282351 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369670744 846103>
13:57:40.284307 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9360433:9360653(220) ack 1 win 5712 <nop,nop,timestamp 369670744 846103>
13:57:40.297307 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9360653:9361861(1208) ack 1 win 5712 <nop,nop,timestamp 369670745 846104>
13:57:40.297376 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9359225 win 32616 <nop,nop,timestamp 846111 369670744,nop,nop,sack sack 1 {9360653:9361861} >
13:57:40.308222 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9362081:9363289(1208) ack 1 win 5712 <nop,nop,timestamp 369670745 846104> [class 0x2]
13:57:40.308271 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9359225 win 32616 <nop,nop,timestamp 846112 369670744,nop,nop,sack sack 2 {9362081:9363289}{9360653:9361861} >
13:57:40.310424 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9361861:9362081(220) ack 1 win 5712 <nop,nop,timestamp 369670745 846105>
13:57:40.310471 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9359225 win 32616 <nop,nop,timestamp 846112 369670744,nop,nop,sack sack 1 {9360653:9363289} >
13:57:40.325396 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9363289:9363509(220) ack 1 win 5712 <nop,nop,timestamp 369670750 846111> [class 0x2]
13:57:40.325447 tornado.wiggy.net.33035 > 2001:968:1::2.8000: . ack 9359225 win 32616 <nop,nop,timestamp 846113 369670744,nop,nop,sack sack 1 {9360653:9363509} >
13:57:40.568652 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369670773 846113>
13:57:41.121608 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369670829 846113>
13:57:42.242095 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369670941 846113>
13:57:44.481379 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369671165 846113>
13:57:48.963035 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369671613 846113>
13:57:53.955118 fe80::250:4ff:fe0b:dd79 > tornado.wiggy.net: icmp6: neighbor sol: who has tornado.wiggy.net
13:57:53.955183 tornado.wiggy.net > fe80::250:4ff:fe0b:dd79: icmp6: neighbor adv: tgt is tornado.wiggy.net
13:57:57.921294 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369672509 846113>
13:58:15.841902 2001:968:1::2.8000 > tornado.wiggy.net.33035: . 9359225:9360433(1208) ack 1 win 5712 <nop,nop,timestamp 369674301 846113>
13:58:28.296672 tornado.wiggy.net.33035 > 2001:968:1::2.8000: F 1:1(0) ack 9359225 win 32616 <nop,nop,timestamp 850911 369670744,nop,nop,sack sack 1 {9360653:9363509} >
13:58:28.323604 2001:968:1::2.8000 > tornado.wiggy.net.33035: . ack 2 win 5712 <nop,nop,timestamp 369675550 850911>

tornado.wiggy.net is my client running Linux 2.4.19 (unpatched, UP machine),
and 2001:968:1::2 is the icecast server running Linux 2.4.20-rc2-ac3 (SMP).
If you want to test the stream yourself, please stream from
http://ipv6.lkml.org:8000/difm .

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
