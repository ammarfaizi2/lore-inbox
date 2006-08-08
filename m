Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWHHBMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWHHBMk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 21:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWHHBMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 21:12:40 -0400
Received: from twin.jikos.cz ([213.151.79.26]:57837 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751143AbWHHBMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 21:12:39 -0400
Date: Tue, 8 Aug 2006 03:12:27 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>
cc: Len Brown <len.brown@intel.com>, linux-acpi@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RESEND] [PATCH] ACPI - change GFP_ATOMIC to GFP_KERNEL for
 non-atomic allocation
In-Reply-To: <20060807135836.d766c50e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0608080300130.26318@twin.jikos.cz>
References: <Pine.LNX.4.58.0608071602480.26318@twin.jikos.cz>
 <20060807135836.d766c50e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006, Andrew Morton wrote:

> acpi_os_acquire_object() is fixed in -rc4.  I queued the
> acpi_pci_link_set() improvement for sending on to Len, thanks.  

Thanks. Unfortunately, looking at the refactorized ACPI code in 
2.6.18-rc4, there are still issues with sleeping functions called with 
disabled interrupts (during resume), in ACPI code.

Two random examples:

- when acpi_pci_link_set() is called during resume (local irqs off), the 
following callchain happens, which is bad: acpi_pci_link_resume -> 
acpi_pci_link_set -> acpi_set_current_resources -> 
acpi_rs_set_srs_method_data -> acpi_ns_evaluate -> acpi_ns_get_node .. 
here the mutex is acquired. Not good. 

- device_power_up -> sysdev_resume -> __sysdev_resume -> cpufreq_resume -> 
blocking_notifier_call_chain -> down on semaphore. Not good.

Is there any general idea for solution?

-- 
JiKos.
