Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317129AbSEXMRY>; Fri, 24 May 2002 08:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317128AbSEXMRX>; Fri, 24 May 2002 08:17:23 -0400
Received: from sol.mixi.net ([208.131.233.11]:56766 "EHLO sol.mixi.net")
	by vger.kernel.org with ESMTP id <S314375AbSEXMRV>;
	Fri, 24 May 2002 08:17:21 -0400
X-Envelope-From: <todd@tekinteractive.com>
X-Mailer: emacs 21.1.95.1 (via feedmail 8 I);
	VM 7.05 under Emacs 21.1.95.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15598.12112.123636.961105@rtfm.ofc.tekinteractive.com>
Date: Fri, 24 May 2002 07:17:20 -0500
From: "Todd R. Eigenschink" <todd@tekinteractive.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at filemap.c:122!  (2.4.19-pre8 + ext3 update)
Reply-To: todd@tekinteractive.com
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (sol)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was doing a preemptive reboot last night of our problematic machine
to avoid an oh-dark-thirty crash from the waitqueue list corruption
that Bill Irwin is looking into, and on the way down, I got this oops,
preceeded by "kernel BUG at filemap.c:122!", which is here:

void __remove_inode_page(struct page *page)
{
        if (PageDirty(page)) BUG();
        remove_page_from_inode_queue(page);
        remove_page_from_hash_queue(page);
}

I've had these on shutdown before with previous recentish 2.4 kernels,
but none since I recently attached a serial console.  The kernel is
2.4.19-pre8, plus the recent ext3 update patch--nothing more.

I don't know enough to know if this is related to the other problem or
not.

http://groups.google.com/groups?hl=en&lr=&ie=utf-8&oe=utf-8&threadm=linux.kernel.15593.36325.828828.485554%40rtfm.ofc.tekinteractive.com&rnum=1&prev=/groups%3Fq%3Dtodd%2520eigenschink%26sourceid%3Dopera%26num%3D0%26ie%3Dutf-8%26oe%3Dutf-8%26scoring%3Dd



ksymoops 2.4.5 on i686 2.4.19-pre8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre8/ (default)
     -m /boot/System.map-2.4.19-pre8.2 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0128e5a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 0100005d   ebx: 002a3400   ecx: c11c2aa0   edx: c11c2aa0
esi: c11c2aa0   edi: c11c2aa0   ebp: 0804a460   esp: ea25ff2c
ds: 0018   es: 0018   ss: 0018
Process swapoff (pid: 931, stackpage=ea25f000)
Stack: c01320eb c11c2aa0 c0132133 c11c2aa0 ea250001 ffffffff c0132c98 c11c2aa0
       ea25e000 ffffffff c03331c0 0804a460 e4194000 00000000 ea25ffa4 00000000
       00000000 00002a34 002a3400 f882a468 c02a94a0 c03331c0 c0132eca 00000000
Call Trace: [<c01320eb>] [<c0132133>] [<c0132c98>] [<c0132eca>] [<c01374e3>]
   [<c0108a23>]
Code: 0f 0b 7a 00 60 fc 25 c0 8b 41 08 ff 48 18 8b 51 04 8b 01 89


>>EIP; c0128e5a <__remove_inode_page+e/4c>   <=====

>>eax; 0100005d Before first symbol
>>ebx; 002a3400 Before first symbol
>>ecx; c11c2aa0 <END_OF_CODE+e5b444/????>
>>edx; c11c2aa0 <END_OF_CODE+e5b444/????>
>>esi; c11c2aa0 <END_OF_CODE+e5b444/????>
>>edi; c11c2aa0 <END_OF_CODE+e5b444/????>
>>ebp; 0804a460 Before first symbol
>>esp; ea25ff2c <END_OF_CODE+29ef88d0/????>

Trace; c01320eb <__delete_from_swap_cache+37/44>
Trace; c0132133 <delete_from_swap_cache+3b/5c>
Trace; c0132c98 <try_to_unuse+244/314>
Trace; c0132eca <sys_swapoff+162/348>
Trace; c01374e3 <sys_read+fb/104>
Trace; c0108a23 <system_call+33/40>

Code;  c0128e5a <__remove_inode_page+e/4c>
00000000 <_EIP>:
Code;  c0128e5a <__remove_inode_page+e/4c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0128e5c <__remove_inode_page+10/4c>
   2:   7a 00                     jp     4 <_EIP+0x4> c0128e5e <__remove_inode_page+12/4c>
Code;  c0128e5e <__remove_inode_page+12/4c>
   4:   60                        pusha  
Code;  c0128e5f <__remove_inode_page+13/4c>
   5:   fc                        cld    
Code;  c0128e60 <__remove_inode_page+14/4c>
   6:   25 c0 8b 41 08            and    $0x8418bc0,%eax
Code;  c0128e65 <__remove_inode_page+19/4c>
   b:   ff 48 18                  decl   0x18(%eax)
Code;  c0128e68 <__remove_inode_page+1c/4c>
   e:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c0128e6b <__remove_inode_page+1f/4c>
  11:   8b 01                     mov    (%ecx),%eax
Code;  c0128e6d <__remove_inode_page+21/4c>
  13:   89 00                     mov    %eax,(%eax)


2 warnings issued.  Results may not be reliable.

