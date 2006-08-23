Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965281AbWHWWpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281AbWHWWpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 18:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbWHWWpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 18:45:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43973 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965281AbWHWWpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 18:45:17 -0400
Date: Wed, 23 Aug 2006 15:35:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 6/18] 2.6.17.9 perfmon2 patch for review: sampling
 format support
Message-Id: <20060823153537.cb36b9ac.akpm@osdl.org>
In-Reply-To: <200608230805.k7N85v1s000408@frankl.hpl.hp.com>
References: <200608230805.k7N85v1s000408@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 01:05:57 -0700
Stephane Eranian <eranian@frankl.hpl.hp.com> wrote:

> This files contains the sampling format support.
> 
> Perfmon2 supports an in-kernel sampling buffer for performance
> reasons. Yet to ensure maximum flexibility to applications,
> the formats is which infmration is recorded into the kernel
> buffer is not specified by the interface. Instead it is
> delegated to a kernel plug-in modules called sampling formats.
> 
> Each formats controls:
> 	- what is recorded in the the sampling buffer
> 	- how the information is recorded
> 	- when to notify the application to extract the information
> 	- how the buffer is exported to user level
> 	- hoe the buffer is allocated
> 
> Each format is identified via a 128-bit UUID which can be requested
> when the context is created with pfm_create_context().
> 
> The interface comes with a simple default sampling format. It records
> information sequentially in the buffer. Each entry, called sample,
> is composed of a fixed size header and a variable size body where
> the values of PMDS can be recorded based upon the user's request.
> 
> Sampling formats can be dynamically registered with perfmon. The management
> of sampling formats is implemented in perfmon_fmt.c:
> 
> pfm_register_smpl_fmt(struct pfm_smpl_fmt *fmt):
> 	- register a new sampling format
> 		
> pfm_unregister_smpl_fmt(pfm_uuid_t uuid):
> 	- unregister a sampling format
> 
> It is possible to list the available formats by looking at /sys/kernel/perfmon/formats.
> 

Why identify a format with a UUID rather than via a nice human-readable name?

> +/*
> + * find a buffer format based on its uuid
> + */
> +struct pfm_smpl_fmt *pfm_smpl_fmt_get(pfm_uuid_t uuid)
> +{
> +	struct pfm_smpl_fmt * fmt;
> +
> +	spin_lock(&pfm_smpl_fmt_lock);
> +
> +	fmt = __pfm_find_smpl_fmt(uuid);
> +
> +	/*
> +	 * increase module refcount
> +	 */
> +	if (fmt && fmt_is_mod(fmt) && !try_module_get(fmt->owner))
> +		fmt = NULL;
> +
> +	spin_unlock(&pfm_smpl_fmt_lock);
> +
> +	return fmt;
> +}

Is pfm_smpl_fmt_lock really needed?  The module API _should_ be unracy wrt
lookup and removal.  If the name of the module was equal to the name of the
format (sensible) then perhaps the module system's
refcounting/atomicity/lookup mechanisms are sufficient?

> +	pfm_sysfs_add_fmt(fmt);

Please check for and handle all sysfs-related errors.  All errors, indeed.

Yes, a lot of the kernel blithely assumes that sysfs operations never fail.
We need to fix that badness rather than copy it.


