Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVDZHBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVDZHBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVDZHAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:00:06 -0400
Received: from colino.net ([213.41.131.56]:26096 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261365AbVDZG73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 02:59:29 -0400
Date: Tue, 26 Apr 2005 08:59:14 +0200
From: Colin Leroy <colin@colino.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfsplus: don't oops on bad FS
Message-ID: <20050426085914.2b278856@colin.toulouse>
In-Reply-To: <Pine.LNX.4.61.0504252218570.25129@scrub.home>
References: <20050425211915.126ddab5@jack.colino.net>
	<Pine.LNX.4.61.0504252145220.25129@scrub.home>
	<20050425220345.6b2ed6d5@jack.colino.net>
	<Pine.LNX.4.61.0504252218570.25129@scrub.home>
X-Mailer: Sylpheed-Claws 1.9.6 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005 22:26:26 +0200 (CEST)
Roman Zippel <zippel@linux-m68k.org> wrote:

Hi,

> > > Actually it looks like we are always leaking it, so actually 
> > > hfsplus_put_super() needs fixing, could you add the check and
> > > kfree there and do the same fix for hfs?
> > 
> > Mmh, right. Here's an updated version that fixes it too.
> 
> Don't change hfsplus_fill_super, add a "if (!sb->s_fs_info) return;"
> to hfsplus_put_super 

I don't get it. I do have to change hfsplus_fill_super to free 
sb->s_fs_info, don't I? If I just nullify it there, there will be a
leak, and if I don't, put_super won't know it shouldn't do anything.

This try brings in less changes, but I don't see how to do even less:
(pseudo-patch that won't apply, just to know):
--- fs/hfsplus/super.c.orig     2005-04-25 21:56:56.000000000 +0200
+++ fs/hfsplus/super.c  2005-04-26 08:57:22.000000000 +0200
@@ -207,6 +207,9 @@ static void hfsplus_write_super(struct s

 static void hfsplus_put_super(struct super_block *sb)
 {
+       if (!sb->s_fs_info)
+               return;
+
        dprint(DBG_SUPER, "hfsplus_put_super\n");
        if (!(sb->s_flags & MS_RDONLY)) {
                struct hfsplus_vh *vhdr = HFSPLUS_SB(sb).s_vhdr;
@@ -226,6 +229,9 @@ static void hfsplus_put_super(struct sup
        brelse(HFSPLUS_SB(sb).s_vhbh);
        if (HFSPLUS_SB(sb).nls)
                unload_nls(HFSPLUS_SB(sb).nls);
+
+       kfree(sb->s_fs_info);
+       sb->s_fs_info = NULL;
 }

 static int hfsplus_statfs(struct super_block *sb, struct kstatfs *buf)
@@ -427,6 +433,9 @@ out:
        return 0;

 cleanup:
+       kfree(sb->s_fs_info);
+       sb->s_fs_info = NULL;
+
        hfsplus_put_super(sb);
        if (nls)
                unload_nls(nls);

What do you think?

Thanks,
-- 
Colin
