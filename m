Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSIEQTr>; Thu, 5 Sep 2002 12:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317799AbSIEQTr>; Thu, 5 Sep 2002 12:19:47 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:39328 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S317755AbSIEQTq>; Thu, 5 Sep 2002 12:19:46 -0400
Message-ID: <3D778527.86F10C10@nortelnetworks.com>
Date: Thu, 05 Sep 2002 12:24:07 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-6mdkenterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Ryan <genanr@emsphone.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ARP and alias IPs
References: <20020905150949.GA8112@thumper2.emsphone.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Ryan wrote:
> 
> The linux implementation of ARP is causing me problems.  Linux sends out an
> ARP request with the default interface as the sender address, rather than then
> interface the request came on.
> 
> For example
> 
> eth0   10.1.1.100
> eth0:1 192.16.1.101
> 
> and an ARP is received on 192.16.1.101, linux responds with
> 10.1.1.100 as the source address in the ARP request, rather than 192.16.1.101
> (which FreeBSD, Solaris, and tru64 do).  To me, this is just plain wrong.
> The sender address should be an address on the subnet that the request came
> from, not a different one.  Is there any way to fix this?


I'm not sure how you're managing to get that behaviour.  I just reproduced the scenario on a 2.2.17
kernel and logged the output. 47.129.82.232 is configured as eth0:0, with 47.129.82.53 being eth0,
and pcary1ja maps to 47.129.82.54.


08:04:59.650707 eth0 > 0:0:0:0:0:0 0:30:65:a0:ff:c6 arp 42: arp who-has 47.129.82.232 tell pcary1ja
(0:30:65:a0:ff:c6)
                         0001 0800 0604 0001 0030 65a0 ffc6 2f81
                         5236 0000 0000 0000 2f81 52e8
08:04:59.650707 eth0 < 0:30:65:c0:23:c4 0:0:0:0:0:1 arp 64: arp reply 47.129.82.232 is-at
0:30:65:c0:23:c4 (0:30:65:a0:ff:c6)
                         0001 0800 0604 0002 0030 65c0 23c4 2f81
                         52e8 0030 65a0 ffc6 2f81 5236 5555 5555
                         5555 5555 5555 5555 5555 5555 5555 e796
                         9051

As you can see, the reply is properly sent out with the source IP address of 47.129.82.232.

Are you sure you aren't misreading something?  If you change the source IP address then the arp
reply is totally useless as it is a reply to another request entirely.

Chris
