Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264494AbRFJAYN>; Sat, 9 Jun 2001 20:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264495AbRFJAYE>; Sat, 9 Jun 2001 20:24:04 -0400
Received: from baghira.han.de ([212.63.63.2]:8203 "EHLO baghira.han.de")
	by vger.kernel.org with ESMTP id <S264494AbRFJAXr>;
	Sat, 9 Jun 2001 20:23:47 -0400
Message-Id: <m158sRu-0009RiC@hydrops.han.de>
From: joerg@hydrops.han.de (Joerg Ahrens)
Subject: [patch] sys_modify_ldt extension (default_ldt)
To: linux-kernel@vger.kernel.org
Date: Sun, 10 Jun 2001 01:47:22 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM992130442-1191-0_
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM992130442-1191-0_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I am trying to integrate binfmt_xout.c into kernel 2.4 as part of the 
linux-abi project (formerly known as iBCS). For old Xenix 286 binaries the 
lcall7 gate needs to part of the LDT.

In kernels 2.0 sys_modify_ldt(0,...) used to return the default_ldt (with 
lcall7 gate) if there were no segments set up. This behaviour changed in 
kernels 2.2 . As a result of a discussion with Linus, David Bruce wrote a 
patch for binfmt_xout.c tweaking with gdt and current->tss.ldt to get the
address of default_ldt. This patch does not work any more with kernels 2.4
as tss vanished from task_struct. 

I do see 4 ways to cope with this problem:

a) extend sys_modify_ldt with a function to retrieve the default_ldt. I did 
   this for testing (see attached diff for arch/i386/kernel/ldt.c ).

b) do some work an Davids patch but this is kind of magic for me :-)
   (see attached default_ldt patch)

c) loose the option to compile binfmt_xout (and the rest of linux-abi) as 
   module and simply use the symbol default_ldt. I dint't try that.

d) Forget about those old fashioned 286 binaries. This option will make some
   linux users feel sad, as they run these progs for their daily business.

Joerg
-- 
------------------------------------------------------------------------------
Joerg Ahrens                                              _/           
Koenigsberger Strasse 32                                _/_/
31226 Peine                                           _/  _/
Tel.: 05171/57308                             _/    _/_/_/_/
e-mail: joerg@hydrops.han.de                _/_/_/_/      _/
------------------------------------------------------------------------------

--ELM992130442-1191-0_
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=ldt.c.diff
Content-Description: ldt.c.diff
Content-Transfer-Encoding: 7bit

--- linux-2.4.0/arch/i386/kernel/ldt.c	Fri Dec 29 23:07:20 2000
+++ linux-2.4.0.i/arch/i386/kernel/ldt.c	Sat Jun  9 22:48:46 2001
@@ -44,7 +44,24 @@
 out:
 	return err;
 }
+static int read_default_ldt(void * ptr, unsigned long bytecount)
+{
+	int err;
+	unsigned long size;
+	void *address;
+
+	err = 0;
+	address = &default_ldt[0];
+	size = sizeof(struct desc_struct);
+	if (size > bytecount)
+		size = bytecount;
+
+	err = size;
+	if (copy_to_user(ptr, address, size))
+		err = -EFAULT;
 
+	return err;
+}
 static int write_ldt(void * ptr, unsigned long bytecount, int oldmode)
 {
 	struct mm_struct * mm = current->mm;
@@ -156,6 +173,9 @@
 		break;
 	case 1:
 		ret = write_ldt(ptr, bytecount, 1);
+		break;
+	case 2:
+		ret = read_default_ldt(ptr, bytecount);
 		break;
 	case 0x11:
 		ret = write_ldt(ptr, bytecount, 0);

--ELM992130442-1191-0_
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=default_ldt_patch
Content-Description: default_ldt_patch
Content-Transfer-Encoding: 7bit

struct desc_struct def_ldt;
unsigned long *lp, *lp2;

asm volatile ( "sgdt __gdt+2" );

lp = (unsigned long *)(__gdt[1] + current->tss.ldt );

lp2 = (unsigned long *)(((*lp >> 16) & 0x0000ffff)
           | (*(lp+1) & 0xff000000)
           | ((*(lp+1) << 16) & 0x00ff0000));

def_ldt.a = *lp2;
def_ldt.b = *(lp2+1);

--ELM992130442-1191-0_--
