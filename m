Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUCGUId (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 15:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUCGUId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 15:08:33 -0500
Received: from paja.kn.vutbr.cz ([147.229.191.135]:50437 "EHLO
	paja.kn.vutbr.cz") by vger.kernel.org with ESMTP id S262316AbUCGUIc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 15:08:32 -0500
Message-ID: <404B812F.7000204@stud.feec.vutbr.cz>
Date: Sun, 07 Mar 2004 21:08:15 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-pre2
References: <Pine.LNX.4.44.0403061618420.4428-100000@dmt.cyclades>
In-Reply-To: <Pine.LNX.4.44.0403061618420.4428-100000@dmt.cyclades>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> <mlord:pobox.com>:
>   o Fix vmalloc() error handling
> 

This change has a problem. In __vmalloc_area_pages when pmd_alloc fails, 
the spinlock will not be released. Maybe the following patch is needed? 
(only compile tested, I don't have SMP)

Michal Schmidt


--- linux-2.4.26-pre2/mm/vmalloc.c      Sun Mar  7 20:44:27 2004
+++ linux-2.4.26-pre2.mich/mm/vmalloc.c Sun Mar  7 20:54:02 2004
@@ -183,6 +183,7 @@ static inline int __vmalloc_area_pages (
  err:
         if (address > start)
                 vmfree_area_pages((address - start), address - start);
+       spin_unlock(&init_mm.page_table_lock);
         return -ENOMEM;
  }
