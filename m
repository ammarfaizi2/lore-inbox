Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVAOVjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVAOVjI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 16:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVAOVjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 16:39:08 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:62085 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262328AbVAOVjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 16:39:01 -0500
Date: Sat, 15 Jan 2005 22:39:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: slab.c use of __get_user and sparse
Message-ID: <20050115213906.GA22486@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andi Kleen <ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi, lkml.

In slab.c around line 1450 the following code is present:

list_for_each(p, &cache_chain) {
	kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
	char tmp;
	/* This happens when the module gets unloaded and doesn't
	   destroy its slab cache and noone else reuses the vmalloc
	   area of the module. Print a warning. */
	if (__get_user(tmp,(char __user *) pc->name)) { 
		printk("SLAB: cache with size %d has lost its name\n", 
			pc->objsize); 
		continue; 

sparse emit a warning for the line with __get_user because the pointer
is not marker __user. So the above cast inserted by me made sparse shut up.

Based on the comment it is understood that suddenly this pointer points
to userspace, because the module got unloaded.
I wonder why we can rely on the same address now the module got unloaded -
we may risk this virtual address is taken over by someone else?

Andi - sent to you since you made this change loong time ago.

[mm/ is sparse clean with defconfig when this is fixed].

	Sam
