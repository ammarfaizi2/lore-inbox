Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263527AbUJ2UWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbUJ2UWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbUJ2USy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:18:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:25521 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263484AbUJ2UOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:14:07 -0400
Date: Fri, 29 Oct 2004 15:13:15 -0500
From: Greg KH <greg@kroah.com>
To: Andrew <cmkrnl@speakeasy.net>, Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.6.10.rc1.bk6 /lib/kobject_uevent.c buffer issues
Message-ID: <20041029201314.GA29171@kroah.com>
References: <20041027142925.GA17484@imladris.arnor.me> <20041027152134.GA13991@kroah.com> <417FCD78.6020807@speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417FCD78.6020807@speakeasy.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 12:31:52PM -0400, Andrew wrote:
> 
> Greg KH wrote:
> >
> >
> >Why not just use the same buffer?  We should be able to do that.
> >
> >
> >I'd prefer we use the same buffer.  Care to respin your patch?
> >
> 
> Sure, I can only see two ways of achieving that however.
> 1) Change the API of kset_hotplug_ops.hotplug() to return the amount
>    of consumed buffer (and possibly an updated value for i (num_envp)
>    and then changing every real function that implements that interface
>    or
> 2) Spin through the envp[] starting at i to NUM_ENVP looking for a NULL
>    pointer dropping back 1 (last_used) then do a
>    scratch += strlen(envp[last_used]) + 1

Ick, ok, let's stick with 2 buffers.  How about the patch below?  It's a
bit smaller than yours.

But there might still be a problem.  With this change, the sequence
number is not sent out the kevent message.  Kay, do you think this is an
issue?  I don't think we can get netlink messages out of order, right?

I'll hold off on applying this patch until we figure this out...

thanks,

greg k-h


--- 1.5/lib/kobject_uevent.c	2004-10-22 17:42:27 -05:00
+++ edited/kobject_uevent.c	2004-10-29 15:05:32 -05:00
@@ -182,6 +182,7 @@
 	char *argv [3];
 	char **envp = NULL;
 	char *buffer = NULL;
+	char *seq_buff = NULL;
 	char *scratch;
 	int i = 0;
 	int retval;
@@ -229,6 +230,9 @@
 	buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
 	if (!buffer)
 		goto exit;
+	seq_buff = kmalloc(BUFFER_SIZE, GFP_KERNEL);
+	if (!seq_buff)
+		goto exit;
 
 	if (hotplug_ops->name)
 		name = hotplug_ops->name(kset, kobj);
@@ -258,6 +262,9 @@
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "SUBSYSTEM=%s", name) + 1;
 
+	/* point to the buffer, but don't fill it until after the hotplug call */
+	envp [i++] = seq_buff;
+
 	if (hotplug_ops->hotplug) {
 		/* have the kset specific function add its stuff */
 		retval = hotplug_ops->hotplug (kset, kobj,
@@ -273,9 +280,7 @@
 	spin_lock(&sequence_lock);
 	seq = ++hotplug_seqnum;
 	spin_unlock(&sequence_lock);
-
-	envp [i++] = scratch;
-	scratch += sprintf(scratch, "SEQNUM=%lld", (long long)seq) + 1;
+	sprintf(seq_buff, "SEQNUM=%lld", (long long)seq);
 
 	pr_debug ("%s: %s %s seq=%lld %s %s %s %s %s\n",
 		  __FUNCTION__, argv[0], argv[1], (long long)seq,
@@ -293,6 +298,7 @@
 
 exit:
 	kfree(kobj_path);
+	kfree(seq_buff);
 	kfree(buffer);
 	kfree(envp);
 	return;
