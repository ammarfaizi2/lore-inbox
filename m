Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVF2Qqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVF2Qqv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVF2Qoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:44:44 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:35083 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262609AbVF2Qk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:40:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=AzLbtWhkSw1PfJSylZC1JC6WYB/nshFig4yWsKN5xMZUk5LS/PnPYhE+tQmUwGeHwqviQHRGkCXJk8Sf4VPsrKQUaGNBkVURspoyqHZXtLhymLB57tl4VwPVXNN7oERutGSwr964zyIOjoIkAEVuGvg4Y7HjRknk3kQ5hcp/aMY=
Message-ID: <42C2BD26.7090209@gmail.com>
Date: Wed, 29 Jun 2005 15:24:22 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: prasanna@in.ibm.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Kprobes: Verify probepoint in register_jprobe()
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, built against version 2.6.12, checks if probepoint address is a
function entry point using an offset value, obtained from kallsyms_lookup().
If offset is zero, we register jprobe, otherwise we return -EINVAL.


Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>

--- ./kernel/kprobes.c.orig	2005-06-29 00:17:43.000000000 +0000
+++ ./kernel/kprobes.c	2005-06-29 11:08:02.000000000 +0000
@@ -33,6 +33,7 @@
 #include <linux/hash.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/kallsyms.h>
 #include <asm/cacheflush.h>
 #include <asm/errno.h>
 #include <asm/kdebug.h>
@@ -245,7 +246,15 @@ static struct notifier_block kprobe_exce

 int register_jprobe(struct jprobe *jp)
 {
-	/* Todo: Verify probepoint is a function entry point */
+	unsigned long size, offset;
+	char *modname, namebuf[KSYM_NAME_LEN+1];
+	
+	kallsyms_lookup((unsigned long)jp->kp.addr, &size,
+			&offset, &modname, namebuf);
+	
+	if(unlikely(offset))
+		return -EINVAL;
+	
 	jp->kp.pre_handler = setjmp_pre_handler;
 	jp->kp.break_handler = longjmp_break_handler;


Regards,
-- 
					Luca




