Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288891AbSATSIR>; Sun, 20 Jan 2002 13:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288870AbSATSII>; Sun, 20 Jan 2002 13:08:08 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:18810 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288882AbSATSHx>; Sun, 20 Jan 2002 13:07:53 -0500
Date: Sun, 20 Jan 2002 19:08:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jure Pecar <pegasus@telemach.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17rc2aa2 oops in page_alloc.c
Message-ID: <20020120190835.H21279@athlon.random>
In-Reply-To: <20020120182655.301234b4.pegasus@telemach.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020120182655.301234b4.pegasus@telemach.net>; from pegasus@telemach.net on Sun, Jan 20, 2002 at 06:26:55PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 06:26:55PM +0100, Jure Pecar wrote:
> I just got this mailed from the logs on our mail server. The BUG said it's in page_alloc.c line 85.
> System is a redhat 6.2, 4way p3 xeon, 2gb ram, 512mb swap. Heavily loaded through the week (mostly i/o: sendmail, cyrus, ldap, mysql), altough the oops occured at the time of least activity.
> 
> ksymoops 0.7c on i686 2.4.17-rc2aa2.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.17-rc2aa2/ (default)
>      -m /usr/src/linux/System.map (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c0218650, System.map says c015ac60.  Ignoring ksyms_base entry
> Jan 19 23:04:01 castor kernel: invalid operand: 0000 
> Jan 19 23:04:01 castor kernel: CPU:    0 
> Jan 19 23:04:01 castor kernel: EIP:    0010:[__free_pages_ok+171/740]    Not tainted 
> Jan 19 23:04:01 castor kernel: EFLAGS: 00010282 
> Jan 19 23:04:01 castor kernel: eax: 0000001f   ebx: 00000028   ecx: c02d8388   edx: 0000651b 
> Jan 19 23:04:01 castor kernel: esi: c232fc40   edi: dd52a000   ebp: df749000   esp: dd52bed0 
> Jan 19 23:04:01 castor kernel: ds: 0018   es: 0018   ss: 0018 
> Jan 19 23:04:01 castor kernel: Process ps (pid: 20330, stackpage=dd52b000) 
> Jan 19 23:04:01 castor kernel: Stack: c0281b01 00000055 00000028 c232fc40 dd52a000 df749000 dd52a000 eee015a0  
> Jan 19 23:04:01 castor kernel:        bfffff2c 00000000 00000000 00000000 c012f620 c011d554 00000000 eee015a0  
> Jan 19 23:04:01 castor kernel:        df749000 e28d0000 c232fc40 00000f2c eee015bc dd52a000 eee015bc df749000  
> Jan 19 23:04:01 castor kernel: Call Trace: [__free_pages+28/32] [access_process_vm+448/540] [proc_pid_cmdline+100/256] [proc_info_read+89/296] [sys_read+142/196]  
> Jan 19 23:04:01 castor kernel: Code: 0f 0b 83 c4 08 8b 46 18 a8 80 74 11 6a 57 68 01 1b 28 c0 e8

seems like a genuine bug in mainline with the introduction of
get_user_pages in late 2.4, here it is the incremental fix:

--- 2.4.18pre2aa2/kernel/ptrace.c.~1~	Wed Jan 16 17:52:20 2002
+++ 2.4.18pre2aa2/kernel/ptrace.c	Sun Jan 20 18:53:35 2002
@@ -150,7 +150,7 @@
 
 		ret = get_user_pages(current, mm, addr, 1,
 				write, 1, &page, &vma);
-		if (ret <= 0)
+		if (ret <= 0 || !page)
 			break;
 
 		bytes = len;


however it also sounds a little strage that you have a task with a
special page in the cmdline, but that's indipendent to the above fix to
access_process_vm.

> Using defaults from ksymoops -t elf32-i386 -a i386
> 
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   0f 0b                     ud2a   
> Code;  00000002 Before first symbol
>    2:   83 c4 08                  add    $0x8,%esp
> Code;  00000005 Before first symbol
>    5:   8b 46 18                  mov    0x18(%esi),%eax
> Code;  00000008 Before first symbol
>    8:   a8 80                     test   $0x80,%al
> Code;  0000000a Before first symbol
>    a:   74 11                     je     1d <_EIP+0x1d> 0000001d Before first symbol
> Code;  0000000c Before first symbol
>    c:   6a 57                     push   $0x57
> Code;  0000000e Before first symbol
>    e:   68 01 1b 28 c0            push   $0xc0281b01
> Code;  00000013 Before first symbol
>   13:   e8 00 00 00 00            call   18 <_EIP+0x18> 00000018 Before first symbol
> 
> 
> 2 warnings issued.  Results may not be reliable.
> 
> About 19 hours later, the box appears to work ok.
> 
> 
> Some thoughts on aa kernel ... well it is definitely better that stock
> 2.4.17, but the box still uses up to 50mb of swap. 2.4.17 went into
> 300mb easily. For contrast, 2.4.2 which run more than half a year
> without problems on this box, _never_ swapped.

the real question is, does it feel slower with 50mbyte in swap? I mean,
some very very lightweight background activity in the long run should be
a very good thing, it should save you some ram on the very long run. of
course unless you keep seeing swapin/swapout almost all the time, in
such a case it would be a big mistake but I don't think it's the case.
If after a week you see 50mbyte in swap (and you almost never seen any
swapin, and maybe only a few very seldom swapout), that sounds good.
Infact it's not even sure that you did any real swapout yet, part of the
50mbyte in swap may only be preallocated.

with -aa if you don't want to see such 50mbyte in swap (even if they
seems very sane at first sight, so this is not a suggestion, this is
just informational, just if you want to try) you can run:

	echo 1000 >/proc/sys/vm/vm_mapped_ratio

Andrea
