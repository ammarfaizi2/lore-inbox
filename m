Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264997AbSJPOcZ>; Wed, 16 Oct 2002 10:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264998AbSJPOcZ>; Wed, 16 Oct 2002 10:32:25 -0400
Received: from matrix.roma2.infn.it ([141.108.255.2]:64746 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id <S264997AbSJPOcY>; Wed, 16 Oct 2002 10:32:24 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Emiliano Gabrielli <Emiliano.Gabrielli@roma2.infn.it>
To: tlan@zet.no, linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at swap.c:62 [2.4.19 vanilla]
Date: Wed, 16 Oct 2002 16:38:45 +0200
User-Agent: KMail/1.4.3
References: <20021016150131.F26786@stine.vestdata.no>
In-Reply-To: <20021016150131.F26786@stine.vestdata.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210161638.45032.gabrielli@roma2.infn.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:01, mercoledì 16 ottobre 2002, Thomas Langås wrote:
> Reading Oops report from the terminal
> kernel BUG at swap.c:62!
> kernel BUG at swap.c:62!
> invalid operand: 0000
> CPU:    1
> EIP:    0010:[<c01329ca>]    Not tainted
> EFLAGS: 00010202
> invalid operand: 0000

>
> This is a vanilla 2.4.19 kernel, and we've seen this bug on several
> machines, but we haven't been able to find out what triggers it. And I
> don't see a BUG-statement at swap.c line 62.  So, anyone with an idea of
> what to do is welcome with suggestions :)

well, the BUG() is inplicit in add_page_to_inactive_list in linux.c:61, this 
macro is defined in linux/swap.h:197.

Could this one is a patch ?!?:

@linux/swap.h
#define DEBUG_LRU_PAGE(page)                    \
do {                                            \
-        if (!PageLRU(page))                     \
-                BUG();                          \
-        if (PageActive(page))                   \
-                BUG();                          \
+        BUG_ON(!PageLRU(page))                  \
+        BUG_ON (PageActive(page))               \
} while (0)

@mm/swap.c
void lru_cache_add(struct page * page)
{
+        spin_lock(&pagemap_lru_lock);
        if (!TestSetPageLRU(page)) {
-        spin_lock(&pagemap_lru_lock);
	add_page_to_inactive_list(page);
-        spin_unlock(&pagemap_lru_lock);
        }
+        spin_unlock(&pagemap_lru_lock);
}

best reguards 

Emiliano 'AlberT' Gabrielli

