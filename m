Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbTGBSr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbTGBSr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:47:29 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27112 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264372AbTGBSr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 14:47:27 -0400
Date: Wed, 02 Jul 2003 11:50:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm3
Message-ID: <535730000.1057171811@flay>
In-Reply-To: <530600000.1057169520@flay>
References: <20030701203830.19ba9328.akpm@digeo.com><15570000.1057122469@[10.10.2.4]> <20030701221829.3e0edf3a.akpm@digeo.com> <530600000.1057169520@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> scsi HBA driver Qlogic ISP 10X0/2X00 didn't set a release method.
> st: Version 20030622, fixed bufsize 32768, s/g segs 256
> oprofile: using NMI interrupt.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP: routing cache hash table of 131072 buckets, 1024Kbytes
> TCP: Hash tables configured (established 524288 bind 65536)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> VFS: Cannot open root device "sda2" or unknown-block(0,0)
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)
> 
> Note the "scsi HBA driver Qlogic ISP 10X0/2X00 didn't set a release method"
> bit.

OK, this rediffed version of Mike's earlier patch fixes it - I guess it
got trampled in the merge. All the ifdefs surrounding isplinux_release
are a bit odd, but I think I got 'em right. Would be a damned sight 
easier if we ripped out all that version crud.

M.

diff -purN linux-2.5.73-mm3/drivers/scsi/isp/isp_linux.c 2.5.73-mm3/drivers/scsi/isp/isp_linux.c
--- linux-2.5.73-mm3/drivers/scsi/isp/isp_linux.c	2003-07-01 20:29:04.000000000 -0700
+++ 2.5.73-mm3/drivers/scsi/isp/isp_linux.c	2003-07-02 11:01:02.000000000 -0700
@@ -145,7 +145,6 @@ isplinux_detect(Scsi_Host_Template *tmpt
     return (rval);
 }
 
-#ifdef	MODULE
 /* io_request_lock *not* held here */
 int
 isplinux_release(struct Scsi_Host *host)
@@ -185,7 +184,6 @@ isplinux_release(struct Scsi_Host *host)
 	isp_kfree(FCPARAM(isp)->isp_dump_data, amt);
 	FCPARAM(isp)->isp_dump_data = 0;
     }
-#endif
 #if defined(CONFIG_PROC_FS) && LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
     /*
      * Undo any PROCFS stuff
@@ -193,8 +191,8 @@ isplinux_release(struct Scsi_Host *host)
     isplinux_undo_proc(isp);
 #endif
     return (1);
-}
 #endif
+}
 
 const char *
 isplinux_info(struct Scsi_Host *host)
diff -purN linux-2.5.73-mm3/drivers/scsi/isp/isp_linux.h 2.5.73-mm3/drivers/scsi/isp/isp_linux.h
--- linux-2.5.73-mm3/drivers/scsi/isp/isp_linux.h	2003-07-01 20:29:04.000000000 -0700
+++ 2.5.73-mm3/drivers/scsi/isp/isp_linux.h	2003-07-02 10:53:38.000000000 -0700
@@ -774,12 +774,8 @@ static INLINE unsigned long _usec_to_jif
 
 int isplinux_proc_info(char *, char **, off_t, int, int, int);
 int isplinux_detect(Scsi_Host_Template *);
-#ifdef	MODULE
 int isplinux_release(struct Scsi_Host *);
 #define	ISPLINUX_RELEASE	isplinux_release
-#else
-#define	ISPLINUX_RELEASE	NULL
-#endif
 const char *isplinux_info(struct Scsi_Host *);
 int isplinux_queuecommand(Scsi_Cmnd *, void (* done)(Scsi_Cmnd *));
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)

