Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWHGU6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWHGU6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 16:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWHGU6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:58:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29633 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932352AbWHGU6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:58:42 -0400
Date: Mon, 7 Aug 2006 13:58:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RESEND] [PATCH] ACPI - change GFP_ATOMIC to GFP_KERNEL for
 non-atomic allocation
Message-Id: <20060807135836.d766c50e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0608071602480.26318@twin.jikos.cz>
References: <Pine.LNX.4.58.0608071602480.26318@twin.jikos.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006 16:30:43 +0200 (CEST)
Jiri Kosina <jikos@jikos.cz> wrote:

> acpi_pci_link_set() allocates with GFP_ATOMIC. On resume from suspend,
> this is called with interrupts off, otherwise GFP_KERNEL is safe.
> 
> On the other hand, when resuming from suspend with interrupts off, the 
> following callchain allocates with GFP_KERNEL, which is wrong:
> 
> acpi_pci_link_resume -> acpi_pci_link_set -> acpi_set_current_resources ->
> acpi_rs_set_srs_method_data -> acpi_ut_create_internal_object_dbg ->
> acpi_ut_allocate_object_desc_dbg -> acpi_os_acquire_object ->
> kmem_cache_alloc(GFP_KERNEL) flag.
> 
> Resending patch, which didn't make it into -rc4, to fix both issues. The
> patch is intentionally using irqs_disabled() and does not check in_resume
> flag, as this is marked for removal (which is for example how
> acpi_os_allocate() checks whether it should perform GFP_KERNEL or
> GFP_ATOMIC allocation).

acpi_os_acquire_object() is fixed in -rc4.  I queued the
acpi_pci_link_set() improvement for sending on to Len, thanks.  
