Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUIJVBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUIJVBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUIJVBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:01:38 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:9448 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267872AbUIJVBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:01:24 -0400
Message-ID: <4142161F.1060904@nortelnetworks.com>
Date: Fri, 10 Sep 2004 15:01:19 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: Hugh Dickins <hugh@veritas.com>
Subject: problems with remap_page_range() and virt_to_phys() -- solved
References: <4140EEDA.2040909@nortelnetworks.com>
In-Reply-To: <4140EEDA.2040909@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friesen, Christopher [CAR:VC21:EXCH] wrote:


> The problem that I'm having is that after the call to remap_page_range, 
> the result of
> 
> virt_to_phys(map_addr)
> 
> is not equal to "phys", and I assume it should be since its supposed to 
> be pointing to the same physical page as "virt".

I seem to have found my problem.  There were two things involved:

1) virt_to_phys() doesn't work on user addresses, so you basically have to walk 
the page tables.  For ppc, iopa() seems to do this although there is a comment 
about it not working on pmac (which it seems to).

2) to setup the vma for unmapped areas I was using mmap with MAP_PRIVATE.  On 
the first write by userspace, the mapping was changed and the user page was no 
longer mapped to the desired kernel page.  Changing this to MAP_SHARED fixed it.

Chris
