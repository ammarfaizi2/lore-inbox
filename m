Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTGGIa3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 04:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTGGIa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 04:30:29 -0400
Received: from tekila.org ([80.65.224.205]:50439 "EHLO pulsar.tekila.org")
	by vger.kernel.org with ESMTP id S263056AbTGGIa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 04:30:26 -0400
Date: Mon, 7 Jul 2003 10:45:08 +0200
From: Laurent Canet <lc@tekila.org>
To: linux-kernel@vger.kernel.org, rui.p.m.sousa@clix.pt
Subject: 2.5.74 kernel oops in OSS emu10k1
Message-Id: <20030707104508.64c39eab.lc@tekila.org>
Organization: TEKILA
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__7_Jul_2003_10:45:08_+0200_0828fae8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Mon__7_Jul_2003_10:45:08_+0200_0828fae8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

While loading emu10k1 module from 2.5.74 I got an oops:

Unable to handle kernel paging request at virtual address 000040a8
 printing eip:
e085d0e5
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<e085d0e5>]    Not tainted
EFLAGS: 00010246
EIP is at emu10k1_midi_init+0x15/0x170 [emu10k1]
eax: 00000002   ebx: 0000000c   ecx: c03d9669   edx: c03d966a
esi: 00000000   edi: dd280000   ebp: dd2cdeb4   esp: dd2cdea0
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 122, threadinfo=dd2cc000 task=dd5b06e0)
Stack: e0865f00 ffffffff dff66454 00000000 dd280000 dd2cde00 e085ed90 0000000c
       ffffffed dff66400 e0865e40 dd280000 80261102 dd2cdef0 c026fd1d dff66400
       e0865de4 dff66400 e0865e40 dff66454 dd2cdf08 c026fe60 e0865e40 dff66400
Call Trace:
 [<e085ed90>] emu10k1_probe+0x2c0/0x3a0 [emu10k1]
 [<c026fd1d>] pci_device_probe_static+0x2d/0x50
 [<c026fe60>] __pci_device_probe+0x20/0x40
 [<c026fea1>] pci_device_probe+0x21/0x40
 [<c02c28b8>] bus_match+0x38/0x70
 [<c02c29a3>] driver_attach+0x43/0x60
 [<c02c2c1e>] bus_add_driver+0x6e/0x90
 [<c02c2ff6>] driver_register+0x36/0x40
 [<c027012a>] pci_register_driver+0x6a/0xa0
 [<e083a01b>] emu10k1_init_module+0x1b/0x45 [emu10k1]
 [<c012d7c8>] sys_init_module+0xf8/0x200
 [<c0108ea7>] syscall_call+0x7/0xb
                                                                                                                              
Code: 89 83 9c 40 00 00 83 c4 08 85 c0 7d 14 68 20 26 86 e0 e8 d4
---------

After some debugging, I found that the error comes from sound/emu10k1/main.c
in emu10k1_mixer_init()

	char s[32];
....
	sprintf(s, "driver/emu10k1/%s/ac97", card->pci_dev->slot_name);

here I have "driver/emu10k1/0000:00:11.0/ac97" which is too long for the 32 
bytes buffer. 
To fix this bug, we just need to add some bytes to the buffer. I think that
48 would be enough. patch follows

diff -Naur linux-2.5.74-orig/sound/oss/emu10k1/main.c linux-2.5.74-modified/sound/oss/emu10k1/main.c
--- linux-2.5.74-orig/sound/oss/emu10k1/main.c  2003-07-07 10:35:17.000000000 +0200
+++ linux-2.5.74-modified/sound/oss/emu10k1/main.c      2003-07-07 10:31:25.000000000 +0200
@@ -221,7 +221,7 @@
  
 static int __devinit emu10k1_mixer_init(struct emu10k1_card *card)
 {
-       char s[32];
+       char s[48];
  
        struct ac97_codec *codec = &card->ac97;
        card->ac97.dev_mixer = register_sound_mixer(&emu10k1_mixer_fops, -1);
@@ -288,7 +288,7 @@
  
 static void __devinit emu10k1_mixer_cleanup(struct emu10k1_card *card)
 {
-       char s[32];
+       char s[48];
  
        if (!card->is_aps) {
                sprintf(s, "driver/emu10k1/%s/ac97", card->pci_dev->slot_name);



(Maybe we could avoid using the stack here, I already seen emu10k1 in the top
stack users list) 

-- 
Laurent Canet
----------------------------


--Multipart_Mon__7_Jul_2003_10:45:08_+0200_0828fae8
Content-Type: application/octet-stream;
 name="patch-emu10k1-oops-2.5.74"
Content-Disposition: attachment;
 filename="patch-emu10k1-oops-2.5.74"
Content-Transfer-Encoding: base64

ZGlmZiAtTmF1ciBsaW51eC0yLjUuNzQtb3JpZy9zb3VuZC9vc3MvZW11MTBrMS9tYWluLmMgbGlu
dXgtMi41Ljc0LW1vZGlmaWVkL3NvdW5kL29zcy9lbXUxMGsxL21haW4uYwotLS0gbGludXgtMi41
Ljc0LW9yaWcvc291bmQvb3NzL2VtdTEwazEvbWFpbi5jICAyMDAzLTA3LTA3IDEwOjM1OjE3LjAw
MDAwMDAwMCArMDIwMAorKysgbGludXgtMi41Ljc0LW1vZGlmaWVkL3NvdW5kL29zcy9lbXUxMGsx
L21haW4uYyAgICAgIDIwMDMtMDctMDcgMTA6MzE6MjUuMDAwMDAwMDAwICswMjAwCkBAIC0yMjEs
NyArMjIxLDcgQEAKICAKIHN0YXRpYyBpbnQgX19kZXZpbml0IGVtdTEwazFfbWl4ZXJfaW5pdChz
dHJ1Y3QgZW11MTBrMV9jYXJkICpjYXJkKQogewotICAgICAgIGNoYXIgc1szMl07CisgICAgICAg
Y2hhciBzWzQ4XTsKICAKICAgICAgICBzdHJ1Y3QgYWM5N19jb2RlYyAqY29kZWMgPSAmY2FyZC0+
YWM5NzsKICAgICAgICBjYXJkLT5hYzk3LmRldl9taXhlciA9IHJlZ2lzdGVyX3NvdW5kX21peGVy
KCZlbXUxMGsxX21peGVyX2ZvcHMsIC0xKTsKQEAgLTI4OCw3ICsyODgsNyBAQAogIAogc3RhdGlj
IHZvaWQgX19kZXZpbml0IGVtdTEwazFfbWl4ZXJfY2xlYW51cChzdHJ1Y3QgZW11MTBrMV9jYXJk
ICpjYXJkKQogewotICAgICAgIGNoYXIgc1szMl07CisgICAgICAgY2hhciBzWzQ4XTsKICAKICAg
ICAgICBpZiAoIWNhcmQtPmlzX2FwcykgewogICAgICAgICAgICAgICAgc3ByaW50ZihzLCAiZHJp
dmVyL2VtdTEwazEvJXMvYWM5NyIsIGNhcmQtPnBjaV9kZXYtPnNsb3RfbmFtZSk7Cgo=

--Multipart_Mon__7_Jul_2003_10:45:08_+0200_0828fae8--
