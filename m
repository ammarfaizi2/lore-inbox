Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUHaRSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUHaRSz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268754AbUHaRQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:16:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7613 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265127AbUHaRM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:12:56 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16692.45331.968648.262910@segfault.boston.redhat.com>
Date: Tue, 31 Aug 2004 13:10:43 -0400
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: netpoll trapped question
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matt,

This part of the netpoll trapped logic seems suspect to me, from
include/linux/netdevice.h:

static inline void netif_wake_queue(struct net_device *dev)
{
#ifdef CONFIG_NETPOLL_TRAP
	if (netpoll_trap())
		return;
#endif
	if (test_and_clear_bit(__LINK_STATE_XOFF, &dev->state))
		__netif_schedule(dev);
}

static inline void netif_stop_queue(struct net_device *dev)
{
#ifdef CONFIG_NETPOLL_TRAP
	if (netpoll_trap())
		return;
#endif
	set_bit(__LINK_STATE_XOFF, &dev->state);
}

This looks buggy.  Network drivers are now not able to stop the queue when
they run out of Tx descriptors.  I think the __netif_schedule is okay to do
in the context of netpoll, and certainly a set_bit is okay.  Why are these
hooks in place?  I've tested alt-sysrq-t over netconsole and also netdump
with these #ifdef's removed, and things work correctly.  Compare this with
alt-sysrq-t hanging the system with these tests in place.  If I run netdump
with this logic still in place, I get the following messages from the tg3
driver:

  eth0: BUG! Tx Ring full when queue awake!

Shall I send a patch, or have I missed something?

-Jeff
