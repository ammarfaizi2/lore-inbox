Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267485AbUHDWnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267485AbUHDWnY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 18:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbUHDWnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 18:43:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:3553 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267485AbUHDWnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 18:43:21 -0400
Date: Wed, 4 Aug 2004 15:46:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com,
       tony.luck@intel.com
Subject: Re: [Patch 2.6.7]might-sleep-in-atomic while dumping elf
Message-Id: <20040804154644.211c5ae5.akpm@osdl.org>
In-Reply-To: <C0ECD887E2CBE349ACF9C483510BF8381C22DD@pdsmsx401.ccr.corp.intel.com>
References: <C0ECD887E2CBE349ACF9C483510BF8381C22DD@pdsmsx401.ccr.corp.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zou, Nanhai" <nanhai.zou@intel.com> wrote:
>
> Here is a patch to fix a problem of might-sleep-in-atomic which
> David Mosberger mentioned at
> http://www.gelato.unsw.edu.au/linux-ia64/0407/10526.html
> 
> On IA64 platform, a might-sleep-in-atomic warning raise while dumping a
> multi-thread process.
> That is because elf_cord_dump hold the tasklist_lock before kernel doing
> a access_process_vm in elf_core_copy_task_regs, 
> 
> This patch detached elf_core_copy_task_regs function from inside
> tasklist_lock to remove the warning.

hm, OK, no worse than what we had there before :(

That GFP_ATOMIC allocation of one 824-byte-on-x86 structure for each
thread looks really, really nasty.  It could easily chew up 100% of the page
reserves and fail.  I wonder if it is safe to drop the tasklist_lock while we 
allocate the memory?

You're still testing for a zero return from elf_dump_thread_status().  I
think that with your changes, that is no longer possible, is it?

Please edit in 80-col xterms.  You'll find that a layout such as the below
becomes more agreeable.


+		list_for_each(t, &thread_list) {
+			struct elf_thread_status *tmp;
+			int sz;
+
+			tmp = list_entry(t, struct elf_thread_status, list);
+			sz = elf_dump_thread_status(signr, tmp);


