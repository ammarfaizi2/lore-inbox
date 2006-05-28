Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWE1KbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWE1KbQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 06:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWE1KbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 06:31:16 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:25285 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750716AbWE1KbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 06:31:15 -0400
Message-ID: <44797BEF.70206@gmail.com>
Date: Sun, 28 May 2006 11:31:11 +0100
From: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Possible kernel memory leaks
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are some possible kernel memory leaks discovered by kmemleak. I
didn't have time for investigating them. Please let me know if they are
not leaks so that I can improve kmemleak (or just add a false alarm call):

- acpi_evaluate_integer in drivers/acpi/utils.c - "element" is not freed
on the error path (if Coverity hasn't seen this, it was probably
confused by the return_* macros)

- acpi_ev_execute_reg_method in drivers/acpi/events/evregion.c - I'm not
sure about this but kmemleak reports an orphan pointer on the following
allocation path:
  c0159372: <kmem_cache_alloc>
  c01ffa07: <acpi_os_acquire_object>
  c0215b3a: <acpi_ut_allocate_object_desc_dbg>
  c02159ce: <acpi_ut_create_internal_object_dbg>
  c0203784: <acpi_ev_execute_reg_method>
  c0203db4: <acpi_ev_reg_run>
  c020ed17: <acpi_ns_walk_namespace>
  c0203d6b: <acpi_ev_execute_reg_methods>
Is acpi_ut_remove_reference actually removing the params[0/1]?

And some new false positives (kmemleak needs fixing):

- legacy_init_iomem_resources in arch/i386/kernel/setup.c - kmemleak is
probably right here in that "res" can never be freed since the pointer
was lost. However, there is no need to free this resource and that's why
I'll add a false alarm call

- there are a lot of false positives caused by module loading. I would
need to investigate these a bit more (it's missing a root memory block
that can lead to the reported pointers; it's also missing the static
variables in module)

Thanks,

Catalin
