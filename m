Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWHGPPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWHGPPh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWHGPPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:15:37 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:34021
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932139AbWHGPPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:15:36 -0400
Date: Mon, 7 Aug 2006 16:12:16 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Keen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64 dirty fix to restore dual command line store
Message-ID: <20060807151216.GA15194@shadowen.org>
References: <44D75691.8070908@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <44D75691.8070908@shadowen.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 dirty fix to restore dual command line store

Ok, It seems that the patch below effectivly removes the second
copy of the command line.  This means that any modification to the
'working' command line (as returned from setup_arch) is incorrectly
visible in userspace via /proc/cmdline.

	x86_64-mm-early-param.patch

This patch restores the second copy.  Its probabally not the right
way to fix this long term.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff -upN reference/arch/x86_64/kernel/setup.c current/arch/x86_64/kernel/setup.c
--- reference/arch/x86_64/kernel/setup.c
+++ current/arch/x86_64/kernel/setup.c
@@ -378,7 +378,8 @@ void __init setup_arch(char **cmdline_p)
 	early_identify_cpu(&boot_cpu_data);
 
 	parse_early_param();
-	*cmdline_p = saved_command_line;
+	memcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	*cmdline_p = command_line;
 
 	finish_e820_parsing();
 
