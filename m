Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbUJ1QES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbUJ1QES (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbUJ1QDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:03:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7072 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261750AbUJ1P7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:59:49 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16769.5944.484586.755596@segfault.boston.redhat.com>
Date: Thu, 28 Oct 2004 11:58:48 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netpoll_setup questions
In-Reply-To: <20041027202942.GR31237@waste.org>
References: <16767.50093.59665.83462@segfault.boston.redhat.com>
	<20041027173031.GO31237@waste.org>
	<16767.61372.910664.763968@segfault.boston.redhat.com>
	<20041027194113.GP31237@waste.org>
	<16767.64161.361255.512272@segfault.boston.redhat.com>
	<20041027202942.GR31237@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: netpoll_setup questions; Matt Mackall <mpm@selenic.com> adds:

mpm> On Wed, Oct 27, 2004 at 03:44:33PM -0400, Jeff Moyer wrote: Again,
mpm> does the oops actually happen? I'd expect I'd have seen it by now if
mpm> this were really a problem, but I don't mind adding another check.
>> I'm sorry, I should have said this before.  Yes, it occurs.  You simply
>> need to have an interface in the down state, plugged into a network that
>> will not auto-assign an address.  Then, modprobe netconsole, and don't
>> specify what the local IP address is.  Believe it or not, I have a bug
>> filed on this.  ;)

mpm> Ok, fair enough. Resend your patch when you've tested it and I'll
mpm> forward it on to Andrew.

Patch attached, unchanged.  This did indeed fix the problem.

-Jeff

Signed-off by: Jeff Moyer <jmoyer@redhat.com>

--- linux-2.6.9/net/core/netpoll.c~	2004-10-21 17:49:10.000000000 -0400
+++ linux-2.6.9/net/core/netpoll.c	2004-10-27 14:53:57.492149880 -0400
@@ -571,7 +571,7 @@ int netpoll_setup(struct netpoll *np)
 		goto release;
 	}
 
-	if (!(ndev->flags & IFF_UP)) {
+	if (!netif_running(ndev)) {
 		unsigned short oflags;
 		unsigned long atmost, atleast;
 
@@ -617,7 +617,7 @@ int netpoll_setup(struct netpoll *np)
 		rcu_read_lock();
 		in_dev = __in_dev_get(ndev);
 
-		if (!in_dev) {
+		if (!in_dev || !in_dev->ifa_list) {
 			rcu_read_unlock();
 			printk(KERN_ERR "%s: no IP address for %s, aborting\n",
 			       np->name, np->dev_name);

