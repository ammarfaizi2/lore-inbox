Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWBLTgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWBLTgj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 14:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWBLTgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 14:36:39 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:7583 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751434AbWBLTgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 14:36:38 -0500
Date: Sun, 12 Feb 2006 12:36:37 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linda Walsh <lkml@tlinx.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
Message-ID: <20060212193637.GI12822@parisc-linux.org>
References: <43ED5A7B.7040908@tlinx.org> <20060212180601.GU27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212180601.GU27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 06:06:01PM +0000, Al Viro wrote:
> On Fri, Feb 10, 2006 at 07:31:07PM -0800, Linda Walsh wrote:
> > The maximum number of followed symlinks seems to be set to 5.
> > 
> > This seems small when compared to other filesystem limits.
> > Is there some objection to it being raised?  Should it be
> > something like Glib's '20' or '255'?

Just a note (which Al probably considered too obvious to point out), but
MAX_NESTED_LINKS isn't the maximum number of followed symlinks.  It's
the number of recursions we're limited to.  The maximum number of
symlinks followed is 40 (see fs/namei.c:do_follow_link).

Al, would it be worth making 40 an enumerated constant in the same
enumeration as MAX_NESTED_LINKS?  Something like this:

Index: include/linux/namei.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/namei.h,v
retrieving revision 1.4
diff -u -p -r1.4 namei.h
--- include/linux/namei.h       12 Nov 2005 04:09:17 -0000      1.4
+++ include/linux/namei.h       12 Feb 2006 19:35:31 -0000
@@ -11,7 +11,10 @@ struct open_intent {
        struct file *file;
 };
 
-enum { MAX_NESTED_LINKS = 5 };
+enum {
+       MAX_NESTED_LINKS = 5,
+       MAX_FOLLOW_SYMLINKS = 40,
+};
 
 struct nameidata {
        struct dentry   *dentry;
Index: fs/namei.c
===================================================================
RCS file: /var/cvs/linux-2.6/fs/namei.c,v
retrieving revision 1.31
diff -u -p -r1.31 namei.c
--- fs/namei.c  12 Nov 2005 04:08:32 -0000      1.31
+++ fs/namei.c  12 Feb 2006 19:35:31 -0000
@@ -598,7 +598,7 @@ static inline int do_follow_link(struct 
        int err = -ELOOP;
        if (current->link_count >= MAX_NESTED_LINKS)
                goto loop;
-       if (current->total_link_count >= 40)
+       if (current->total_link_count >= MAX_FOLLOW_SYMLINKS)
                goto loop;
        BUG_ON(nd->depth >= MAX_NESTED_LINKS);
        cond_resched();

