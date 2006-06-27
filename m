Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWF0UTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWF0UTO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWF0UTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:19:12 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:19073 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161277AbWF0UTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:19:08 -0400
Message-Id: <20060627201655.873643000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:21 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Sam Ravnborg <sam@ravnborg.org>, Nix <nix@esperi.org.uk>
Subject: [PATCH 21/25] kbuild: Fix 100% initramfs bloat in 2.6.17 versus 2.6.16
Content-Disposition: inline; filename=kbuild-fix-100-initramfs-bloat-in-2.6.17-versus-2.6.16.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Nix <nix@esperi.org.uk>

When I built 2.6.17 for the first time I was a little surprised to see
my kernel putting on >500Kb in weight.

It didn't take long to work out that this was because my initramfs's
contents were being included twice in the cpio image.

A make V=1 makes the problem obvious:

/bin/sh /usr/packages/linux/versions/i686-loki/scripts/gen_initramfs_list.sh -l  "usr/initramfs" > usr/.initramfs_data.cpio.gz.d
  /bin/sh /usr/packages/linux/versions/i686-loki/scripts/gen_initramfs_list.sh -o usr/initramfs_data.cpio.gz  -u 0  -g 0  "usr/initramfs"  "usr/initramfs"

Note that doubling-up of the "usr/initramfs", which leads to
gen_initramfs_list.sh dumping the thing into the cpio archive twice.

The cause is an obvious pasto, fixed thusly:

Signed-off-by: Nick Alcock <nix@esperi.org.uk>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 usr/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.1.orig/usr/Makefile
+++ linux-2.6.17.1/usr/Makefile
@@ -33,7 +33,7 @@ ifneq ($(wildcard $(obj)/.initramfs_data
 endif
 
 quiet_cmd_initfs = GEN     $@
-      cmd_initfs = $(initramfs) -o $@ $(ramfs-args) $(ramfs-input)
+      cmd_initfs = $(initramfs) -o $@ $(ramfs-args)
 
 targets := initramfs_data.cpio.gz
 $(deps_initramfs): klibcdirs

--
