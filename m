Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265050AbTFLXNp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbTFLXLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:11:31 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:51191 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265046AbTFLXJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:09:28 -0400
Date: Thu, 12 Jun 2003 16:25:23 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@tech9.net>
Cc: Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@digeo.com>,
       sdake@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030612232523.GA1917@kroah.com>
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com> <20030612150335.6710a94f.akpm@digeo.com> <20030612225040.GA1492@kroah.com> <20030612155148.60a39787.akpm@digeo.com> <20030612230246.GA1782@kroah.com> <20030612230910.GA1896@kroah.com> <1055459762.662.336.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055459762.662.336.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 04:16:03PM -0700, Robert Love wrote:
> On Thu, 2003-06-12 at 16:09, Greg KH wrote:
> 
> > +
> > +	envp [i++] = scratch;
> > +	scratch += sprintf(scratch, "SEQNUM=%ld", sequence_num) + 1;
> > +	++sequence_num;
> 
> Since I do not see a lock in here, I think you need to use atomics?
> 
> As is, you can also race and have the same sequence_num value written
> out twice.

Doh, I ate too much for lunch today and need to wake up...

Pat, here's an updated patch.

thanks,

greg k-h


diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Thu Jun 12 16:21:21 2003
+++ b/lib/kobject.c	Thu Jun 12 16:21:21 2003
@@ -100,6 +100,8 @@
 
 #define BUFFER_SIZE	1024	/* should be enough memory for the env */
 #define NUM_ENVP	32	/* number of env pointers */
+static unsigned long sequence_num;
+static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
 static void kset_hotplug(const char *action, struct kset *kset,
 			 struct kobject *kobj)
 {
@@ -151,6 +153,12 @@
 
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "ACTION=%s", action) + 1;
+
+	spin_lock(&sequence_lock);
+	envp [i++] = scratch;
+	scratch += sprintf(scratch, "SEQNUM=%ld", sequence_num) + 1;
+	++sequence_num;
+	spin_unlock(&sequence_lock);
 
 	kobj_path_length = get_kobj_path_length (kset, kobj);
 	kobj_path = kmalloc (kobj_path_length, GFP_KERNEL);
