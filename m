Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752438AbWCPRcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbWCPRcN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbWCPRcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:32:13 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:42918 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752438AbWCPRcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:32:11 -0500
Subject: Re: [Bug? Report] kref problem
From: Dave Hansen <haveblue@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: "Artem B. Bityutskiy" <dedekind@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060316165323.GA10197@kroah.com>
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru>
	 <20060316165323.GA10197@kroah.com>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 09:31:18 -0800
Message-Id: <1142530278.10906.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 08:53 -0800, Greg KH wrote:
> On Thu, Mar 16, 2006 at 02:41:19PM +0300, Artem B. Bityutskiy wrote:
> > struct my_obj_a
> > {
> > 	struct kobject kobj;
> > } a;
> > 
> > struct my_obj_b
> > {
> > 	struct kobject kobj;
> > } b;
> 
> Don't statically create kobjects, it's not nice.  But the real problem
> is below...

This seems to be one of those top ten sysfs snafus.  Could we take the
definitions from include/asm-generic/sections.h, and make a kobject
verification function to put in the critical generic kernel functions
that deal with kobjects,  like kobject_init()?

Somthing like...

void verify_dynamic_kobject_allocation(struct kobject *kobj)
{
	if (kobj >= &_data && kobj < &_edata)
		goto warn;
	if (kobj >= &_bss_start && kobj < &_bss_end)
		goto warn;
	...
	return;
warn:
	printk(KERN_WARN "statically allocated kobject, you suck...\n");
}

I'm not sure that all of the architectures fill in all of the values,
but we could at least support the warnings for the ones that do.  That
includes at least i386, so it could be a relatively effective tool.

I'll cook up a real patch in a bit.

-- Dave

