Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUGNRj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUGNRj4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 13:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265106AbUGNRj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 13:39:56 -0400
Received: from moutng.kundenserver.de ([212.227.126.191]:39164 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265099AbUGNRjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 13:39:54 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] was: [RFC] removal of sync in panic
Date: Wed, 14 Jul 2004 19:39:52 +0200
User-Agent: KMail/1.6.2
Cc: Lars Marowsky-Bree <lmb@suse.de>, Andrew Morton <akpm@osdl.org>
References: <200407141745.47107.linux-kernel@borntraeger.net> <20040714162357.GU3922@marowsky-bree.de>
In-Reply-To: <20040714162357.GU3922@marowsky-bree.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407141939.52316.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree wrote:
> > 1. remove sys_sync completely: syslogd and klogd use fsync. No need to
> > help them. Furthermore we have a severe problem which is worth a panic,
> > so we better dont do any I/O.

> I've seen exactly the behaviour you describe and would be inclined to go
> for this option too.

As this problem definitely exists, here is a patch. 

--- linux-2.6.8-rc1/kernel/panic.c      2004-06-16 07:20:04.000000000 +0200
+++ linux-patch/kernel/panic.c  2004-07-14 19:37:02.000000000 +0200
@@ -59,13 +59,7 @@ NORET_TYPE void panic(const char * fmt,
        va_start(args, fmt);
        vsnprintf(buf, sizeof(buf), fmt, args);
        va_end(args);
-       printk(KERN_EMERG "Kernel panic: %s\n",buf);
-       if (in_interrupt())
-               printk(KERN_EMERG "In interrupt handler - not syncing\n");
-       else if (!current->pid)
-               printk(KERN_EMERG "In idle task - not syncing\n");
-       else
-               sys_sync();
+       printk(KERN_EMERG "Kernel panic - not syncing: %s\n",buf);
        bust_spinlocks(0);

 #ifdef CONFIG_SMP


