Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422768AbWHYS1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422768AbWHYS1u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422766AbWHYSZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:34 -0400
Received: from mx.pathscale.com ([64.160.42.68]:46210 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422780AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 23 of 23] IB/ipath - control receive polarity inversion
X-Mercurial-Node: 7a03a7b18dcfe1afeeb1a0d1fd67dddd77365231
Message-Id: <7a03a7b18dcfe1afeeb1.1156530288@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:48 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_driver.c b/drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:46 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri Aug 25 11:19:46 2006 -0700
@@ -2156,5 +2156,22 @@ bail:
 	return ret;
 }
 
+int ipath_set_rx_pol_inv(struct ipath_devdata *dd, u8 new_pol_inv)
+{
+	u64 val;
+	if ( new_pol_inv > INFINIPATH_XGXS_RX_POL_MASK ) {
+		return -1;
+	}
+	if ( dd->ipath_rx_pol_inv != new_pol_inv ) {
+		dd->ipath_rx_pol_inv = new_pol_inv;
+		val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_xgxsconfig);
+		val &= ~(INFINIPATH_XGXS_RX_POL_MASK <<
+                         INFINIPATH_XGXS_RX_POL_SHIFT);
+                val |= ((u64)dd->ipath_rx_pol_inv) <<
+                        INFINIPATH_XGXS_RX_POL_SHIFT;
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_xgxsconfig, val);
+	}
+	return 0;
+}
 module_init(infinipath_init);
 module_exit(infinipath_cleanup);
diff --git a/drivers/infiniband/hw/ipath/ipath_iba6110.c b/drivers/infiniband/hw/ipath/ipath_iba6110.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6110.c	Fri Aug 25 11:19:46 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6110.c	Fri Aug 25 11:19:46 2006 -0700
@@ -1290,6 +1290,15 @@ static int ipath_ht_bringup_serdes(struc
 		val &= ~INFINIPATH_XGXS_RESET;
 		change = 1;
 	}
+	if (((val >> INFINIPATH_XGXS_RX_POL_SHIFT) &
+	     INFINIPATH_XGXS_RX_POL_MASK) != dd->ipath_rx_pol_inv ) {
+		/* need to compensate for Tx inversion in partner */
+		val &= ~(INFINIPATH_XGXS_RX_POL_MASK <<
+		         INFINIPATH_XGXS_RX_POL_SHIFT);
+		val |= dd->ipath_rx_pol_inv <<
+			INFINIPATH_XGXS_RX_POL_SHIFT;
+		change = 1;
+	}
 	if (change)
 		ipath_write_kreg(dd, dd->ipath_kregs->kr_xgxsconfig, val);
 
diff --git a/drivers/infiniband/hw/ipath/ipath_iba6120.c b/drivers/infiniband/hw/ipath/ipath_iba6120.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6120.c	Fri Aug 25 11:19:46 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6120.c	Fri Aug 25 11:19:46 2006 -0700
@@ -654,6 +654,15 @@ static int ipath_pe_bringup_serdes(struc
 		val &= ~INFINIPATH_XGXS_RESET;
 		change = 1;
 	}
+	if (((val >> INFINIPATH_XGXS_RX_POL_SHIFT) &
+	     INFINIPATH_XGXS_RX_POL_MASK) != dd->ipath_rx_pol_inv ) {
+		/* need to compensate for Tx inversion in partner */
+		val &= ~(INFINIPATH_XGXS_RX_POL_MASK <<
+		         INFINIPATH_XGXS_RX_POL_SHIFT);
+		val |= dd->ipath_rx_pol_inv <<
+			INFINIPATH_XGXS_RX_POL_SHIFT;
+		change = 1;
+	}
 	if (change)
 		ipath_write_kreg(dd, dd->ipath_kregs->kr_xgxsconfig, val);
 
diff --git a/drivers/infiniband/hw/ipath/ipath_kernel.h b/drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:46 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri Aug 25 11:19:46 2006 -0700
@@ -503,6 +503,8 @@ struct ipath_devdata {
 	u8 ipath_pci_cacheline;
 	/* LID mask control */
 	u8 ipath_lmc;
+	/* Rx Polarity inversion (compensate for ~tx on partner) */
+	u8 ipath_rx_pol_inv;
 
 	/* local link integrity counter */
 	u32 ipath_lli_counter;
@@ -570,6 +572,7 @@ int ipath_set_linkstate(struct ipath_dev
 int ipath_set_linkstate(struct ipath_devdata *, u8);
 int ipath_set_mtu(struct ipath_devdata *, u16);
 int ipath_set_lid(struct ipath_devdata *, u32, u8);
+int ipath_set_rx_pol_inv(struct ipath_devdata *dd, u8 new_pol_inv);
 
 /* for use in system calls, where we want to know device type, etc. */
 #define port_fp(fp) ((struct ipath_portdata *) (fp)->private_data)
diff --git a/drivers/infiniband/hw/ipath/ipath_registers.h b/drivers/infiniband/hw/ipath/ipath_registers.h
--- a/drivers/infiniband/hw/ipath/ipath_registers.h	Fri Aug 25 11:19:46 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_registers.h	Fri Aug 25 11:19:46 2006 -0700
@@ -282,6 +282,8 @@
 #define INFINIPATH_XGXS_RESET          0x7ULL
 #define INFINIPATH_XGXS_MDIOADDR_MASK  0xfULL
 #define INFINIPATH_XGXS_MDIOADDR_SHIFT 4
+#define INFINIPATH_XGXS_RX_POL_SHIFT 19
+#define INFINIPATH_XGXS_RX_POL_MASK 0xfULL
 
 #define INFINIPATH_RT_ADDR_MASK 0xFFFFFFFFFFULL	/* 40 bits valid */
 
diff --git a/drivers/infiniband/hw/ipath/ipath_sysfs.c b/drivers/infiniband/hw/ipath/ipath_sysfs.c
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c	Fri Aug 25 11:19:46 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Fri Aug 25 11:19:46 2006 -0700
@@ -561,6 +561,33 @@ bail:
 	return ret;
 }
 
+static ssize_t store_rx_pol_inv(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf,
+			  size_t count)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	int ret, r;
+	u16 val;
+
+	ret = ipath_parse_ushort(buf, &val);
+	if (ret < 0)
+		goto invalid;
+
+	r = ipath_set_rx_pol_inv(dd, val);
+	if (r < 0) {
+		ret = r;
+		goto bail;
+	}
+
+	goto bail;
+invalid:
+	ipath_dev_err(dd, "attempt to set invalid Rx Polarity invert\n");
+bail:
+	return ret;
+}
+
+
 static DRIVER_ATTR(num_units, S_IRUGO, show_num_units, NULL);
 static DRIVER_ATTR(version, S_IRUGO, show_version, NULL);
 
@@ -587,6 +614,7 @@ static DEVICE_ATTR(status_str, S_IRUGO, 
 static DEVICE_ATTR(status_str, S_IRUGO, show_status_str, NULL);
 static DEVICE_ATTR(boardversion, S_IRUGO, show_boardversion, NULL);
 static DEVICE_ATTR(unit, S_IRUGO, show_unit, NULL);
+static DEVICE_ATTR(rx_pol_inv, S_IWUSR, NULL, store_rx_pol_inv);
 
 static struct attribute *dev_attributes[] = {
 	&dev_attr_guid.attr,
@@ -601,6 +629,7 @@ static struct attribute *dev_attributes[
 	&dev_attr_boardversion.attr,
 	&dev_attr_unit.attr,
 	&dev_attr_enabled.attr,
+	&dev_attr_rx_pol_inv.attr,
 	NULL
 };
 
