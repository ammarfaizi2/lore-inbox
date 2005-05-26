Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVEZVtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVEZVtC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVEZVtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:49:01 -0400
Received: from smtp.wp.pl ([212.77.101.1]:57524 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S261810AbVEZVsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:48:52 -0400
From: "Stanislaw W. Gruszka" <stf@xl.wp.pl>
Subject: [PATCH] bugfix: drivers/base/firmware_class.c
Date: Thu, 26 May 2005 23:23:17 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200505262323.17437.stf@xl.wp.pl>
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO AS1=NO(Body=1 Fuz1=1 Fuz2=1) AS2=NO(0.524919) AS3=NO AS4=NO                          
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I did:
	echo -20 > /sys/class/firmware/timeout
	modprobe ueagle-atm
and the oops was generated. 

Module ueagle-atm (http://castet.matthieu.free.fr/eagle/ueagle-pre12.tar.gz), 
call request_firmware(). Variable loading_timeout should be probably unsigned,
but this is not direct oops reason. There are races between 
firmware_loading_show() and request_firmware() when someone 
write 1 to $SYSFS/$DEVPATH/loading file after releasing firmware. 
Attached small patch should fix problem.

--
Staszek Gruszka

OOPS:
Unable to handle kernel NULL pointer dereference at virtual address 00000004
printing eip:
d08dd1e9
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: ueagle_atm usbatm pppoatm ppp_generic slhc firmware_class crc32 nvidia_agp intel_agp clip atm i810_audio ac97_codec soundcore agpgart uhci_hcd usbcore video thermal processor fan button battery ac
CPU:    0
EIP:    0060:[pg0+273338857/1069343744]    Not tainted VLI
EFLAGS: 00010246   (2.6.12-rc5) 
EIP is at firmware_loading_store+0x89/0xf0 [firmware_class]
 eax: 00000000   ebx: 00000001   ecx: 0000000a   edx: 00000028
 esi: cf0a8680   edi: c3b07fa4   ebp: 080f3408   esp: c3b07f0c
 ds: 007b   es: 007b   ss: 0068
Process firmware.agent (pid: 3577, threadinfo=c3b06000 task=cfc40020)
Stack: c3acf000 00000000 0000000a cabd4100 d08ded04 c0234dfa cabd4100 c3acf000 
	00000002 c0394404 c01935be cabd4108 d08ded04 c3acf000 00000002 c5e00bc0 
	c8b13980 c0193628 c78bd8c0 c5e00bc0 00000002 00000002 00000000 c8b13980 
Call Trace:
[class_device_attr_store+58/64] class_device_attr_store+0x3a/0x40
[flush_write_buffer+62/80] flush_write_buffer+0x3e/0x50
[sysfs_write_file+88/128] sysfs_write_file+0x58/0x80
[vfs_write+174/304] vfs_write+0xae/0x130
[sys_write+81/128] sys_write+0x51/0x80
[syscall_call+7/11] syscall_call+0x7/0xb
Code: 6e 58 02 8d 46 20 e8 f7 b3 83 ef 8b 44 24 20 8b 5c 24 0c 8b 74 24 10 83 c4 14 c3 f0 ff 0d 24 ec 8d d0 0f 88 18 0a 00 00 8b 46 54 <8b> 40 04 89 04 24 e8 8c 6f 87 ef 8b 46 54 c7 40 04 00 00 00 00 

PATCH:
diff -up drivers/base/firmware_class.c{.orig,}

--- drivers/base/firmware_class.c.orig  2005-05-26 22:47:44.000000000 +0200
+++ drivers/base/firmware_class.c       2005-05-26 22:48:21.000000000 +0200
@@ -428,6 +428,7 @@ request_firmware(const struct firmware *
        set_bit(FW_STATUS_DONE, &fw_priv->status);

        del_timer_sync(&fw_priv->timeout);
+       class_device_unregister(class_dev);

        down(&fw_lock);
        if (!fw_priv->fw->size || test_bit(FW_STATUS_ABORT, &fw_priv->status)) {
@@ -437,7 +438,6 @@ request_firmware(const struct firmware *
        }
        fw_priv->fw = NULL;
        up(&fw_lock);
-       class_device_unregister(class_dev);
        goto out;

 error_kfree_fw:

