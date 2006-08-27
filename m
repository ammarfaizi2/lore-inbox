Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWH0Pcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWH0Pcn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 11:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWH0Pcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 11:32:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:33563 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750907AbWH0Pcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 11:32:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=oybyE6vPOJKCycwoh/bAg8nlYBdlnslR3kKlDeuoBKAdGOA7dTQN8N7b6UebXE8ZFEkqqnRY/wN4NVnorB3NlQ2EcjUXckgr6UMlLk6ZNRYK+Yz5JHMAqy1BLvOkvOuDzK4RlEW4lr+Tg1VKzWD56xLTXwjVJc1kRGgwXg9/QYg=
Date: Sun, 27 Aug 2006 19:32:34 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFT] sched.h removal from module.h
Message-ID: <20060827153234.GA31505@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have compile-kernel-in-a-minute box, so

Please, test on your usual configs and send me _new_ warnings and errors
that appeared.

Patch seems to pass [alpha, i386, x86_64] x [allmodconfig-SMP, -UP] without
regressions.

[PATCH] sched.h removal from module.h

This is done by duplicating prototype of wake_up_process() which seems
to be the only thing module.h wants.

Some modules doesn't really want more than
module_init/module_exit/MODULE_LICENSE so dragging 43 headers from sched.h
mostly slows down compilation.

Examples:

$ wc lib/sort.i
 10933  31212 287154 lib/sort.i
  7919  21084 198611 lib/sort.i	# after removal
  ------------------
                -31%

$ wc lib/idr.i
 11299  32412 298627 lib/idr.i
  8269  22287 210083 lib/idr.i	# after removal
  ------------------
                -30%

Note that, say, PCI drivers shouldn't shrink much due to linux/pci.h
including asm/pci.h including linux/mm.h including, you guessed it right,
sched.h. That's for later.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/base/cpu.c                |    1 +
 drivers/hwmon/abituguru.c         |    1 +
 drivers/leds/ledtrig-ide-disk.c   |    1 +
 drivers/leds/ledtrig-timer.c      |    1 +
 drivers/scsi/scsi_transport_sas.c |    2 ++
 drivers/w1/slaves/w1_therm.c      |    1 +
 include/linux/acct.h              |    1 +
 include/linux/module.h            |    3 ++-
 include/linux/phy.h               |    1 +
 include/scsi/libiscsi.h           |    1 +
 10 files changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -9,6 +9,7 @@ #include <linux/cpu.h>
 #include <linux/topology.h>
 #include <linux/device.h>
 #include <linux/node.h>
+#include <linux/sched.h>
 
 #include "base.h"
 
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -21,6 +21,7 @@
     etc voltage & frequency control is not supported!
 */
 #include <linux/module.h>
+#include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
--- a/drivers/leds/ledtrig-ide-disk.c
+++ b/drivers/leds/ledtrig-ide-disk.c
@@ -15,6 +15,7 @@ #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/timer.h>
+#include <linux/jiffies.h>
 #include <linux/leds.h>
 
 static void ledtrig_ide_timerfunc(unsigned long data);
--- a/drivers/leds/ledtrig-timer.c
+++ b/drivers/leds/ledtrig-timer.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -29,6 +29,8 @@ #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
+#include <asm/param.h>
+
 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -25,6 +25,7 @@ #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/device.h>
+#include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/delay.h>
 
--- a/include/linux/acct.h
+++ b/include/linux/acct.h
@@ -119,6 +119,7 @@ #ifdef __KERNEL__
 #ifdef CONFIG_BSD_PROCESS_ACCT
 struct vfsmount;
 struct super_block;
+struct pacct_struct;
 extern void acct_auto_close_mnt(struct vfsmount *m);
 extern void acct_auto_close(struct super_block *sb);
 extern void acct_init_pacct(struct pacct_struct *pacct);
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -6,7 +6,6 @@ #define _LINUX_MODULE_H
  * Rewritten by Richard Henderson <rth@tamu.edu> Dec 1996
  * Rewritten again by Rusty Russell, 2002
  */
-#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/stat.h>
@@ -406,6 +405,8 @@ static inline int try_module_get(struct 
 	return ret;
 }
 
+/* Prototype duplicated only to not include sched.h */
+int FASTCALL(wake_up_process(struct task_struct * tsk));
 static inline void module_put(struct module *module)
 {
 	if (module) {
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -20,6 +20,7 @@ #define __PHY_H
 
 #include <linux/spinlock.h>
 #include <linux/device.h>
+#include <linux/workqueue.h>
 
 #define PHY_BASIC_FEATURES	(SUPPORTED_10baseT_Half | \
 				 SUPPORTED_10baseT_Full | \
--- a/include/scsi/libiscsi.h
+++ b/include/scsi/libiscsi.h
@@ -25,6 +25,7 @@ #define LIBISCSI_H
 
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/workqueue.h>
 #include <scsi/iscsi_proto.h>
 #include <scsi/iscsi_if.h>
 

