Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752442AbWCPRnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbWCPRnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbWCPRnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:43:04 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:18819
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1752442AbWCPRnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:43:02 -0500
Date: Thu, 16 Mar 2006 09:42:54 -0800
From: Greg KH <greg@kroah.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Artem B. Bityutskiy" <dedekind@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Bug? Report] kref problem
Message-ID: <20060316174254.GA6698@kroah.com>
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru> <20060316165323.GA10197@kroah.com> <1142530278.10906.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142530278.10906.27.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 09:31:18AM -0800, Dave Hansen wrote:
> On Thu, 2006-03-16 at 08:53 -0800, Greg KH wrote:
> > On Thu, Mar 16, 2006 at 02:41:19PM +0300, Artem B. Bityutskiy wrote:
> > > struct my_obj_a
> > > {
> > > 	struct kobject kobj;
> > > } a;
> > > 
> > > struct my_obj_b
> > > {
> > > 	struct kobject kobj;
> > > } b;
> > 
> > Don't statically create kobjects, it's not nice.  But the real problem
> > is below...
> 
> This seems to be one of those top ten sysfs snafus.  Could we take the
> definitions from include/asm-generic/sections.h, and make a kobject
> verification function to put in the critical generic kernel functions
> that deal with kobjects,  like kobject_init()?

I wish.  The main offender of this is the kernel core code itself, with
the decl_subsys and struct bus stuff.  If you provide some nice fuctions
to fix those up to be dynamic, then I would have no problem with the
function you have below.

> Somthing like...
> 
> void verify_dynamic_kobject_allocation(struct kobject *kobj)
> {
> 	if (kobj >= &_data && kobj < &_edata)
> 		goto warn;
> 	if (kobj >= &_bss_start && kobj < &_bss_end)
> 		goto warn;
> 	...
> 	return;
> warn:
> 	printk(KERN_WARN "statically allocated kobject, you suck...\n");
> }
> 
> I'm not sure that all of the architectures fill in all of the values,
> but we could at least support the warnings for the ones that do.  That
> includes at least i386, so it could be a relatively effective tool.
> 
> I'll cook up a real patch in a bit.

That would be fun to play with, I'd appreciate it.  If nothing else,
I'll add it to my tree for future use.

thanks,

greg k-h
