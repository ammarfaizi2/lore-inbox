Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbTLSRVb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 12:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbTLSRVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 12:21:31 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:7184 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S263539AbTLSRV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 12:21:29 -0500
Date: Fri, 19 Dec 2003 11:23:01 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, mike.miller@hp.com,
       scott.benesh@hp.com
Subject: Re: cciss update for 2.4.24-pre1, #3
In-Reply-To: <Pine.LNX.4.58L.0312191422100.27571@logos.cnet>
Message-ID: <Pine.LNX.4.58.0312191111490.7900@beardog.cca.cpqcorp.net>
References: <Pine.LNX.4.58.0312170909380.30620@beardog.cca.cpqcorp.net>
 <Pine.LNX.4.58L.0312191422100.27571@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
Prefetch has undergone extensive testing internally. Other groups are
continuing to test it, also. All controllers on the street now have
prefetch enabled. When version 1.92 of the controller f/w is released
prefetch will be disabled by default. This patch re-enables it on x86 only
because of a _big_ performance hit in RAID1 operations.
This is on my list for 2.6. Since it has now been released I will begin
submitting updates after Christmas. (My list for 2.6 is extensive.)
Also, please include this version of the patch rather than my first
submission. I moved a variable inside the ifdef to clean up warnings on
non-x86 platforms.

Thanks,
mikem
mike.miller@hp.com
------------------------------------------------------------------------------
diff -burN lx2424pre1.test2/drivers/block/cciss.c lx2424pre1.test/drivers/block/cciss.c
--- lx2424pre1.test2/drivers/block/cciss.c	2003-12-18 09:12:52.000000000 -0600
+++ lx2424pre1.test/drivers/block/cciss.c	2003-12-18 09:09:11.000000000 -0600
@@ -2675,6 +2675,15 @@
 		printk("Does not appear to be a valid CISS config table\n");
 		return -1;
 	}
+
+#ifdef CONFIG_X86
+	/* Need to enable prefetch in the SCSI core for 6400 in x86 */
+	__u32 prefetch;
+	prefetch = readl(&(c->cfgtable->SCSI_Prefetch));
+	prefetch |= 0x100;
+	writel(prefetch, &(c->cfgtable->SCSI_Prefetch));
+#endif
+
 #ifdef CCISS_DEBUG
 	printk("Trying to put board into Simple mode\n");
 #endif /* CCISS_DEBUG */
diff -burN lx2424pre1.test2/drivers/block/cciss_cmd.h lx2424pre1.test/drivers/block/cciss_cmd.h
--- lx2424pre1.test2/drivers/block/cciss_cmd.h	2003-06-13 09:51:32.000000000 -0500
+++ lx2424pre1.test/drivers/block/cciss_cmd.h	2003-12-18 09:10:01.000000000 -0600
@@ -266,6 +266,7 @@
   DWORD            Reserved;
   BYTE             ServerName[16];
   DWORD            HeartBeat;
+  DWORD            SCSI_Prefetch;
 } CfgTable_struct;
 #pragma pack()
 #endif /* CCISS_CMD_H */
-------------------------------------------------------------------------------
On Fri, 19 Dec 2003, Marcelo Tosatti wrote:

>
>
> On Wed, 17 Dec 2003 mikem@beardog.cca.cpqcorp.net wrote:
>
> > Sorry I forgot to send this fix in with the 2 patches I submitted
> > yesterday. We found a bug in the ASIC used on the 64xx Smart Array
> > controllers. When prefetching from host memory we grab an extra 750 or
> > so bytes of data. If this occurs on a memory boundary the machine will crash.
> > This is primarily an issue on IPF and Alpha systems although it could happen
> > on other platforms. Proliant systems are not affected by this bug because
> > memory is contiguous and the top 4k of memory is masked off by the system
> > firmware. The solution to the problem is to disable SCSI prefetch in the
> > controller firmware. This results in a performance hit on x86 during RAID1
> > operations. This patch turns on prefetch for x86 based systems only.
> > Please consider this patch for inclusion in the 2.4.24 kernel.
> > This patch should be applied after the 2 I submitted yesterday. It will
> > patch into a fresh tree with offsets.
>
> The other two patches have been included.
>
> Has the prefetching been tested for long? Which kernels have it enabled?
>
> What about 2.6?
>
