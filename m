Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbULOH15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbULOH15 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 02:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbULOH1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 02:27:37 -0500
Received: from lists.us.dell.com ([143.166.224.162]:12150 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262233AbULOH1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 02:27:06 -0500
Date: Wed, 15 Dec 2004 01:24:53 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>, brking@us.ibm.com,
       linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, bunk@fs.tum.de,
       Andrew Morton <akpm@osdl.org>, "Ju, Seokmann" <sju@lsil.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>, "Mukker, Atul" <Atulm@lsil.com>
Subject: Re: How to add/drop SCSI drives from within the driver?
Message-ID: <20041215072453.GB17274@lists.us.dell.com>
References: <60807403EABEB443939A5A7AA8A7458B7F5071@otce2k01.adaptec.com> <1102536081.4218.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102536081.4218.0.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 02:01:21PM -0600, James Bottomley wrote:
> On Wed, 2004-12-08 at 13:42 -0500, Salyzyn, Mark wrote:
> > James Bottomley writes:
> > >The real way I'd like to handle this is via hotplug.  The hotplug event
> > >would transmit the HCTL in the environment.  Whether the drive actually
> > >gets incorporated into the system and where is user policy, so it's
> > >appropriate that it should be in userland.
> 
> Hotplug is the standard way of handling configuration changes (whether
> requested or forced).  There's value to handling things in a standard
> manner.  If the current implementation needs improving, then you're free
> to do it (and it would benefit far more than just SCSI...).
> 
> So the firmware calls the SCSI API which triggers the hotplug event and
> adds the device ... there's no problem.

James, I've been thinking about this a little more, and you may be on
to something here. Let each driver add files as such:

/sys/class/scsi_host
 |-- host0
 |   |-- add_logical_drive
 |   |-- remove_logical_drive
 |   `-- rescan_logical_drive

Then we can go 2 ways with this.
1) driver functions directly call scsi_add_device(),
scsi_remove_device(), and something for rescan (option 2 handles this
one cleanly for us).  ATM, megaraid_mbox doesn't implement a rescan
function, so this point may be moot. 

2) driver functions call a midlayer library function, which invokes
   /sbin/hotplug with appropriate data, and add a new /etc/hotplug.d
   helper app which would then write to these files:

/sys/class/scsi_host
|-- host0
|   |-- scan
/sys/devices/pci0000:0x/0000:0x:0x.0/host0
|-- 0:0:0:0
|   |-- delete
|   |-- rescan

to do likewise.


Patch below against scsi-misc-2.6, as a proof of concept for option 1
above, option 2 would take a little more time to do and get right, but
I want to get feedback as to direction before digging further.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== drivers/scsi/megaraid/megaraid_mbox.c 1.11 vs edited =====
--- 1.11/drivers/scsi/megaraid/megaraid_mbox.c	2004-11-18 16:12:10 -06:00
+++ edited/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-15 01:18:19 -06:00
@@ -455,6 +455,133 @@ static struct pci_driver megaraid_pci_dr
 
 
 /*
+ * sysfs class device support
+ * creates three files:
+ * /sys/class/scsi_host
+ * |-- host0
+ * |   |-- add_logical_drive
+ * |   |-- remove_logical_drive
+ * |   `-- rescan_logical_drive
+ *
+ * These make the midlayer invoke /sbin/hotplug, which then calls back into sysfs
+ * /sys/class/scsi_host
+ * |-- host0
+ * |   |-- scan
+ *
+ * and
+ *
+ * /sys/devices/pci0000:0x/0000:0x:0x.0/host0
+ * |-- 0:0:0:0
+ * |   |-- delete
+ * |   |-- rescan
+ *
+ * respectively.  This allows userspace applications to work
+ * using their logical drive number, and lets the driver translate
+ * that into host, channel, id, and lun values which the other
+ * mechanisms require.  This is similar to how hot plug CPU works.
+ */
+
+/**
+ * lda_to_hcil()
+ * @adapter
+ * @lda - logical drive address
+ * @host_no
+ * @channel
+ * @id
+ * @lun
+ *
+ * converts a logical drive address into a host, channel id, lun tuple.
+ */
+
+static inline int megaraid_lda_to_hcil(struct Scsi_Host *shost, u32 lda,
+				       u32 *host_no, u32 *channel, u32 *id, u32 *lun)
+{
+	if (lda > MAX_LOGICAL_DRIVES_40LD)
+		return -EINVAL;
+	*host_no = shost->host_no;
+	*channel = shost->max_channel;
+	*id      = (lda < shost->this_id) ? lda : lda + 1;
+	*lun     = 0;
+	return 0;
+}
+
+enum megaraid_host_action {
+	LD_ADD    = 1,
+	LD_REMOVE = 2,
+	LD_RESCAN = 3,
+};
+
+static int megaraid_host_store(struct class_device *class_dev, const char *buf, size_t count, int action)
+{
+        struct Scsi_Host *shost = class_to_shost(class_dev);
+	struct scsi_device *sdev;
+	int fields=0, rc=-EINVAL;
+	u32 lda=0, host_no=0, channel=0, id=0, lun=0;
+	fields = sscanf(buf, "%u", &lda);
+	if (fields != 1)
+		return rc;
+	if (lda > MAX_LOGICAL_DRIVES_40LD)
+		return rc;
+	rc = megaraid_lda_to_hcil(shost, lda, &host_no, &channel, &id, &lun);
+	if (rc)
+		return rc;
+
+	/*
+	 * This is where the call-out to /sbin/hotplug would go.
+	 * for now, short-circuit that and just call the necessary
+	 * functions directly.
+	 */
+	rc = -EINVAL;
+	switch (action) {
+	case LD_ADD:
+		scsi_add_device(shost, channel, id, lun);
+		break;
+	case LD_REMOVE:
+		sdev = scsi_device_lookup(shost, channel, id, lun);
+		if (sdev) {
+			scsi_remove_device(sdev);
+			scsi_device_put(sdev);
+			return -EINVAL;
+		}
+		break;
+	case LD_RESCAN:
+		return -ENOSYS;
+	default:
+		return -EINVAL;
+	}
+	return count;
+}
+
+static ssize_t megaraid_host_store_add_ld(struct class_device *class_dev, const char *buf, size_t count)
+{
+	return megaraid_host_store(class_dev, buf, count, LD_ADD);
+}
+static ssize_t megaraid_host_store_remove_ld(struct class_device *class_dev, const char *buf, size_t count)
+{
+	return megaraid_host_store(class_dev, buf, count, LD_REMOVE);
+}
+static ssize_t megaraid_host_store_rescan_ld(struct class_device *class_dev, const char *buf, size_t count)
+{
+	return megaraid_host_store(class_dev, buf, count, LD_RESCAN);
+}
+
+
+#define MEGARAID_HOST_WOATTR(_name,_store) \
+CLASS_DEVICE_ATTR(_name, S_IWUSR|S_IWGRP, NULL, _store)
+
+static MEGARAID_HOST_WOATTR(add_logical_drive, megaraid_host_store_add_ld);
+static MEGARAID_HOST_WOATTR(remove_logical_drive, megaraid_host_store_remove_ld);
+static MEGARAID_HOST_WOATTR(rescan_logical_drive, megaraid_host_store_rescan_ld);
+
+/* Host attributes initializer */
+static struct class_device_attribute *megaraid_host_attrs[] = {
+	&class_device_attr_add_logical_drive,
+	&class_device_attr_remove_logical_drive,
+	&class_device_attr_rescan_logical_drive,
+	NULL,
+};
+
+/*
  * Scsi host template for megaraid unified driver
  */
 static struct scsi_host_template megaraid_template_g = {
@@ -467,6 +594,7 @@ static struct scsi_host_template megarai
 	.eh_bus_reset_handler		= megaraid_reset_handler,
 	.eh_host_reset_handler		= megaraid_reset_handler,
 	.use_clustering			= ENABLE_CLUSTERING,
+	.shost_attrs			= megaraid_host_attrs,
 };
 
 
