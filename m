Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUDQGPu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 02:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263683AbUDQGPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 02:15:50 -0400
Received: from ozlabs.org ([203.10.76.45]:31163 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263596AbUDQGPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 02:15:48 -0400
Subject: Re: [RFC] fix sysfs symlinks
From: Rusty Russell <rusty@rustcorp.com.au>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Greg KH <greg@kroah.com>, Maneesh Soni <maneesh@in.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040415191447.GE24997@parcelfarce.linux.theplanet.co.uk>
References: <20040413124037.GA21637@in.ibm.com>
	 <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk>
	 <20040414064015.GA4505@in.ibm.com>
	 <20040414070227.GA31500@parcelfarce.linux.theplanet.co.uk>
	 <20040415091752.A24815@flint.arm.linux.org.uk>
	 <20040415103849.GA24997@parcelfarce.linux.theplanet.co.uk>
	 <20040415161942.A7909@flint.arm.linux.org.uk>
	 <20040415161011.GB2965@kroah.com>
	 <20040415161332.GC24997@parcelfarce.linux.theplanet.co.uk>
	 <20040415191447.GE24997@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1082179555.1390.102.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Apr 2004 16:15:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-16 at 05:14, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> BTW, how about a new section that would
> 	a) be allocated separately at module load time
> 	b) contain a kobject with ->release() freeing that section
> 	c) be populated with structures containing kobjects and having
> no ->release(); main kobject would be pinned down by them.  Original
> refcount in each of those guys would be 1.
> 
> module_exit() would unregister all stuff we have in there and then drop
> the references to them.  No waiting for anything and when all references
> to these objects are gone, we get the section freed.  That can happen
> way after the completion of rmmod - as the matter of fact we could have
> the same module loaded again by that time.

Or you could skip the extra section, and keep all the module memory
until later.  Instead of a section marker, you then set the release of
those static things to "static_release" which does the put on the module
memory kref:

void static_release(struct kobject *kobj)
{
	struct module *mod;

	down(&module_mutex);
	list_for_each_entry(mod, &modules, list) {
		BUG_ON(within(kobj, mod->module_init, mod->init_size);
		if (within(kobj, mod->module_core, mod->core_size)) {
			kref_put(&mod->mem_kref);
			up(&module_mutex);
			return;
		}
	}
	up(&module_mutex);
	BUG();
}

One question which comes to mind, who does the original kref_get()s on
the module memory?  Even if we did have a separate section, the module
loader can't know how many objects objects are in there...

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

