Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268699AbTBZTKU>; Wed, 26 Feb 2003 14:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268823AbTBZTKU>; Wed, 26 Feb 2003 14:10:20 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:48000 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S268699AbTBZTKR>;
	Wed, 26 Feb 2003 14:10:17 -0500
Subject: [BUG][2.5.63] kernel BUG at mm/slab.c:1101
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046287232.747.7.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Feb 2003 20:20:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've managed to trigger a BUG_ON() in mm/slab.c:1101.
I was trying to load the iee1394 sbp2 module to use an external firewire
harddrive.

My kernel is compiled with a lot of the debugging options, just because
I want to catch things like this.
This is an UP compiled kernel.

line 1101 in mm/slab.c is this:

static inline void check_irq_on(void)
{
#if DEBUG
        BUG_ON(irqs_disabled());
#endif
}

which is called from smp_call_function_all_cpus at line 1118

static void smp_call_function_all_cpus(void (*func) (void *arg), void *arg)
{
        check_irq_on();
        local_irq_disable();
        func(arg);
        local_irq_enable();

So it appears that something in the backtrace disabled interrupts...

I'm not sure if it's ieee1394 or scsi-stuff or module stuff that's to
blame.

I don't think this scsi-warning has anything to do with the error but
I'm not sure.


scsi HBA driver IEEE-1394 SBP-2 protocol driver didn't set a release method, please fix the template
------------[ cut here ]------------
kernel BUG at mm/slab.c:1101!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c012b99f>]    Not tainted
EFLAGS: 00010002
EIP is at smp_call_function_all_cpus+0xf/0x24
eax: 00000001   ebx: 000001e0   ecx: 00000000   edx: c012c968
esi: 00000001   edi: d70bbea4   ebp: ebd72940   esp: d70bbe88
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2058, threadinfo=d70ba000 task=d9d62060)
Stack: c012ca15 c012c968 d70bbea4 ebd72940 00000c00 00000000 ebd72940 ebd72940 
       e26db600 c012cac1 ebd72940 00000078 0000003c 00000060 c012b7f7 ebd72940 
       eeaaf320 d8163894 d81638ac eeaaf348 d70bbeec c0101ee8 ebd72978 e8b80f38 
Call Trace:
 [<c012ca15>] do_tune_cpucache+0x85/0xf0
 [<c012c968>] do_ccupdate_local+0x0/0x28
 [<c012cac1>] enable_cpucache+0x41/0x60
 [<c012b7f7>] kmem_cache_create+0x2eb/0x484
 [<eeaaf320>] scsi_cmd_pool+0x0/0x14 [scsi_mod]
 [<eeaaf348>] host_cmd_pool_mutex+0x0/0x14 [scsi_mod]
 [<eeaa1209>] scsi_setup_command_freelist+0x65/0xf8 [scsi_mod]
 [<eeaa844e>] spaces+0x4a/0x819 [scsi_mod]
 [<eeade480>] scsi_driver_template+0x0/0x80 [sbp2]
 [<eeaaf348>] host_cmd_pool_mutex+0x0/0x14 [scsi_mod]
 [<eeaa2786>] scsi_register+0x242/0x29c [scsi_mod]
 [<eeada4f4>] sbp2_add_host+0x0/0xac [sbp2]
 [<eeada57b>] sbp2_add_host+0x87/0xac [sbp2]
 [<eeade480>] scsi_driver_template+0x0/0x80 [sbp2]
 [<eeab4723>] hl_all_hosts+0x1f/0x3c [ieee1394]
 [<eeade480>] scsi_driver_template+0x0/0x80 [sbp2]
 [<eeab47b0>] gcc2_compiled.+0x70/0x84 [ieee1394]
 [<eeada4f4>] sbp2_add_host+0x0/0xac [sbp2]
 [<eeade500>] +0x0/0x100 [sbp2]
 [<eeada397>] sbp2_init+0xf/0x68 [sbp2]
 [<eeadc414>] +0x174/0xfde [sbp2]
 [<eeade418>] sbp2_hl_ops+0x0/0x14 [sbp2]
 [<eeadc165>] sbp2scsi_detect+0x5/0x10 [sbp2]
 [<eeaa2818>] scsi_register_host+0x38/0x94 [scsi_mod]
 [<eeade480>] scsi_driver_template+0x0/0x80 [sbp2]
 [<eeade500>] +0x0/0x100 [sbp2]
 [<eeadc23a>] sbp2_module_init+0x4a/0x75 [sbp2]
 [<eeade480>] scsi_driver_template+0x0/0x80 [sbp2]
 [<c0125a48>] sys_init_module+0x10c/0x198
 [<c010888b>] syscall_call+0x7/0xb

Code: 0f 0b 4d 04 a7 5f 24 c0 fa 8b 44 24 08 50 ff d2 fb 83 c4 04 

I'll recompile without all the debugging and see if I can get the
harddrive working. If anyone has a patch I should try just send it along
and I'll test it.

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
