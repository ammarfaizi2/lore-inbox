Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423687AbWJZRZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423687AbWJZRZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 13:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423688AbWJZRZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 13:25:40 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:3722 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423687AbWJZRZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 13:25:38 -0400
Date: Thu, 26 Oct 2006 10:26:30 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andrew Morton <akpm@osdl.org>, gianluca@abinetworks.biz, cate@debian.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, proski@gnu.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH ??] Re: incorrect taint of ndiswrapper
Message-Id: <20061026102630.ad191d21.randy.dunlap@oracle.com>
In-Reply-To: <20061025205923.828c620d.akpm@osdl.org>
References: <1161807069.3441.33.camel@dv>
	<1161808227.7615.0.camel@localhost.localdomain>
	<20061025205923.828c620d.akpm@osdl.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2006 20:59:23 -0700 Andrew Morton wrote:

> > On Wed, 25 Oct 2006 21:30:26 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Ar Mer, 2006-10-25 am 16:11 -0400, ysgrifennodd Pavel Roskin:
> > > I don't see any legal reasons behind this restriction.  A driver under
> > > GPL should be able to use any exported symbols.  EXPORT_SYMBOL_GPL is a
> > > technical mechanism of enforcing GPL against non-free code, but
> > > ndiswrapper is free.  The non-free NDIS drivers are not using those
> > > symbols.
> > 
> > The combination of GPL wrapper and the NDIS driver as a work is not free
> > (in fact its questionable if its even legal to ship such a combination
> > together).
> 
> May be so.  But this patch was supposed to print a helpful taint message to
> draw our attention to the fact that ndis-wrapper was in use.  The patch was
> not intended to cause gpl'ed modules to stop loading (or if is was, that
> effect was concealed from yours truly).
> 
> IOW, this was a mistake.
> 
> 
> Now, if we do want to disallow gpl module loading after ndis-wrapper has
> been used then fine, we can discuss that.  If we decide to proceed that way
> then we will probably cause a load of ndis-wrapper to emit a scary printk for
> six months or so to give people time to make arrangements.

Yes, if I understand what's happening, then this was an unintended
consequence.
Does the patch below allow ndiswrapper to operate?
Of course, this still leaves the kernel marked as tainted,
without an indication of which module caused that.  Not the best
situation.

---
From: Randy Dunlap <randy.dunlap@oracle.com>

For ndiswrapper and driverloader, don't set the module->taints
flags, just set the kernel global tainted flag.
This should allow ndiswrapper to continue to use GPL symbols.
Not tested.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 kernel/module.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2619-rc3-pv.orig/kernel/module.c
+++ linux-2619-rc3-pv/kernel/module.c
@@ -1718,9 +1718,9 @@ static struct module *load_module(void _
 	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
 
 	if (strcmp(mod->name, "ndiswrapper") == 0)
-		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
+		add_taint(TAINT_PROPRIETARY_MODULE);
 	if (strcmp(mod->name, "driverloader") == 0)
-		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
+		add_taint(TAINT_PROPRIETARY_MODULE);
 
 	/* Set up MODINFO_ATTR fields */
 	setup_modinfo(mod, sechdrs, infoindex);
