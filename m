Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWIAQJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWIAQJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWIAQJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:09:55 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:50935 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932159AbWIAQJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:09:53 -0400
Date: Fri, 1 Sep 2006 09:09:25 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/18] 2.6.17.9 perfmon2 patch for review: sampling format support
Message-ID: <20060901160925.GF27854@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230805.k7N85v1s000408@frankl.hpl.hp.com> <20060823153537.cb36b9ac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823153537.cb36b9ac.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Wed, Aug 23, 2006 at 03:35:37PM -0700, Andrew Morton wrote:
> On Wed, 23 Aug 2006 01:05:57 -0700
> Stephane Eranian <eranian@frankl.hpl.hp.com> wrote:
> 
> > This files contains the sampling format support.
> > 
> > Perfmon2 supports an in-kernel sampling buffer for performance
> > reasons. Yet to ensure maximum flexibility to applications,
> > the formats is which infmration is recorded into the kernel
> > buffer is not specified by the interface. Instead it is
> > delegated to a kernel plug-in modules called sampling formats.
> > 
> > Each formats controls:
> > 	- what is recorded in the the sampling buffer
> > 	- how the information is recorded
> > 	- when to notify the application to extract the information
> > 	- how the buffer is exported to user level
> > 	- hoe the buffer is allocated
> > 
> > Each format is identified via a 128-bit UUID which can be requested
> > when the context is created with pfm_create_context().
> > 
> > The interface comes with a simple default sampling format. It records
> > information sequentially in the buffer. Each entry, called sample,
> > is composed of a fixed size header and a variable size body where
> > the values of PMDS can be recorded based upon the user's request.
> > 
> > Sampling formats can be dynamically registered with perfmon. The management
> > of sampling formats is implemented in perfmon_fmt.c:
> > 
> > pfm_register_smpl_fmt(struct pfm_smpl_fmt *fmt):
> > 	- register a new sampling format
> > 		
> > pfm_unregister_smpl_fmt(pfm_uuid_t uuid):
> > 	- unregister a sampling format
> > 
> > It is possible to list the available formats by looking at /sys/kernel/perfmon/formats.
> > 
> 
> Why identify a format with a UUID rather than via a nice human-readable name?
> 

Although a UUID is slightly more difficult to manipulate than a clear text string, it
offers several advantages:
	- is guaranteed unique
	- generation is fully distributed
	- easy generation with uuidgen
	- fixed size
	- very easy to pass to the kernel, there is not char * in a struct pass to kernel
	- not to worry about '\0'

We use UUID to idenitfy a format + a version number. The version number can be useful
to identify backward compatible versions of a format.

> > +/*
> > + * find a buffer format based on its uuid
> > + */
> > +struct pfm_smpl_fmt *pfm_smpl_fmt_get(pfm_uuid_t uuid)
> > +{
> > +	struct pfm_smpl_fmt * fmt;
> > +
> > +	spin_lock(&pfm_smpl_fmt_lock);
> > +
> > +	fmt = __pfm_find_smpl_fmt(uuid);
> > +
> > +	/*
> > +	 * increase module refcount
> > +	 */
> > +	if (fmt && fmt_is_mod(fmt) && !try_module_get(fmt->owner))
> > +		fmt = NULL;
> > +
> > +	spin_unlock(&pfm_smpl_fmt_lock);
> > +
> > +	return fmt;
> > +}
> 
> Is pfm_smpl_fmt_lock really needed?  The module API _should_ be unracy wrt
> lookup and removal.  If the name of the module was equal to the name of the
> format (sensible) then perhaps the module system's
> refcounting/atomicity/lookup mechanisms are sufficient?
> 

I believe the module API + refcount make it safe against removal. When
perfmon does a lookup in the linked list of registered formats, it is not
clear to me what would protect it. I believe it would be safe if I used 
the rcu list instead of basic list.

> > +	pfm_sysfs_add_fmt(fmt);
> 
> Please check for and handle all sysfs-related errors.  All errors, indeed.
> 
> Yes, a lot of the kernel blithely assumes that sysfs operations never fail.
> We need to fix that badness rather than copy it.
> 
I fixed that now. 

thanks.
-- 
-Stephane
