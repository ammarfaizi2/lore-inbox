Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161385AbWJKV3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161385AbWJKV3v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161490AbWJKV3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:29:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:44702 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161395AbWJKVFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:05:18 -0400
Date: Wed, 11 Oct 2006 14:04:35 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jack Morgenstein <jackm@dev.mellanox.co.il>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Roland Dreier <rolandd@cisco.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 13/67] IB/mthca: Fix lid used for sending traps
Message-ID: <20061011210435.GN16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ib-mthca-fix-lid-used-for-sending-traps.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jack Morgenstein <jackm@dev.mellanox.co.il>

The SM LID used to send traps to is incorrectly set to port LID.  This
is a regression from 2.6.17 -- after a PortInfo MAD is received, no
traps are sent to the SM LID.  The traps go to the loopback interface
instead, and are dropped there.  The SM LID should be taken from the
sm_lid of the PortInfo response.

The bug was introduced by commit 12bbb2b7be7f5564952ebe0196623e97464b8ac5:
	IB/mthca: Add client reregister event generation

Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <rolandd@cisco.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/infiniband/hw/mthca/mthca_mad.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.orig/drivers/infiniband/hw/mthca/mthca_mad.c
+++ linux-2.6.18/drivers/infiniband/hw/mthca/mthca_mad.c
@@ -119,7 +119,7 @@ static void smp_snoop(struct ib_device *
 
 			mthca_update_rate(to_mdev(ibdev), port_num);
 			update_sm_ah(to_mdev(ibdev), port_num,
-				     be16_to_cpu(pinfo->lid),
+				     be16_to_cpu(pinfo->sm_lid),
 				     pinfo->neighbormtu_mastersmsl & 0xf);
 
 			event.device           = ibdev;

--
