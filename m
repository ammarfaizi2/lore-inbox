Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136182AbRAGSVS>; Sun, 7 Jan 2001 13:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132296AbRAGSVI>; Sun, 7 Jan 2001 13:21:08 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:9965 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S136182AbRAGSUz>; Sun, 7 Jan 2001 13:20:55 -0500
Date: Sun, 7 Jan 2001 20:19:52 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "H . Peter Anvin" <hpa@zytor.com>
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] Cyrix III boot fix and bug report
Message-ID: <20010107201952.C10035@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I reported the crash on boot with a Winchip (which was actually
an Cyrix III) since test12-pre8.

I couldn't access the machine and debug the problem until now.


[1.] One line summary of the problem:

   Cyrix III doesn't boot, because of illegal rdmsr to 80000001
   
[2.] Full description of the problem/report:

   In linux-2.4.0/arch/i386/kernel/setup.c:1400 we try to detect
   3DNOW extensions for Cyrix III via rdmsr from 0x80000001. This
   fails with an exception, that is not handled and thus we oops
   on boot.
   
[3.] Keywords (i.e., modules, networking, kernel):
   i386, kernel, cyrix, winchip, msr, 3dnow
   
[4.] Kernel version (from /proc/version):

   Linux version 2.4.0 (root@compiler) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 Sat Jan 6 18:58:11 CET 2001
   
[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.3.4 on i586 2.4.0-prerelease.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m boot/System.map-2.4.0 (specified)

CPU: 0
EIP: 0010:[<c020dee6>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a86
eax: 00000008 ebx: 746e6543 ecx: 80000001 edx: 00000000
esi: 80000000 edi: 80860000 ebp: c01f9680 esp: c020bf94
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c020b000)
Stack: 746e6543 80000000 80860000 c01f9680 00000000 00000000 808030b5 c020e7d6
       c01f9680 00003ff0 0009b800 c0105000 0008e000 c0212a2d c01d982d 80000005
       c020c102 c01f9680 c020c77c 00003ff0 00003ff0 00003ff0 00003ff0 00003ff0
Call Trace: [<c0105000>] [<c0100191>]
Code: 0f 32 89 d6 85 f6 7d 09 b8 3f 00 00 00 0f ab 45 0c 55 e8 6f

>>EIP; c020dee6 <init_centaur+1ce/1f8>   <=====
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  c020dee6 <init_centaur+1ce/1f8>
00000000 <_EIP>:
Code;  c020dee6 <init_centaur+1ce/1f8>   <=====
   0:   0f 32                     rdmsr     <=====
Code;  c020dee8 <init_centaur+1d0/1f8>
   2:   89 d6                     mov    %edx,%esi
Code;  c020deea <init_centaur+1d2/1f8>
   4:   85 f6                     test   %esi,%esi
Code;  c020deec <init_centaur+1d4/1f8>
   6:   7d 09                     jge    11 <_EIP+0x11> c020def7 <init_centaur+1df/1f8>
Code;  c020deee <init_centaur+1d6/1f8>
   8:   b8 3f 00 00 00            mov    $0x3f,%eax
Code;  c020def3 <init_centaur+1db/1f8>
   d:   0f ab 45 0c               bts    %eax,0xc(%ebp)
Code;  c020def7 <init_centaur+1df/1f8>
  11:   55                        push   %ebp
Code;  c020def8 <init_centaur+1e0/1f8>
  12:   e8 6f 00 00 00            call   86 <_EIP+0x86> c020df6c <init_transmeta+5c/180>

Kernel panic: Attempted to kill the idle task!

[6.] A small shell script or example program which triggers the
     problem (if possible)

     Not applicable. Just boot it on the right hardware.

[7.] Environment

   A heavily mangled Debian (potato) GNU/Linux with the required
   updates to run this kernel.
   
[7.1.] Software (add the output of the ver_linux script here)

   Not applicable, since this is an embedded system.

[7.2.] Processor information (from /proc/cpuinfo):

   Couldn't get to this stage. But my be this will help:

   CPU: Before vendor init, caps: 008030b5 808030b5 0000000, vendor = 5
   
   This is the last log message seen before the oops.

[7.3.] Module information (from /proc/modules):

   Nothing loaded in this stage.

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
   
   Nothing used at this stage. Even with all pluggable hardware
   removed (except graphics adapter), we still see the problem.

   Chipset: VIA VT82C694XA/596B
   Mainboard: P6VAP-Me from AMR
   
[7.5.] PCI information ('lspci -vvv' as root)

   Not applicable(?). We support this too, if needed.

[7.6.] SCSI information (from /proc/scsi/scsi)

   Not applicable. (only using ide-scsi later)

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

   Ask for this.

[X.] Other notes, patches, fixes, workarounds:

The patch that fixed it for me:

--- linux-2.4.0/arch/i386/kernel/setup.c.orig	Sun Dec 31 19:26:18 2000
+++ linux-2.4.0/arch/i386/kernel/setup.c	Sat Jan  6 23:21:43 2001
@@ -1400,10 +1400,11 @@
 					wrmsr (0x1107, lo, hi);
 
 					set_bit(X86_FEATURE_CX8, &c->x86_capability);
+					/* The rdmsr will oops on my machine -ioe
 					rdmsr (0x80000001, lo, hi);
 					if (hi & (1<<31))
 						set_bit(X86_FEATURE_3DNOW, &c->x86_capability);
-
+					*/
 					get_model_name(c);
 					display_cacheinfo(c);
 					break;


But using rdmsr_eio() or sth. else, which catches execptions and
reports them only as errors and just disables the feature instead
of oopsing on boot, might be an better option.

Happy hackin' now

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
