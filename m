Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbTDLVAw (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 17:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTDLVAw (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 17:00:52 -0400
Received: from [12.47.58.73] ([12.47.58.73]:104 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263399AbTDLVAv (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 17:00:51 -0400
Date: Sat, 12 Apr 2003 14:12:48 -0700
From: Andrew Morton <akpm@digeo.com>
To: Gert Vervoort <gert.vervoort@hccnet.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67: ppa driver & preempt == oops
Message-Id: <20030412141248.47a487b0.akpm@digeo.com>
In-Reply-To: <3E982AAC.3060606@hccnet.nl>
References: <3E982AAC.3060606@hccnet.nl>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2003 21:12:30.0173 (UTC) FILETIME=[3A23D8D0:01C30138]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gert Vervoort <gert.vervoort@hccnet.nl> wrote:
>
> ppa: Version 2.07 (for Linux 2.4.x)
> ppa: Found device at ID 6, Attempting to use EPP 16 bit
> ppa: Communication established with ID 6 using EPP 16 bit
> scsi0 : Iomega VPI0 (ppa) interface
> bad: scheduling while atomic!

This patch should make the warnings go away.

I've been sitting on it for a while, waiting for someone to tell me if the
ppa driver actually works.  Perhaps that person is you?


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

