Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWIJNgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWIJNgV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWIJNgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:36:21 -0400
Received: from ns.oss.ntt.co.jp ([222.151.198.98]:47565 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP id S932156AbWIJNgT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:36:19 -0400
Message-ID: <40243.58.158.20.108.1157895371.squirrel@serv1.oss.ntt.co.jp>
In-Reply-To: <20060907135329.GA17937@in.ibm.com>
References: <20060907135329.GA17937@in.ibm.com>
Date: Sun, 10 Sep 2006 22:36:11 +0900 (JST)
Subject: Re: [RFC] Linux Kernel Dump Test Module
From: fernando@oss.ntt.co.jp
To: ankita@in.ibm.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, fernando@oss.ntt.co.jp,
       maneesh@in.ibm.com
User-Agent: SquirrelMail/1.4.6-7.el4
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-2022-jp
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ankita,

Thank you for your great job porting LKDTT to kprobes!

I still could not review your code carefully but I will as soon as I get
back to office (I am attending the 2nd OSDL Japan Linux Symposium this
week so I will be absent until Wednesday).

I am looking forward to testing your patches.

Best regards,

Fernando

Ankita Garg wrote:
> Hi,
>
> Please find below a patch for a simple module to test Linux Kernel Dump
> mechanism. This module uses jprobes to install/activate pre-defined crash
> points. At different crash points, various types of crashing scenarios
> are created like a BUG(), panic(), exception, recursive loop and stack
> overflow. The user can activate a crash point with specific type by
> providing parameters at the time of module insertion. Please see the file
> header for usage information. The module is based on the Linux Kernel
> Dump Test Tool by Fernando <http://lkdtt.sourceforge.net>.
>
> This module could be merged with mainline. Jprobes is used here so that
> the
> context in which crash point is hit, could be maintained. This implements
> all the crash points as done by LKDTT except the one in the middle of
> tasklet_action().
>
>
> Please review and comment.
>
> Thanks
> Ankita
>
>
> o This patch implements the Linux Kernel Dump Test Module, to test Linux
>   kernel crashdumping mechanisms. The detailed usage information is in
>   drivers/misc/lkdtm.c
>
>
> Signed-off-by: Ankita Garg <ankita@in.ibm.com>
> --
>  drivers/misc/Makefile |    1
>  drivers/misc/lkdtm.c  |  334
> ++++++++++++++++++++++++++++++++++++++++++++++++++ lib/Kconfig.debug
> |   14 ++
>  3 files changed, 349 insertions(+)
>
> Index: linux-2.6.18-rc5/lib/Kconfig.debug
> ===================================================================
> --- linux-2.6.18-rc5.orig/lib/Kconfig.debug2006-09-07 10:32:15.000000000
> +0530
> +++ linux-2.6.18-rc5/lib/Kconfig.debug2006-09-07 10:52:22.000000000 +0530
> @@ -429,3 +429,17 @@
>    at boot time (you probably don't).
>    Say M if you want the RCU torture tests to build as a module.
>    Say N if you are unsure.
> +
> +config LKDTM
> +tristate "Linux Kernel Dump Test Tool Module"
> +depends on KPROBES
> +default n
> +help
> +This module enables testing of the different dumping mechanisms by
> +inducing system failures at predefined crash points.
> +If you don't need it: say N
> +Choose M here to compile this code as a module. The module will be
> +called lkdtm.
> +
> +Documentation on how to use the module can be found in
> +drivers/misc/lkdtm.c
> Index: linux-2.6.18-rc5/drivers/misc/Makefile
> ===================================================================
> --- linux-2.6.18-rc5.orig/drivers/misc/Makefile2006-08-28
> 09:11:48.000000000 +0530
> +++ linux-2.6.18-rc5/drivers/misc/Makefile2006-09-07 10:43:41.000000000
> +0530
> @@ -5,3 +5,4 @@
>
>  obj-$(CONFIG_IBM_ASM)+= ibmasm/
>  obj-$(CONFIG_HDPU_FEATURES)+= hdpuftrs/
> +obj-$(CONFIG_LKDTM)+= lkdtm.o
> Index: linux-2.6.18-rc5/drivers/misc/lkdtm.c
> ===================================================================
> --- /dev/null1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.18-rc5/drivers/misc/lkdtm.c2006-09-07 10:48:52.000000000
> +0530
> @@ -0,0 +1,334 @@
> +/*
> + * Kprobe module for testing crash dumps
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
> USA.
> + *
> + * Copyright (C) IBM Corporation, 2006
> + *
> + * Author: Ankita Garg <ankita@in.ibm.com>
> + *
> + * This module induces system failures at predefined crashpoints to
> + * evaluate the reliability of crash dumps obtained using different
> dumping
> + * solutions.
> + *
> + * It is adapted from the Linux Kernel Dump Test Tool by
> + * Fernando Luis Vazquez Cao <http://lkdtt.sourceforge.net>
> + *
> + * Usage :  insmod lkdtm.ko [recur_count={>0}] cpoint_name=<>
> cpoint_type=<>
> + *[cpoint_count={>0}]
> + *
> + * recur_count : Recursion level for the stack overflow test. Default is
> 10.
> + *
> + * cpoint_name : Crash point where the kernel is to be crashed. It can be
> + * one of INT_HARDWARE_ENTRY, INT_HW_IRQ_EN, INT_TASKLET_ENTRY,
> + * FS_DEVRW, MEM_SWAPOUT, TIMERADD, SCSI_DISPATCH_CMD,
> + * IDE_CORE_CP
> + *
> + * cpoint_type : Indicates the action to be taken on hitting the crash
> point.
> + * It can be one of PANIC, BUG, EXCEPTION, LOOP, OVERFLOW
> + *
> + * cpoint_count : Indicates the number of times the crash point is to be
> hit
> + *  to trigger an action. The default is 10.
> + */
> +
> +#include<linux/kernel.h>
> +#include<linux/module.h>
> +#include<linux/kprobes.h>
> +#include<linux/kallsyms.h>
> +#include<linux/init.h>
> +#include<linux/irq.h>
> +#include<linux/ide.h>
> +#include<linux/interrupt.h>
> +#include<scsi/scsi_cmnd.h>
> +
> +#define NUM_CPOINTS 8
> +#define NUM_CPOINT_TYPES 5
> +#define DEFAULT_COUNT 10
> +#define REC_NUM_DEFAULT 10
> +
> +enum cname {
> +INVALID,
> +INT_HARDWARE_ENTRY,
> +INT_HW_IRQ_EN,
> +INT_TASKLET_ENTRY,
> +FS_DEVRW,
> +MEM_SWAPOUT,
> +TIMERADD,
> +SCSI_DISPATCH_CMD,
> +IDE_CORE_CP
> +};
> +
> +enum ctype {
> +NONE,
> +PANIC,
> +BUG,
> +EXCEPTION,
> +LOOP,
> +OVERFLOW
> +};
> +
> +static char* cp_name[] = {
> +"INT_HARDWARE_ENTRY",
> +"INT_HW_IRQ_EN",
> +"INT_TASKLET_ENTRY",
> +"FS_DEVRW",
> +"MEM_SWAPOUT",
> +"TIMERADD",
> +"SCSI_DISPATCH_CMD",
> +"IDE_CORE_CP"
> +};
> +
> +static char* cp_type[] = {
> +"PANIC",
> +"BUG",
> +"EXCEPTION",
> +"LOOP",
> +"OVERFLOW"
> +};
> +
> +static struct jprobe lkdtm;
> +
> +static int lkdtm_parse_commandline(void);
> +static void lkdtm_handler(void);
> +
> +static char* cpoint_name = INVALID;
> +static char* cpoint_type = NONE;
> +static int cpoint_count = DEFAULT_COUNT;
> +static int recur_count = REC_NUM_DEFAULT;
> +
> +static enum cname cpoint = INVALID;
> +static enum ctype cptype = NONE;
> +static int count = DEFAULT_COUNT;
> +
> +module_param(recur_count, int, 0644);
> +MODULE_PARM_DESC(recur_count, "Recurcion level for the stack overflow
> test,\
> + default is 10");
> +module_param(cpoint_name, charp, 0644);
> +MODULE_PARM_DESC(cpoint_name, "Crash Point, where kernel is to be
> crashed");
> +module_param(cpoint_type, charp, 06444);
> +MODULE_PARM_DESC(cpoint_type, "Crash Point Type, action to be taken on\
> +hitting the crash point");
> +module_param(cpoint_count, int, 06444);
> +MODULE_PARM_DESC(cpoint_count, "Crash Point Count, number of times the \
> +crash point is to be hit to trigger action");
> +
> +unsigned int jp_do_irq(unsigned int irq, struct pt_regs *regs)
> +{
> +lkdtm_handler();
> +jprobe_return();
> +return 0;
> +}
> +
> +irqreturn_t jp_handle_irq_event(unsigned int irq, struct pt_regs *regs,
> +struct irqaction *action)
> +{
> +lkdtm_handler();
> +jprobe_return();
> +return 0;
> +}
> +
> +void jp_tasklet_action(struct softirq_action *a)
> +{
> +lkdtm_handler();
> +jprobe_return();
> +}
> +
> +void jp_ll_rw_block(int rw, int nr, struct buffer_head *bhs[])
> +{
> +lkdtm_handler();
> +jprobe_return();
> +}
> +
> +struct scan_control;
> +
> +unsigned long jp_shrink_page_list(struct list_head *page_list,
> +                                        struct scan_control *sc)
> +{
> +lkdtm_handler();
> +jprobe_return();
> +return 0;
> +}
> +
> +int jp_hrtimer_start(struct hrtimer *timer, ktime_t tim,
> +const enum hrtimer_mode mode)
> +{
> +lkdtm_handler();
> +jprobe_return();
> +return 0;
> +}
> +
> +int jp_scsi_dispatch_cmd(struct scsi_cmnd *cmd)
> +{
> +lkdtm_handler();
> +jprobe_return();
> +return 0;
> +}
> +
> +int jp_generic_ide_ioctl(ide_drive_t *drive, struct file *file,
> +struct block_device *bdev, unsigned int cmd,
> +unsigned long arg)
> +{
> +lkdtm_handler();
> +jprobe_return();
> +return 0;
> +}
> +
> +
> +static int lkdtm_parse_commandline(void)
> +{
> +int i;
> +
> +if (cpoint_name == INVALID || cpoint_type == NONE ||
> +cpoint_count < 1 || recur_count < 1)
> +return -EINVAL;
> +
> +for (i = 0; i < NUM_CPOINTS; ++i) {
> +if (!strcmp(cpoint_name, cp_name[i])) {
> +cpoint = i + 1;
> +break;
> +}
> +}
> +
> +for (i = 0; i < NUM_CPOINT_TYPES; ++i) {
> +if (!strcmp(cpoint_type, cp_type[i])) {
> +cptype = i + 1;
> +break;
> +}
> +}
> +
> +if (cpoint == INVALID || cptype == NONE)
> +                return -EINVAL;
> +
> +count = cpoint_count;
> +
> +return 0;
> +}
> +
> +static int recursive_loop(int a)
> +{
> +char buf[1024];
> +
> +memset(buf,0xFF,1024);
> +recur_count--;
> +if (!recur_count)
> +return 0;
> +else
> +        return recursive_loop(a);
> +}
> +
> +void lkdtm_handler(void)
> +{
> +printk(KERN_INFO "lkdtm : Crash point %s of type %s hit\n",
> + cpoint_name, cpoint_type);
> +--count;
> +
> +if (count == 0) {
> +switch (cptype) {
> +case NONE:
> +break;
> +case PANIC:
> +printk(KERN_INFO "lkdtm : PANIC\n");
> +panic("dumptest");
> +break;
> +case BUG:
> +printk(KERN_INFO "lkdtm : BUG\n");
> +BUG();
> +break;
> +case EXCEPTION:
> +printk(KERN_INFO "lkdtm : EXCEPTION\n");
> +*((int *) 0) = 0;
> +break;
> +case LOOP:
> +printk(KERN_INFO "lkdtm : LOOP\n");
> +for (;;);
> +break;
> +case OVERFLOW:
> +printk(KERN_INFO "lkdtm : OVERFLOW\n");
> +(void) recursive_loop(0);
> +break;
> +default:
> +break;
> +}
> +count = cpoint_count;
> +}
> +}
> +
> +int lkdtm_module_init(void)
> +{
> +int ret;
> +
> +if (lkdtm_parse_commandline() == -EINVAL) {
> +printk(KERN_INFO "lkdtm : Invalid command\n");
> +return -EINVAL;
> +}
> +
> +switch (cpoint) {
> +case INT_HARDWARE_ENTRY:
> +lkdtm.kp.symbol_name = "__do_IRQ";
> +lkdtm.entry = (kprobe_opcode_t*) jp_do_irq;
> +break;
> +case INT_HW_IRQ_EN:
> +lkdtm.kp.symbol_name = "handle_IRQ_event";
> +lkdtm.entry = (kprobe_opcode_t*) jp_handle_irq_event;
> +break;
> +case INT_TASKLET_ENTRY:
> +lkdtm.kp.symbol_name = "tasklet_action";
> +lkdtm.entry = (kprobe_opcode_t*) jp_tasklet_action;
> +break;
> +case FS_DEVRW:
> +lkdtm.kp.symbol_name = "ll_rw_block";
> +lkdtm.entry = (kprobe_opcode_t*) jp_ll_rw_block;
> +break;
> +case MEM_SWAPOUT:
> +lkdtm.kp.symbol_name = "shrink_page_list";
> +lkdtm.entry = (kprobe_opcode_t*) jp_shrink_page_list;
> +break;
> +case TIMERADD:
> +lkdtm.kp.symbol_name = "hrtimer_start";
> +lkdtm.entry = (kprobe_opcode_t*) jp_hrtimer_start;
> +break;
> +case SCSI_DISPATCH_CMD:
> +lkdtm.kp.symbol_name = "scsi_dispatch_cmd";
> +lkdtm.entry = (kprobe_opcode_t*) jp_scsi_dispatch_cmd;
> +break;
> +case IDE_CORE_CP:
> +lkdtm.kp.symbol_name = "generic_ide_ioctl";
> +lkdtm.entry = (kprobe_opcode_t*) jp_generic_ide_ioctl;
> +break;
> +default:
> +printk(KERN_INFO "lkdtm : Invalid Crash Point\n");
> +break;
> +}
> +
> +if ( (ret = register_jprobe(&lkdtm)) < 0) {
> +                printk(KERN_INFO "lkdtm : Couldn't register jprobe\n");
> +                return ret;
> +}
> +
> +printk(KERN_INFO "lkdtm : Crash point %s of type %s registered\n",
> +cpoint_name, cpoint_type);
> +return 0;
> +}
> +
> +void lkdtm_module_exit(void)
> +{
> +        unregister_jprobe(&lkdtm);
> +        printk(KERN_INFO "lkdtm : Crash point unregistered\n");
> +}
> +
> +module_init(lkdtm_module_init);
> +module_exit(lkdtm_module_exit);
> +
> +MODULE_LICENSE("GPL");
>


