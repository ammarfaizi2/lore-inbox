Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbVLWWvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbVLWWvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbVLWWtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:49:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:13520 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161109AbVLWWth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:37 -0500
Date: Fri, 23 Dec 2005 14:47:58 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       James.Bottomley@steeleye.com, miquels@cistron.nl, aacraid@adaptec.com,
       mark_salyzyn@adaptec.com
Subject: [patch 06/19] [PATCH] dpt_i2o fix for deadlock condition
Message-ID: <20051223224758.GF19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dpt_i2o-fix-for-deadlock-condition.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>

Miquel van Smoorenburg <miquels@cistron.nl> forwarded me this fix to
resolve a deadlock condition that occurs due to the API change in 2.6.13+
kernels dropping the host locking when entering the error handling.  They
all end up calling adpt_i2o_post_wait(), which if you call it unlocked,
might return with host_lock locked anyway and that causes a deadlock.

Signed-off-by: Mark Salyzyn <aacraid@adaptec.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/scsi/dpt_i2o.c |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

--- linux-2.6.14.4.orig/drivers/scsi/dpt_i2o.c
+++ linux-2.6.14.4/drivers/scsi/dpt_i2o.c
@@ -660,7 +660,12 @@ static int adpt_abort(struct scsi_cmnd *
 	msg[2] = 0;
 	msg[3]= 0; 
 	msg[4] = (u32)cmd;
-	if( (rcode = adpt_i2o_post_wait(pHba, msg, sizeof(msg), FOREVER)) != 0){
+	if (pHba->host)
+		spin_lock_irq(pHba->host->host_lock);
+	rcode = adpt_i2o_post_wait(pHba, msg, sizeof(msg), FOREVER);
+	if (pHba->host)
+		spin_unlock_irq(pHba->host->host_lock);
+	if (rcode != 0) {
 		if(rcode == -EOPNOTSUPP ){
 			printk(KERN_INFO"%s: Abort cmd not supported\n",pHba->name);
 			return FAILED;
@@ -697,10 +702,15 @@ static int adpt_device_reset(struct scsi
 	msg[2] = 0;
 	msg[3] = 0;
 
+	if (pHba->host)
+		spin_lock_irq(pHba->host->host_lock);
 	old_state = d->state;
 	d->state |= DPTI_DEV_RESET;
-	if( (rcode = adpt_i2o_post_wait(pHba, msg,sizeof(msg), FOREVER)) ){
-		d->state = old_state;
+	rcode = adpt_i2o_post_wait(pHba, msg,sizeof(msg), FOREVER);
+	d->state = old_state;
+	if (pHba->host)
+		spin_unlock_irq(pHba->host->host_lock);
+	if (rcode != 0) {
 		if(rcode == -EOPNOTSUPP ){
 			printk(KERN_INFO"%s: Device reset not supported\n",pHba->name);
 			return FAILED;
@@ -708,7 +718,6 @@ static int adpt_device_reset(struct scsi
 		printk(KERN_INFO"%s: Device reset failed\n",pHba->name);
 		return FAILED;
 	} else {
-		d->state = old_state;
 		printk(KERN_INFO"%s: Device reset successful\n",pHba->name);
 		return SUCCESS;
 	}
@@ -721,6 +730,7 @@ static int adpt_bus_reset(struct scsi_cm
 {
 	adpt_hba* pHba;
 	u32 msg[4];
+	u32 rcode;
 
 	pHba = (adpt_hba*)cmd->device->host->hostdata[0];
 	memset(msg, 0, sizeof(msg));
@@ -729,7 +739,12 @@ static int adpt_bus_reset(struct scsi_cm
 	msg[1] = (I2O_HBA_BUS_RESET<<24|HOST_TID<<12|pHba->channel[cmd->device->channel].tid);
 	msg[2] = 0;
 	msg[3] = 0;
-	if(adpt_i2o_post_wait(pHba, msg,sizeof(msg), FOREVER) ){
+	if (pHba->host)
+		spin_lock_irq(pHba->host->host_lock);
+	rcode = adpt_i2o_post_wait(pHba, msg,sizeof(msg), FOREVER);
+	if (pHba->host)
+		spin_unlock_irq(pHba->host->host_lock);
+	if (rcode != 0) {
 		printk(KERN_WARNING"%s: Bus reset failed.\n",pHba->name);
 		return FAILED;
 	} else {

--
