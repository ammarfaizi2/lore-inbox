Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265072AbTFLXLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265067AbTFLXLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:11:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:27298 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265072AbTFLXKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:10:14 -0400
Date: Thu, 12 Jun 2003 16:25:42 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Robert Love <rml@tech9.net>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       <sdake@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <1055459762.662.336.camel@localhost>
Message-ID: <Pine.LNX.4.44.0306121624470.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Jun 2003, Robert Love wrote:

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

Yeah, how about this ammended patch? 


	-pat

===== lib/kobject.c 1.25 vs edited =====
--- 1.25/lib/kobject.c	Wed Jun 11 12:06:06 2003
+++ edited/lib/kobject.c	Thu Jun 12 16:24:26 2003
@@ -100,6 +100,9 @@
 
 #define BUFFER_SIZE	1024	/* should be enough memory for the env */
 #define NUM_ENVP	32	/* number of env pointers */
+static unsigned long sequence_num;
+static spinlock_t sequence_lock = SPIN_LOCK_UNLOCKED;
+
 static void kset_hotplug(const char *action, struct kset *kset,
 			 struct kobject *kobj)
 {
@@ -112,6 +115,7 @@
 	int kobj_path_length;
 	char *kobj_path = NULL;
 	char *name = NULL;
+	unsigned long seq;
 
 	/* If the kset has a filter operation, call it. If it returns
 	   failure, no hotplug event is required. */
@@ -151,6 +155,13 @@
 
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "ACTION=%s", action) + 1;
+
+	spin_lock(&sequence_lock);
+	seq = sequence_num++;
+	spin_unlock(&sequence_lock);
+
+	envp [i++] = scratch;
+	scratch += sprintf(scratch, "SEQNUM=%ld", seq) + 1;
 
 	kobj_path_length = get_kobj_path_length (kset, kobj);
 	kobj_path = kmalloc (kobj_path_length, GFP_KERNEL);

