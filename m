Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263614AbUJ2XY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbUJ2XY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263560AbUJ2XXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:23:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:51852 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263614AbUJ2XOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:14:01 -0400
Date: Fri, 29 Oct 2004 18:13:19 -0500
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Andrew <cmkrnl@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.6.10.rc1.bk6 /lib/kobject_uevent.c buffer issues
Message-ID: <20041029231319.GA503@kroah.com>
References: <20041027142925.GA17484@imladris.arnor.me> <20041027152134.GA13991@kroah.com> <417FCD78.6020807@speakeasy.net> <20041029201314.GA29171@kroah.com> <20041029212856.GA12582@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029212856.GA12582@vrfy.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 11:28:56PM +0200, Kay Sievers wrote:
> > But there might still be a problem.  With this change, the sequence
> > number is not sent out the kevent message.  Kay, do you think this is an
> > issue?  I don't think we can get netlink messages out of order, right?
> 
> Right, especially not the events with the same DEVPATH, like "remove"
> beating an "add". But I'm not sure if the number isn't useful. Whatever
> we may do with the hotplug over netlink in the future, we will only have
> /sbin/hotplug for the early boot and it may be nice to know, what events
> we have already handled...
> 
> > I'll hold off on applying this patch until we figure this out...
> 
> How about just reserving 20 bytes for the number (u64 will never be
> more than that), save the pointer to that field, and fill the number in
> later?

Ah, something like this instead?  I like it, it's even smaller than the
previous patch.  Compile tested only...

thanks,

greg k-h

--------

--- 1.5/lib/kobject_uevent.c	2004-10-22 17:42:27 -05:00
+++ edited/kobject_uevent.c	2004-10-29 18:07:50 -05:00
@@ -182,6 +182,7 @@
 	char *argv [3];
 	char **envp = NULL;
 	char *buffer = NULL;
+	char *seq_buff;
 	char *scratch;
 	int i = 0;
 	int retval;
@@ -258,6 +259,11 @@
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "SUBSYSTEM=%s", name) + 1;
 
+	/* reserve space for the sequence, 
+	 * put the real one in after the hotplug call */
+	envp[i++] = seq_buff = scratch;
+	scratch += sprintf(scratch, "SEQNUM=12345678901234567890") + 1;
+
 	if (hotplug_ops->hotplug) {
 		/* have the kset specific function add its stuff */
 		retval = hotplug_ops->hotplug (kset, kobj,
@@ -273,9 +279,7 @@
 	spin_lock(&sequence_lock);
 	seq = ++hotplug_seqnum;
 	spin_unlock(&sequence_lock);
-
-	envp [i++] = scratch;
-	scratch += sprintf(scratch, "SEQNUM=%lld", (long long)seq) + 1;
+	sprintf(seq_buff, "SEQNUM=%lld", (long long)seq);
 
 	pr_debug ("%s: %s %s seq=%lld %s %s %s %s %s\n",
 		  __FUNCTION__, argv[0], argv[1], (long long)seq,
