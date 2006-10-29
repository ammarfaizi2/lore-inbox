Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbWJ2X7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbWJ2X7p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 18:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbWJ2X7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 18:59:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:51248 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030460AbWJ2X7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 18:59:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=omqtuPcZ7Mz9HyHPhRPmGniZhKa3qQSs4GRQbfCaArn6OPE7trdWYqoKeBWm6qI0L45o39XFeUHswHGvFQnrzvfBubWvraKDi7CuJg7NHv4xPBtuUfB/xAjGEtKcfM2rvtb0DTlWDTkzG6d52bcP3Ucu4hGnOC6EqXHT40JwCn8=
Date: Mon, 30 Oct 2006 01:58:04 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Compile-time check re world-writeable module params
Message-ID: <20061029225804.GB9197@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of mistakes module_param() user can make is to supply default value
of module parameter as the last argument. module_param() accepts
permissions instead. If default value is, say, 3 (-------wx), parameter
becomes world-writeable.

So far, the only remedy was to apply grep(1) and read drivers submitted
to -mm. BTDT.

With this patch applied, compiler will finally do some job.

*) bounds checking on permissions
*) world-writeable bit checking on permissions
*) compile breakage if checks trigger

First version of this check (only "& 2" part) directly caught 4 out of 7
places during my last grep.

    Subject: Neverending module_param() bugs
    [X] drivers/acpi/sbs.c:101:module_param(capacity_mode, int, CAPACITY_UNIT);
    [X] drivers/acpi/sbs.c:102:module_param(update_mode, int, UPDATE_MODE);
    [ ] drivers/acpi/sbs.c:103:module_param(update_info_mode, int, UPDATE_INFO_MODE);
    [ ] drivers/acpi/sbs.c:104:module_param(update_time, int, UPDATE_TIME);
    [ ] drivers/acpi/sbs.c:105:module_param(update_time2, int, UPDATE_TIME2);
    [X] drivers/char/watchdog/sbc8360.c:203:module_param(timeout, int, 27);
    [X] drivers/media/video/tuner-simple.c:13:module_param(offset, int, 0666);

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/moduleparam.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -63,6 +63,9 @@ struct kparam_array
    not there, read bits mean it's readable, write bits mean it's
    writable. */
 #define __module_param_call(prefix, name, set, get, arg, perm)		\
+	/* Default value instead of permissions? */			\
+	static int __param_perm_check_##name __attribute__((unused)) =	\
+	BUILD_BUG_ON_ZERO((perm) < 0 || (perm) > 0777 || ((perm) & 2));	\
 	static char __param_str_##name[] = prefix #name;		\
 	static struct kernel_param const __param_##name			\
 	__attribute_used__						\

