Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbTASNzc>; Sun, 19 Jan 2003 08:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbTASNzc>; Sun, 19 Jan 2003 08:55:32 -0500
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:12296 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id <S264756AbTASNzb> convert rfc822-to-8bit;
	Sun, 19 Jan 2003 08:55:31 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jaroslav Kysela <perex@suse.cz>
Subject: [Bug + Patch] opl3sa2 unregister bug
Date: Sun, 19 Jan 2003 15:04:26 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301191504.26219.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi jaroslav

i played a bit with snd-opl3sa2...

modprobe snd-opl3sa2 #1 fails, no sound card found, module _not_ loaded
modprobe snd-opl3sa2 #2 produces that one:

pnp: the card driver 'opl3sa2' has been registered
Yamaha OPL3-SA soundcard not found or device busy
pnp: the card driver 'opl3sa2' has been registered
Badness in kobject_register at lib/kobject.c:152
Call Trace:
 [<c0199146>] kobject_register+0x3e/0x50
 [<c01aa72f>] bus_add_driver+0x53/0xd8
 [<d08c793c>] opl3sa2_pnpc_driver+0x3c/0xfffefff4 [snd_opl3sa2]
 [<d08c7900>] opl3sa2_pnpc_driver+0x0/0xfffefff4 [snd_opl3sa2]
 [<d08c793c>] opl3sa2_pnpc_driver+0x3c/0xfffefff4 [snd_opl3sa2]
 [<c01aaafa>] driver_register+0x36/0x3c
 [<d08c791c>] opl3sa2_pnpc_driver+0x1c/0xfffefff4 [snd_opl3sa2]
 [<c01a0c86>] pnpc_register_driver+0x36/0x54
 [<d08c791c>] opl3sa2_pnpc_driver+0x1c/0xfffefff4 [snd_opl3sa2]
 [<d08c5b65>] +0x2a5/0xffff2034 [snd_opl3sa2]
 [<d08b78c8>] alsa_card_opl3sa2_init+0x44/0x6c [snd_opl3sa2]
 [<d08c7900>] opl3sa2_pnpc_driver+0x0/0xfffefff4 [snd_opl3sa2]
 [<d08c79a0>] +0x0/0xfffeff54 [snd_opl3sa2]
 [<c012b836>] sys_init_module+0x13a/0x1cc
 [<c010a917>] syscall_call+0x7/0xb


to fix it:
--- linux-2.5/sound/isa/opl3sa2.c~	2003-01-19 14:42:20.000000000 +0100
+++ linux-2.5/sound/isa/opl3sa2.c	2003-01-19 14:43:54.000000000 +0100
@@ -896,6 +896,9 @@
 #ifdef MODULE
 		printk(KERN_ERR "Yamaha OPL3-SA soundcard not found or device busy\n");
 #endif
+#ifdef CONFIG_PNP
+		pnpc_unregister_driver(&opl3sa2_pnpc_driver);
+#endif
 		return -ENODEV;
 	}
 	return 0;
@@ -905,7 +908,9 @@
 {
         int dev;

+#ifdef CONFIG_PNP
 	pnpc_unregister_driver(&opl3sa2_pnpc_driver);
+#endif
 	for (dev = 0; dev < SNDRV_CARDS; dev++)
 		snd_card_free(snd_opl3sa2_cards[dev]);
 }


against 2.5.59 + your driver patch from
http://marc.theaimsgroup.com/?l=linux-kernel&m=104292513020851

rgds,
-daniel

