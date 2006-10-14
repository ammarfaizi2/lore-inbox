Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422864AbWJNVna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422864AbWJNVna (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 17:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422863AbWJNVna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 17:43:30 -0400
Received: from web50614.mail.yahoo.com ([206.190.39.114]:15717 "HELO
	web50614.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964796AbWJNVn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 17:43:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=JTVnLHAOeYvhAH44/ugu+uwDMgxpwLVB/8gjNQaH0h598mlOtbQxmsfZd0phTGb1pwJY27h95pO4otj9litC4UolUD2lJrI6SBsgJOJAnryVnRG12ho4v1yV1jmCZjyT22dg3AldDrxdsE7UNNtMVOABGisN6Zj2ooaZbv88tNo=  ;
Message-ID: <20061014214328.25873.qmail@web50614.mail.yahoo.com>
Date: Sat, 14 Oct 2006 14:43:28 -0700 (PDT)
From: Joan Raventos <jraventos@yahoo.com>
Subject: poll problem with PF_PACKET when using PACKET_RX_RING
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In order to use PF_PACKET/SOCK_RAW with PACKET_RX_RING
one would possibly do (as described in
Documentation/networking/packet_mmap.txt):
1. setup PF_PACKET socket via socket call.
2. use setsockopt to change the PF_PACKET socket into
PACKET_RX_RING mode and alloc the ring.
3. mmap the ring.
4. use poll with the socket descriptor and then
directly access the pkts from the mmaped ring.

However I've observed that if the socket is opened on
a link with substantial traffic, chances are that some
pkts might hit the socket between (1) and (2). At that
point those pkts will make the socket descriptor be
active (packet_poll is built as an OR from
datagram_poll -essentially whether sk_receive_queue is
empty- and the ring status). However after (2) pkts
are no longer processed by packet_rcv but via
tpacket_rcv, and thus no longer queued in the
sk_receive_queue but into the ring. Moreover since the
user-space app is likely to access them directly (4),
no one is going to empty the socket queue and the
descriptor will remain always active, converting the
poll loop into a busy wait (100% cpu occupied by the
user-space process, etc.).

Is this a bug in PF_PACKET? Should the socket queue be
emptied by packet_set_ring (called via setsockopt when
PACKET_RX_RING is used) so the above cannot happen?
Should the user-space app drain the socket queue with
recvfrom prior to (4) -quite unlikely in practice-?

Thx in advance for your comments!

Salu2,
J.
