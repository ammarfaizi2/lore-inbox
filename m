Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbWBIImx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWBIImx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 03:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWBIImx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 03:42:53 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:44729 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750828AbWBIImw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 03:42:52 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inotify: fix one-shot support
Date: Thu, 9 Feb 2006 09:42:43 +0100
User-Agent: KMail/1.7.2
Cc: Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>
References: <200602080105.k1815her002647@hera.kernel.org> <200602080852.18179.ingo@oeser-vu.de> <1139415393.8883.193.camel@betsy.boston.ximian.com>
In-Reply-To: <1139415393.8883.193.camel@betsy.boston.ximian.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602090942.44977.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,
hi John,

On Wednesday 08 February 2006 17:16, Robert Love wrote:
> On Wed, 2006-02-08 at 08:52 +0100, Ingo Oeser wrote:
> > See, now you can just pass IN_ONESHOT behavior flag without any
> > events to shoot at, which you couldn't do before. But this makes only
> > sense, if we would like to set a multi-shot mask to one-shot now.
> 
> Ack!

Ok, here comes the patch (against Linus' HEAD). 
It turned out, that we needed to change some more places to avoid having zero
events to watch for. If you are ok with it, I'll send it straight to Linus with
your Ack included and in proper patch format.


Regards

Ingo Oeser


diff --git a/fs/inotify.c b/fs/inotify.c
index 3041503..16ec5fb 100644
--- a/fs/inotify.c
+++ b/fs/inotify.c
@@ -935,6 +935,7 @@ asmlinkage long sys_inotify_add_watch(in
 	struct file *filp;
 	int ret, fput_needed;
 	int mask_add = 0;
+	int no_events = 0;
 	unsigned flags = 0;
 
 	filp = fget_light(fd, &fput_needed);
@@ -966,9 +967,13 @@ asmlinkage long sys_inotify_add_watch(in
 	if (mask & IN_MASK_ADD)
 		mask_add = 1;
 
-	/* don't let user-space set invalid bits: we don't want flags set */
+	/* Do we change and events or only multishot/singleshot? */
+	if (!(mask & IN_ALL_EVENTS))
+		no_events = 1;
+
+	/* Don't let user-space set invalid bits: we don't want flags set. */
 	mask &= IN_ALL_EVENTS | IN_ONESHOT;
-	if (unlikely(!mask)) {
+	if (unlikely(no_events && !mask_add)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -987,6 +992,15 @@ asmlinkage long sys_inotify_add_watch(in
 		goto out;
 	}
 
+	/* 
+	 * Want to change only multishot/singleshot, 
+	 * but has no existing watch? -> Illegal -ioe 
+	 */
+	if (unlikely(no_events)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	watch = create_watch(dev, mask, inode);
 	if (unlikely(IS_ERR(watch))) {
 		ret = PTR_ERR(watch);

