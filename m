Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSG1NHX>; Sun, 28 Jul 2002 09:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSG1NHX>; Sun, 28 Jul 2002 09:07:23 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:53732 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S316434AbSG1NHW> convert rfc822-to-8bit; Sun, 28 Jul 2002 09:07:22 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bart De Schuymer <bart.de.schuymer@pandora.be>
To: linux-kernel@vger.kernel.org
Subject: EXPORT_SYMBOL problem, in networking code
Date: Sun, 28 Jul 2002 15:11:40 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207281511.40633.bart.de.schuymer@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I use a function pointer called broute_decision that is default set to NULL, 
but can be initialized by another kernel module.
The definition of the function pointer is situated in net/bridge/br_input.c, 
this file contains the right EXPORT_SYMBOL(broute_decision); line.

When compiling the kernel with the  both the bridge and my code as a module, I 
get the following error after "make modules_install":

depmod: *** Unresolved symbols in 
/lib/modules/2.4.18/kernel/net/bridge/netfilter/ebtable_broute.o
depmod:	broute_decision_Rsmp_b3a20e56

using objdump gives:
#>objdump --disassemble -j __ksymtab net/bridge/br_input.o'
net/bridge/br_input.o:	file format elf32-i386
Disassembly of section __ksymtab:
00000000 <__ksymtab_broute_decision_Rsmp_b3a20e56

#>objdump --disassemble -j __ksymtab net/bridge/bridge.o'
net/bridge/bridge.o:	file format elf32-i386

So, although br_input.o has the symbol in its table, bridge.o doesn't. 
My difficulties come, AFAIK, from the fact that the bridge module is composed 
out of multiple c-files, here is (an excerpt of) the bridge Makefile:

O_TARGET        := bridge.o
# the follwing line is added by me
export-objs := br_input.o
obj-y := br.o br_device.o br_fdb.o br_forward.o br_if.o br_input.o \
                        br_ioctl.o br_notify.o br_stp.o br_stp_bpdu.o \
                        br_stp_if.o br_stp_timer.o
obj-m := $(O_TARGET)

When compiling the same kernel, but with the bridge and my code built into the 
kernel (not as modules), everything compiles and it works fine.

I have a "solution" by defining broute_decision in net/core/dev.c and doing 
the EXPORT_SYMBOL in net/netsyms.c. This works. But broute_decision is not 
used  in net/core/dev.c, so I would like the definition to be in 
net/bridge/br_input.c.

How do I get this to work?
Please CC me as I'm not subscribed to the list.
I can provide the compilable code (using net/core/dev.c) and the 
non-compilable code (using net/bridge/br_input.c) if necessary.

-- 
cheers,
Bart

