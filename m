Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWIDJKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWIDJKp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 05:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWIDJKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 05:10:45 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:62115 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751163AbWIDJKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 05:10:43 -0400
Date: Mon, 4 Sep 2006 11:06:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 06/16] GFS2: dentry, export, super and vm operations
In-Reply-To: <1157031245.3384.795.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609041046380.11217@yvahk01.tjqt.qr>
References: <1157031245.3384.795.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+	this 		= &fh_obj.this;
>+	fh_obj.imode 	= DT_UNKNOWN;
>+	memset(&parent, 0, sizeof(struct gfs2_inum));
>+
>+	switch (fh_type) {
>+	case 10:
>+		parent.no_formal_ino = ((uint64_t)be32_to_cpu(fh[4])) << 32;
>+		parent.no_formal_ino |= be32_to_cpu(fh[5]);
>+		parent.no_addr = ((uint64_t)be32_to_cpu(fh[6])) << 32;
>+		parent.no_addr |= be32_to_cpu(fh[7]);
>+		fh_obj.imode = be32_to_cpu(fh[8]);
>+	case 4:

What do these constants specify? Would not it be better to have a #define or
enum{} for them somewhere?


>+	if (IS_ERR(inode))
>+		return ERR_PTR(PTR_ERR(inode));

Just return inode.

>+	if (!strncmp(sb->s_type->name, "gfs2meta", 8))
>+		return; /* meta fs. don't do nothin' */

Don't nobody go nowhere![1] You see, american negation can be fun, but well,
just say: Nothing to do for gfs2meta.

>+	sb->s_fs_info = NULL;

Required?

>+static void gfs2_write_super(struct super_block *sb)
>+{
>+	struct gfs2_sbd *sdp = sb->s_fs_info;
>+	gfs2_log_flush(sdp, NULL);
>+}

gfs2_log_flush(sb->s_fs_info, NULL)

>+static void gfs2_unlockfs(struct super_block *sb)
>+{
>+	struct gfs2_sbd *sdp = sb->s_fs_info;
>+	gfs2_unfreeze_fs(sdp);
>+}



>+	for (x = 2;; x++) {
>+		uint64_t space, d;
>+		uint32_t m;
>+
>+		space = sdp->sd_heightsize[x - 1] * sdp->sd_inptrs;
>+		d = space;
>+		m = do_div(d, sdp->sd_inptrs);

Note for Ingo: simple "/" division does not do it:

11:00 gwdg-wb04A:/dev/shm > cat foo.c
#include <linux/types.h>


uint32_t foo(uint32_t arg) {
    uint64_t bar = 1337;
    return bar / arg;
}


11:00 gwdg-wb04A:/dev/shm > make -C /lib/modules/2.6.17.11-jen33-default/build
M=$PWD modules
make: Entering directory /usr/src/linux-2.6.17.11-jen33-obj/i386/default'
make -C ../../../linux-2.6.17.11-jen33
O=../linux-2.6.17.11-jen33-obj/i386/default modules
  CC [M]  /dev/shm/foo.o
  Building modules, stage 2.
  MODPOST
WARNING: "__udivdi3" [/dev/shm/foo.ko] undefined!
  CC      /dev/shm/foo.mod.o
  LD [M]  /dev/shm/foo.ko
make: Leaving directory /usr/src/linux-2.6.17.11-jen33-obj/i386/default'



>+/**
>+ * gfs2_assert_warn_i - Print a message to the console if @assertion is false
>+ * Returns: -1 if we printed something
>+ *          -2 if we didn't
>+ */

Why not just 0 and 1?



[1] Marvin in "Back To The Future I"


Jan Engelhardt
-- 

-- 
VGER BF report: U 0.499261
