Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbTFLWxe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265036AbTFLWxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:53:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:16843 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265032AbTFLWxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:53:21 -0400
Date: Thu, 12 Jun 2003 16:09:10 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, sdake@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030612230910.GA1896@kroah.com>
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com> <20030612150335.6710a94f.akpm@digeo.com> <20030612225040.GA1492@kroah.com> <20030612155148.60a39787.akpm@digeo.com> <20030612230246.GA1782@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612230246.GA1782@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 04:02:47PM -0700, Greg KH wrote:
> On Thu, Jun 12, 2003 at 03:51:48PM -0700, Andrew Morton wrote:
> > Greg KH <greg@kroah.com> wrote:
> > >
> > > <handwaving>
> > 
> > heh.
> > 
> > Thought about adding a sequence number to the /sbin/hotplug argument list?
> 
> /me owes you a lot of beer at ols.
> 
> That's a world simpler than my proposal, I think I'll go write that
> patch right now...

Pat, here's a patch to add a sequence number to kobject hotplug calls to
help userspace out a lot.

thanks,

greg k-h

# kobject: add sequence number to hotplug events to help userspace out.

diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Thu Jun 12 16:05:06 2003
+++ b/lib/kobject.c	Thu Jun 12 16:05:06 2003
@@ -100,6 +100,7 @@
 
 #define BUFFER_SIZE	1024	/* should be enough memory for the env */
 #define NUM_ENVP	32	/* number of env pointers */
+static unsigned long sequence_num;
 static void kset_hotplug(const char *action, struct kset *kset,
 			 struct kobject *kobj)
 {
@@ -151,6 +152,10 @@
 
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "ACTION=%s", action) + 1;
+
+	envp [i++] = scratch;
+	scratch += sprintf(scratch, "SEQNUM=%ld", sequence_num) + 1;
+	++sequence_num;
 
 	kobj_path_length = get_kobj_path_length (kset, kobj);
 	kobj_path = kmalloc (kobj_path_length, GFP_KERNEL);
