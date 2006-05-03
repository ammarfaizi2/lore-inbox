Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbWECOst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWECOst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 10:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbWECOst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 10:48:49 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:15313 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S965110AbWECOss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 10:48:48 -0400
Subject: Re: [PATCH 11/14] Reworked patch for labels on user space messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Steve Grubb <sgrubb@redhat.com>,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@namei.org>,
       Jon Smirl <jonsmirl@gmail.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060503142802.GD27946@ftp.linux.org.uk>
References: <E1FaVfH-000531-LX@ZenIV.linux.org.uk>
	 <9e4733910605030711p2acab747g8f2ea7fdbb95f3c4@mail.gmail.com>
	 <20060503142802.GD27946@ftp.linux.org.uk>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 03 May 2006 10:52:36 -0400
Message-Id: <1146667956.27735.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 15:28 +0100, Al Viro wrote:
> On Wed, May 03, 2006 at 10:11:52AM -0400, Jon Smirl wrote:
> > Something seems to be wrong in selinux_get_task_sid. I am getting
> > thousands of these and can't boot the kernel.
> 
> It's actually in security/selinux/hooks.c::selinux_disable() and gets
> triggered if you have selinux enabled and explicitly disable afterwards.
> Stephen Smalley had done a fix yesterday, basically adding
> 	selinux_enabled = 0;
> after
>         selinux_disabled = 1;
> in there.  selinux_get_task_sid() happens to step on that in visible way
> and nobody had caught that while this stuff was sitting in -mm ;-/
> 
> The only question I have about that patch: what would happen if we do not
> have CONFIG_SECURITY_SELINUX_BOOTPARAM?  In that case selinux_enabled is
> defined to 1, so...

Good point.  Ok, take two.

[patch 1/1] selinux:  Clear selinux_enabled flag upon runtime disable.

Clear selinux_enabled flag upon runtime disable of SELinux by userspace,
and make sure it is defined even if selinux= boot parameter support is
not enabled in configuration.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/hooks.c            |    3 +++
 security/selinux/include/security.h |    5 -----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/hooks.c linux-2.6.17-rc3-mm1-x2/security/selinux/hooks.c
--- linux-2.6.17-rc3-mm1/security/selinux/hooks.c	2006-05-02 09:08:02.000000000 -0400
+++ linux-2.6.17-rc3-mm1-x2/security/selinux/hooks.c	2006-05-03 10:26:43.000000000 -0400
@@ -101,6 +101,8 @@ static int __init selinux_enabled_setup(
 	return 1;
 }
 __setup("selinux=", selinux_enabled_setup);
+#else
+int selinux_enabled = 1;
 #endif
 
 /* Original (dummy) security module. */
@@ -4535,6 +4537,7 @@ int selinux_disable(void)
 	printk(KERN_INFO "SELinux:  Disabled at runtime.\n");
 
 	selinux_disabled = 1;
+	selinux_enabled = 0;
 
 	/* Reset security_ops to the secondary module, dummy or capability. */
 	security_ops = secondary_ops;
diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/include/security.h linux-2.6.17-rc3-mm1-x2/security/selinux/include/security.h
--- linux-2.6.17-rc3-mm1/security/selinux/include/security.h	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc3-mm1-x2/security/selinux/include/security.h	2006-05-03 10:25:39.000000000 -0400
@@ -29,12 +29,7 @@
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
 #define POLICYDB_VERSION_MAX   POLICYDB_VERSION_AVTAB
 
-#ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
 extern int selinux_enabled;
-#else
-#define selinux_enabled 1
-#endif
-
 extern int selinux_mls_enabled;
 
 int security_load_policy(void * data, size_t len);


-- 
Stephen Smalley
National Security Agency

