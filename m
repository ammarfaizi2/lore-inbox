Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbSLBWED>; Mon, 2 Dec 2002 17:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbSLBWED>; Mon, 2 Dec 2002 17:04:03 -0500
Received: from packet.digeo.com ([12.110.80.53]:46490 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265065AbSLBWEC>;
	Mon, 2 Dec 2002 17:04:02 -0500
Message-ID: <3DEBDA8D.CBB4B6D0@digeo.com>
Date: Mon, 02 Dec 2002 14:11:25 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecate use of bdflush()
References: <1038864066.1221.43.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Dec 2002 22:11:25.0034 (UTC) FILETIME=[C0F794A0:01C29A4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> We can never get rid of it if we do not deprecate it - so do so and
> print a stern warning to those who still run bdflush daemons.
> 

Ho-hum.  I was going to do this months ago but general exhaustion
and sluggishness won out.

We should tell the user which process called sys_bdflush() to aid
their expunging efforts.


--- 25/fs/buffer.c~deprecate-bdflush	Mon Dec  2 13:40:44 2002
+++ 25-akpm/fs/buffer.c	Mon Dec  2 13:45:11 2002
@@ -2755,11 +2755,25 @@ int block_sync_page(struct page *page)
 /*
  * There are no bdflush tunables left.  But distributions are
  * still running obsolete flush daemons, so we terminate them here.
+ *
+ * Use of bdflush() is deprecated and will be removed in a future kernel.
+ * The `pdflush' kernel threads fully replace bdflush daemons and this call.
  */
 asmlinkage long sys_bdflush(int func, long data)
 {
+	static int msg_count;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
+
+	if (msg_count < 5) {
+		msg_count++;
+		printk(KERN_INFO
+			"warning: process `%s' used the obsolete bdflush"
+			" system call\nFix your initscripts?\n",
+			current->comm);
+	}
+
 	if (func == 1)
 		do_exit(0);
 	return 0;

_
