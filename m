Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbTKZTqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 14:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264294AbTKZTqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 14:46:42 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:2432
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S264290AbTKZTqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 14:46:34 -0500
From: John Mock <kd6pag@qsl.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: -test10/PPC still broken on PowerMac 8500
Message-Id: <E1AP5Zm-0000FD-00@penngrove.fdns.net>
Date: Wed, 26 Nov 2003 11:43:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the clues.  I think the attached patch fixes most of the issues
with 'mac53c94.c' (please check the license before passing upstream); and 
by forcing a 16 byte boundary in the slab debug area, also fixes the MESH
problems (including CDROM eject, which my earlier kludgy patch didn't deal
with).  Both get a couple of compilation warnings (see attachment) which
may need attention.

I spent alot of time on the 'controlfb' driver and haven't gotten very far
with it.  What i can tell you about this is that control_set_hardware()
gets initially called with 'cmode' of 0, then gets set to 'cmode' of 2.
If i invoke X, when it comes back from X, it has 'cmode' of 1; that is to 
say, the video mode information doesn't seem to be preserved.  By supplying
different values of '-depth' to X, i can change the 'cmode' of the frame 
buffer when it returns. [See attachment: The first set are initialization, 
the second involves X sets parameters several times before deciding on a 
setting, and the last is attempting to restore the frame buffer settings.]

The other hint is that 'fbset' to change screen depths does not update the
screen properly (if at all).

I hope this helps and i'll do more testing of 'swim3' when i get a chance 
to retrieve some of those old floppies from storage.  Please let me know 
what you'd like me to try next.
				   -- JM

Attachments:
  Patches for SCSI issues on PowerMac 8500
  SCSI compilation warnings for same
  'dmesg' extracts on 'controlfb' screen problem.
-------------------------------------------------------------------------------
--- ./drivers/scsi/mac53c94.c.orig	2003-11-23 17:31:08.000000000 -0800
+++ ./drivers/scsi/mac53c94.c	2003-11-26 09:50:17.000000000 -0800
@@ -123,9 +123,9 @@
 			printk(KERN_ERR "mac53c94: ioremap failed for %s\n",
 			       node->full_name);
 			if (state->dma != NULL)
-				iounmap(state->dma);
+				iounmap((void *) state->dma);
 			if (state->regs != NULL)
-				iounmap(state->regs);
+				iounmap((void *) state->regs);
 			scsi_unregister(host);
 			break;
 		}
@@ -161,8 +161,8 @@
 			printk(KERN_ERR "mac53C94: can't get irq %d for %s\n",
 			       state->intr, node->full_name);
 		err_cleanup:
-			iounmap(state->dma);
-			iounmap(state->regs);
+			iounmap((void *) state->dma);
+			iounmap((void *) state->regs);
 			scsi_unregister(host);
 			break;
 		}
@@ -187,6 +187,7 @@
 		iounmap((void *) fp->dma);
 	kfree(fp->dma_cmd_space);
 	free_irq(fp->intr, fp);
+	scsi_unregister(host);
 	return 0;
 }
 
@@ -630,3 +631,5 @@
 };
 
 #include "scsi_module.c"
+
+MODULE_LICENSE("GPL");
--- ./mm/slab.c.orig	2003-11-23 17:32:42.000000000 -0800
+++ ./mm/slab.c	2003-11-26 10:07:04.000000000 -0800
@@ -1106,6 +1106,11 @@
 		/* add space for red zone words */
 		cachep->dbghead += BYTES_PER_WORD;
 		size += 2*BYTES_PER_WORD;
+#ifdef CONFIG_SCSI_MESH
+		/* MESH hardware has buffer alignment issues */
+		size            += (0x10 - cachep->dbghead) & 0xf;
+		cachep->dbghead += (0x10 - cachep->dbghead) & 0xf;
+#endif
 	}
 	if (flags & SLAB_STORE_USER) {
 		flags &= ~SLAB_HWCACHE_ALIGN;
-------------------------------------------------------------------------------
  CC      drivers/scsi/mesh.o
drivers/scsi/mesh.c: In function `data_goes_out':
drivers/scsi/mesh.c:1913: warning: enumeration value `DMA_BIDIRECTIONAL' not handled in switch
drivers/scsi/mesh.c:1913: warning: enumeration value `DMA_NONE' not handled in switch
  LD      drivers/scsi/built-in.o
  CC [M]  drivers/scsi/mac53c94.o
drivers/scsi/mac53c94.c: In function `data_goes_out':
drivers/scsi/mac53c94.c:577: warning: enumeration value `DMA_BIDIRECTIONAL' not handled in switch
drivers/scsi/mac53c94.c:577: warning: enumeration value `DMA_NONE' not handled in switch
  LD      drivers/built-in.o
-------------------------------------------------------------------------------
	...
Nov 26 10:41:40 penngrove kernel: fb0: control_set_hardware(0xc05cb0f0,0xc054bdd8), cmode 0
Nov 26 10:41:40 penngrove kernel:  regs[]: 063d 063c 003c 0020  0004 063e 0640 0086
Nov 26 10:41:40 penngrove kernel:          028e 0287 0087 002f  028f 0018 0148 0260
Nov 26 10:41:40 penngrove kernel: Call trace:
Nov 26 10:41:40 penngrove kernel:  [c000b1ec] dump_stack+0x18/0x28
Nov 26 10:41:40 penngrove kernel:  [c00e9254] control_set_hardware+0xb0/0x274
Nov 26 10:41:40 penngrove kernel:  [c00e8e5c] controlfb_set_par+0x64/0x9c
Nov 26 10:41:40 penngrove kernel:  [c00e4e0c] fb_set_var+0xd4/0xd8
Nov 26 10:41:40 penngrove kernel:  [c022b014] init_control+0xf8/0x264
Nov 26 10:41:40 penngrove kernel:  [c022b558] control_of_init+0x1f0/0x238
Nov 26 10:41:40 penngrove kernel:  [c022b1a4] control_init+0x24/0x48
Nov 26 10:41:40 penngrove kernel:  [c022aa30] fbmem_init+0xf4/0x114
Nov 26 10:41:40 penngrove kernel:  [c0227be0] chr_dev_init+0x3c/0x64
Nov 26 10:41:40 penngrove kernel:  [c02145dc] do_initcalls+0x54/0xe0
Nov 26 10:41:40 penngrove kernel:  [c0003958] init+0x1c/0xc0
Nov 26 10:41:40 penngrove kernel:  [c000a970] kernel_thread+0x44/0x60
Nov 26 10:41:40 penngrove kernel: fb0: control display adapter
Nov 26 10:41:40 penngrove kernel: MacOS display is /chaos/control
Nov 26 10:41:40 penngrove kernel: Thermal assist unit using timers, shrink_timer: 200 jiffies
Nov 26 10:41:40 penngrove kernel: fb0: control_set_hardware(0xc05cb0f0,0xc054be68), cmode 2
Nov 26 10:41:40 penngrove kernel:  regs[]: 063d 063c 003c 0020  0004 063e 0640 0086
Nov 26 10:41:40 penngrove kernel:          028e 0287 0087 002f  028f 0018 0148 0260
Nov 26 10:41:40 penngrove kernel: Call trace:
Nov 26 10:41:40 penngrove kernel:  [c000b1ec] dump_stack+0x18/0x28
Nov 26 10:41:40 penngrove kernel:  [c00e9254] control_set_hardware+0xb0/0x274
Nov 26 10:41:40 penngrove kernel:  [c00e8e5c] controlfb_set_par+0x64/0x9c
Nov 26 10:41:40 penngrove kernel:  [c00e0660] fbcon_startup+0x210/0x2cc
Nov 26 10:41:40 penngrove kernel:  [c00b9c20] take_over_console+0x38/0x1ec
Nov 26 10:41:40 penngrove kernel:  [c022a56c] fb_console_init+0x44/0x5c
Nov 26 10:41:40 penngrove kernel:  [c02289d8] vty_init+0xcc/0x100
Nov 26 10:41:40 penngrove kernel:  [c022808c] tty_init+0x240/0x258
Nov 26 10:41:40 penngrove kernel:  [c02145dc] do_initcalls+0x54/0xe0
Nov 26 10:41:40 penngrove kernel:  [c0003958] init+0x1c/0xc0
Nov 26 10:41:40 penngrove kernel:  [c000a970] kernel_thread+0x44/0x60
Nov 26 10:41:40 penngrove kernel: Console: switching to colour frame buffer device 128x48
	...
Nov 26 10:43:35 penngrove kernel: fb0: control_set_hardware(0xc05cb0f0,0xcaec9d18), cmode 2
Nov 26 10:43:35 penngrove kernel:  regs[]: 065c 064c 004c 0028  0004 066c 066e 00a2
Nov 26 10:43:35 penngrove kernel:          02a6 02a3 00a3 003b  02a7 001e 0154 026c
Nov 26 10:43:35 penngrove kernel: Call trace:
Nov 26 10:43:35 penngrove kernel:  [c000b1ec] dump_stack+0x18/0x28
Nov 26 10:43:35 penngrove kernel:  [c00e9254] control_set_hardware+0xb0/0x274
Nov 26 10:43:35 penngrove kernel:  [c00e8e5c] controlfb_set_par+0x64/0x9c
Nov 26 10:43:35 penngrove kernel:  [c00e4e0c] fb_set_var+0xd4/0xd8
Nov 26 10:43:35 penngrove kernel:  [c00e513c] fb_ioctl+0x228/0x5a4
Nov 26 10:43:35 penngrove kernel:  [c0067c9c] sys_ioctl+0xdc/0x2f4
Nov 26 10:43:35 penngrove kernel:  [c00075dc] ret_from_syscall+0x0/0x44
Nov 26 10:43:35 penngrove kernel: fb0: control_set_hardware(0xc05cb0f0,0xcaec9d18), cmode 2
Nov 26 10:43:35 penngrove kernel:  regs[]: 0570 0570 0030 0019  0002 0570 0572 0082
Nov 26 10:43:35 penngrove kernel:          0262 0243 0083 0031  0263 0019 0132 0232
Nov 26 10:43:35 penngrove kernel: Call trace:
Nov 26 10:43:35 penngrove kernel:  [c000b1ec] dump_stack+0x18/0x28
Nov 26 10:43:35 penngrove kernel:  [c00e9254] control_set_hardware+0xb0/0x274
Nov 26 10:43:35 penngrove kernel:  [c00e8e5c] controlfb_set_par+0x64/0x9c
Nov 26 10:43:35 penngrove kernel:  [c00e4e0c] fb_set_var+0xd4/0xd8
Nov 26 10:43:35 penngrove kernel:  [c00e513c] fb_ioctl+0x228/0x5a4
Nov 26 10:43:35 penngrove kernel:  [c0067c9c] sys_ioctl+0xdc/0x2f4
Nov 26 10:43:35 penngrove kernel:  [c00075dc] ret_from_syscall+0x0/0x44
Nov 26 10:43:35 penngrove kernel: fb0: control_set_hardware(0xc05cb0f0,0xcaec9d18), cmode 2
Nov 26 10:43:35 penngrove kernel:  regs[]: 04df 04de 002e 0018  0002 04e0 04e2 0062
Nov 26 10:43:35 penngrove kernel:          01fe 01f3 0063 0023  01ff 0012 0100 01dc
Nov 26 10:43:35 penngrove kernel: Call trace:
Nov 26 10:43:35 penngrove kernel:  [c000b1ec] dump_stack+0x18/0x28
Nov 26 10:43:35 penngrove kernel:  [c00e9254] control_set_hardware+0xb0/0x274
Nov 26 10:43:35 penngrove kernel:  [c00e8e5c] controlfb_set_par+0x64/0x9c
Nov 26 10:43:35 penngrove kernel:  [c00e4e0c] fb_set_var+0xd4/0xd8
Nov 26 10:43:35 penngrove kernel:  [c00e513c] fb_ioctl+0x228/0x5a4
Nov 26 10:43:35 penngrove kernel:  [c0067c9c] sys_ioctl+0xdc/0x2f4
Nov 26 10:43:35 penngrove kernel:  [c00075dc] ret_from_syscall+0x0/0x44
Nov 26 10:43:35 penngrove kernel: fb0: control_set_hardware(0xc05cb0f0,0xcaec9d18), cmode 2
Nov 26 10:43:35 penngrove kernel:  regs[]: 040e 0404 0044 0023  0002 0418 041a 0046
Nov 26 10:43:35 penngrove kernel:          018e 0187 0047 002f  018f 0018 00c8 0160
Nov 26 10:43:35 penngrove kernel: Call trace:
Nov 26 10:43:35 penngrove kernel:  [c000b1ec] dump_stack+0x18/0x28
Nov 26 10:43:35 penngrove kernel:  [c00e9254] control_set_hardware+0xb0/0x274
Nov 26 10:43:35 penngrove kernel:  [c00e8e5c] controlfb_set_par+0x64/0x9c
Nov 26 10:43:35 penngrove kernel:  [c00e4e0c] fb_set_var+0xd4/0xd8
Nov 26 10:43:35 penngrove kernel:  [c00e513c] fb_ioctl+0x228/0x5a4
Nov 26 10:43:35 penngrove kernel:  [c0067c9c] sys_ioctl+0xdc/0x2f4
Nov 26 10:43:35 penngrove kernel:  [c00075dc] ret_from_syscall+0x0/0x44
Nov 26 10:43:35 penngrove kernel: fb0: control_set_hardware(0xc05cb0f0,0xcaec9d18), cmode 2
Nov 26 10:43:35 penngrove kernel:  regs[]: 065c 064c 004c 0028  0004 066c 066e 00a2
Nov 26 10:43:35 penngrove kernel:          02a6 02a3 00a3 003b  02a7 001e 0154 026c
Nov 26 10:43:35 penngrove kernel: Call trace:
Nov 26 10:43:35 penngrove kernel:  [c000b1ec] dump_stack+0x18/0x28
Nov 26 10:43:35 penngrove kernel:  [c00e9254] control_set_hardware+0xb0/0x274
Nov 26 10:43:35 penngrove kernel:  [c00e8e5c] controlfb_set_par+0x64/0x9c
Nov 26 10:43:35 penngrove kernel:  [c00e4e0c] fb_set_var+0xd4/0xd8
Nov 26 10:43:35 penngrove kernel:  [c00e513c] fb_ioctl+0x228/0x5a4
Nov 26 10:43:35 penngrove kernel:  [c0067c9c] sys_ioctl+0xdc/0x2f4
Nov 26 10:43:35 penngrove kernel:  [c00075dc] ret_from_syscall+0x0/0x44
Nov 26 10:44:07 penngrove kernel: fb0: control_set_hardware(0xc05cb0f0,0xcaec9d18), cmode 2
Nov 26 10:44:07 penngrove kernel:  regs[]: 040e 0404 0044 0023  0002 0418 041a 0046
Nov 26 10:44:07 penngrove kernel:          018e 0187 0047 002f  018f 0018 00c8 0160
Nov 26 10:44:07 penngrove kernel: Call trace:
Nov 26 10:44:07 penngrove kernel:  [c000b1ec] dump_stack+0x18/0x28
Nov 26 10:44:07 penngrove kernel:  [c00e9254] control_set_hardware+0xb0/0x274
Nov 26 10:44:07 penngrove kernel:  [c00e8e5c] controlfb_set_par+0x64/0x9c
Nov 26 10:44:07 penngrove kernel:  [c00e4e0c] fb_set_var+0xd4/0xd8
Nov 26 10:44:07 penngrove kernel:  [c00e513c] fb_ioctl+0x228/0x5a4
Nov 26 10:44:07 penngrove kernel:  [c0067c9c] sys_ioctl+0xdc/0x2f4
Nov 26 10:44:07 penngrove kernel:  [c00075dc] ret_from_syscall+0x0/0x44
Nov 26 10:44:07 penngrove kernel: fb0: control_set_hardware(0xc05cb0f0,0xcaec9c18), cmode 2
Nov 26 10:44:07 penngrove kernel:  regs[]: 064e 0644 0044 0023  0002 0658 065a 0046
Nov 26 10:44:07 penngrove kernel:          024e 0247 0047 002f  024f 0018 0128 0220
Nov 26 10:44:07 penngrove kernel: Call trace:
Nov 26 10:44:07 penngrove kernel:  [c000b1ec] dump_stack+0x18/0x28
Nov 26 10:44:07 penngrove kernel:  [c00e9254] control_set_hardware+0xb0/0x274
Nov 26 10:44:07 penngrove kernel:  [c00e8e5c] controlfb_set_par+0x64/0x9c
Nov 26 10:44:07 penngrove kernel:  [c00e4e0c] fb_set_var+0xd4/0xd8
Nov 26 10:44:07 penngrove kernel:  [c00e2868] fbcon_resize+0xd0/0x15c
Nov 26 10:44:07 penngrove kernel:  [c00e2a0c] fbcon_switch+0x118/0x280
Nov 26 10:44:07 penngrove kernel:  [c00b5be4] redraw_screen+0xf0/0x1ac
Nov 26 10:44:07 penngrove kernel:  [c00b0ac8] complete_change_console+0x44/0xf4
Nov 26 10:44:07 penngrove kernel:  [c00b02f4] vt_ioctl+0x168c/0x1cc0
Nov 26 10:44:07 penngrove kernel:  [c00a8db0] tty_ioctl+0x150/0x5bc
Nov 26 10:44:07 penngrove kernel:  [c0067c9c] sys_ioctl+0xdc/0x2f4
Nov 26 10:44:07 penngrove kernel:  [c00075dc] ret_from_syscall+0x0/0x44
===============================================================================
