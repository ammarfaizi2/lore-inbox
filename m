Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUAUBdt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 20:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUAUBdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 20:33:49 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:51719 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S261188AbUAUBdq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 20:33:46 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.4.25pre6 and qlogic pcmcia driver
Date: Wed, 21 Jan 2004 02:32:43 +0100
User-Agent: KMail/1.5.94
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, andersen@codepoet.org
References: <200401180355.01190.arekm@pld-linux.org> <Pine.LNX.4.58L.0401201400490.14726@logos.cnet> <20040120101121.5ce95f97.rddunlap@osdl.org>
In-Reply-To: <20040120101121.5ce95f97.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401210232.44118.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia wto 20. stycznia 2004 19:11, Randy.Dunlap napisa³:
> On Tue, 20 Jan 2004 14:01:54 -0200 (BRST) Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> | Same here, 2.4.24 does not show this behaviour.
> |
> | I can't find the guilty modification in 2.4.25-pre.
>
> Same problem with aha152x pcmcia being built as a module.
>
> I also don't see any changes that would be causing this...
>
> It's clear that this problem should be detected, since
> scsi/qlogicfas.c and scsi/pcmcia/qlogic_stub.c both
> #include <linux/init.h>, so both of them define the module
> init and cleanup functions.  I don't see how this worked
> in the past, unless it was due to some tools that missed
> detecting the duplicated functions.
This change causes whole problem:

diff -Naur -p -X /home/marcelo/lib/dontdiff linux-2.4.24/include/linux/spinlock.h linux-2.4.25-pre6/include/linux/spinlock.h
--- linux-2.4.24/include/linux/spinlock.h       2002-11-28 23:53:15.000000000 +0000
+++ linux-2.4.25-pre6/include/linux/spinlock.h  2004-01-16 12:20:45.000000000 +0000
@@ -3,6 +3,8 @@

 #include <linux/config.h>

+#include <asm/system.h>
+
 /*
  * These are the generic versions of the spinlocks and read-write
  * locks..

The difference between 2.4.23 after preprocessing is: 
static Scsi_Host_Template driver_template = { detect: qlogicfas_detect, release: qlogicfas_release, info: qlogicfas_info, co
mmand: qlogicfas_command, queuecommand: qlogicfas_queuecommand, abort: qlogicfas_abort, reset: qlogicfas_reset, bios_param:
qlogicfas_biosparam, can_queue: 0, this_id: -1, sg_tablesize: 0xff, cmd_per_lun: 1, use_clustering: 0 };
# 1 "scsi_module.c" 1
# 35 "scsi_module.c"
static int __attribute__ ((__section__ (".text.init"))) init_this_scsi_driver(void)
{
        driver_template.module = (&__this_module);
        scsi_register_module(1, &driver_template);
        if (driver_template.present)
                return 0;

        scsi_unregister_module(1, &driver_template);
        return -19;
}

static void __attribute__ ((unused, __section__(".text.exit"))) exit_this_scsi_driver(void)
{
        scsi_unregister_module(1, &driver_template);
}

static initcall_t __initcall_init_this_scsi_driver __attribute__ ((unused,__section__ (".initcall.init"))) = init_this_scsi_
driver;;
static exitcall_t __exitcall_exit_this_scsi_driver __attribute__ ((unused,__section__ (".exitcall.exit"))) = exit_this_scsi_
driver;;

and on 2.4.25pre6:
static Scsi_Host_Template driver_template = { detect: qlogicfas_detect, release: qlogicfas_release, info: qlogicfas_info, co
mmand: qlogicfas_command, queuecommand: qlogicfas_queuecommand, abort: qlogicfas_abort, reset: qlogicfas_reset, bios_param:
qlogicfas_biosparam, can_queue: 0, this_id: -1, sg_tablesize: 0xff, cmd_per_lun: 1, use_clustering: 0 };
# 1 "scsi_module.c" 1
# 35 "scsi_module.c"
static int init_this_scsi_driver(void)
{
        driver_template.module = (&__this_module);
        scsi_register_module(1, &driver_template);
        if (driver_template.present)
                return 0;

        scsi_unregister_module(1, &driver_template);
        return -19;
}

static void exit_this_scsi_driver(void)
{
        scsi_unregister_module(1, &driver_template);
}

int init_module(void) __attribute__((alias("init_this_scsi_driver"))); static __inline__ __attribute__((always_inline)) __at
tribute__((always_inline)) __init_module_func_t __init_module_inline(void) { return init_this_scsi_driver; };
void cleanup_module(void) __attribute__((alias("exit_this_scsi_driver"))); static __inline__ __attribute__((always_inline))
__attribute__((always_inline)) __cleanup_module_func_t __cleanup_module_inline(void) { return exit_this_scsi_driver; };
# 723 "qlogicfas.c" 2

The problem is because in 2.4.25pre6 we have
MODULE defined and
drivers/scsi/qlogicfas.c -> #include <linux/module.h>
include/linux/moduleh -> #include <linux/spinlock.h>
include/linux/spinlock.h -> #include <asm/system.h>
include/asm/system.h -> #include <linux/init.h>
as MODULE is defined then wrong functions are taken (we want these for undefined MODULE to be taken later)
then back in drivers/scsi/qlogicfas.c

#ifdef PCMCIA
#undef MODULE
#endif

and again #include <linux/init.h> this time with MODULE undefined
	
-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux
