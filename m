Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWDZRHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWDZRHq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 13:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWDZRHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 13:07:46 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:7041 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932327AbWDZRHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 13:07:45 -0400
Date: Wed, 26 Apr 2006 19:07:42 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kswapd oops reproduced with 2.6.17-rc2 (was Oops with 2.6.15.3 on amd64)
Message-ID: <20060426170742.GA14280@uio.no>
References: <20060422221232.GA6269@uio.no> <20060426151535.GA13203@uio.no> <200604261740.47107.Rafal.Wysocki@fuw.edu.pl> <20060426161214.GA13689@uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060426161214.GA13689@uio.no>
X-Operating-System: Linux 2.6.14.3 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 06:12:14PM +0200, Steinar H. Gunderson wrote:
> It isn't, but I hadn't changed the sources, .config or build environment
> since I built it, so I did a straight recompile with CONFIG_DEBUG_INFO set,
> and got:
> 
>   (gdb) l *(isolate_lru_pages+74)
>   0xffffffff80250c2a is in isolate_lru_pages (list.h:154).
> 
> (I had to run gdb on a machine with 64-bit userspace, but I guess just
> copying the vmlinux file should suffice.)

FWIW, I kept on looking at this, and I believe the kernel's symbol table is
borked somehow. The code doesn't match with the disassembly at all, and the
address of isolate_lru_pages in my disassembly doesn't really match what's
in /proc/kallsyms. OTOH, if I disassemble, I can find the exact code fragment
from the "Code" dump at:

  ffffffff8025096a <invalidate_mapping_pages>:
  
  <...>

  static inline int page_mapped(struct page *page)
  {
          return atomic_read(&(page)->_mapcount) >= 0;
  ffffffff802509cf:       75 0a                   jne    ffffffff802509db <invalidate_mapping_pages+0x71>
  ffffffff802509d1:       0f 0b                   ud2a   
  ffffffff802509d3:       68 9d 0f 3c 80          pushq  $0xffffffff803c0f9d
  ffffffff802509d8:       c2 4f 02                retq   $0x24f
  ffffffff802509db:       49 8b 10                mov    (%r8),%rdx
  ffffffff802509de:       49 8b 40 08             mov    0x8(%r8),%rax
  ffffffff802509e2:       48 89 42 08             mov    %rax,0x8(%rdx)
  ffffffff802509e6:       48 89 10                mov    %rdx,(%rax)                      <-- crash is here
  ffffffff802509e9:       41 8b 50 e0             mov    0xffffffffffffffe0(%r8),%edx
  ffffffff802509ed:       49 c7 00 00 01 10 00    movq   $0x100100,(%r8)
  ffffffff802509f4:       49 c7 40 08 00 02 20    movq   $0x200200,0x8(%r8)
  ffffffff802509fb:       00 

which matches the _address_ from the kernel, but not the _symbol_ it spits
out. Something's odd here :-)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
