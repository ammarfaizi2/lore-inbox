Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVI2PHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVI2PHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVI2PHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:07:20 -0400
Received: from 203.197.88.2.ILL-PUNE.static.vsnl.net.in ([203.197.88.2]:6828
	"EHLO marvin.codito.net") by vger.kernel.org with ESMTP
	id S932178AbVI2PHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:07:19 -0400
Subject: Linux I-cache aliasing problem
From: Amit Bhor <amit.bhor@codito.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Codito Technologies Pvt. Ltd.
Date: Thu, 29 Sep 2005 20:35:52 +0530
Message-Id: <1128006353.7140.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, 

I am working on linux(2.4) port to a 32 bit RISC core. The question I
have is about cache aliasing. The architecture has virtually indexed and
physically tagged cache. The I-cache is a 2 way 32K cache and the page
size is 8K. Since the way size (16) is greater than the page size (8K)
it would suffer from I-cache aliasing. I am talking about the aliasing
case where 2 different virtual addresses can be indexed into the same
cache line and physical tag will also match. Basically 1 bit used for
virtual indexing which is also translated by the MMU. This is case is
different from the kernel-user aliasing where the same phys address is
mapped at two different virtual addresses. 

eg : 

31              14|13        5|4         0
 -----------------------------------------
|Phys tag         |Set index  |line offset|
 -----------------------------------------

0-4 i.e. 5 bits for line offset into a 32 byte line
5-13 i.e. 9 bits for indexing into a 32K 2 way cache (16K/512 sets per
way)
14-31 i.e. remaining 18 bits as a physical tag in the virt indexed phys
tagged cache

V->0x0000_0000  P->0x0000_0000
V->0x0001_0000  P->0x0000_2000

First lets say the program accesses address 0x0, the cache will be
indexed using the 9 index bits in the  virt addr (0x0) and the phys tag
will be the top 18 bits in the translated addr (again 0x0). Now say the
program accesses 0x0001_0000. The cache will be indexed using the index
bits which turn out to be 0x0 and the phys tag will also match(top 18
bits) thus causing an incorrect cache lookup.

One way of looking at the problem is that there are insufficient phys
tag bits and another is that one bit (bit 13) from virt addr is used to
index and it is also translated. 

I have take a look at the cache and tlb flush architecture with the help
of your documentation. I have also studied sparc64's page coloring to
avoid cache aliasing(pte_alloc* in pgalloc.h). But it seems to me that
this page colouring can only handle D-cache aliasing and not I-cache
aliasing (the above case) since Instruction/code pages mapped from
filesystem and not allocated using the pte_alloc* functions. 

Is my understanding correct ? Do you have any comments on this issue and
how, if at all, I can solve it.  Any help would be greatly appreciated.


Regards,
Amit


