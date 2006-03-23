Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWCWLIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWCWLIh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 06:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWCWLIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 06:08:37 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:63423 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S964807AbWCWLIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 06:08:36 -0500
Date: Thu, 23 Mar 2006 12:08:31 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, linux-mm@kvack.org, wli@holomorphy.com
Subject: mm/hugetlb.c/alloc_fresh_huge_page(): slow division on NUMA
Message-ID: <20060323110831.GA14855@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

following up on my previous mail
(subject "ring buffer indices: way too much modulo (division!) fiddling"),
I switched my .config to a NUMA setup and found that on NUMA there
indeed is an idiv opcode in the mm/hugetlb.o output:

 138:   e8 fc ff ff ff          call   139 <alloc_fresh_huge_page+0x32>
 13d:   8b 1d 10 00 00 00       mov    0x10,%ebx
 143:   89 c6                   mov    %eax,%esi
 145:   83 c3 01                add    $0x1,%ebx
 148:   c7 44 24 04 10 00 00    movl   $0x10,0x4(%esp)
 14f:   00
 150:   c7 04 24 00 00 00 00    movl   $0x0,(%esp)
 157:   e8 fc ff ff ff          call   158 <alloc_fresh_huge_page+0x51>
 15c:   89 c2                   mov    %eax,%edx
 15e:   89 d8                   mov    %ebx,%eax
 160:   89 d1                   mov    %edx,%ecx
 162:   99                      cltd
 163:   f7 f9                   idiv   %ecx
 165:   85 f6                   test   %esi,%esi
 167:   89 15 10 00 00 00       mov    %edx,0x10
 16d:   74 3a                   je     1a9 <alloc_fresh_huge_page+0xa2>
 16f:   b8 00 00 00 00          mov    $0x0,%eax
 174:   e8 fc ff ff ff          call   175 <alloc_fresh_huge_page+0x6e>

Changing the code to use:

        /* nid = (nid + 1) % num_online_nodes(); */
        nid++;
        if (nid >= num_online_nodes())
                nid = 0;

results in:

 139:   e8 fc ff ff ff          call   13a <alloc_fresh_huge_page+0x33>
 13e:   83 05 10 00 00 00 01    addl   $0x1,0x10
 145:   89 c3                   mov    %eax,%ebx
 147:   c7 44 24 04 10 00 00    movl   $0x10,0x4(%esp)
 14e:   00
 14f:   c7 04 24 00 00 00 00    movl   $0x0,(%esp)
 156:   e8 fc ff ff ff          call   157 <alloc_fresh_huge_page+0x50>
 15b:   39 05 10 00 00 00       cmp    %eax,0x10
 161:   7c 0a                   jl     16d <alloc_fresh_huge_page+0x66>
 163:   c7 05 10 00 00 00 00    movl   $0x0,0x10
 16a:   00 00 00
 16d:   85 db                   test   %ebx,%ebx
 16f:   74 3a                   je     1ab <alloc_fresh_huge_page+0xa4>
 171:   b8 00 00 00 00          mov    $0x0,%eax
 176:   e8 fc ff ff ff          call   177 <alloc_fresh_huge_page+0x70>

avoiding the idiv slowness.

At this point I wanted to add a huge rant that while this is faster,
we're now not thread-safe any more (I thought that the modulo increment
was an atomic operation), but analyzing the above code it is obvious
that both versions are not atomic, so sending a patch with this change
should be fine I guess?

Andreas Mohr
