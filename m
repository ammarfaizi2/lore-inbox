Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbULXSp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbULXSp5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 13:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbULXSp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 13:45:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:59619 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261432AbULXSpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 13:45:46 -0500
Date: Fri, 24 Dec 2004 10:45:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Vladimir Saveliev <vs@namesys.com>
Cc: tabris@tabris.net, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/inode.c:1116 with
 2.6.10-rc{2-mm4,3-mm1}[repost]
Message-Id: <20041224104512.5c9291c1.akpm@osdl.org>
In-Reply-To: <1103903639.23776.50.camel@tribesman.namesys.com>
References: <200412231923.14444.tabris@tabris.net>
	<20041224000938.22b9f909.akpm@osdl.org>
	<200412241032.02190.tabris@tabris.net>
	<1103903639.23776.50.camel@tribesman.namesys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Saveliev <vs@namesys.com> wrote:
>
> Hello
> 
> On Fri, 2004-12-24 at 18:31, tabris wrote:
> > On Friday 24 December 2004 3:09 am, Andrew Morton wrote:
> > > tabris <tabris@tabris.net> wrote:
> > > > 	Attached are the BUG reports for 2.6.10-rc2-mm4 (multiple BUG
> > > > reports) and one from 2.6.10-rc3-mm1, plus dmesg from
> > > > 2.6.10-rc3-mm1.
> > >
> > > Are you using quotas?
> > 	Yes, I am using quotas.
> > >

I'd be suspecting a quota bug, purely based on the small number of people
reporting a problem and on the size of the quota changes..

> > > What filesystem types are in use?
> > 	I'm using reiserFS and XFS mostly, with one ext2 partition (/boot, 
> > mounted -o sync)
> 
> Would you please try to reproduce this problem with:
> http://marc.theaimsgroup.com/?l=reiserfs&m=110381606727976&q=p3

Reproduced below.  If this doesn't help I'll roll you a kernel without the
quota changes, thanks.


--- 25/fs/reiserfs/super.c~reiserfs-bug-fix-do-not-clear-ms_active-mount-flag	Thu Dec 23 15:08:12 2004
+++ 25-akpm/fs/reiserfs/super.c	Thu Dec 23 15:08:12 2004
@@ -158,6 +158,7 @@ static int finish_unfinished (struct sup
     int truncate;
 #ifdef CONFIG_QUOTA
     int i;
+    int ms_active_set;
 #endif
  
  
@@ -168,7 +169,12 @@ static int finish_unfinished (struct sup
 
 #ifdef CONFIG_QUOTA
     /* Needed for iput() to work correctly and not trash data */
-    s->s_flags |= MS_ACTIVE;
+    if (s->s_flags & MS_ACTIVE) {
+	    ms_active_set = 0;
+    } else {
+	    ms_active_set = 1;
+	    s->s_flags |= MS_ACTIVE;
+    }
     /* Turn on quotas so that they are updated correctly */
     for (i = 0; i < MAXQUOTAS; i++) {
 	if (REISERFS_SB(s)->s_qf_names[i]) {
@@ -276,8 +282,9 @@ static int finish_unfinished (struct sup
             if (sb_dqopt(s)->files[i])
                     vfs_quota_off_mount(s, i);
     }
-    /* Restore the flag back */
-    s->s_flags &= ~MS_ACTIVE;
+    if (ms_active_set)
+	    /* Restore the flag back */
+	    s->s_flags &= ~MS_ACTIVE;
 #endif
     pathrelse (&path);
     if (done)
_

