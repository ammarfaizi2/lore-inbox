Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVCJBWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVCJBWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVCJBVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:21:22 -0500
Received: from t11-170.gprs.mtsnet.ru ([213.87.11.170]:28430 "EHLO
	xantippe.fb12.tu-berlin.de") by vger.kernel.org with ESMTP
	id S262574AbVCJAuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:50:13 -0500
From: JustMan <justman@e1.bmstu.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] fix call kobject_get_path() with zero kobject argument  in drivers/base/class.c
Date: Thu, 10 Mar 2005 03:49:41 +0300
User-Agent: KMail/1.7.2
References: <000a01c519ca$301a10f0$4f00a8c0@kachmar>
In-Reply-To: <000a01c519ca$301a10f0$4f00a8c0@kachmar>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200503100349.41469.justman@e1.bmstu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fix call kobject_get_path() with zero kobject argument.

This situation take place for example in unexpected disconnection of USB devices such as GPRS modem. 
(in my case it is Motorola C350 mobile phone modem)

Mar  6 00:55:52 toshiba kernel:  <6>usb 2-1: USB disconnect, address 4
Mar  6 00:55:53 toshiba kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Mar  6 00:55:53 toshiba kernel:  printing eip:
Mar  6 00:55:53 toshiba kernel: c0255299
Mar  6 00:55:53 toshiba kernel: *pde = 00000000
Mar  6 00:55:53 toshiba kernel: Oops: 0000 [#1]
Mar  6 00:55:53 toshiba kernel: PREEMPT
Mar  6 00:55:53 toshiba kernel: Modules linked in: ppp_deflate zlib_deflate bsd_comp ppp_async crc_ccitt ppp_generic slhc i
pt_REJECT ipt_LOG iptable_filter ipt_MASQUERADE iptable_nat ip_conntrack ip_tables pktcdvd snd_pcm_oss snd_mixer_oss rtc pcs
pkr usbhid intel_agp intelfb uhci_hcd ehci_hcd i8xx_tco 8250_pci 8250 serial_core snd_intel8x0m eepro100 mii evdev pcmcia ye
nta_socket rsrc_nonstatic pcmcia_core nls_koi8_r ntfs cdc_acm usb_storage usbkbd usbmouse usbcore msr cpuid sg sd_mod scsi_m
od dummy ide_cd cdrom snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc agpgart
Mar  6 00:55:53 toshiba kernel: CPU:    0
Mar  6 00:55:53 toshiba kernel: EIP:    0060:[<c0255299>]    Not tainted VLI
Mar  6 00:55:53 toshiba kernel: EFLAGS: 00010246   (2.6.11)
Mar  6 00:55:53 toshiba kernel: EIP is at get_kobj_path_length+0x29/0x50
Mar  6 00:55:53 toshiba kernel: eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: ffffffff
Mar  6 00:55:53 toshiba kernel: esi: 00000001   edi: 00000000   ebp: d4397d9c   esp: d4397d8c
Mar  6 00:55:53 toshiba kernel: ds: 007b   es: 007b   ss: 0068
Mar  6 00:55:53 toshiba kernel: Process pppd (pid: 6057, threadinfo=d4396000 task=d432da20)
Mar  6 00:55:53 toshiba kernel: Stack: dedf5bb8 000000d0 dedf5b94 d6dfa298 d4397db8 c0255339 d4397dc4 dedf5bb8
Mar  6 00:55:53 toshiba kernel:        c041f708 dedf5b94 d6dfa298 d4397dfc c02bc68f 00000286 ffffffff fffffffd
Mar  6 00:55:53 toshiba kernel:        ffffffff 21ac27d7 de53d829 c039d8ab c041f720 00000000 d6dfa90c 00000000
Mar  6 00:55:53 toshiba kernel: Call Trace:
Mar  6 00:55:53 toshiba kernel:  [<c0103e3a>] show_stack+0x7a/0x90
Mar  6 00:55:53 toshiba kernel:  [<c0103fb9>] show_registers+0x149/0x1b0
Mar  6 00:55:53 toshiba kernel:  [<c01041ad>] die+0xdd/0x170
Mar  6 00:55:53 toshiba kernel:  [<c01157aa>] do_page_fault+0x30a/0x65a
Mar  6 00:55:53 toshiba kernel:  [<c0103abf>] error_code+0x2b/0x30
Mar  6 00:55:53 toshiba kernel:  [<c0255339>] kobject_get_path+0x19/0x60
Mar  6 00:55:53 toshiba kernel:  [<c02bc68f>] class_hotplug+0x6f/0x160
Mar  6 00:55:53 toshiba kernel:  [<c0255ec4>] kobject_hotplug+0x1b4/0x2c0
Mar  6 00:55:53 toshiba kernel:  [<c0255660>] kobject_del+0x10/0x20
Mar  6 00:55:53 toshiba kernel:  [<c02bcab2>] class_device_del+0x92/0xc0
Mar  6 00:55:53 toshiba kernel:  [<c02bcaeb>] class_device_unregister+0xb/0x20
Mar  6 00:55:53 toshiba kernel:  [<dfc795bc>] acm_tty_close+0x14c/0x160 [cdc_acm]
Mar  6 00:55:53 toshiba kernel:  [<c029f6a2>] release_dev+0x7f2/0x810
Mar  6 00:55:53 toshiba kernel:  [<c029fb12>] tty_release+0x12/0x20
Mar  6 00:55:53 toshiba kernel:  [<c0156c9b>] __fput+0x12b/0x140
Mar  6 00:55:53 toshiba kernel:  [<c01554cf>] filp_close+0x4f/0x80
Mar  6 00:55:53 toshiba kernel:  [<c010300f>] syscall_call+0x7/0xb
Mar  6 00:55:53 toshiba kernel: Code: 00 00 55 ba ff ff ff ff 89 e5 57 56 be 01 00 00 00 53 83 ec 04 31 db 89 45 f0 90 8d b
4 26 00 00 00 00 8b 45 f0 89 d1 8b 38 89 d8 <f2> ae f7 d1 49 8b 45 f0 8d 74 31 01 8b 40 24 89 45 f0 85 c0 75

-- 
Regards, JustMan.


Signed-Off-By: Serge A. Suchkov <justman@e1.bmstu.ru>

diff -uNrp linux-2.6.11/drivers/base/class.orig.c  linux-2.6.11/drivers/base/class.c
--- linux-2.6.11/drivers/base/class.orig.c      2005-03-10 02:14:58.000000000 +0300
+++ linux-2.6.11/drivers/base/class.c   2005-03-10 02:15:06.000000000 +0300
@@ -307,12 +307,17 @@ static int class_hotplug(struct kset *ks
        if (class_dev->dev) {
                /* add physical device, backing this device  */
                struct device *dev = class_dev->dev;
-               char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
+               char   zero_kobj[sizeof(struct kobject)]={0};
+               char  *path;
+
+               if(!memcmp(zero_kobj,&dev->kobj,sizeof(struct kobject))) {

-               add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
-                                   &length, "PHYSDEVPATH=%s", path);
-               kfree(path);
+                       path = kobject_get_path(&dev->kobj, GFP_KERNEL);

+                       add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
+                                   &length, "PHYSDEVPATH=%s", path);
+                       kfree(path);
+               }
                /* add bus name of physical device */
                if (dev->bus)
                        add_hotplug_env_var(envp, num_envp, &i,
