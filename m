Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319272AbSIKSkY>; Wed, 11 Sep 2002 14:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319273AbSIKSkY>; Wed, 11 Sep 2002 14:40:24 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:48133 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319272AbSIKSkX>; Wed, 11 Sep 2002 14:40:23 -0400
Date: Wed, 11 Sep 2002 19:44:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
Message-ID: <20020911194447.A7073@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christian Guggenberger <christian.guggenberger@physik.uni-regensburg.de>,
	linux-kernel@vger.kernel.org, andrea@suse.de, linux-xfs@oss.sgi.com
References: <20020911201602.A13655@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020911201602.A13655@pc9391.uni-regensburg.de>; from christian.guggenberger@physik.uni-regensburg.de on Wed, Sep 11, 2002 at 08:16:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 08:16:02PM +0200, Christian Guggenberger wrote:
> Hi!
> 
> just tried out 2.4.20-pre5aa2 with xfs enabled as module. But I can't load 
> the xfs Module...
> modprobe xfs just won't work. Via top on another console I see two modpobe 
> processes, each consuming 99.9% CPU time. Then, after a minute or so, the 
> machine reboots...
> 
> System is a Dell Precision with 2 Intel Xeons@2.2GHz and 2GB RDRAM and 
> hyper-threading enabled, OS is Debian/GNU Linux 3.0 with:
> 
> gcc-2.95.4 20011002 (Debian prerelease)
> ld-2.12.90.0.1 20020307 Debian/GNU Linux
> 
> 
> I tried to disable HT, but then it was even worse. Then my machine crashed 
> hard after starting "modprobe xfs".

Could you please try the following patch from Andrea?

--- 2.4.20pre5aa3/fs/xfs/pagebuf/page_buf.c.~1~	Wed Sep 11 05:17:46 2002
+++ 2.4.20pre5aa3/fs/xfs/pagebuf/page_buf.c	Wed Sep 11 06:00:35 2002
@@ -2055,9 +2055,9 @@ pagebuf_iodone_daemon(
 	spin_unlock_irq(&current->sigmask_lock);
 
 	/* Migrate to the right CPU */
-	current->cpus_allowed = 1UL << cpu;
-	while (smp_processor_id() != cpu)
-		schedule();
+	set_cpus_allowed(current, 1UL << cpu);
+	if (cpu() != cpu)
+		BUG();
 
 	sprintf(current->comm, "pagebuf_io_CPU%d", bind_cpu);
 	INIT_LIST_HEAD(&pagebuf_iodone_tq[cpu]);

