Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267714AbSLSW2B>; Thu, 19 Dec 2002 17:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267709AbSLSW1D>; Thu, 19 Dec 2002 17:27:03 -0500
Received: from mail41-s.fg.online.no ([148.122.161.41]:52198 "EHLO
	mail41.fg.online.no") by vger.kernel.org with ESMTP
	id <S267705AbSLSW0D> convert rfc822-to-8bit; Thu, 19 Dec 2002 17:26:03 -0500
Subject: [BUG] oops in dcache.c , 2.4.20
From: "Nils O." =?ISO-8859-1?Q?Sel=E5sdal?= <noselasd@frisurf.no>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 19 Dec 2002 23:34:30 +0100
Message-Id: <1040337273.2031.12.camel@space>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently upgraded a little box from 2.4.20-pre3 to 2.4.20, and after 2
days it locked up, and the following oops occured:

Dec 19 03:41:13 lfs kernel: kernel BUG at dcache.c:345!
Dec 19 03:41:13 lfs kernel: invalid operand: 0000
Dec 19 03:41:13 lfs kernel: CPU:    0
Dec 19 03:41:13 lfs kernel: EIP:    0010:[prune_dcache+78/336]    Not
tainted
Dec 19 03:41:13 lfs kernel: EFLAGS: 00010206
Dec 19 03:41:13 lfs kernel: eax: 00020000   ebx: c0d76e78   ecx:
000008c5   edx: c0d76ef8
Dec 19 03:41:13 lfs kernel: esi: c0d76e60   edi: c02d1f18   ebp:
00000049   esp: c0039f60
Dec 19 03:41:13 lfs kernel: ds: 0018   es: 0018   ss: 0018
Dec 19 03:41:13 lfs kernel: Process kswapd (pid: 5, stackpage=c0039000)
Dec 19 03:41:13 lfs kernel: Stack: 0000000e 000001d0 00000018 00000006
c0147f65 000001b1 c012f9a1 00000006 
Dec 19 03:41:13 lfs kernel:        000001d0 c0257cc0 00000006 000001d0
c0257cc0 00000000 c012f9f0 00000020 
Dec 19 03:41:13 lfs kernel:        c0257cc0 00000000 c0038000 c012fb00
c0257cc0 00000000 c0038245 0008e000 
Dec 19 03:41:13 lfs kernel: Call Trace:    [shrink_dcache_memory+37/64]
[shrink_caches+97/128] [try_to_free_pages_zone+48/80]
[kswapd_balance_pgdat+80/160] [kswapd_balance+22/48]
Dec 19 03:41:13 lfs kernel: Code: 0f 0b 59 01 71 c4 22 c0 8d 43 f8 8b 53
f8 8b 48 04 89 4a 04 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   59                        pop    %ecx
Code;  00000003 Before first symbol
   3:   01 71 c4                  add    %esi,0xffffffc4(%ecx)
Code;  00000006 Before first symbol
   6:   22 c0                     and    %al,%al
Code;  00000008 Before first symbol
   8:   8d 43 f8                  lea    0xfffffff8(%ebx),%eax
Code;  0000000b Before first symbol
   b:   8b 53 f8                  mov    0xfffffff8(%ebx),%edx
Code;  0000000e Before first symbol
   e:   8b 48 04                  mov    0x4(%eax),%ecx
Code;  00000011 Before first symbol
  11:   89 4a 04                  mov    %ecx,0x4(%edx)

Dec 19 19:20:52 lfs kernel: Intel Pentium with F0 0F bug - workaround
enabled.
Lines right before the oops in the syslog were:
Dec 18 14:10:00 lfs fcron[1196]: Job /sbin/rmmod -as ; /sbin/rmmod -as ;
/sbin/rmmod -as ; /sbin/rmmod -as started for user root (pid 1197)
Dec 19 03:34:00 lfs fcron[1202]: Job /usr/sbin/logrotate
/etc/logrotate.conf started for user root (pid 1203)
Dec 19 03:40:00 lfs fcron[1204]: Job updatedb started for user root (pid
1205)

The box is using reiserfs all over, and the 2.4.20 is compiled with gcc
3.2.1, got 16MB ram.
And its using a 2.5" harddisk from a laptop if it matters.

noselasd:~$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 6
cpu MHz         : 119.755
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 238.38

noselasd:~$ cat /proc/pci     
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 430FX - 82437FX TSC [Triton I] (rev 2).
      Master Capable.  Latency=64.  
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corp. 82371FB PIIX ISA [Triton I] (rev 2).
  Bus  0, device   8, function  0:
    VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev
0).
      IRQ 11.
      Non-prefetchable 32 bit memory at 0xff000000 [0xff7fffff].



The box also locked up one more time, when moving 1500 mails to an IMAP
folder on the machine. No oops in the log this time, but when rebooting
it oopsed when replaying the (reiserfs) log on the / filesystem.
Switched back to 2.4.20-pre3 and it works fine.

-- 
Nils Olav Selåsdal <NOS@Utel.no>
System Developer, UtelSystems a/s
w w w . u t e l s y s t e m s . c o m


