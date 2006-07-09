Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161178AbWGIWI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161178AbWGIWI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161179AbWGIWIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:08:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:61422 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161178AbWGIWIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:08:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=e2fO39XGnUJJ8Z17YDMcAPLZRkAMs46DfJ/w77vjqjbN5y8gYC5cy6P7QCrNenz4fGJ5ntHv0l96NA7ofAV0I0U4LRetPu/ZzRY46XOq+Ti/JU5KEqSA2yJzDXMnh8YPJIBH5Bvk+rtKOjXaGutu7Byxru6ad5pQlq2JmfQivvw=
Message-ID: <44B0CE8A.3090401@gmail.com>
Date: Sun, 09 Jul 2006 15:08:18 +0530
From: "Om.Turyx" <om.turyx@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: regarding mem_map in NUMA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
While going through Mel gorman's book, I read that mem_map for NUMA
systems is  treated as a virtual array at PAGE_OFFSET. I could 
understand the the explanation  as follows.

mem_map[pfn] should not be accessed as it is. calculate the actual
node corresponding to pfn and access the page as
pglist_data[A]->node_zonelists[B]->zone_mem_map[C], where,
A : node_id, calculated using pfn,
B : offset in the zonelist calculated using pfn and,
C : offset in the local mem_map calculated using pfn.

Searching google resulted in http://lwn.net/Articles/9188/ Under other 
memory management work, it states mem_map[x] is not recommended in NUMA. 
Instead pfn_to_page() must be used.
from include/asm-i386/mmzone.h,
#define pfn_to_page(pfn)                        \
({\
    unsigned long __pfn = pfn;\
    int __node  = pfn_to_nid(__pfn);\
    &NODE_DATA(__node)->node_mem_map[node_localnr(__pfn,__node)];\
})
Means, pfn is used to traverse nodeid, and node_mem_map.
But even now I have not found where mem_map is initialized to 
PAGE_OFFSET, neither the significance of it.

Now, why should the mem_map be initialized to PAGE_OFFSET? Where is it
done? In page_alloc.c, I found mem_map = NODE_DATA(0)->node_mem_map;
when CONFIG_FLAT_NODE_MEM_MAP  is defined (non numa case).  If my
understanding is correct, this case should hold for NUMA as well.


Regards,
Om.
