Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317152AbSFQXQ7>; Mon, 17 Jun 2002 19:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317142AbSFQXQ7>; Mon, 17 Jun 2002 19:16:59 -0400
Received: from host194.steeleye.com ([216.33.1.194]:37384 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317144AbSFQXQ4>; Mon, 17 Jun 2002 19:16:56 -0400
Message-Id: <200206172316.g5HNGrY05827@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: sullivan <sullivan@austin.ibm.com>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH][RFC] Driverfs support for SCSI devices 
In-Reply-To: Message from sullivan <sullivan@austin.ibm.com> 
   of "Mon, 17 Jun 2002 16:18:59 CDT." <20020617161859.C14455@austin.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jun 2002 18:16:53 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a BUG in device.h:213 trying to insert the st.o module, but other than 
that, it seems to be running OK.

You forgot to export the symbol scsi_bus_type which is needed for sd et al. to 
compile as modules.

This code:

+/* Driverfs file content handlers */
+char * scsi_type_names[] = {
+	"DISK",
+	"TAPE",
+	NULL,
+	"PROCESSOR",
+	"WORM",
+	"ROM",
+	"SCANNER",
+	"MOD",
+	"MEDIUM_CHANGER",
+	"COMM",
+	NULL,
+	NULL,
+	NULL,
+	"ENCLOSURE"};

Duplicates the scsi_device_types array (in scsi.c), but with slightly 
different names.  Could you use the same array? otherwise we're going to get 
different device types from driverfs and /proc/scsi/scsi.

And, of course, for a legacy array, all the LUNs have the same name:

3:0:3:0/  3:0:3:1/  3:0:3:2/  3:0:3:3/  name  power
jroot@malley> cat 3\:0\:3\:*/name
S1T41711424NCR
S1T41711424NCR
S1T41711424NCR
S1T41711424NCR

James

Oops trace for st insert:kernel BUG at /mnt2/jejb/BK/BUILD-2.5/include/linux/de
vice.h:213!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0178624>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: f7d7e000   ecx: 00000000   edx: f7d7e004
esi: f88c81a0   edi: fffffff4   ebp: f7d7e3c4   esp: f7c5be68
ds: 0018   es: 0018   ss: 0018
Stack: f7d7e000 00000000 f7d7e3c4 f7c5bee4 f88c67a9 f7d7e3c4 f88c81a0 f7d7e3c4 
       f7d7e0a4 00000000 f7d7e130 f7d7e0e0 00000140 00000160 00000900 f7d7e0b4 
       f7d7e3f0 00000450 00000470 00000980 f7c5bee4 f7d7e004 f7d7e008 f7751d2c 
Call Trace: [<f88c67a9>] [<f88c81a0>] [<f88c8080>] [<f88096aa>] [<f88c6c78>] 
   [<f88c8080>] [<c011afc7>] [<f88c82ec>] [<f88c1060>] [<c0108977>] 
Code: 0f 0b d5 00 c0 76 20 c0 f0 ff 85 90 00 00 00 68 f0 01 00 00 

>>EIP; c0178624 <device_create_file+24/80>   <=====
Trace; f88c67a9 <[st]st_attach+489/760>
Trace; f88c81a0 <[st]st_device_type_file+0/20>
Trace; f88c8080 <[st]st_template+0/90>
Trace; f88096aa <[scsi_mod]scsi_register_device+aa/140>
Trace; f88c6c78 <[st]init_st+58/a0>
Trace; f88c8080 <[st]st_template+0/90>
Trace; c011afc7 <inter_module_put+797/870>
Trace; f88c82ec <[st].bss.end+1/6>
Trace; f88c1060 <[st]st_incompatible+0/f0>
Trace; c0108977 <__read_lock_failed+1137/3740>
Code;  c0178624 <device_create_file+24/80>
00000000 <_EIP>:
Code;  c0178624 <device_create_file+24/80>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0178626 <device_create_file+26/80>
   2:   d5 00                     aad    $0x0
Code;  c0178628 <device_create_file+28/80>
   4:   c0                        (bad)  
Code;  c0178629 <device_create_file+29/80>
   5:   76 20                     jbe    27 <_EIP+0x27> c017864b 
<device_create_file+4b/80>
Code;  c017862b <device_create_file+2b/80>
   7:   c0                        (bad)  
Code;  c017862c <device_create_file+2c/80>
   8:   f0 ff 85 90 00 00 00      lock incl 0x90(%ebp)
Code;  c0178633 <device_create_file+33/80>
   f:   68 f0 01 00 00            push   $0x1f0








