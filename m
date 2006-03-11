Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWCKBOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWCKBOQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 20:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbWCKBOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 20:14:16 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:39507 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1751291AbWCKBOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 20:14:15 -0500
X-IronPort-AV: i="4.02,182,1139212800"; 
   d="scan'208"; a="414600847:sNHT32297280"
To: "Sean Hefty" <sean.hefty@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       <openib-general@openib.org>
Subject: Re: [PATCH 4/6 v2] IB: address translation to map IP toIB addresses (GIDs)
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX401FRaqbC8wSA0000000d@orsmsx401.amr.corp.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 10 Mar 2006 17:14:13 -0800
In-Reply-To: <ORSMSX401FRaqbC8wSA0000000d@orsmsx401.amr.corp.intel.com> (Sean Hefty's message of "Mon, 6 Mar 2006 15:31:58 -0800")
Message-ID: <ada1wx9hjfe.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Mar 2006 01:14:14.0610 (UTC) FILETIME=[1C918B20:01C644A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ib_addr module depends on CONFIG_INET, because it uses symbols
like arp_tbl, which are only exported if INET is enabled.

I fixed this up by creating a new (non-user-visible) config symbol to
control when ib_addr is built -- I put the following diff on top of
your patch in my tree:

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index bdf0891..48c8bb5 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -29,6 +29,11 @@ config INFINIBAND_USER_ACCESS
 	  libibverbs, libibcm and a hardware driver library from
 	  <http://www.openib.org>.
 
+config INFINIBAND_ADDR_TRANS
+	tristate
+	depends on INFINIBAND && INET
+	default y
+
 source "drivers/infiniband/hw/mthca/Kconfig"
 
 source "drivers/infiniband/ulp/ipoib/Kconfig"
diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 2393e9d..935851d 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -1,7 +1,8 @@
 obj-$(CONFIG_INFINIBAND) +=		ib_core.o ib_mad.o ib_sa.o \
-					ib_cm.o ib_addr.o
+					ib_cm.o 
 obj-$(CONFIG_INFINIBAND_USER_MAD) +=	ib_umad.o
 obj-$(CONFIG_INFINIBAND_USER_ACCESS) +=	ib_uverbs.o ib_ucm.o
+obj-$(CONFIG_INFINIBAND_ADDR_TRANS) +=	ib_addr.o
 
 ib_core-y :=			packer.o ud_header.o verbs.o sysfs.o \
 				device.o fmr_pool.o cache.o
