Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263140AbSJBQS7>; Wed, 2 Oct 2002 12:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263136AbSJBQS7>; Wed, 2 Oct 2002 12:18:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:58613 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263131AbSJBQSz>; Wed, 2 Oct 2002 12:18:55 -0400
Date: Wed, 2 Oct 2002 09:24:43 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Andreas Boman <aboman@nerdfest.org>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       linux-kernel@vger.kernel.org, dougg@gear.torque.net
Subject: Re: 2.4.39 "Sleeping function called from illegal context at slab.c:1374"
Message-ID: <20021002162443.GA1317@beaverton.ibm.com>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	Andreas Boman <aboman@nerdfest.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	linux-kernel@vger.kernel.org, dougg@gear.torque.net
References: <3D99885B.533C320D@aitel.hist.no> <3D99EF62.3A3E6932@digeo.com> <20021001215907.GA8273@midgaard.us> <3D9A207A.14BFF440@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9A207A.14BFF440@digeo.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton [akpm@digeo.com] wrote:
> That is known - sg_init() is blatantly calling vmalloc under
> write_lock_irqsave().

I had not already seen a patch for this.

During Douglas Gilbert's time-off he connects when he can so it maybe a
bit until he can address this. 

In the interim a quick patch below should fix the problem, and still
provide for safe additions.

I have done just minor testing on 2.5.40 using the sg_utils.

-andmike
--
Michael Anderson
andmike@us.ibm.com

sg.c |   48 +++++++++++++++++++++++++++++++++---------------
1 files changed, 33 insertions(+), 15 deletions(-)

diff -Nru a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c	Wed Oct  2 09:00:41 2002
+++ b/drivers/scsi/sg.c	Wed Oct  2 09:00:41 2002
@@ -1354,11 +1354,29 @@
 {
 	static int sg_registered = 0;
 	unsigned long iflags;
+	int tmp_dev_max;
+	Sg_device **tmp_da;
 
 	if ((sg_template.dev_noticed == 0) || sg_dev_arr)
 		return 0;
 
+	SCSI_LOG_TIMEOUT(3, printk("sg_init\n"));
+
+	write_lock_irqsave(&sg_dev_arr_lock, iflags);
+	tmp_dev_max = sg_template.dev_noticed + SG_DEV_ARR_LUMP;
+	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+
+	tmp_da = (Sg_device **)vmalloc(
+				tmp_dev_max * sizeof(Sg_device *));
+	if (NULL == tmp_da) {
+		printk(KERN_ERR "sg_init: no space for sg_dev_arr\n");
+		return 1;
+	}
+	memset(tmp_da, 0, tmp_dev_max * sizeof (Sg_device *));
 	write_lock_irqsave(&sg_dev_arr_lock, iflags);
+	sg_template.dev_max = tmp_dev_max;
+	sg_dev_arr = tmp_da;
+
 	if (!sg_registered) {
 		if (register_chrdev(SCSI_GENERIC_MAJOR, "sg", &sg_fops)) {
 			printk(KERN_ERR
@@ -1370,16 +1388,6 @@
 		sg_registered++;
 	}
 
-	SCSI_LOG_TIMEOUT(3, printk("sg_init\n"));
-	sg_template.dev_max = sg_template.dev_noticed + SG_DEV_ARR_LUMP;
-	sg_dev_arr = (Sg_device **)vmalloc(
-			sg_template.dev_max * sizeof(Sg_device *));
-	if (NULL == sg_dev_arr) {
-		printk(KERN_ERR "sg_init: no space for sg_dev_arr\n");
-		write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
-		return 1;
-	}
-	memset(sg_dev_arr, 0, sg_template.dev_max * sizeof (Sg_device *));
 	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
 #ifdef CONFIG_PROC_FS
 	sg_proc_init();
@@ -1430,7 +1438,7 @@
 static int
 sg_attach(Scsi_Device * scsidp)
 {
-	Sg_device *sdp;
+	Sg_device *sdp = NULL;
 	unsigned long iflags;
 	int k;
 
@@ -1439,15 +1447,16 @@
 		Sg_device **tmp_da;
 		int tmp_dev_max = sg_template.nr_dev + SG_DEV_ARR_LUMP;
 
+		write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
 		tmp_da = (Sg_device **)vmalloc(
 				tmp_dev_max * sizeof(Sg_device *));
 		if (NULL == tmp_da) {
 			scsidp->attached--;
-			write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
 			printk(KERN_ERR
 			       "sg_attach: device array cannot be resized\n");
 			return 1;
 		}
+		write_lock_irqsave(&sg_dev_arr_lock, iflags);
 		memset(tmp_da, 0, tmp_dev_max * sizeof (Sg_device *));
 		memcpy(tmp_da, sg_dev_arr,
 		       sg_template.dev_max * sizeof (Sg_device *));
@@ -1456,6 +1465,7 @@
 		sg_template.dev_max = tmp_dev_max;
 	}
 
+find_empty_slot:
 	for (k = 0; k < sg_template.dev_max; k++)
 		if (!sg_dev_arr[k])
 			break;
@@ -1467,11 +1477,19 @@
 		       " type=%d, minor number exceed %d\n",
 		       scsidp->host->host_no, scsidp->channel, scsidp->id,
 		       scsidp->lun, scsidp->type, SG_MAX_DEVS_MASK);
+		if (NULL != sdp)
+			vfree((char *) sdp);
 		return 1;
 	}
-	if (k < sg_template.dev_max)
-		sdp = (Sg_device *)vmalloc(sizeof(Sg_device));
-	else
+	if (k < sg_template.dev_max) {
+		if (NULL == sdp) {
+			write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+			sdp = (Sg_device *)vmalloc(sizeof(Sg_device));
+			write_lock_irqsave(&sg_dev_arr_lock, iflags);
+			if (!sg_dev_arr[k])
+				goto find_empty_slot;
+		}
+	} else
 		sdp = NULL;
 	if (NULL == sdp) {
 		scsidp->attached--;

