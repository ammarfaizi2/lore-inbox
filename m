Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315756AbSENPJS>; Tue, 14 May 2002 11:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSENPJR>; Tue, 14 May 2002 11:09:17 -0400
Received: from sol.mixi.net ([208.131.233.11]:26763 "EHLO sol.mixi.net")
	by vger.kernel.org with ESMTP id <S315756AbSENPJN>;
	Tue, 14 May 2002 11:09:13 -0400
X-Envelope-From: <todd@tekinteractive.com>
X-Mailer: emacs 21.1.95.1 (via feedmail 8 I);
	VM 7.05 under Emacs 21.1.95.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15585.10390.825902.226132@rtfm.ofc.tekinteractive.com>
Date: Tue, 14 May 2002 10:09:10 -0500
From: "Todd R. Eigenschink" <todd@tekinteractive.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kswapd OOPS under 2.4.19-pre8 (ext3, Reiserfs + (soft)raid0)
In-Reply-To: <15577.5431.625191.582701@rtfm.ofc.tekinteractive.com>
Reply-To: todd@tekinteractive.com
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (sol)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I never saw any reponses to my oops post...but now I've narrowed
things further, to a point that makes it seem more serious.

I thought the problem might be reiserfs, so I copied everything
elsewhere (which killed the machine a number of times) and reformatted
the two reiserfs partitions as ext3.  At the same time, I reduced the
raid partition from four disks to just two.

In particular, it had died at least once while it shouldn't have been
*touching* the raid partition--that partition only handles web stats,
and no web stats processing was running.  The oops was in an rcp that
was copying a file to the smaller, non-raid ext3 partition.

In the process of copying everyting back, the machine died several
more times.  OK, so that rules out reiserfs.  I reconfigured to mount
everything as ext2.  It lasted an awful lot longer (~ 36 hours), but
still died.  Here's the latest oops.  It looks a lot like the rest of
them.

I was considering going back to 2.2.20 when I thought it was the
combination of reiserfs + raid, since the machine ran 2.x flawlessly
for the longest time.  But now that (in my mind) ext3, reiser, and
raid have all been ruled out, what's left seems like a pretty serious
problem.  What else could/should I try to narrow the problem?

Dual P3/500, 2 GB RAM, Intel L440-GXC mainboard.


----------------------------------------------------------------------
ksymoops 2.4.5 on i686 2.4.19-pre8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre8/ (default)
     -m /boot/System.map-2.4.19-pre8 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page
 not found in System.map.  Ignoring ksyms_base entry
Oops: 0000
CPU:    0
EIP:    0010:[<c0115ba8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010087
eax: c2802db4   ebx: c2002db4   ecx: 00000000   edx: 00000003
esi: c2802db0   edi: c2802db0   ebp: cd2fdf48   esp: cd2fdf2c
ds: 0018   es: 0018   ss: 0018
Process ld-linux.so.2 (pid: 18110, stackpage=cd2fd000)
Stack: c1095000 c2802db0 00000000 c2802db4 00000000 00000282 00000003 00000000
       c01295fe c1095000 00001000 c012bef0 00000000 ce03f5c0 ffffffea 00001000
       e0855de8 00001000 00000000 00001000 00001000 00001000 00004000 00000000
Call Trace: [<c01295fe>] [<c012bef0>] [<c0136d57>] [<c010889b>]
Code: 8b 01 85 45 fc 74 69 31 c0 9c 5e fa f0 fe 0d 80 a9 30 c0 0f


>>EIP; c0115ba8 <__wake_up+40/d0>   <=====

>>eax; c2802db4 <END_OF_CODE+249a758/????>
>>ebx; c2002db4 <END_OF_CODE+1c9a758/????>
>>esi; c2802db0 <END_OF_CODE+249a754/????>
>>edi; c2802db0 <END_OF_CODE+249a754/????>
>>ebp; cd2fdf48 <END_OF_CODE+cf958ec/????>
>>esp; cd2fdf2c <END_OF_CODE+cf958d0/????>

Trace; c01295fe <unlock_page+62/68>
Trace; c012bef0 <generic_file_write+578/778>
Trace; c0136d57 <sys_write+8f/100>
Trace; c010889b <system_call+33/38>

Code;  c0115ba8 <__wake_up+40/d0>
00000000 <_EIP>:
Code;  c0115ba8 <__wake_up+40/d0>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c0115baa <__wake_up+42/d0>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0115bad <__wake_up+45/d0>
   5:   74 69                     je     70 <_EIP+0x70> c0115c18 <__wake_up+b0/d
0>
Code;  c0115baf <__wake_up+47/d0>
   7:   31 c0                     xor    %eax,%eax
Code;  c0115bb1 <__wake_up+49/d0>
   9:   9c                        pushf  
Code;  c0115bb2 <__wake_up+4a/d0>
   a:   5e                        pop    %esi
Code;  c0115bb3 <__wake_up+4b/d0>
   b:   fa                        cli    
Code;  c0115bb4 <__wake_up+4c/d0>
   c:   f0 fe 0d 80 a9 30 c0      lock decb 0xc030a980
Code;  c0115bbb <__wake_up+53/d0>
  13:   0f 00 00                  sldt   (%eax)


2 warnings issued.  Results may not be reliable.

----------------------------------------------------------------------

