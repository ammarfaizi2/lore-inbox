Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316604AbSGGWsb>; Sun, 7 Jul 2002 18:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSGGWsa>; Sun, 7 Jul 2002 18:48:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:64459 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316604AbSGGWs2>;
	Sun, 7 Jul 2002 18:48:28 -0400
Message-ID: <3C88087A.2030704@us.ibm.com>
Date: Thu, 07 Mar 2002 16:40:26 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: truncate_list_pages() page lock confusion and BUG
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting BUG()s from page_alloc.c:109 in 2.5.6-pre2

truncate_list_pages() contains

failed = TryLockPage(page);

The page should always be locked when I get past there

shortly after this, truncate_complete_page() can be called

truncate_complete_page() calls:
         remove_inode_page(page);
              if (!PageLocked(page))
                 PAGE_BUG(page);
followed immediately by
         page_cache_release(page);
             calls __free_pages_ok(page, 0);
                 if (PageLocked(page))
                    BUG();

So, it appears that when truncate_complete_page() is called, it is a BUG 
if the page is unlocked in remove_inode_page(), or locked in 
page_cache_release().   What am I missing?  Actual bug follows:

kernel BUG at page_alloc.c:109!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c012f27c>]    Not tainted
EFLAGS: 00010202
eax: 01000001   ebx: c13ba15c   ecx: c13ba15c   edx: c13ba15c
esi: 00000000   edi: db5aff20   ebp: 00000000   esp: db5afe90
ds: 0018   es: 0018   ss: 0018
Stack: c13ba15c 00000000 db5aff20 00000000 c13ba15c c13ba15c 00000000 
c13ba15c
        00000000 db5aff20 00000000 c012717a c13ba15c 00000000 c012fb05 
c13ba15c
        c01271c2 c13ba15c c13ba15c c0127326 c13ba15c 00000000 db5aff20 
00000018
Call Trace: [<c012717a>] [<c012fb05>] [<c01271c2>] [<c0127326>] 
[<c01273db>]
    [<c0125192>] [<c012a49d>] [<c01361fb>] [<c0108a23>]
Code: 0f 0b 6d 00 60 89 24 c0 8b 4c 24 10 8b 41 18 a8 40 74 08 0f

 >>EIP; c012f27c <__free_pages_ok+6c/29c>   <=====
Trace; c012717a <do_flushpage+26/2c>
Trace; c012fb05 <page_cache_release+2d/30>
Trace; c01271c2 <truncate_complete_page+42/48>
Trace; c0127326 <truncate_list_pages+15e/1c4>
Trace; c01273db <truncate_inode_pages+4f/80>
Trace; c0125192 <vmtruncate+be/154>
Trace; c012a49d <generic_file_write+62d/6f8>
Trace; c01361fb <sys_write+8f/10c>
Trace; c0108a23 <syscall_call+7/b>
Code;  c012f27c <__free_pages_ok+6c/29c>
00000000 <_EIP>:
Code;  c012f27c <__free_pages_ok+6c/29c>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c012f27e <__free_pages_ok+6e/29c>
    2:   6d                        insl   (%dx),%es:(%edi)
Code;  c012f27f <__free_pages_ok+6f/29c>
    3:   00 60 89                  add    %ah,0xffffff89(%eax)
Code;  c012f282 <__free_pages_ok+72/29c>
    6:   24 c0                     and    $0xc0,%al
Code;  c012f284 <__free_pages_ok+74/29c>
    8:   8b 4c 24 10               mov    0x10(%esp,1),%ecx
Code;  c012f288 <__free_pages_ok+78/29c>
    c:   8b 41 18                  mov    0x18(%ecx),%eax
Code;  c012f28b <__free_pages_ok+7b/29c>
    f:   a8 40                     test   $0x40,%al
Code;  c012f28d <__free_pages_ok+7d/29c>
   11:   74 08                     je     1b <_EIP+0x1b> c012f297 
<__free_pages_ok+87/29c>
Code;  c012f28f <__free_pages_ok+7f/29c>
   13:   0f 00 00                  sldt   (%eax)

-- 
Dave Hansen
haveblue@us.ibm.com


