Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVBORPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVBORPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVBORPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:15:37 -0500
Received: from mx1.mail.ru ([194.67.23.121]:39484 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261797AbVBORNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:13:22 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] ext3: Fix sparse -Wbitwise warnings.
Date: Tue, 15 Feb 2005 20:13:21 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Andreas Dilger <adilger@clusterfs.com>,
       ext3-users@redhat.com, linux-kernel@vger.kernel.org
References: <200502151246.06598.adobriyan@mail.ru> <1108476729.3363.9.camel@sisko.sctweedie.blueyonder.co.uk>
In-Reply-To: <1108476729.3363.9.camel@sisko.sctweedie.blueyonder.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200502152013.21556.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 February 2005 16:12, Stephen C. Tweedie wrote:
> On Tue, 2005-02-15 at 10:46, Alexey Dobriyan wrote:
> 
> > -			if ((ret = EXT3_HAS_RO_COMPAT_FEATURE(sb,
> > -					~EXT3_FEATURE_RO_COMPAT_SUPP))) {
> > +			if ((ret = le32_to_cpu(EXT3_HAS_RO_COMPAT_FEATURE(sb,
> > +					~EXT3_FEATURE_RO_COMPAT_SUPP)))) {
> 
> NAK.

Argh... stupid me. super.c part should be just:

--- linux-2.6.11-rc4/fs/ext3/super.c.orig	2005-02-15 20:01:52.000000000 +0200
+++ linux-2.6.11-rc4/fs/ext3/super.c	2005-02-15 20:02:47.000000000 +0200
@@ -2106,6 +2106,7 @@ static int ext3_remount (struct super_bl
 			ext3_mark_recovery_complete(sb, es);
 		} else {
 			__le32 ret;
+			int ret1;
 			if ((ret = EXT3_HAS_RO_COMPAT_FEATURE(sb,
 					~EXT3_FEATURE_RO_COMPAT_SUPP))) {
 				printk(KERN_WARNING "EXT3-fs: %s: couldn't "
@@ -2122,8 +2123,8 @@ static int ext3_remount (struct super_bl
 			 */
 			ext3_clear_journal_err(sb, es);
 			sbi->s_mount_state = le16_to_cpu(es->s_state);
-			if ((ret = ext3_group_extend(sb, es, n_blocks_count)))
-				return ret;
+			if ((ret1 = ext3_group_extend(sb, es, n_blocks_count)))
+				return ret1;
 			if (!ext3_setup_super (sb, es, 0))
 				sb->s_flags &= ~MS_RDONLY;
 		}
