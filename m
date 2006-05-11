Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbWEKRZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWEKRZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 13:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWEKRZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 13:25:05 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:40491 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030384AbWEKRZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 13:25:03 -0400
To: Or Gerlitz <ogerlitz@voltaire.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] [PATCH 6/6] iSER Kconfig and Makefile
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.44.0605111003160.18975-100000@zuben>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 11 May 2006 10:24:51 -0700
In-Reply-To: <Pine.LNX.4.44.0605111003160.18975-100000@zuben> (Or Gerlitz's message of "Thu, 11 May 2006 10:03:30 +0300 (IDT)")
Message-ID: <adau07w1nks.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 May 2006 17:24:51.0748 (UTC) FILETIME=[CFCE5640:01C6751F]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed up this patch so that it actually hooks into the build (as
below).  (BTW, when sending patches in the future, please make them
apply with "-p1" -- your patches had paths like

    /usr/src/linux-2.6.17-rc3/drivers/infiniband/ulp/iser-x/Kconfig 

so I had to manually strip off the /usr/src/)

Anyway, with a config like

    CONFIG_SCSI_ISCSI_ATTRS=y
    # CONFIG_ISCSI_TCP is not set
    CONFIG_INFINIBAND_ISER=y

My build fails with a bunch of errors like:

    drivers/built-in.o: In function `iser_comp_error_worker':iser_verbs.c:(.text+0x7d7cd): undefined reference to `iscsi_conn_failure'

and so on.  Is the correct fix for this to add

obj-$(CONFIG_INFINIBAND_ISER) 	+= libiscsi.o

to drivers/scsi/Makefile?

Also, I get the following sparse warning:

    drivers/infiniband/ulp/iser/iser_initiator.c:610:25: error: incompatible types for operation (&)

and the code there does look fishy:

	itt = hdr->itt & ISCSI_ITT_MASK; /* mask out cid and age bits */

hdr->itt is __be32 but ISCSI_ITT_MASK is just (0xfff), so it seems
that there is something wrong, either with the iSCSI endianness
annotation or with the code itself.

Thanks,
  Roland

---

diff-tree 9120bc6c8b5bdd1f4c85df7a04779ae8faa0c1a5 (from 4161cba09429dae06d249584ee1c7d63c672422c)
Author: Or Gerlitz <ogerlitz@voltaire.com>
Date:   Thu May 11 10:03:30 2006 +0300

    IB/iser: iSER Kconfig and Makefile
    
    Kconfig and Makefile for iSER.
    
    Signed-off-by: Or Gerlitz <ogerlitz@voltaire.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index ba2d650..69a53d4 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -41,4 +41,6 @@ source "drivers/infiniband/ulp/ipoib/Kco
 
 source "drivers/infiniband/ulp/srp/Kconfig"
 
+source "drivers/infiniband/ulp/iser/Kconfig"
+
 endmenu
diff --git a/drivers/infiniband/Makefile b/drivers/infiniband/Makefile
index eea2732..abeaf79 100644
--- a/drivers/infiniband/Makefile
+++ b/drivers/infiniband/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_INFINIBAND_MTHCA)		+= hw/mt
 obj-$(CONFIG_IPATH_CORE)		+= hw/ipath/
 obj-$(CONFIG_INFINIBAND_IPOIB)		+= ulp/ipoib/
 obj-$(CONFIG_INFINIBAND_SRP)		+= ulp/srp/
+obj-$(CONFIG_INFINIBAND_SRP)		+= ulp/iser/
diff --git a/drivers/infiniband/ulp/iser/Kconfig b/drivers/infiniband/ulp/iser/Kconfig
new file mode 100644
index 0000000..fead87d
--- /dev/null
+++ b/drivers/infiniband/ulp/iser/Kconfig
@@ -0,0 +1,11 @@
+config INFINIBAND_ISER
+	tristate "ISCSI RDMA Protocol"
+	depends on INFINIBAND && SCSI
+	select SCSI_ISCSI_ATTRS
+	---help---
+	  Support for the ISCSI RDMA Protocol over InfiniBand.  This
+	  allows you to access storage devices that speak ISER/ISCSI
+	  over InfiniBand.
+
+	  The ISER protocol is defined by IETF.
+	  See <http://www.ietf.org/>.
diff --git a/drivers/infiniband/ulp/iser/Makefile b/drivers/infiniband/ulp/iser/Makefile
new file mode 100644
index 0000000..fe6cd15
--- /dev/null
+++ b/drivers/infiniband/ulp/iser/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_INFINIBAND_ISER)	+= ib_iser.o
+
+ib_iser-y			:= iser_verbs.o iser_initiator.o iser_memory.o \
+				   iscsi_iser.o
