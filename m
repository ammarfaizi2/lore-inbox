Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263665AbUECM37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUECM37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 08:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUECM36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 08:29:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56032 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263654AbUECM3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 08:29:49 -0400
Date: Mon, 3 May 2004 13:29:48 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-scsi@vger.kernel.org, kaos@sgi.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Fw: 2.6.6-rc3 ia64 smp_call_function() called with interrupts disabled
Message-ID: <20040503122948.GI2281@parcelfarce.linux.theplanet.co.uk>
References: <20040502214525.5ad05bed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040502214525.5ad05bed.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 09:45:25PM -0700, Andrew Morton wrote:
> Begin forwarded message:
> 
> Date: Mon, 03 May 2004 12:39:44 +1000
> From: Keith Owens <kaos@sgi.com>
> To: linux-kernel@vger.kernel.org
> Subject: 2.6.6-rc3 ia64 smp_call_function() called with interrupts disabled
> 
> 
> 2.6.6-rc3, modprobe sg calls vfree() with interrupts disabled.  On
> ia64, vfree calls smp_flush_tlb_all() which calls smp_call_function().
> Calling smp_call_function() with interrupts disabled can deadlock.
> 
> Badness in smp_call_function at arch/ia64/kernel/smp.c:312
> 
> Call Trace:
>  [<a000000100142fb0>] __vunmap+0x50/0x1e0
>                                 sp=e00001307811fe30 bsp=e0000130781190a0
>  [<a0000002002ae4d0>] sg_add+0x2d0/0xbe0 [sg]
>                                 sp=e00001307811fe30 bsp=e000013078119038

How about the following patch?  Noet that vfree() handles a NULL argument,
so it's not necessary to check the pointer.

Index: drivers/scsi/sg.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/scsi/sg.c,v
retrieving revision 1.13
diff -u -p -r1.13 sg.c
--- a/drivers/scsi/sg.c	15 Apr 2004 18:04:45 -0000	1.13
+++ b/drivers/scsi/sg.c	3 May 2004 12:28:12 -0000
@@ -1341,6 +1341,7 @@ sg_add(struct class_device *cl_dev)
 	Sg_device *sdp = NULL;
 	unsigned long iflags;
 	struct cdev * cdev = NULL;
+	void *old_sg_dev_arr = NULL;
 	int k, error;
 
 	disk = alloc_disk(1);
@@ -1368,7 +1369,7 @@ sg_add(struct class_device *cl_dev)
 		memset(tmp_da, 0, tmp_dev_max * sizeof (Sg_device *));
 		memcpy(tmp_da, sg_dev_arr,
 		       sg_dev_max * sizeof (Sg_device *));
-		vfree((char *) sg_dev_arr);
+		old_sg_dev_arr = sg_dev_arr;
 		sg_dev_arr = tmp_da;
 		sg_dev_max = tmp_dev_max;
 	}
@@ -1384,8 +1385,7 @@ find_empty_slot:
 		       " type=%d, minor number exceeds %d\n",
 		       scsidp->host->host_no, scsidp->channel, scsidp->id,
 		       scsidp->lun, scsidp->type, SG_MAX_DEVS - 1);
-		if (NULL != sdp)
-			vfree((char *) sdp);
+		vfree(sdp);
 		error = -ENODEV;
 		goto out;
 	}
@@ -1459,6 +1459,7 @@ find_empty_slot:
 	return 0;
 
 out:
+	vfree(old_sg_dev_arr);
 	put_disk(disk);
 	if (cdev)
 		cdev_del(cdev);

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
