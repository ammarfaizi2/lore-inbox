Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263601AbUEHLAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbUEHLAA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 07:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbUEHK77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 06:59:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:30084 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263601AbUEHK76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 06:59:58 -0400
Date: Sat, 8 May 2004 03:59:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how long does it take to init the scheduler?
Message-Id: <20040508035934.46101a9b.akpm@osdl.org>
In-Reply-To: <20040508105311.GA15577@suse.de>
References: <20040508105311.GA15577@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> wrote:
>
> 
> Hi,
> 
> the patch below looks wrong to me. Why did you move it to the very end
> of the boot process, instead to the very end of start_kernel()?
> 

coz I forgot about drivers which want to go opening files in their
module_init().

Like this?

--- 25/init/main.c~populate_rootfs-before-initcalls	2004-05-08 03:57:54.168918048 -0700
+++ 25-akpm/init/main.c	2004-05-08 03:58:58.668112680 -0700
@@ -660,9 +660,15 @@ static int init(void * unused)
 	fixup_cpu_present_map();
 	smp_init();
 	sched_init_smp();
-	do_basic_setup();
 
+	/*
+	 * Do this before initcalls, because some drivers want to access
+	 * firmware files.
+	 */
 	populate_rootfs();
+
+	do_basic_setup();
+
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work

_

