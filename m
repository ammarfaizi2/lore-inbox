Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264778AbTIDHpA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264832AbTIDHnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:43:04 -0400
Received: from ihemail1.lucent.com ([192.11.222.161]:27617 "EHLO
	ihemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S264778AbTIDHmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:42:14 -0400
Message-ID: <007001c372b8$131a8580$8112fc87@ZHANGHAOFENG>
From: "Zhang haofeng" <zhanghf@blrcsv.china.bell-labs.com>
To: <linux-kernel@vger.kernel.org>
Subject: sk_buff problem
Date: Thu, 4 Sep 2003 15:42:21 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4927.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,
    Does somebody have some knowledge about /net/ipv6/sit.c?
    I try to modify sit.c to cater for my requirements: I want to use
IPv4+UDP+IPv6+IPv6 Data to encapsulate IPv6 packets, thus every IPv6 packet
will be able to pass through some IPv4 NATs. As you know, sit.c is to
encapsulate IPv6 packets in IPv4 payload, so it seems that I only need to
add UDP layer between IPv4 header and IPv6 header in the encapsulated
packet.
    But I got problem when I receive an IPv4 UDP packet. I wanna
de-encapsulate the packet and send UDP data (which is an IPv6 packet) to
IPv6 upper layer protocol use netif_rx( ).  But it seems that I can not set
the correspondent field in sk_buff struct correctly.
    In sit.c, line 396, when 6to4 interface receive a IPv4 packet:
*****************
    if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
        goto out;
...
    skb->mac.raw= skb->nh.raw;
    skb->nh.raw= skb-> data;
...
    netif_rx(skb);

    So in my modified sit.c, I modify the source code to :
*****************
    if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
        goto out;
...
    skb->mac.ethernet->h_proto= __constant_htons(0x86DD);
    skb->nh.raw= skb->data+sizeof(struct udphdr);
    skb->protocol = __constant_htons(0x86DD);
...
    netif_rx(skb);
...

    The result is, from the debug information, I can see the IPv6 header,
the IPv6 data is put in sk_buff structure correctly. But
after I cannot use netif_rx() to send this de-encapsulated packet to IPv6
core protocol stack correctly, while the ICMPv4 UDP port unreachable message
is sent to the sender. I am confused :(
    I really appreciate your any kind of help, thanks in advance.....

Zhanghaofeng
Sep 3rd, 2003



