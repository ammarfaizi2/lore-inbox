Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264002AbTCXAEo>; Sun, 23 Mar 2003 19:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264003AbTCXAEn>; Sun, 23 Mar 2003 19:04:43 -0500
Received: from packet.digeo.com ([12.110.80.53]:61692 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264002AbTCXAEf>;
	Sun, 23 Mar 2003 19:04:35 -0500
Date: Sun, 23 Mar 2003 16:15:48 -0800
From: Andrew Morton <akpm@digeo.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: wa1ter@myrealbox.com
Subject: Re: [Bug 492] New: Zip drive parallel-port driver causes segfault
 in 2.5.x
Message-Id: <20030323161548.44d5a278.akpm@digeo.com>
In-Reply-To: <2070000.1048457694@[10.10.2.4]>
References: <2070000.1048457694@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2003 00:15:36.0112 (UTC) FILETIME=[7E021B00:01C2F19A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> Problem Description: ppa module doesn't work properly and, if compiled into
> kernel it causes a kernel panic at boot.
> Steps to reproduce:compile ppa.ko as a module and modprobe ppa:

Null-pointer deref.  This fixes it for me, but I'm not sure why the detect
routing is returning with the host lock held.  Maybe scsi detect routines are
supposed to do that?

diff -puN drivers/scsi/ppa.c~ppa-null-pointer-fix drivers/scsi/ppa.c
--- 25/drivers/scsi/ppa.c~ppa-null-pointer-fix	2003-03-23 16:08:37.000000000 -0800
+++ 25-akpm/drivers/scsi/ppa.c	2003-03-23 16:09:14.000000000 -0800
@@ -219,13 +219,15 @@ int ppa_detect(Scsi_Host_Template * host
 	    printk("  supported by the imm (ZIP Plus) driver. If the\n");
 	    printk("  cable is marked with \"AutoDetect\", this is what has\n");
 	    printk("  happened.\n");
-	    spin_lock_irq(hreg->host_lock);
+	    if (hreg)	/* This is silly */
+		spin_lock_irq(hreg->host_lock);
 	    return 0;
 	}
 	try_again = 1;
 	goto retry_entry;
     } else {
-	spin_lock_irq(hreg->host_lock);
+	if (hreg)	/* And this should be unnecessary */
+		spin_lock_irq(hreg->host_lock);
 	return 1;		/* return number of hosts detected */
     }
 }

_

