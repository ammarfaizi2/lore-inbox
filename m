Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSCHWOY>; Fri, 8 Mar 2002 17:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286687AbSCHWON>; Fri, 8 Mar 2002 17:14:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:5014 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S286322AbSCHWN6>;
	Fri, 8 Mar 2002 17:13:58 -0500
Message-ID: <3C89379B.4020107@us.ibm.com>
Date: Fri, 08 Mar 2002 14:13:47 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: truncate_list_pages()  BUG and confusion
In-Reply-To: <3C880EFF.A0789715@zip.com.au>,		<3C8809BA.4070003@us.ibm.com> <3C880EFF.A0789715@zip.com.au> <17920000.1015622098@flay> <3C8932CC.761C8829@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> If the page_cache_release() in truncate_complete_page() is calling
> __free_pages_ok() then something really horrid has happened.

Something horrid _IS_ happening:

kernel BUG at page_alloc.c:109!
CPU:    1
EIP:    0010:[<c012d9ac>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 01000005   ebx: c1471560   ecx: c1471560   edx: c1471560
esi: 00000000   edi: 00000000   ebp: 00000000   esp: da569ed0
ds: 0018   es: 0018   ss: 0018
Stack: c1471560 00000000 00000000 00000000 c1471560 c1471560 00000000 
c1471560
        00000000 00000000 00000000 c012574a c1471560 00000000 c012e235 
c1471560
        c0125792 c1471560 c1471560 c01258f6 c1471560 00000000 da569f60 
00000000
Call Trace: [<c012574a>] [<c012e235>] [<c0125792>] [<c01258f6>] 
[<c01259ab>]
    [<c0148df5>] [<c0146697>] [<c0140635>] [<c01070a3>]
Code: 0f 0b 6d 00 80 6d 23 c0 8b 4c 24 10 8b 41 18 a8 40 74 08 0f

 >>EIP; c012d9ac <__free_pages_ok+6c/29c>   <=====
Trace; c012574a <do_flushpage+26/2c>
Trace; c012e235 <page_cache_release+2d/30>
Trace; c0125792 <truncate_complete_page+42/48>
Trace; c01258f6 <truncate_list_pages+15e/1c4>
Trace; c01259ab <truncate_inode_pages+4f/80>
Trace; c0148df5 <iput+b5/1d8>
Trace; c0146697 <dput+e7/148>
Trace; c0140635 <sys_unlink+b1/124>
Trace; c01070a3 <syscall_call+7/b>
Code;  c012d9ac <__free_pages_ok+6c/29c>
00000000 <_EIP>:
Code;  c012d9ac <__free_pages_ok+6c/29c>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c012d9ae <__free_pages_ok+6e/29c>
    2:   6d                        insl   (%dx),%es:(%edi)
Code;  c012d9af <__free_pages_ok+6f/29c>
    3:   00 80 6d 23 c0 8b         add    %al,0x8bc0236d(%eax)
Code;  c012d9b5 <__free_pages_ok+75/29c>
    9:   4c                        dec    %esp
Code;  c012d9b6 <__free_pages_ok+76/29c>
    a:   24 10                     and    $0x10,%al
Code;  c012d9b8 <__free_pages_ok+78/29c>
    c:   8b 41 18                  mov    0x18(%ecx),%eax
Code;  c012d9bb <__free_pages_ok+7b/29c>
    f:   a8 40                     test   $0x40,%al
Code;  c012d9bd <__free_pages_ok+7d/29c>
   11:   74 08                     je     1b <_EIP+0x1b> c012d9c7 
<__free_pages_ok+87/29c>
Code;  c012d9bf <__free_pages_ok+7f/29c>
   13:   0f 00 00                  sldt   (%eax)

 > Is this happening with the dbench/ENOSPC/1k blocksize testcase?
yes

For this particular one, dbench ran without failure, but while rm'ing 
the leftover directories, it BUGged.

-- 
Dave Hansen
haveblue@us.ibm.com

