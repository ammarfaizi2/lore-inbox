Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVDEQ23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVDEQ23 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVDEQ23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:28:29 -0400
Received: from [195.23.16.24] ([195.23.16.24]:24809 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261471AbVDEQ0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:26:34 -0400
Message-ID: <4252BC37.8030306@grupopie.com>
Date: Tue, 05 Apr 2005 17:26:31 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: RFC: turn kmalloc+memset(,0,) into kcalloc
Content-Type: multipart/mixed;
 boundary="------------040302060109030507000302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040302060109030507000302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

I noticed there are a number of places in the kernel that do:

	ptr = kmalloc(n * size, ...)
	if (!ptr)
		goto out;
	memset(ptr, 0, n * size);

It seems that these could be replaced by:

	ptr = kcalloc(n, size, ...)
	if (!ptr)
		goto out;

saving a few bytes.

Most of the times the size isn't something "n * size", but simply "n". 
These could be replaced by kcalloc(n, 1, ...) or we could create a 
special "kmalloc_zero" function to do this without the need for the 
extra "1" parameter.

A quick (and lame) grep through the tree shows about 1200 of these 
cases. This means that about one quarter of all the kmallocs in the 
kernel are actually zeroed right after allocation.

I could send patches to slowly clean this up, like Adrian Bunk did for 
the static functions and Jesper Juhl for the kfree NULL checks.

There are pros and cons to doing this:

pros:
   - smaller kernel image size
   - smaller (and more readable) source code
   - explicit interface to request zeroed data. If in the future we have 
a good way of providing some zeroed-cachehot-super-duper-slabs, we can 
allocate space from there and avoid the memset altogether

cons:
   - the NULL test is done twice
   - memset will not be optimized for constant sizes

The disadvantages don't seem to matter much for non-critical paths. For 
really fast paths we should probably keep the kmalloc + memset.

Attached is a sample of what one of those patches would look like.

Would this be a good thing to clean up, or isn't it worth the effort at all?

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

--------------040302060109030507000302
Content-Type: text/plain;
 name="patchsample"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patchsample"

--- ./lib/kobject_uevent.c.orig	2005-04-05 16:39:09.000000000 +0100
+++ ./lib/kobject_uevent.c	2005-04-05 17:01:26.000000000 +0100
@@ -234,10 +234,9 @@ void kobject_hotplug(struct kobject *kob
 	if (!action_string)
 		return;
 
-	envp = kmalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
+	envp = kmalloc_zero(NUM_ENVP * sizeof (char *), GFP_KERNEL);
 	if (!envp)
 		return;
-	memset (envp, 0x00, NUM_ENVP * sizeof (char *));
 
 	buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
 	if (!buffer)

--------------040302060109030507000302--
