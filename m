Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267918AbUIPLHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267918AbUIPLHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267936AbUIPLHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:07:37 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:46304 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267935AbUIPLEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:04:42 -0400
Subject: [PATCH] Suspend2 Merge: Get module list.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095332772.3855.170.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 21:06:12 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

This patch adds support for getting a list of currently loaded modules.
It's used in displaying debugging info:


> Please include the following information in bug reports:
> - SWSUSP core    : 2.0.0.107
> - Kernel Version : 2.4.27
> - Version spec.  : 2.0.1
> - Compiler vers. : 3.3
> - Modules loaded : ppp_mppe ppp_deflate zlib_inflate zlib_deflate
> bsd_comp ltmodem_cs ds i82365 pcmcia_core maestro3 ac97_codec
> soundcore ftdi_sio visor usbserial printer usb-uhci usbcore Mvnetd
> Mvnet Mvnetint Mvw Mvmouse Mvkbd Mvgic Mvdsp Mserial Mmpip Mmerge
> mki-adapter i830 agpgart parport_pc lp parport ide-cd cdrom floppy
> ipt_LOG ipt_state ipt_MASQUERADE iptable_nat ip_conntrack
> ipt_multiport ipt_REJECT iptable_filter ip_tables ppp_async
> ppp_generic slhc af_packet omnibook battery button eepro100 mii rtc
> unix suspend_swap suspend_block_io suspend_lzf suspend_bootsplash
> suspend_text suspend_core
> - Attempt number : 1
> - Parameters     : 0 2816 0 0 0 128
> - Limits         : 161664 pages RAM. Initial boot: 156425.
> - Overall expected compression percentage: 0.
> - LZF Compressor enabled.
>   Compressed 340914176 bytes into 187258858 (45 percent compression).
> - Swapwriter active.
>   Swap available for image: 172688 pages.
> - Debugging compiled in.
> - Preemptive kernel.
> - I/O speed: Write 28 MB/s, Read 49 MB/s.
> [root@laptop current-2.6.9-rc2-patches]#

(I'm using 2.4 because there's no 2.6 pcmcia_cs ltmodem driver yet :>).

Regards,

Nigel

diff -ruN linux-2.6.9-rc1/kernel/module.c software-suspend-linux-2.6.9-rc1-rev3/kernel/module.c
--- linux-2.6.9-rc1/kernel/module.c	2004-09-07 21:59:00.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/kernel/module.c	2004-09-09 19:36:24.000000000 +1000
@@ -2146,6 +2146,33 @@
 	printk("\n");
 }
 
+#define MODLIST_SIZE 4096
+
+void print_module_list(void)
+{
+	static char modlist[MODLIST_SIZE];
+	struct module *mod;
+	int pos = 0;
+
+	list_for_each_entry(mod, &modules, list)
+		if (mod->name)
+			pos += snprintf(modlist+pos, MODLIST_SIZE-pos-1, 
+					"%s ", mod->name);
+	printk("%s\n",modlist);
+}
+
+int print_module_list_to_buffer(char * buffer, int size)
+{
+	struct module *mod;
+	int pos = 0;
+
+	list_for_each_entry(mod, &modules, list)
+		if (mod->name)
+			pos += snprintf(buffer+pos, size-pos-1, 
+					"%s ", mod->name);
+	return pos;
+}
+
 #ifdef CONFIG_MODVERSIONS
 /* Generate the signature for struct module here, too, for modversions. */
 void struct_module(struct module *mod) { return; }
@@ -2157,3 +2184,6 @@
 	return subsystem_register(&module_subsys);
 }
 __initcall(modules_init);
+
+/* For Suspend2 */
+EXPORT_SYMBOL(print_module_list_to_buffer);

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

