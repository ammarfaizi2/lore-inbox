Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289903AbSAKIxX>; Fri, 11 Jan 2002 03:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289901AbSAKIxN>; Fri, 11 Jan 2002 03:53:13 -0500
Received: from [202.54.26.202] ([202.54.26.202]:51660 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S289896AbSAKIxE>;
	Fri, 11 Jan 2002 03:53:04 -0500
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256B3E.0030C343.00@sandesh.hss.hns.com>
Date: Fri, 11 Jan 2002 14:17:25 +0530
Subject: Re: [PATCH] locked page handling in shrink_cache() : revised
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Sorry...
I have corrected tha patch.

Thanks
Amol


--- vmscan_orig.c   Fri Jan 11 13:55:25 2002
+++ vmscan.c   Fri Jan 11 13:56:40 2002
@@ -387,6 +387,8 @@
                    wait_on_page(page);
                    page_cache_release(page);
                    spin_lock(&pagemap_lru_lock);
+                   list_del(&page.lru);
+                   list_add(&page.lru,inactive_list.prev);
               }
               continue;
          }







Ken Brownfield <brownfld@irridia.com> on 01/11/2002 12:34:09 PM

To:   Amol Lad/HSS@HSS
cc:

Subject:  Re: [PATCH] locked page handling in shrink_cache() : revised




FWIW, on a 2x933 P3, 256MB RAM, running "make -j36 bzImage".
--
Ken.
brownfld@irridia.com

ksymoops 2.4.3 on i686 2.4.18-pre3kb0.  Options used
     -V (default)
     -k ./ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-pre3kb0/ (default)
     -m /boot/System.map-x (specified)

kernel BUG at vmscan.c:387!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013092c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001c   ebx: c13657dc   ecx: c02d4568   edx: 00003998
esi: c13657c0   edi: 00000000   ebp: 00000010   esp: c9607ddc
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 3110, stackpage=c9607000)
Stack: c027a710 00000183 00000020 000001d2 00000020 00000006 c1407070 0000006e
       0000043f 000001d2 c02d5928 c0130e07 00000006 00000084 00000006 000001d2
       c02d5928 000001d2 000032c6 c02d5928 c0130e71 00000020 00000000 00000000
Call Trace: [<c0130e07>] [<c0130e71>] [<c013193a>] [<c0131c23>] [<c012aab2>]
   [<c01318c0>] [<c0126ba7>] [<c0126caf>] [<c0126ec4>] [<c0113d17>] [<c0113b88>]
   [<c01282ee>] [<c0127345>] [<c01071fc>]
Code: 0f 0b 83 c4 08 8b 53 04 8b 03 89 50 04 89 02 a1 04 81 35 c0

>>EIP; c013092c <shrink_cache+e4/458>   <=====
Trace; c0130e06 <shrink_caches+5a/90>
Trace; c0130e70 <try_to_free_pages+34/54>
Trace; c013193a <balance_classzone+76/240>
Trace; c0131c22 <__alloc_pages+11e/17c>
Trace; c012aab2 <filemap_nopage+10e/23c>
Trace; c01318c0 <_alloc_pages+18/1c>
Trace; c0126ba6 <do_anonymous_page+3a/110>
Trace; c0126cae <do_no_page+32/1ec>
Trace; c0126ec4 <handle_mm_fault+5c/bc>
Trace; c0113d16 <do_page_fault+18e/4e8>
Trace; c0113b88 <do_page_fault+0/4e8>
Trace; c01282ee <do_brk+11a/21c>
Trace; c0127344 <sys_brk+c0/f0>
Trace; c01071fc <error_code+34/3c>
Code;  c013092c <shrink_cache+e4/458>
00000000 <_EIP>:
Code;  c013092c <shrink_cache+e4/458>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013092e <shrink_cache+e6/458>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c0130930 <shrink_cache+e8/458>
   5:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c0130934 <shrink_cache+ec/458>
   8:   8b 03                     mov    (%ebx),%eax
Code;  c0130936 <shrink_cache+ee/458>
   a:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c0130938 <shrink_cache+f0/458>
   d:   89 02                     mov    %eax,(%edx)
Code;  c013093a <shrink_cache+f2/458>
   f:   a1 04 81 35 c0            mov    0xc0358104,%eax


On Tue, Jan 08, 2002 at 10:51:24AM +0530, alad@hss.hns.com wrote:
|
|
|
| Whenever the shrink_cache wakes up after a laundered page in unlocked, it
should
| move that page to the end of inactive list so that
| the page can be freed immediately and shrink_cache dosen't have to wait for
| complete list scan before freeing this page.
|
| The patch is created against standard redhat 7.1 distribution 2.4.16 kernel.
| Let me know if I need to create it for a different kernel release.
|
| regards
| Amol
|
|
| --- vmscan_orig.c   Mon Jan  7 11:47:43 2002
| +++ vmscan.c   Mon Jan  7 11:49:07 2002
| @@ -387,6 +387,8 @@
|                     wait_on_page(page);
|                     page_cache_release(page);
|                     spin_lock(&pagemap_lru_lock);
| +                   list_del(&page->lru);
| +                   list_add(&page->lru,inactive_list.prev);
|                }
|                continue;
|           }
|
| 

|
|
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/





Hughes Software Systems



