Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWGKU1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWGKU1A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWGKU1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:27:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37394 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751296AbWGKU07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:26:59 -0400
Date: Tue, 11 Jul 2006 21:26:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: [PATCH] Fix broken kernel headers preventing ARM build
Message-ID: <20060711202652.GD3677@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>, Adrian Bunk <bunk@stusta.de>
References: <20060711160639.GY13938@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711160639.GY13938@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And this can be the first of the series.  Note that this is NOT a
cleanup, but a build fix, so _is_ immediate -rc1 material.
-----

As a result of 894673ee6122a3ce1958e1fe096901ba5356a96b, the ARM
architecture is more or less unbuildable - only one defconfig appears
to build, with all others erroring out with:

  CC      arch/arm/kernel/setup.o
In file included from /home/rmk/git/linux-2.6-rmk/arch/arm/kernel/setup.c:22:
/home/rmk/git/linux-2.6-rmk/include/linux/root_dev.h:7: warning: implicit declaration of function `MKDEV'
/home/rmk/git/linux-2.6-rmk/include/linux/root_dev.h:7: error: enumerator value for `Root_NFS' not integer constant
/home/rmk/git/linux-2.6-rmk/include/linux/root_dev.h:8: error: enumerator value for `Root_RAM0' not integer constant
/home/rmk/git/linux-2.6-rmk/include/linux/root_dev.h:9: error: enumerator value for `Root_RAM1' not integer constant
/home/rmk/git/linux-2.6-rmk/include/linux/root_dev.h:10: error: enumerator value for `Root_FD0' not integer constant
/home/rmk/git/linux-2.6-rmk/include/linux/root_dev.h:11: error: enumerator value for `Root_HDA1' not integer constant
/home/rmk/git/linux-2.6-rmk/include/linux/root_dev.h:12: error: enumerator value for `Root_HDA2' not integer constant
/home/rmk/git/linux-2.6-rmk/include/linux/root_dev.h:13: error: enumerator value for `Root_SDA1' not integer constant
/home/rmk/git/linux-2.6-rmk/include/linux/root_dev.h:14: error: enumerator value for `Root_SDA2' not integer constant
/home/rmk/git/linux-2.6-rmk/include/linux/root_dev.h:15: error: enumerator value for `Root_HDC1' not integer constant
/home/rmk/git/linux-2.6-rmk/include/linux/root_dev.h:16: error: enumerator value for `Root_SR0' not integer constant
make[2]: *** [arch/arm/kernel/setup.o] Error 1
make[1]: *** [arch/arm/kernel] Error 2
make: *** [_all] Error 2

Essentially, root_dev.h uses MKDEV and dev_t, but does not include any
headers which provide either of these definitions.  The reason it worked
previously is that linux/tty.h just happened to include the required
headers for linux/root_dev.h.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---

 include/linux/root_dev.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/root_dev.h b/include/linux/root_dev.h
index ea4bc9d..ed241aa 100644
--- a/include/linux/root_dev.h
+++ b/include/linux/root_dev.h
@@ -2,6 +2,8 @@ #ifndef _ROOT_DEV_H_
 #define _ROOT_DEV_H_
 
 #include <linux/major.h>
+#include <linux/types.h>
+#include <linux/kdev_t.h>
 
 enum {
 	Root_NFS = MKDEV(UNNAMED_MAJOR, 255),


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
