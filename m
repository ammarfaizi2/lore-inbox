Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWFTXPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWFTXPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 19:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWFTXPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 19:15:25 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:35590 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932114AbWFTXPY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 19:15:24 -0400
To: linux-kernel@vger.kernel.org
Cc: kai@germaschewski.name, Sam Ravnborg <sam@ravnborg.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] Fix 100% initramfs bloat in 2.6.17 versus 2.6.16
From: Nix <nix@esperi.org.uk>
X-Emacs: because idle RAM is the Devil's playground.
Date: Wed, 21 Jun 2006 00:15:17 +0100
Message-ID: <87psh3mnay.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

diff -durN linux-orig/usr/Makefile linux/usr/Makefile
--- linux-orig/usr/Makefile	2006-06-21 00:07:10.000000000 +0100
+++ linux/usr/Makefile	2006-06-21 00:09:29.000000000 +0100
@@ -33,7 +33,7 @@
 endif
 
 quiet_cmd_initfs = GEN     $@
-      cmd_initfs = $(initramfs) -o $@ $(ramfs-args) $(ramfs-input)
+      cmd_initfs = $(initramfs) -o $@ $(ramfs-args)
 
 targets := initramfs_data.cpio.gz
 $(deps_initramfs): klibcdirs

-- 
`NB: Anyone suggesting that we should say "Tibibytes" instead of
 Terabytes there will be hunted down and brutally slain.
 That is all.' --- Matthew Wilcox
