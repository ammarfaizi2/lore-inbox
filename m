Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWEaNrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWEaNrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 09:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWEaNrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 09:47:41 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:37869 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S965017AbWEaNrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 09:47:40 -0400
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Possible kernel memory leaks
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
References: <44797BEF.70206@gmail.com>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 31 May 2006 14:47:35 +0100
In-Reply-To: <44797BEF.70206@gmail.com> (Catalin Marinas's message of "Sun,
 28 May 2006 11:31:11 +0100")
Message-ID: <tnxk682wbk8.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 May 2006 13:47:37.0167 (UTC) FILETIME=[C6DA1DF0:01C684B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> wrote:
> There are some possible kernel memory leaks discovered by kmemleak. I
> didn't have time for investigating them. Please let me know if they are
> not leaks so that I can improve kmemleak (or just add a false alarm call):
[...]
> - acpi_ev_execute_reg_method in drivers/acpi/events/evregion.c - I'm not
> sure about this but kmemleak reports an orphan pointer on the following
> allocation path:
>   c0159372: <kmem_cache_alloc>
>   c01ffa07: <acpi_os_acquire_object>
>   c0215b3a: <acpi_ut_allocate_object_desc_dbg>
>   c02159ce: <acpi_ut_create_internal_object_dbg>
>   c0203784: <acpi_ev_execute_reg_method>
>   c0203db4: <acpi_ev_reg_run>
>   c020ed17: <acpi_ns_walk_namespace>
>   c0203d6b: <acpi_ev_execute_reg_methods>
> Is acpi_ut_remove_reference actually removing the params[0/1]?

After a quick check, the reference counts after the
acpi_ns_evaluate_by_handle() call in acpi_ev_execute_reg_method look
like this (they were both 1 before this call):

  params[0]->common.reference_count = 1
  params[1]->common.reference_count = 2

and therefore acpi_ut_remove_reference() doesn't free
params[1]. Kmemleak, however, cannot find the params[1] value while
scanning the memory and therefore reports it as a leak.

Is this normal behaviour for the acpi_ev_execute_reg_method function?
There isn't anything obvious looking at the calling tree (which I
would say is pretty complex).

-- 
Catalin
