Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVGKMx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVGKMx2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 08:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVGKMxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 08:53:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11190 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261668AbVGKMvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 08:51:52 -0400
Subject: Re: [RFC/PATCH 1/2] fsnotify
From: David Woodhouse <dwmw2@infradead.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Robert Love <rml@novell.com>, ttb@tentacle.dhs.org, linux-audit@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050709012657.GE19052@shell0.pdx.osdl.net>
References: <20050709012436.GD19052@shell0.pdx.osdl.net>
	 <20050709012657.GE19052@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 13:52:45 +0100
Message-Id: <1121086366.27264.108.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-08 at 18:26 -0700, Chris Wright wrote:
> Add fsnotify as infrastructure for various fs notifcation schemes.
> Move dnotify to fsnotify.

-               inode_dir_notify(dir, DN_CREATE);
+               fsnotify_create(dir, new_dentry->d_name.name);
....
+ * We don't compile any of this away in some complicated menagerie of ifdefs.
+ * Instead, we rely on the code inside to optimize away as needed.
....
+static inline void fsnotify_create(struct inode *inode, const char *name)
+{
+       dnotify_create(inode, name);
+}
....
+static inline void dnotify_create(struct inode *inode, const char *name)
+{
+       inode_dir_notify(inode, DN_CREATE);
+}

To be honest, I don't really see that this is in any way better than
what we had before. Yes, two different pieces of code actually use hooks
in similar places in the VFS code. But this 'infrastructure' just to
share those hooks is overkill as far as I can tell. It really isn't any
better than having both inotify and audit hooks side by side where we
can actually see what's going on at a glance. In fact, it's worse.

What would make sense, perhaps, would be to actually merge those hooks;
not just a cosmetic amalgamation of the calling sites. Currently, each
of inotify and the audit code does its own filtering when its hooks are
triggered, and then acts upon the event only if it affects a watched
inode. 

To actually merge that filtering code would make sense -- and then both
inotify and auditfs would just register watches on certain inodes and
receive notification as appropriate.

There are features of each which would probably be desirable in the
merged result. The inotify version grows the inode structure by quite a
lot, while the auditfs version recognises that watches will be
relatively infrequent, so uses only a bit in i_flags as a
quickly-accessible indication that an inode is 'interesting' and
maintains its actual data for that inode elsewhere. The auditfs version
is also capable of handling the "Child named 'XXXX' of this inode" kind
of watch, where watches are placed on objects which don't yet exist.
Also, the auditfs code already calls back to a separate function
auditfs_attach_wdata() in the _real_ audit code, which actually reports
when the watch is triggered; it shouldn't be hard to make it call into
an inotify function instead, depending on the type of watch which is
hit.

On the other hand, the inotify triggers require a little more
information from the original hook, which audit_notify_watch() would
need to pass through if the audit code were used as the basis for a
merged 'core watch' functionality.

-- 
dwmw2

