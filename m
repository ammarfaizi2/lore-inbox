Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130079AbQKIHk0>; Thu, 9 Nov 2000 02:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbQKIHkI>; Thu, 9 Nov 2000 02:40:08 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:36648 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130079AbQKIHkB>; Thu, 9 Nov 2000 02:40:01 -0500
Message-ID: <3A0A54B8.66A66AAB@linux.com>
Date: Wed, 08 Nov 2000 23:39:36 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@wirex.com>
CC: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: [bug] usb-uhci locks up on boot half the time
In-Reply-To: <3A09F158.910C925@linux.com> <14857.62696.393621.795132@somanetworks.com> <3A09FD81.E7DA9352@linux.com> <20001108200844.A13446@wirex.com> <3A0A25C1.C46E392B@linux.com> <20001108215901.A13572@wirex.com>
Content-Type: multipart/mixed;
 boundary="------------AE85AA585E961E326C069E54"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AE85AA585E961E326C069E54
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Sigh.  That's not the real hang position.  I needed to step slower.

kdb> ss
0xc01100f8 pci_conf1_write_config_word+0x40:   outw   %ax,(%dx)
SS trap at 0xc01100fa (pci_conf1_write_config_word+0x42)
0xc01100fa pci_conf1_write_config_word+0x42:   popl   %ebx
kdb> ss
0xc01100fa pci_conf1_write_config_word+0x42:   popl   %ebx
SS trap at 0xc01100fb (pci_conf1_write_config_word+0x43)
0xc01100fb pci_conf1_write_config_word+0x43:   xorl   %eax,%eax
kdb> ss
0xc01100fb pci_conf1_write_config_word+0x43:   xorl   %eax,%eax
SS trap at 0xc01100fd (pci_conf1_write_config_word+0x45)
0xc01100fd pci_conf1_write_config_word+0x45:   popl   %esi
kdb> ss
0xc01100fd pci_conf1_write_config_word+0x45:   popl   %esi
SS trap at 0xc01100fe (pci_conf1_write_config_word+0x46)
0xc01100fe pci_conf1_write_config_word+0x46:   movl   %ebp,%esp
kdb> ss
0xc01100fe pci_conf1_write_config_word+0x46:   movl   %ebp,%esp
SS trap at 0xc0110100 (pci_conf1_write_config_word+0x48)
0xc0110100 pci_conf1_write_config_word+0x48:   popl   %ebp
kdb> ss
0xc0110100 pci_conf1_write_config_word+0x48:   popl   %ebp
SS trap at 0xc0110101 (pci_conf1_write_config_word+0x49)
0xc0110101 pci_conf1_write_config_word+0x49:   ret
kdb> ss
0xc0110101 pci_conf1_write_config_word+0x49:   ret
SS trap at 0xc020c7af (pci_write_config_word+0x2b)
0xc020c7af pci_write_config_word+0x2b:   pushl  %ebx
kdb> ss
0xc020c7af pci_write_config_word+0x2b:   pushl  %ebx
SS trap at 0xc020c7b0 (pci_write_config_word+0x2c)
0xc020c7b0 pci_write_config_word+0x2c:   popf
kdb> ss
0xc020c7b0 pci_write_config_word+0x2c:   popf

Here is where it hung this time.  Register dump below.

usb-uhci.c: $Revision: 1.242 $ time 20:13:32 Nov  8 2000
usb-uhci.c: High bandwidth mode enabled
Instruction(i) breakpoint #0 at 0xc03f5a8c (adjusted)
0xc03f5a8c start_uhci:   pushl  %ebp

Entering kdb (current=0xcfff4000, pid 1) due to Breakpoint @ 0xc03f5a8c
kdb> bp pci_write_config_word+0x2c
Instruction(i) BP #1 at 0xc020c7b0 (pci_write_config_word+0x2c)
    is enabled globally adjust 1
kdb> g
Instruction(i) breakpoint #1 at 0xc020c7b0 (adjusted)
0xc020c7b0 pci_write_config_word+0x2c:   popf

Entering kdb (current=0xcfff4000, pid 1) due to Breakpoint @ 0xc020c7b0
kdb> rd
eax = 0x00000000 ebx = 0x00000256 ecx = 0x000000c0 edx = 0x00000cfc
esi = 0x000000c0 edi = 0xc144c800 esp = 0xcfff5f74 eip = 0xc020c7b0
ebp = 0xcfff5f90 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00000046
xds = 0xc1440018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xcfff5f40



0xc020c7aa pci_write_config_word+0x26:   movl   0x10(%edx),%eax
0xc020c7ad pci_write_config_word+0x29:   call   *%eax
0xc020c7af pci_write_config_word+0x2b:   pushl  %ebx
0xc020c7b0 pci_write_config_word+0x2c:   popf
0xc020c7b1 pci_write_config_word+0x2d:   jmp    0xc020c7bc
pci_write_config_word+0x38
0xc020c7b3 pci_write_config_word+0x2f:   nop
0xc020c7b4 pci_write_config_word+0x30:   movl   $0x87,%eax
0xc020c7b9 pci_write_config_word+0x35:   leal   0x0(%esi),%esi
0xc020c7bc pci_write_config_word+0x38:   leal   0xfffffff4(%ebp),%esp

I'm going to have to drop this debug shortly and return to my regular work :(

-d


--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------AE85AA585E961E326C069E54
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------AE85AA585E961E326C069E54--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
