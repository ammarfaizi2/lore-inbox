Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbTLKCef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 21:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTLKCef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 21:34:35 -0500
Received: from moof.zeroth.org ([203.117.131.35]:63753 "EHLO moof.zeroth.org")
	by vger.kernel.org with ESMTP id S264314AbTLKCea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 21:34:30 -0500
Message-ID: <3FD7D78A.4080409@metaparadigm.com>
Date: Thu, 11 Dec 2003 10:33:46 +0800
From: Jamie Clark <jclark@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: 2.4.23aa1 ext3 oops
References: <3FA713B9.3040405@metaparadigm.com> <20031104102816.GB2984@x30.random> <3FA79308.3070300@metaparadigm.com> <20031206010505.GB14904@dualathlon.random>
In-Reply-To: <20031206010505.GB14904@dualathlon.random>
Content-Type: multipart/mixed;
 boundary="------------030809010202050208060105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030809010202050208060105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

OK, no deadlock yet with 2.4.23aa1 however it oopsed under 
ext3_file_write() in __mark_inode_dirty().

Just to recap: this test is dual PIII, running several bonnie++ loads on 
an ext3+noatime+quota filesystem
mounted off

 From the oops the fault happens on the last instruction of:

        movl $0,8(%ebx)
        movl $0,4(%edx)
        movl 100(%edi),%eax 
        movl %edx,4(%eax)    <-- here

which appears to be this code in inode.c  [line 221+]

                if (!(inode->i_state & (I_LOCK|I_FREEING|I_CLEAR)) &&
                    !list_empty(&inode->i_hash)) {
                        list_del(&inode->i_list);
                        list_add(&inode->i_list, &sb->s_dirty);

After a quick browse of the assembler output the zeroing would appear to 
be part of the list_del inline,
and edi seems to equate to &sb. If I have read that correctly then the 
oops happens at the beginning of
the list_add() inline and eax is the head of the s_dirty list - pointing 
into oblivion.

__mark_inode_dirty() does not appear to take sb_lock before adding to 
the s_dirty list. Could that
be the culprit?   I'm completely unfamiliar with linux kernel so I might 
be way off here.

-Jamie

Andrea Arcangeli wrote:

>On Tue, Nov 04, 2003 at 07:52:40PM +0800, Jamie Clark wrote:
>  
>
>>I made the quick fix (disabling rq_mergeable) and started the load test.
>>Will let it run for a week or so.
>>    
>>
>
>does your later recent email means it deadlocked again even with this
>disabled?
>
>Could you try again with 2.4.23aa1 again just in case?
>
>  
>
>>FYI an observation from my last test: the read latency seems to be much
>>improved and more consistent under this kernel (2.4.23pre6aa3, before
>>the oops and before this fix).  The maximum latency seemed steady over
>>the whole test without any of the longish pauses that showed up under
>>2.4.19. Quite a difference.
>>    
>>
>
>nice to hear! thanks.
>  
>

--------------030809010202050208060105
Content-Type: text/plain;
 name="ksymoops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops"

ksymoops 2.4.5 on i686 2.4.23aa1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23aa1/ (default)
     -m /boot/System.map-2.4.23aa1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address d7ffbc0c
c0156eaf
*pde = 17c001e3
Oops: 0002 2.4.23aa1 #2 SMP Sat Dec 6 10:58:56 SGT 2003
CPU:    0
EIP:    0010:[<c0156eaf>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010287
eax: d7ffbc08   ebx: e2ae6a00   ecx: c02a11f8   edx: e2ae6a08
esi: 00000001   edi: f769e000   ebp: 00002000   esp: f2799ef8
ds: 0018   es: 0018   ss: 0018
Process bonnie++ (pid: 330, stackpage=f2799000)
Stack: e2ae6a00 e2ae6a00 f5110420 c0130973 e2ae6a00 00000001 e2ae6a6c e2ae6a00
       f5110420 00002000 e2ae6a00 ffffffeb f785d660 c014bf57 e2ae6a00 00000000
       00000000 e2ae6a00 e2ae6ac4 00000000 00000000 00000000 f5110420 c013108f
Call Trace:         [<c0130973>] (40) [<c014bf57>] (40) [<c013108f>] (36) [<c016f377>] (36) [<c0140e57>] (36) [<c0107133>] (60)
Code: 89 50 04 89 43 08 8d 47 64 89 42 04 89 57 64 c6 05 10 12 2a


>>EIP; c0156eaf <__mark_inode_dirty+93/b0>   <=====

>>eax; d7ffbc08 <END_OF_CODE+1462abd5/????>
>>ebx; e2ae6a00 <END_OF_CODE+1f1159cd/????>
>>ecx; c02a11f8 <inode_in_use+0/8>
>>edx; e2ae6a08 <END_OF_CODE+1f1159d5/????>
>>edi; f769e000 <END_OF_CODE+33cccfcd/????>
>>ebp; 00002000 Before first symbol
>>esp; f2799ef8 <END_OF_CODE+2edc8ec5/????>

Trace; c0130973 <generic_file_write_nolock+d3/4c8>
Trace; c014bf57 <permission+7b/84>
Trace; c013108f <generic_file_write+13f/158>
Trace; c016f377 <ext3_file_write+23/bc>
Trace; c0140e57 <sys_write+8f/100>
Trace; c0107133 <system_call+33/38>

Code;  c0156eaf <__mark_inode_dirty+93/b0>
00000000 <_EIP>:
Code;  c0156eaf <__mark_inode_dirty+93/b0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0156eb2 <__mark_inode_dirty+96/b0>
   3:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  c0156eb5 <__mark_inode_dirty+99/b0>
   6:   8d 47 64                  lea    0x64(%edi),%eax
Code;  c0156eb8 <__mark_inode_dirty+9c/b0>
   9:   89 42 04                  mov    %eax,0x4(%edx)
Code;  c0156ebb <__mark_inode_dirty+9f/b0>
   c:   89 57 64                  mov    %edx,0x64(%edi)
Code;  c0156ebe <__mark_inode_dirty+a2/b0>
   f:   c6 05 10 12 2a 00 00      movb   $0x0,0x2a1210


1 warning issued.  Results may not be reliable.

--------------030809010202050208060105--

