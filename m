Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVJDXFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVJDXFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 19:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVJDXFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 19:05:44 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:10067 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965028AbVJDXFn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 19:05:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RhxRPTx/hyTmCGbzxd1QT89aPMEuUxchQLlazXBc5BJHZfeHiKjNAAwneiw8ZJ31moYrWaCafNTjO67baQ2PKUkB1Sjyeye1AFTUMxFWAUWDqbqPpre4XRUAAnRHnOrceeUImPDzehI2Cs0KQjltzXXXtzTlmA2EJNgqY6MmWsM=
Message-ID: <253000f70510041605n28b2e666q@mail.gmail.com>
Date: Wed, 5 Oct 2005 01:05:42 +0200
From: Igor Popik <igor.popik@gmail.com>
Reply-To: Igor Popik <igor.popik@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix oops when reading /proc/ioports
Cc: linux-pcmcia@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have noticed that in recent kernels (2.6.13 and never) I got an oops
every time I tried to read /proc/ioports after trying to load i82365
pcmcia driver module:

root@alien2:~# modprobe i82365
FATAL: Error inserting i82365
(/lib/modules/2.6.14-rc3/kernel/drivers/pcmcia/i82365.ko): No such
device

root@alien2:~# cat /proc/ioports
<1>Unable to handle kernel paging request at virtual address cff10802
 printing eip:
c01c09bc
*pde = 0eec3067
*pte = 00000000
Oops: 0000 [#4]
Modules linked in: rsrc_nonstatic pcmcia_core snd_via82xx gameport
snd_ac97_codec snd_ac97_bus snd_pcm snd_timer
snd_page_alloc
snd_mpu401_uart snd_rawmidi snd soundcore psmouse
CPU:    0
EIP:    0060:[<c01c09bc>]    Not tainted VLI
EFLAGS: 00010297   (2.6.14-rc3)
EIP is at vsnprintf+0x33c/0x4d0
eax: cff10802   ebx: 0000000a   ecx: cff10802   edx: fffffffe
esi: ce525122   edi: 00000000   ebp: ce525fff   esp: c70e5eb4
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 3365, threadinfo=c70e4000 task=c13b1030)
Stack: ce52511b ce525fff 000003e1 00000000 00000010 00000004 00000002 00000001
       ffffffff ffffffff c30747e0 c7f6efc0 c30747e0 00000116 c01723d5 ce525116
       00000eea c0333dc8 c70e5f2c 00000004 c011cc87 c30747e0 c0333db6 00000000
Call Trace:
 [<c01723d5>] seq_printf+0x35/0x60
 [<c011cc87>] r_show+0x77/0x80
 [<c0171ed6>] seq_read+0x1d6/0x2d0
 [<c01521a7>] vfs_read+0xa7/0x180
 [<c0152561>] sys_read+0x51/0x80
 [<c0103095>] syscall_call+0x7/0xb
Code: 24 08 00 00 00 83 cf 01 eb bb 8b 44 24 48 8b 54 24 20 83 44 24
48 04 8b 08 b8 ac ed 33 c0 81 f9 ff 0f 00 00 0f 46 c8
89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75 20
 Segmentation fault

This oops is caused by broken i82365 PCMCIA driver. Someone tried to
remove deprecated check_region()  but after the changes the driver
does not release its memory regions correctly.

I've attached patch that fixes that oops. This driver looks really
dirty, and I do not know if it still works.

Cheers,
Igor

Signed-off-by: Igor Popik <igor.popik@gmail.com>

--- a/drivers/pcmcia/i82365.c	2005-08-29 01:41:01.000000000 +0200
+++ b/drivers/pcmcia/i82365.c	2005-10-05 00:07:04.000000000 +0200
@@ -697,6 +697,11 @@
     struct i82365_socket *t = &socket[sockets-ns];

     base = sockets-ns;
+    if (t->ioaddr > 0) {
+	if (!request_region(t->ioaddr, 2, "i82365"))
+	    printk(KERN_WARNING "port conflict at %#lx\n", t->ioaddr);
+    }
+
     if (base == 0) printk("\n");
     printk(KERN_INFO "  %s", pcic[type].name);
     printk(" ISA-to-PCMCIA at port %#lx ofs 0x%02x",
@@ -806,7 +811,8 @@
 	if (sockets == 0)
 	    printk("port conflict at %#lx\n", i365_base);
 	return;
-    }
+    } else
+	release_region(i365_base, 2);

     id = identify(i365_base, 0);
     if ((id == IS_I82365DF) && (identify(i365_base, 1) != id)) {
@@ -1440,7 +1446,6 @@
 	i365_set(i, I365_CSCINT, 0);
 	release_region(socket[i].ioaddr, 2);
     }
-    release_region(i365_base, 2);
 #ifdef CONFIG_PNP
     if (i82365_pnpdev)
     		pnp_disable_dev(i82365_pnpdev);
