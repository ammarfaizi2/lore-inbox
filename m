Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265424AbUFVTEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265424AbUFVTEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265133AbUFVTC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:02:27 -0400
Received: from fujitsu1.fujitsu.com ([192.240.0.1]:14516 "EHLO
	fujitsu1.fujitsu.com") by vger.kernel.org with ESMTP
	id S265359AbUFVTA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:00:57 -0400
Date: Tue, 22 Jun 2004 12:00:33 -0700
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Merging Nonlinear and Numa style memory hotplug
Cc: Linux-Node-Hotplug <lhns-devel@lists.sourceforge.net>,
       linux-mm <linux-mm@kvack.org>
Message-Id: <20040622114733.30A6.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

I made merging patches between Nonlinear and Node style
memory hotplug code. I hope that this patches will work
for both of SMP style memory hotplug and NUMA style memory 
hotplug.
The patches is here.
  http://osdn.dl.sourceforge.net/sourceforge/lhms/20040621.tgz

These patches are for Linux 2.6.5.

Please comment.

Bye.

------------------
Note: 
 These patches base is Takahashi-san and Iwamoto-san's patches.
 and this includes nonlinear's code.
 Modifications from them are ...
  - CONFIG definition was divided like this
           CONFIG_HOTPLUG_MEMORY   (common part)
           CONFIG_HOTPLUG_MEMORY_OF_NODE (only node style hotplug)
           CONFIG_HOTPLUG_MEMORY_NONLINAR (only mem_section style 
					   hotplug)
  - Some of strucure's member are added to mem_section[] to 
    unify between nonlinear and node style hotplug.
  - Basic implementation mem_section's hotremove. (See below.)
  - Using NUMA code of build_zonelist() for NUMA style 
    memory hotplug.
  - Code cleaned up Memory hotadd for NUMA style.
    
  Following is remain issue.
    - Hotremovable attribute is vague concept in these patches.
      I don't have suitable solution for it yet.
    - Memory hot-add for memsection.
    - rmap is changed in 2.6.7. These patches should 
      reflect the changes.
  
  These patches are trial. So, system down might occur.
  (Especially, after nonlinear hot-removing code execution.)

-------------------------------------------------
About hotremove for mem_section 
(Using PG_booked)

Hot-remove needs 3 features.
  1. Prohibition reallocation in the removing area against
     page allocator.
  2. Page migration from removing area
  3. System repeats 2. until freeing all of the memory in the area.
     So, system has to know all of memory freed.

1. and 3. have problem for memsection hot-remove.
In Node removing case, system could avoid reallocation
by removing zone from zone_list. But its way can’t be used 
for memsection. System could count freed page by using free_pages
in the zone. But, it will has to know freed area
in the 'removing memsection'.
  
Takahashi-san proposed me that it use PG_book in the page flag 
for prohibition of reallocation in the mem_section. (This flag was
used for reservation of destination of huge-page's migration in
these patches.)
  - System doesn’t allocate booked pages.
  - System doesn’t return the page to per_cpu_page,
    return it to buddy allocator immediately.
  - When all pages in the section are booked and freed,
    system can find that the section can remove.



-- 
Yasunori Goto <ygoto at us.fujitsu.com>


