Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268154AbTBSIYH>; Wed, 19 Feb 2003 03:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268155AbTBSIYH>; Wed, 19 Feb 2003 03:24:07 -0500
Received: from packet.digeo.com ([12.110.80.53]:16524 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268154AbTBSIYE>;
	Wed, 19 Feb 2003 03:24:04 -0500
Date: Wed, 19 Feb 2003 00:35:18 -0800
From: Andrew Morton <akpm@digeo.com>
To: Cliff White <cliffw@osdl.org>
Cc: willy@debian.org, testdev@osdl.org, linux-kernel@vger.kernel.org,
       Matthew Jacob <mjacob@feral.com>
Subject: Re: Qlogic FC, 2.5.62,-mm1 w/flock fix (plm# 1567)
Message-Id: <20030219003518.0e194085.akpm@digeo.com>
In-Reply-To: <200302190754.h1J7sVY30494@es175.pdx.osdl.net>
References: <200302190754.h1J7sVY30494@es175.pdx.osdl.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Feb 2003 08:34:00.0496 (UTC) FILETIME=[A6C73B00:01C2D7F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White <cliffw@osdl.org> wrote:
>
> 
> Thanks Andrew and Matthew.
> We can now actually *without* rebooting the machine,
> start the database.
> stop the database, and 
> (gasp!) re-start the database without error. Progress. :)
> (2.5.62 stock and 2.5.62-mm1 both fail this test)

Ah, that's good news.  I have an update from Matthew which fixes
the confusion-at-reboot-time.  Below.

> Also,
> we've run the OSDL dbt-2 workload on a 4-cpu machine,
> (PIII @700mhz x4 w/3GB RAM Qlogic 2200 FC card)
> using 
> 
> linux-2.5.62 + flock() fix (plm patch id#1567) 
> 	- disk using qlogicfc driver
> linux-2.5.62-mm1 + flock() fix (plm patch id#1567)
> 	- disk using isp (new) driver
> 
> Results and bunch o' numbers at:
> http://www.osdl.org/archive/cliffw/flock/flock-mm1
> http://www.osdl.org/archive/cliffw/flock/flock-62
> 
> Caveats: This data is one run from each kernel,
> results from repeated runs may vary, harmful or fatal if
> swallowed. Merge of plm 1567 w/-mm1 performed by unskilled
> labor. We have *not* tested this on the several other
> wierdasp SCSI devices in house, more results maybe.
> 
> Quick observations: 
> DBT numbers are about the same (+/- 10%), but vmstat differs:
> - There are certainly tunables, especially in /proc/vm/sys
> 	that we haven't tried yet. Any suggestions on tunables
> 	most appreciated. 
> - more procssess are runing w/-mm1 in each sample..
> - this a cached run, io occurs mostly during load, except for db log io
> 

That all looks OK.  You're sustaining almost 95% user CPU time across the
run.  The -mm1 run is using more pagecache for some reason.  Presumably
because of "more processes".



 scsi/isp/isp_linux.c |   18 +++++++++---------
 scsi/isp/isp_pci.c   |   16 +++++++++++++---
 2 files changed, 22 insertions(+), 12 deletions(-)

diff -puN drivers/scsi/isp/isp_linux.c~isp-update-1 drivers/scsi/isp/isp_linux.c
--- 25/drivers/scsi/isp/isp_linux.c~isp-update-1	2003-02-18 13:19:18.000000000 -0800
+++ 25-akpm/drivers/scsi/isp/isp_linux.c	2003-02-18 13:19:18.000000000 -0800
@@ -944,7 +944,7 @@ isplinux_abort(Scsi_Cmnd *Cmnd)
 		NewCmnd = isplinux_remove_from_doneq(Cmnd);
 		wqfnd++;
 	}
-	ISP_UNLKU_SOFTC(isp);
+	ISP_UNLK_SOFTC(isp);
 	isp_prt(isp, ISP_LOGINFO,
 	    "isplinux_abort: found %d:%p for non-running cmd for %d.%d.%d",
 	    wqfnd, NewCmnd, XS_CHANNEL(Cmnd), XS_TGT(Cmnd), XS_LUN(Cmnd));
@@ -954,14 +954,14 @@ isplinux_abort(Scsi_Cmnd *Cmnd)
 	}
     } else {
 	if (isp_control(isp, ISPCTL_ABORT_CMD, Cmnd)) {
-	    ISP_UNLKU_SOFTC(isp);
+	    ISP_UNLK_SOFTC(isp);
 	    ISP_DRIVER_EXIT_LOCK(isp);
 	    return (FAILED);
 	}
 	if (isp->isp_nactive > 0)
 	    isp->isp_nactive--;
 	isp_destroy_handle(isp, handle);
-	ISP_UNLKU_SOFTC(isp);
+	ISP_UNLK_SOFTC(isp);
 	ISP_DRIVER_EXIT_LOCK(isp);
 	isp_prt(isp, ISP_LOGINFO,
 	    "isplinux_abort: aborted running cmd (handle 0x%x) for %d.%d.%d",
@@ -989,9 +989,9 @@ isplinux_bdr(Scsi_Cmnd *Cmnd)
     isp = XS_ISP(Cmnd);
     arg = XS_CHANNEL(Cmnd) << 16 | XS_TGT(Cmnd);
     ISP_DRIVER_ENTRY_LOCK(isp);
-    ISP_LOCKU_SOFTC(isp);
+    ISP_LOCK_SOFTC(isp);
     arg = isp_control(isp, ISPCTL_RESET_DEV, &arg);
-    ISP_UNLKU_SOFTC(isp);
+    ISP_UNLK_SOFTC(isp);
     ISP_DRIVER_EXIT_LOCK(isp);
     isp_prt(isp, ISP_LOGINFO, "Bus Device Reset %succesfully sent to %d.%d.%d",
 	arg == 0? "s" : "uns", XS_CHANNEL(Cmnd), XS_TGT(Cmnd), XS_LUN(Cmnd));
@@ -1013,9 +1013,9 @@ isplinux_sreset(Scsi_Cmnd *Cmnd)
     isp = XS_ISP(Cmnd);
     arg = XS_CHANNEL(Cmnd);
     ISP_DRIVER_ENTRY_LOCK(isp);
-    ISP_LOCKU_SOFTC(isp);
+    ISP_LOCK_SOFTC(isp);
     arg = isp_control(isp, ISPCTL_RESET_BUS, &arg);
-    ISP_UNLKU_SOFTC(isp);
+    ISP_UNLK_SOFTC(isp);
     ISP_DRIVER_EXIT_LOCK(isp);
     isp_prt(isp, ISP_LOGINFO, "SCSI Bus Reset on Channel %d %succesful",
 	XS_CHANNEL(Cmnd), arg == 0? "s" : "uns");
@@ -1041,7 +1041,7 @@ isplinux_hreset(Scsi_Cmnd *Cmnd)
     isp_prt(isp, ISP_LOGINFO, "Resetting Host Adapter");
 
     ISP_DRIVER_ENTRY_LOCK(isp);
-    ISP_LOCKU_SOFTC(isp);
+    ISP_LOCK_SOFTC(isp);
 
     /*
      * Save pending, running, and completed commands.
@@ -1069,7 +1069,7 @@ isplinux_hreset(Scsi_Cmnd *Cmnd)
 
     isplinux_reinit(isp);
 
-    ISP_UNLKU_SOFTC(isp);
+    ISP_UNLK_SOFTC(isp);
     ISP_DRIVER_EXIT_LOCK(isp);
 
     /*
diff -puN drivers/scsi/isp/isp_pci.c~isp-update-1 drivers/scsi/isp/isp_pci.c
--- 25/drivers/scsi/isp/isp_pci.c~isp-update-1	2003-02-18 13:19:18.000000000 -0800
+++ 25-akpm/drivers/scsi/isp/isp_pci.c	2003-02-18 13:20:11.000000000 -0800
@@ -377,12 +377,17 @@ isplinux_pci_addhost(Scsi_Host_Template 
     isp->isp_next = isplist;
     isplist = isp;
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,4)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,61)
     scsi_set_device(host, &pci_isp->pci_dev->dev);
+#else
+    scsi_set_pci_device(host, pci_isp->pci_dev);
+#endif
 #endif
     return (pci_isp);
 }
 
-#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,18)
+#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,18) && \
+    	LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 #include <linux/reboot.h>
 static int
 isp_notify_reboot(struct notifier_block *ispnb, unsigned long Event, void *b)
@@ -513,7 +518,11 @@ isplinux_pci_detect(Scsi_Host_Template *
 	}
     }
 #endif
-#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,18)
+    /*
+     * Don't do reboot notifier stuff for 2.5.X yet
+     */
+#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,18) && \
+    	LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
     if (isp_nfound) {
 	register_reboot_notifier(&isp_notifier);
     }
@@ -551,7 +560,8 @@ isplinux_pci_release(struct Scsi_Host *h
 	RlsPages(FCPARAM(isp)->isp_scratch, 1);
     }
 #endif
-#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,18)
+#if	LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,18) && \
+    	LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
     if (--isp_nfound <= 0) {
         unregister_reboot_notifier(&isp_notifier);
     }

_

