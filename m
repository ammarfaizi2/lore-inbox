Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVGFT7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVGFT7b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVGFT4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:56:24 -0400
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:39353 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S262159AbVGFPiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:38:22 -0400
Date: Wed, 6 Jul 2005 23:38:13 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [4/48] Suspend2 2.1.9.8 for 2.6.12: 302-init-hooks.patch
Message-ID: <20050706153813.GE4165@blackham.com.au>
References: <11206164392@foobar.com> <1120639125.2908.5.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120639125.2908.5.camel@linux-hp.sh.intel.com>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 04:38:45PM +0800, Shaohua Li wrote:
> On Wed, 2005-07-06 at 12:20 +1000, Nigel Cunningham wrote:
> > diff -ruNp 350-workthreads.patch-old/drivers/acpi/osl.c 350-workthreads.patch-new/drivers/acpi/osl.c
> > --- 350-workthreads.patch-old/drivers/acpi/osl.c	2005-06-20 11:46:50.000000000 +1000
> > +++ 350-workthreads.patch-new/drivers/acpi/osl.c	2005-07-04 23:14:18.000000000 +1000
> > @@ -95,7 +95,7 @@ acpi_os_initialize1(void)
> >  		return AE_NULL_ENTRY;
> >  	}
> >  #endif
> > -	kacpid_wq = create_singlethread_workqueue("kacpid");
> > +	kacpid_wq = create_singlethread_workqueue("kacpid", PF_NOFREEZE);
> >  	BUG_ON(!kacpid_wq);
> 
> I'm not sure but kacpid can run any kind of code (depends on BIOS, it
> might touch some devices), is this safe?

FYI, the reason it's there is to do something about acpi events
whilst resuming. If kacpid is not running the following bug occurs:

 - during suspend, prior to the atomic copy, a GPE fires (eg, a
   battery notification)
 - the GPE is disabled until it is serviced by kacpid, but as kacpid
   is not running, it isn't serviced - only disabled.
 - the disabled state of the GPE is recorded in the atomic copy, and
   written to disk
 - poweroff/S4
 - on resume, ACPI initialises the GPEs and enables them all.
 - after the restoring the atomic copy, the GPE may fire. However,
   the kernel thinks it is already disabled and so refuses to
   disable it again.
 - this sends the machine into an interrupt-induced death as the GPE
   fires over and over and over ...

I prepared a patch a while ago that simply omitted the check and
disabled the GPE unconditionally (which was how things were before
the big ACPI merge of 2.6.9), but this made the battery status
unreadable for at least one user. I never followed that up, but
instead some more general GPE suspend/resume handling was discussed,
making GPEs system devices that were suspended and resumed
accordingly. I don't think any code eventuated from this discussion
though ...

Letting kacpid run during suspend appeared to be a good compromise
(but still racy if GPEs were to occur at exactly the right instant
- just before the atomic copy). Implementing suspend/resume support
for GPEs would be the more ideal solution.

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
