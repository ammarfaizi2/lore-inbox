Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUIDRzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUIDRzE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUIDRxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:53:38 -0400
Received: from ozlabs.org ([203.10.76.45]:31427 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265106AbUIDRvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:51:31 -0400
Date: Sun, 5 Sep 2004 03:46:42 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: levon@movementarian.org, phil.el@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: [PATCH] fix oprofile vfree warning on error
Message-ID: <20040904174642.GD7716@krispykreme>
References: <20040904174403.GC7716@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040904174403.GC7716@krispykreme>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On error we can call __free_cpu_buffers with only some buffers
allocated. I was getting a bunch of vfree warnings when I hit it, we
should check before calling vfree.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN drivers/oprofile/cpu_buffer.c~oprofile_vfree_fix drivers/oprofile/cpu_buffer.c
--- linux-2.5/drivers/oprofile/cpu_buffer.c~oprofile_vfree_fix	2004-09-05 02:37:38.223212931 +1000
+++ linux-2.5-anton/drivers/oprofile/cpu_buffer.c	2004-09-05 02:37:43.608142109 +1000
@@ -36,8 +36,10 @@ static void __free_cpu_buffers(int num)
 {
 	int i;
  
-	for_each_online_cpu(i)
-		vfree(cpu_buffer[i].buffer);
+	for_each_online_cpu(i) {
+		if (cpu_buffer[i].buffer)
+			vfree(cpu_buffer[i].buffer);
+	}
 }
  
  

_
