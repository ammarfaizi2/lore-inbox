Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTEADIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 23:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbTEADIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 23:08:52 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:6858 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262195AbTEADIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 23:08:50 -0400
Date: Wed, 30 Apr 2003 22:59:56 -0400
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NULL handler for compat_ioctl
Message-ID: <20030501025955.GA622@phunnypharm.org>
References: <20030501013427.GA516@phunnypharm.org> <20030430194124.03fb29db.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030430194124.03fb29db.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 07:41:24PM -0700, Andrew Morton wrote:
> Ben Collins <bcollins@debian.org> wrote:
> >
> > -	t->handler = handler; 
> > +	if (!handler)
> > +		t->handler = (void *)sys_ioctl;
> > +	else
> > +		t->handler = handler; 
> 
> Is that safe?
> 
> - sys_ioctl takes three args, but this vector is going to be called with
>   four.  That's making assumptions about arg passing conventions which may
>   not be true.
> 
> - sys_ioctl() is asmlinkage, but the caller of this vector doesn't know
>   that.  Arguments may get put in the wrong place.

Out of all the register_ioctl32_conversion functions that were
consolidated with this patch, only s390 and x86_64 did not already use
this same convention. linux/ioctl32.h already documents (and has always
been that way) this feature.

Maybe you feel better about this patch instead? Moved the logic directly
to compat_sys_ioctl. Also note that sys_ioctl is prototyped in
include/linux/ioctl32.h.


Index: fs/compat.c
===================================================================
RCS file: /home/scm/linux-2.5/fs/compat.c,v
retrieving revision 1.8
diff -u -u -r1.8 compat.c
--- linux/fs/compat.c	30 Apr 2003 16:17:21 -0000	1.8
+++ linux/fs/compat.c	1 May 2003 03:18:46 -0000
@@ -300,7 +300,6 @@
 {
 	struct file * filp;
 	int error = -EBADF;
-	int (*handler)(unsigned int, unsigned int, unsigned long, struct file * filp);
 	struct ioctl_trans *t;
 
 	filp = fget(fd);
@@ -317,8 +316,10 @@
 	while (t && t->cmd != cmd)
 		t = (struct ioctl_trans *)t->next;
 	if (t) {
-		handler = t->handler;
-		error = handler(fd, cmd, arg, filp);
+		if (t->handler)
+			error = t->handler(fd, cmd, arg, filp);
+		else
+			error = sys_ioctl(fd, cmd, arg);
 	} else if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
 		error = siocdevprivate_ioctl(fd, cmd, arg);
 	} else {
