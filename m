Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWDCARN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWDCARN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 20:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWDCARN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 20:17:13 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:17346 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932069AbWDCARN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 20:17:13 -0400
Date: Mon, 3 Apr 2006 09:15:04 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: include/asm-arm/memory.h changes break zaurus sl-5500 boot
Message-Id: <20060403091504.ecd341a3.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060402222314.GC12166@elf.ucw.cz>
References: <20060402210003.GA11979@elf.ucw.cz>
	<20060402220807.GD13901@flint.arm.linux.org.uk>
	<20060402222314.GC12166@elf.ucw.cz>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2006 00:23:14 +0200
Pavel Machek <pavel@ucw.cz> wrote:
> > Not surprising given this gem:
> > 
> > > -#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR((pfn) << PAGE_OFFSET))
> > 
> > PAGE_OFFSET being 3GB - that's one hell of a shift value!
> 
> Unfortunately this is mainline now. Is there some better fix than
> simply reverting the offending patches?

Maybe this one will fix (against 2.6.16-mm2)

LOCAL_MAP_NR(kaddr) returns page offset in a node.


-Kame
==
Index: linux-2.6.16-mm2/include/asm-arm/memory.h
===================================================================
--- linux-2.6.16-mm2.orig/include/asm-arm/memory.h
+++ linux-2.6.16-mm2/include/asm-arm/memory.h
@@ -188,7 +188,7 @@ static inline __deprecated void *bus_to_
  */
 #include <linux/numa.h>
 #define arch_pfn_to_nid(pfn)	(PFN_TO_NID(pfn))
-#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR((pfn) << PAGE_OFFSET))
+#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR(__va((pfn) << PAGE_SHIFT)))
 
 #define pfn_valid(pfn)						\
 	({							\

