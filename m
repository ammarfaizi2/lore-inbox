Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264194AbTDJWXb (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbTDJWXa (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:23:30 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:16017 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S264194AbTDJWX2 (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 18:23:28 -0400
Subject: Re: 2.5.67: ext3 and tcp BUG()/oops/error/whatnot?
From: Martin Josefsson <gandalf@netfilter.org>
Reply-To: gandalf@wlug.westbo.se
To: Andrew Morton <akpm@digeo.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, cat@zip.com.au,
       linux-kernel@vger.kernel.org, akpm@zip.com.au, davem@redhat.com,
       jmorris@intercode.com.au
In-Reply-To: <20030410141443.730ead79.akpm@digeo.com>
References: <20030410163857.GB19129@zip.com.au>
	 <20030410173017.GB20177@suse.de>  <20030410141443.730ead79.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050014106.11156.64.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Apr 2003 00:35:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 23:14, Andrew Morton wrote:
> Dave Jones <davej@codemonkey.org.uk> wrote:
> >
> > On Fri, Apr 11, 2003 at 02:38:58AM +1000, CaT wrote:
> > 
> >  > Slab corruption: start=ce6130c4, expend=ce6131f3, problemat=ce613128
> >  > Last user: [<c032ff78>](destroy_conntrack+0x9c/0xac)
> >  > Data: ****************************************************************************************************28 31 61 CE 28 31 61 CE ***************************************************************************************************************************************************************************************************A5 
> >  > Next: 71 F0 2C .78 FF 32 C0 71 F0 2C .********************
> >  > slab error in check_poison_obj(): cache `ip_conntrack': object was modified after freeing
> >  > Call Trace:
> >  >  [<c0131d5d>] __slab_error+0x21/0x28
> >  >  [<c013214c>] check_poison_obj+0x174/0x180
> >  >  [<c01331b9>] kmem_cache_alloc+0x8d/0x128
> >  >  [<c033075f>] init_conntrack+0xcf/0x310
> >  >  [<c033075f>] init_conntrack+0xcf/0x310
> > 
> > Known bug, with known fix. This really should go to Linus.
> > http://bugzilla.kernel.org/show_bug.cgi?id=497
> 
> I've had the below patch in -mm for some time, but am not sure what to do
> with it.  My last attempt to contact netfilter people didn't work.
> 
> James?  Help?

I have a IMO better patch than the one you have and I have tried to get
Harald to approve one of the patches, I just can't get any kind of
response from him.

The new one doesn't leave any dangling pointers around. 
This is the one I'd prefer, I just need to get it blessed.

I'd say we get this to Linus and then Harald can submit a diffrent fix
if he doesn't approve of this one since it seems it can cause crashes.

(although only if the conntrack memory was released by slab before it is
touched by the faulty code in conntrack (which hasn't been the case in
the reports I've seen since it was caught when allocating new
conntracks), shouldn't be able to cause crashes in conntrack itself)

Compiled but not booted (more than what I did with the other fix :)

diff -urN linux-2.5.65.orig/net/ipv4/netfilter/ip_conntrack_core.c linux-2.5.65.fixed/net/ipv4/netfilter/ip_conntrack_core.c
--- linux-2.5.65.orig/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-17 22:43:37.000000000 +0100
+++ linux-2.5.65.fixed/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-26 14:58:54.000000000 +0100
@@ -274,6 +274,7 @@
 		 * the un-established ones only */
 		if (exp->sibling) {
 			DEBUGP("remove_expectations: skipping established %p of %p\n", exp->sibling, ct);
+			exp->expectant = NULL;
 			continue;
 		}
 
@@ -325,6 +326,7 @@
 		ip_conntrack_destroyed(ct);
 
 	WRITE_LOCK(&ip_conntrack_lock);
+	list_del(&ct->sibling_list);
 	/* Delete our master expectation */
 	if (ct->master) {
 		/* can't call __unexpect_related here,


-- 
/Martin
