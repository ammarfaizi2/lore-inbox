Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUHTKMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUHTKMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266212AbUHTKLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:11:50 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:31829 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266127AbUHTKKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:10:33 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: [PATCH] Oops when loading a stripped module
Date: Thu, 19 Aug 2004 17:52:29 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408191750.51863.blaisorblade_spam@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9yMJBAIWbbT78rC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_9yMJBAIWbbT78rC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've stripped a module and tried to load it (I know it's meaningless, but it 
was for testing; I wanted to strip debug symbols). And to my surprise, the 
kernel Oopsed. Well, not a security threat (you are root if you can load 
modules), but anyway not nice, even because it dies while holding 
module_mutex, so that it's nomore possible even to cat /proc/modules!
The oops is attached, together with the disassembly of the apply_alternatives 
function, for deconding the EIP value: I think it's in the memcpy() call. 
I've got a panic in the same situation even on UML, which defines a no-op 
apply_alternatives(); I've not a stack trace for it, anyway. But anyway the 
fix is to return -ENOEXEC for stripped objects; the attached patch (both 
attachment and inline) should do this work (I'm not an ELF expert, but I 
gave a quick look to the objdump and libbfd source code).

Anyway, some more checks should be added: an empty SHT_SYMTAB section could 
probably cause the same thing (and not even root must be able to Oops the 
kernel anyhow); and a malformed object could cause a lot of problems.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.7-SKAS-paolo/kernel/module.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

diff -puN kernel/module.c~reject-stripped-module kernel/module.c
--- vanilla-linux-2.6.7-SKAS/kernel/module.c~reject-stripped-module	2004-08-19 
11:34:11.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/kernel/module.c	2004-08-19 
15:03:31.927895368 +0200
@@ -1456,7 +1456,8 @@ static struct module *load_module(void _
 	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 	sechdrs[0].sh_addr = 0;
 
-	/* And these should exist, but gcc whinges if we don't init them */
+	/* And these should exist, but somebody could have stripped
+	 * the module (yes, I did)*/
 	symindex = strindex = 0;
 
 	for (i = 1; i < hdr->e_shnum; i++) {
@@ -1481,6 +1482,13 @@ static struct module *load_module(void _
 #endif
 	}
 
+	/*Oh, somebody fsck'ed it. Please, remember root != God ! */
+	if (symindex == 0) {
+		printk(KERN_ERR "Trying to load stripped module!!\n");
+		err = -ENOEXEC;
+		goto free_hdr;
+	}
+
 	modindex = find_sec(hdr, sechdrs, secstrings,
 			    ".gnu.linkonce.this_module");
 	if (!modindex) {
_

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0109c5d
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: tun ext3 jbd loop binfmt_misc snd_seq_oss 
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_intel8x0 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart 
snd_rawmidi snd_seq_device snd soundcore af_packet ipv6 ide_cd cdrom ds 
yenta_socket pcmcia_core eth1394 tg3 ohci1394 ieee1394 nls_iso8859_15 
nls_cp850 vfat fat pcspkr non_fatal thermal fan button battery ac powernow_k8 
processor psmouse amd64_agp agpgart sd_mod usb_storage scsi_mod dm_mod evdev 
tsdev usbhid usbmouse ehci_hcd ohci_hcd usbcore rtc
CPU:    0
EIP:    0060:[apply_alternatives+125/224]    Not tainted
EIP:    0060:[<c0109c5d>]    Not tainted
EFLAGS: 00210202   (2.6.7-sysemu-fix-mprotect) 
EIP is at apply_alternatives+0x7d/0xe0
eax: 00000003   ebx: e0fb3e48   ecx: 00000000   edx: e0fb3fc7
esi: 00000000   edi: 00005f37   ebp: c032edc0   esp: c977bee8
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 16714, threadinfo=c977a000 task=df7f30b0)
Stack: c032edc0 e0fb3fc7 e0f8afd0 c02f3cbf e0f8ad74 c02f3cae c011599e e0f8ace2 
       e0f8adc8 e0f61000 e0f8adc8 e0fb6480 000003c0 e0f61000 c012fe3d 00000000 
       e0f8ace2 e0fb6480 00030002 00000000 000003c0 c2153928 e0dc0000 e0fb6480 
Call Trace:
 [module_finalize+142/192] module_finalize+0x8e/0xc0
 [<c011599e>] module_finalize+0x8e/0xc0
 [load_module+2109/2496] load_module+0x83d/0x9c0
 [<c012fe3d>] load_module+0x83d/0x9c0
 [sys_init_module+96/592] sys_init_module+0x60/0x250
 [<c0130020>] sys_init_module+0x60/0x250
 [filp_close+79/144] filp_close+0x4f/0x90
 [<c014ecdf>] filp_close+0x4f/0x90
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
 [<c0103f89>] sysenter_past_esp+0x52/0x71

Code: 66 a5 a8 01 74 01 a4 0f b6 43 0a 0f b6 53 09 29 c2 89 c5 85 

(gdb) disassemble apply_alternatives
Dump of assembler code for function apply_alternatives:
0xc0109be0 <apply_alternatives+0>:      push   %ebp
0xc0109be1 <apply_alternatives+1>:      mov    %eax,%ecx
0xc0109be3 <apply_alternatives+3>:      xor    %ebp,%ebp
0xc0109be5 <apply_alternatives+5>:      push   %edi
0xc0109be6 <apply_alternatives+6>:      push   %esi
0xc0109be7 <apply_alternatives+7>:      push   %ebx
0xc0109be8 <apply_alternatives+8>:      sub    $0x8,%esp
0xc0109beb <apply_alternatives+11>:     mov    0xc032ee24,%eax
0xc0109bf0 <apply_alternatives+16>:     mov    %edx,0x4(%esp,1)
0xc0109bf4 <apply_alternatives+20>:     movl   $0xc032ed80,(%esp,1)
0xc0109bfb <apply_alternatives+27>:     test   %eax,%eax
0xc0109bfd <apply_alternatives+29>:     js     0xc0109c25 
<apply_alternatives+69>
0xc0109bff <apply_alternatives+31>:     nop
0xc0109c00 <apply_alternatives+32>:     bt     %eax,0xc032ec0c
0xc0109c07 <apply_alternatives+39>:     sbb    %eax,%eax
0xc0109c09 <apply_alternatives+41>:     test   %eax,%eax
0xc0109c0b <apply_alternatives+43>:     jne    0xc0109c1b 
<apply_alternatives+59>
0xc0109c0d <apply_alternatives+45>:     inc    %ebp
0xc0109c0e <apply_alternatives+46>:     mov    0xc032ee24(,%ebp,8),%eax
0xc0109c15 <apply_alternatives+53>:     test   %eax,%eax
0xc0109c17 <apply_alternatives+55>:     jns    0xc0109c00 
<apply_alternatives+32>
0xc0109c19 <apply_alternatives+57>:     jmp    0xc0109c25 
<apply_alternatives+69>
0xc0109c1b <apply_alternatives+59>:     mov    0xc032ee28(,%ebp,8),%ebp
0xc0109c22 <apply_alternatives+66>:     mov    %ebp,(%esp,1)
0xc0109c25 <apply_alternatives+69>:     cmp    0x4(%esp,1),%ecx
0xc0109c29 <apply_alternatives+73>:     mov    %ecx,%ebx
0xc0109c2b <apply_alternatives+75>:     jae    0xc0109cac 
<apply_alternatives+204>
---Type <return> to continue, or q <return> to quit---
0xc0109c2d <apply_alternatives+77>:     lea    0x0(%esi),%esi
0xc0109c30 <apply_alternatives+80>:     movzbl 0x8(%ebx),%eax
0xc0109c34 <apply_alternatives+84>:     bt     %eax,0xc032ec0c
0xc0109c3b <apply_alternatives+91>:     sbb    %eax,%eax
0xc0109c3d <apply_alternatives+93>:     test   %eax,%eax
0xc0109c3f <apply_alternatives+95>:     je     0xc0109ca3 
<apply_alternatives+195>
0xc0109c41 <apply_alternatives+97>:     movzbl 0xa(%ebx),%eax
0xc0109c45 <apply_alternatives+101>:    cmp    0x9(%ebx),%al
0xc0109c48 <apply_alternatives+104>:    ja     0xc0109cb4 
<apply_alternatives+212>
0xc0109c4a <apply_alternatives+106>:    movzbl %al,%eax
0xc0109c4d <apply_alternatives+109>:    mov    (%ebx),%edi
0xc0109c4f <apply_alternatives+111>:    mov    0x4(%ebx),%esi
0xc0109c52 <apply_alternatives+114>:    mov    %eax,%ecx
0xc0109c54 <apply_alternatives+116>:    shr    $0x2,%ecx
0xc0109c57 <apply_alternatives+119>:    repz movsl %ds:(%esi),%es:(%edi)
0xc0109c59 <apply_alternatives+121>:    test   $0x2,%al
0xc0109c5b <apply_alternatives+123>:    je     0xc0109c5f 
<apply_alternatives+127>
0xc0109c5d <apply_alternatives+125>:    movsw  %ds:(%esi),%es:(%edi)
0xc0109c5f <apply_alternatives+127>:    test   $0x1,%al
0xc0109c61 <apply_alternatives+129>:    je     0xc0109c64 
<apply_alternatives+132>
0xc0109c63 <apply_alternatives+131>:    movsb  %ds:(%esi),%es:(%edi)
0xc0109c64 <apply_alternatives+132>:    movzbl 0xa(%ebx),%eax
0xc0109c68 <apply_alternatives+136>:    movzbl 0x9(%ebx),%edx
0xc0109c6c <apply_alternatives+140>:    sub    %eax,%edx
0xc0109c6e <apply_alternatives+142>:    mov    %eax,%ebp
0xc0109c70 <apply_alternatives+144>:    test   %edx,%edx
0xc0109c72 <apply_alternatives+146>:    jle    0xc0109ca3 
<apply_alternatives+195>
0xc0109c74 <apply_alternatives+148>:    mov    (%esp,1),%ecx
---Type <return> to continue, or q <return> to quit---
0xc0109c77 <apply_alternatives+151>:    cmp    $0x9,%edx
0xc0109c7a <apply_alternatives+154>:    mov    (%ebx),%edi
0xc0109c7c <apply_alternatives+156>:    mov    $0x8,%eax
0xc0109c81 <apply_alternatives+161>:    cmovl  %edx,%eax
0xc0109c84 <apply_alternatives+164>:    mov    (%ecx,%eax,4),%esi
0xc0109c87 <apply_alternatives+167>:    add    %ebp,%edi
0xc0109c89 <apply_alternatives+169>:    mov    %eax,%ecx
0xc0109c8b <apply_alternatives+171>:    shr    $0x2,%ecx
0xc0109c8e <apply_alternatives+174>:    repz movsl %ds:(%esi),%es:(%edi)
0xc0109c90 <apply_alternatives+176>:    test   $0x2,%al
0xc0109c92 <apply_alternatives+178>:    je     0xc0109c96 
<apply_alternatives+182>
0xc0109c94 <apply_alternatives+180>:    movsw  %ds:(%esi),%es:(%edi)
0xc0109c96 <apply_alternatives+182>:    test   $0x1,%al
0xc0109c98 <apply_alternatives+184>:    je     0xc0109c9b 
<apply_alternatives+187>
0xc0109c9a <apply_alternatives+186>:    movsb  %ds:(%esi),%es:(%edi)
0xc0109c9b <apply_alternatives+187>:    add    %eax,%ebp
0xc0109c9d <apply_alternatives+189>:    sub    %eax,%edx
0xc0109c9f <apply_alternatives+191>:    test   %edx,%edx
0xc0109ca1 <apply_alternatives+193>:    jg     0xc0109c74 
<apply_alternatives+148>
0xc0109ca3 <apply_alternatives+195>:    add    $0xc,%ebx
0xc0109ca6 <apply_alternatives+198>:    cmp    0x4(%esp,1),%ebx
0xc0109caa <apply_alternatives+202>:    jb     0xc0109c30 
<apply_alternatives+80>
0xc0109cac <apply_alternatives+204>:    add    $0x8,%esp
0xc0109caf <apply_alternatives+207>:    pop    %ebx
0xc0109cb0 <apply_alternatives+208>:    pop    %esi
0xc0109cb1 <apply_alternatives+209>:    pop    %edi
0xc0109cb2 <apply_alternatives+210>:    pop    %ebp
0xc0109cb3 <apply_alternatives+211>:    ret
---Type <return> to continue, or q <return> to quit---
0xc0109cb4 <apply_alternatives+212>:    ud2a
0xc0109cb6 <apply_alternatives+214>:    adc    $0x2f214004,%eax
0xc0109cbb <apply_alternatives+219>:    shr    $0x8c,%bl
0xc0109cbe <apply_alternatives+222>:    nop
0xc0109cbf <apply_alternatives+223>:    nop
End of assembler dump.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




--Boundary-00=_9yMJBAIWbbT78rC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="reject-stripped-module.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="reject-stripped-module.patch"


We get Oopses when loading stripped modules... and they are useless.
I hope this patch will detect them.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.7-SKAS-paolo/kernel/module.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

diff -puN kernel/module.c~reject-stripped-module kernel/module.c
--- vanilla-linux-2.6.7-SKAS/kernel/module.c~reject-stripped-module	2004-08-19 11:34:11.000000000 +0200
+++ vanilla-linux-2.6.7-SKAS-paolo/kernel/module.c	2004-08-19 15:03:31.927895368 +0200
@@ -1456,7 +1456,8 @@ static struct module *load_module(void _
 	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 	sechdrs[0].sh_addr = 0;
 
-	/* And these should exist, but gcc whinges if we don't init them */
+	/* And these should exist, but somebody could have stripped
+	 * the module (yes, I did)*/
 	symindex = strindex = 0;
 
 	for (i = 1; i < hdr->e_shnum; i++) {
@@ -1481,6 +1482,13 @@ static struct module *load_module(void _
 #endif
 	}
 
+	/*Oh, somebody fsck'ed it. Please, remember root != God ! */
+	if (symindex == 0) {
+		printk(KERN_ERR "Trying to load stripped module!!\n");
+		err = -ENOEXEC;
+		goto free_hdr;
+	}
+
 	modindex = find_sec(hdr, sechdrs, secstrings,
 			    ".gnu.linkonce.this_module");
 	if (!modindex) {
_

--Boundary-00=_9yMJBAIWbbT78rC--

