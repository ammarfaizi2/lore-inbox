Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbWEaOx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWEaOx1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 10:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWEaOx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 10:53:27 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:13720 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S965046AbWEaOx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 10:53:27 -0400
Subject: [patch 1/1] selinux:  fix sb_lock/sb_security_lock nesting (Was:
	Re: 2.6.17-rc5-mm1)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       James Morris <jmorris@namei.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1149015890.3636.92.camel@laptopd505.fenrus.org>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <6bffcb0e0605301139l2b4895d0mbecffb422fb2c0cf@mail.gmail.com>
	 <1149015890.3636.92.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 31 May 2006 10:56:52 -0400
Message-Id: <1149087412.524.169.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 21:04 +0200, Arjan van de Ven wrote:
> On Tue, 2006-05-30 at 20:39 +0200, Michal Piotrowski wrote:
> > Hi,
> > 
> > On 30/05/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
> > >
> > 
> > I get this on 2.6.17-rc5-mm1 + hot fixes + Arjan's net/ipv4/igmp.c patch.
> > 
> > May 30 20:25:56 ltg01-fedora kernel:
> > May 30 20:25:56 ltg01-fedora kernel:
> > =====================================================
> > May 30 20:25:56 ltg01-fedora kernel: [ BUG: possible circular locking
> > deadlock detected! ]
> > May 30 20:25:56 ltg01-fedora kernel:
> > -----------------------------------------------------
> > May 30 20:25:56 ltg01-fedora kernel: umount/2322 is trying to acquire lock:
> > May 30 20:25:56 ltg01-fedora kernel:  (sb_security_lock){--..}, at:
> > [<c01d6400>] selinux_sb_free_security+0x17/0x4e
> 
> 
> ok so  selinux_complete_init() does
>         spin_lock(&sb_security_lock);
> next_sb:
>         if (!list_empty(&superblock_security_head)) {
>                 struct superblock_security_struct *sbsec =
>                                 list_entry(superblock_security_head.next,
>                                            struct superblock_security_struct,
>                                            list);
>                 struct super_block *sb = sbsec->sb;
>                 spin_lock(&sb_lock);
>                 sb->s_count++;
>                 spin_unlock(&sb_lock);
>                 spin_unlock(&sb_security_lock);
> 
> nesting sb_lock inside sb_security_lock
> 
> while
> 
> put_super() takes the sb_lock, then calls __put_super() which calls 
> selinux_sb_free_security which calls superblock_free_security() which takes sb_security_lock
> which means the nesting is opposite.
> 
> 
> textbook AB-BA deadlock

Yes, looks that way, although oddly I don't see this warning myself upon
performing a umount (w/ 2.6.17-rc5-mm1-lockdep).  Patch below should
fix.

---

Fix unsafe nesting of sb_lock inside sb_security_lock in selinux_complete_init.
Detected by the kernel locking validator.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/hooks.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc5-mm1/security/selinux/hooks.c	2006-05-30 14:26:11.000000000 -0400
+++ linux-2.6.17-rc5-mm1-x/security/selinux/hooks.c	2006-05-31 07:29:23.000000000 -0400
@@ -4448,6 +4448,7 @@ void selinux_complete_init(void)
 
 	/* Set up any superblocks initialized prior to the policy load. */
 	printk(KERN_INFO "SELinux:  Setting up existing superblocks.\n");
+	spin_lock(&sb_lock);
 	spin_lock(&sb_security_lock);
 next_sb:
 	if (!list_empty(&superblock_security_head)) {
@@ -4456,19 +4457,20 @@ next_sb:
 				           struct superblock_security_struct,
 				           list);
 		struct super_block *sb = sbsec->sb;
-		spin_lock(&sb_lock);
 		sb->s_count++;
-		spin_unlock(&sb_lock);
 		spin_unlock(&sb_security_lock);
+		spin_unlock(&sb_lock);
 		down_read(&sb->s_umount);
 		if (sb->s_root)
 			superblock_doinit(sb, NULL);
 		drop_super(sb);
+		spin_lock(&sb_lock);
 		spin_lock(&sb_security_lock);
 		list_del_init(&sbsec->list);
 		goto next_sb;
 	}
 	spin_unlock(&sb_security_lock);
+	spin_unlock(&sb_lock);
 }
 
 /* SELinux requires early initialization in order to label

-- 
Stephen Smalley
National Security Agency

