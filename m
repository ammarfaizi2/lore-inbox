Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWI2XR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWI2XR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWI2XR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:17:29 -0400
Received: from xenotime.net ([66.160.160.81]:6860 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932244AbWI2XR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:17:27 -0400
Date: Fri, 29 Sep 2006 16:18:52 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>, len.brown@intel.com
Cc: Martin Bligh <mbligh@google.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Fix up a multitude of ACPI compiler warnings on x86_64
Message-Id: <20060929161852.4b6ae44a.rdunlap@xenotime.net>
In-Reply-To: <20060929150526.38eec941.akpm@osdl.org>
References: <451D9236.6040902@google.com>
	<20060929150526.38eec941.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 15:05:26 -0700 Andrew Morton wrote:

> On Fri, 29 Sep 2006 14:37:58 -0700
> Martin Bligh <mbligh@google.com> wrote:
> 
> > 32bit vs 64 bit issues. sizeof(sizeof) and sizeof(pointer) is variable,
> > but we're trying to shove it into unsigned int or u32.
> >
> > ...
> >
> > -	"RSDT/XSDT length (%X) is smaller than minimum (%X)",
> > +	"RSDT/XSDT length (%X) is smaller than minimum (%lX)",
> >  	table_ptr->length,
> > -	sizeof(struct acpi_table_header)));
> > +	(unsigned long) sizeof(struct acpi_table_header)));
> > 
> 
> These two sizeof()s have already been fixed by Randy in -mm's
> acpi-fix-printk-format-warnings.patch.
> 
> Randy's fix is the preferred one: sizeof() returns size_t and size_t's are
> printed with %z - there's no need to use a typecast.
> 
> (Actually Randy used %Z which avoids the warning which old gcc emitted with
> %z, but is old-fashioned.  I'll switch that to %z).
> 
> 
> acpi-fix-printk-format-warnings.patch was submitted to the ACPI developers
> on August 14 and on September 25 but remains unmerged.

Len and I discussed that patch some.  The question about it is:
why does gcc report this at all?  Is this a gcc problem or are
we misreading it somehow?

 drivers/acpi/tables/tbget.c: In function 'acpi_tb_get_this_table':
drivers/acpi/tables/tbget.c:326: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'

drivers/acpi/tables/tbrsdt.c: In function 'acpi_tb_validate_rsdt':
drivers/acpi/tables/tbrsdt.c:189: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'

Why does it think that sizeof(struct X) is long unsigned int?
(and only on 64-bit)

---
~Randy
