Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUIALJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUIALJC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUIALJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:09:02 -0400
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:65466 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S266116AbUIALIt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:08:49 -0400
Date: Wed, 01 Sep 2004 11:08:39 +0000
From: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: 3ware queue depth [was: Re: HIGHMEM4G config for 1GB RAM on
 desktop?]
To: Christoph Hellwig <hch@infradead.org>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, lkml@lpbproductions.com,
       Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
References: <200408021602.34320.swsnyder@insightbb.com>
	<1094030083l.3189l.2l@traveler> <1094030194l.3189l.3l@traveler>
	<200409010233.31643.lkml@lpbproductions.com>
	<1094032735l.3189l.7l@traveler> <20040901110944.A10160@infradead.org>
In-Reply-To: <20040901110944.A10160@infradead.org> (from hch@infradead.org
	on Wed Sep  1 12:09:44 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1094036919l.3189l.11l@traveler>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.09.01 12:09, Christoph Hellwig wrote:
> On Wed, Sep 01, 2004 at 09:58:55AM +0000, Miquel van Smoorenburg wrote:
> > On 2004.09.01 11:33, Matt Heler wrote:
> > >
> > > I have a 3ware 7000-2 card. And I noticed the same problem. 
> > > 
> > > Actually what I just did now was change the max luns from 254 to 64. 
> > > Recompiled and booted up. This seems to fix all my problems, and the speed 
> > > seems to be quite faster then before.
> > 
> > Yes, that is because the queue_depth parameter gets set from
> > TW_MAX_CMDS_PER_LUN by the 3w-xxxx.c driver ...
> > 
> > I found the 3ware patch. The patch below makes the queue depth
> > an optional module parameter, makes sure that the initial
> > nr_requests is twice the size of the queue_depth, and
> > makes queue_depth writable for the 3ware driver.
> 
>  - the writeable queue_depth sysfs attr is fine,
>  - the reverse_scan option is vetoed because it can't be supported when
>    the driver will be converted to the pci_driver interface (soon)

Sure. That was more an experiment (the BIOS of the Tyan mobo I use
detects PCI cards in the reverse order from the kernel ...)

>  - I'm not so sure about the module parameter, what's the problem of beeing
>    able to only change the queue depth once sysfs is mounted?

Nothing much, I guess. Just ease of use, or "there's more than one
way to do it". Hey wait, that tunable is already a module parameter
in at least 2.6.9-rc1, only there it's called 'cmds_per_lun'.
Ofcourse cmds_per_lun and queue_depth are the same.

Anyway here's the minimal patch against 2.6.9-rc1

[PATCH] 3w-xxxx.c queue depth

make 3w-xxxx.c queue_depth sysfs parameter writable, adjust initial
queue nr_requests to 2*queue_depth

Signed-off-by: Miquel van Smoorenburg <miquels@cistron.nl>

--- linux-2.6.9-rc1/drivers/scsi/3w-xxxx.c.orig	2004-08-17 22:07:49.000000000 +0200
+++ linux-2.6.9-rc1/drivers/scsi/3w-xxxx.c	2004-09-01 13:07:32.000000000 +0200
@@ -184,6 +184,8 @@
    1.26.00.039 - Fix bug in tw_chrdev_ioctl() polling code.
                  Fix data_buffer_length usage in tw_chrdev_ioctl().
                  Update contact information.
+   1.02.00.XXX - Miquel van Smoorenburg - make queue_depth sysfs parameter
+                 writable, adjust initial queue nr_requests to 2*queue_depth
 */
 
 #include <linux/module.h>
@@ -3388,8 +3390,6 @@
 {
 	int max_cmds;
 
-	dprintk(KERN_WARNING "3w-xxxx: tw_slave_configure()\n");
-
 	if (cmds_per_lun) {
 		max_cmds = cmds_per_lun;
 		if (max_cmds > TW_MAX_CMDS_PER_LUN)
@@ -3399,6 +3399,10 @@
 	}
 	scsi_adjust_queue_depth(SDptr, MSG_ORDERED_TAG, max_cmds);
 
+	/* make sure blockdev queue depth is at least 2 * scsi depth */
+	if (SDptr->request_queue->nr_requests < 2 * max_cmds)
+		SDptr->request_queue->nr_requests = 2 * max_cmds;
+
 	return 0;
 } /* End tw_slave_configure() */
 
@@ -3482,6 +3486,34 @@
 	outl(control_reg_value, control_reg_addr);
 } /* End tw_unmask_command_interrupt() */
 
+static ssize_t
+tw_store_queue_depth(struct device *dev, const char *buf, size_t count)
+{
+	int depth;
+										
+	struct scsi_device *SDp = to_scsi_device(dev);
+	if (sscanf(buf, "%d", &depth) != 1)
+		return -EINVAL;
+	if (depth < 1 || depth > TW_MAX_CMDS_PER_LUN)
+		return -EINVAL;
+	scsi_adjust_queue_depth(SDp, MSG_ORDERED_TAG, depth);
+										
+	return count;
+}
+										
+static struct device_attribute tw_queue_depth_attr = {
+	.attr = {
+		.name =		"queue_depth",
+		.mode =		S_IWUSR,
+	},
+	.store = tw_store_queue_depth,
+};
+
+static struct device_attribute *tw_dev_attrs[] = {
+	&tw_queue_depth_attr,
+	NULL,
+};
+
 static Scsi_Host_Template driver_template = {
 	.proc_name		= "3w-xxxx",
 	.proc_info		= tw_scsi_proc_info,
@@ -3499,6 +3531,7 @@
 	.max_sectors		= TW_MAX_SECTORS,
 	.cmd_per_lun		= TW_MAX_CMDS_PER_LUN,	
 	.use_clustering		= ENABLE_CLUSTERING,
+	.sdev_attrs		= tw_dev_attrs,
 	.emulated		= 1
 };
 #include "scsi_module.c"


