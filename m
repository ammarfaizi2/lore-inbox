Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWJOOAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWJOOAs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 10:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWJOOAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 10:00:48 -0400
Received: from stinky.trash.net ([213.144.137.162]:29684 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S964838AbWJOOAr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 10:00:47 -0400
Message-ID: <45323F0B.2010604@trash.net>
Date: Sun, 15 Oct 2006 16:00:43 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joan Raventos <jraventos@yahoo.com>
CC: linux-kernel@vger.kernel.org, Linux Netdev List <netdev@vger.kernel.org>
Subject: Re: poll problem with PF_PACKET when using PACKET_RX_RING
References: <20061014214328.25873.qmail@web50614.mail.yahoo.com>
In-Reply-To: <20061014214328.25873.qmail@web50614.mail.yahoo.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joan Raventos wrote:
> Hello,
> 
> In order to use PF_PACKET/SOCK_RAW with PACKET_RX_RING
> one would possibly do (as described in
> Documentation/networking/packet_mmap.txt):
> 1. setup PF_PACKET socket via socket call.
> 2. use setsockopt to change the PF_PACKET socket into
> PACKET_RX_RING mode and alloc the ring.
> 3. mmap the ring.
> 4. use poll with the socket descriptor and then
> directly access the pkts from the mmaped ring.
> 
> However I've observed that if the socket is opened on
> a link with substantial traffic, chances are that some
> pkts might hit the socket between (1) and (2). At that
> point those pkts will make the socket descriptor be
> active (packet_poll is built as an OR from
> datagram_poll -essentially whether sk_receive_queue is
> empty- and the ring status). However after (2) pkts
> are no longer processed by packet_rcv but via
> tpacket_rcv, and thus no longer queued in the
> sk_receive_queue but into the ring. Moreover since the
> user-space app is likely to access them directly (4),
> no one is going to empty the socket queue and the
> descriptor will remain always active, converting the
> poll loop into a busy wait (100% cpu occupied by the
> user-space process, etc.).
> 
> Is this a bug in PF_PACKET? Should the socket queue be
> emptied by packet_set_ring (called via setsockopt when
> PACKET_RX_RING is used) so the above cannot happen?
> Should the user-space app drain the socket queue with
> recvfrom prior to (4) -quite unlikely in practice-?


I guess the best way is not to bind the socket before having
completed setup. We could still flush the queue to make life
easier for userspace, not sure about that ..

