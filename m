Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWIDPVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWIDPVq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 11:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWIDPVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 11:21:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3033 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751463AbWIDPVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 11:21:44 -0400
Subject: Re: [PATCH 06/16] GFS2: dentry, export, super and vm operations
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609041046380.11217@yvahk01.tjqt.qr>
References: <1157031245.3384.795.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609041046380.11217@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 04 Sep 2006 16:27:02 +0100
Message-Id: <1157383622.3384.950.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-09-04 at 11:06 +0200, Jan Engelhardt wrote:
> >+	this 		= &fh_obj.this;
> >+	fh_obj.imode 	= DT_UNKNOWN;
> >+	memset(&parent, 0, sizeof(struct gfs2_inum));
> >+
> >+	switch (fh_type) {
> >+	case 10:
> >+		parent.no_formal_ino = ((uint64_t)be32_to_cpu(fh[4])) << 32;
> >+		parent.no_formal_ino |= be32_to_cpu(fh[5]);
> >+		parent.no_addr = ((uint64_t)be32_to_cpu(fh[6])) << 32;
> >+		parent.no_addr |= be32_to_cpu(fh[7]);
> >+		fh_obj.imode = be32_to_cpu(fh[8]);
> >+	case 4:
> 
> What do these constants specify? Would not it be better to have a #define or
> enum{} for them somewhere?
> 
The sizes of the NFS file handles in units of sizeof(u32). I've added a
couple of #defines as requested.

> 
> >+	if (IS_ERR(inode))
> >+		return ERR_PTR(PTR_ERR(inode));
> 
> Just return inode.
> 
The function returns a dentry, so it would need to be casted and I
thought that would look "more odd" than this construction.

> >+	if (!strncmp(sb->s_type->name, "gfs2meta", 8))
> >+		return; /* meta fs. don't do nothin' */
> 
> Don't nobody go nowhere![1] You see, american negation can be fun, but well,
> just say: Nothing to do for gfs2meta.
> 
> >+	sb->s_fs_info = NULL;
> 
> Required?
> 
Both fixed.

> >+static void gfs2_write_super(struct super_block *sb)
> >+{
> >+	struct gfs2_sbd *sdp = sb->s_fs_info;
> >+	gfs2_log_flush(sdp, NULL);
> >+}
> 
> gfs2_log_flush(sb->s_fs_info, NULL)
> 
ok.

> >+static void gfs2_unlockfs(struct super_block *sb)
> >+{
> >+	struct gfs2_sbd *sdp = sb->s_fs_info;
> >+	gfs2_unfreeze_fs(sdp);
> >+}
> 
> 
I just realised that I missed this one, but it will be in the next
patch...

> 
> >+	for (x = 2;; x++) {
> >+		uint64_t space, d;
> >+		uint32_t m;
> >+
> >+		space = sdp->sd_heightsize[x - 1] * sdp->sd_inptrs;
> >+		d = space;
> >+		m = do_div(d, sdp->sd_inptrs);
> 
> Note for Ingo: simple "/" division does not do it:
> 
> 11:00 gwdg-wb04A:/dev/shm > cat foo.c
> #include <linux/types.h>
> 
> 
> uint32_t foo(uint32_t arg) {
>     uint64_t bar = 1337;
>     return bar / arg;
> }
> 
> 
> 11:00 gwdg-wb04A:/dev/shm > make -C /lib/modules/2.6.17.11-jen33-default/build
> M=$PWD modules
> make: Entering directory /usr/src/linux-2.6.17.11-jen33-obj/i386/default'
> make -C ../../../linux-2.6.17.11-jen33
> O=../linux-2.6.17.11-jen33-obj/i386/default modules
>   CC [M]  /dev/shm/foo.o
>   Building modules, stage 2.
>   MODPOST
> WARNING: "__udivdi3" [/dev/shm/foo.ko] undefined!
>   CC      /dev/shm/foo.mod.o
>   LD [M]  /dev/shm/foo.ko
> make: Leaving directory /usr/src/linux-2.6.17.11-jen33-obj/i386/default'
> 
> 
Yes, I'd spotted this in your email earlier on in the day, so thats why
I didn't reply to this thread before.

> 
> >+/**
> >+ * gfs2_assert_warn_i - Print a message to the console if @assertion is false
> >+ * Returns: -1 if we printed something
> >+ *          -2 if we didn't
> >+ */
> 
> Why not just 0 and 1?
> 
gfs2_assert_warn_i is called from the gfs2_assert_warn macro in util.h.
The macro evaluates to 0 in the case that the assert is not triggered,
so anything non-zero means that it was triggered, even if nothing was
printed. The patch this time is:

http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=5acd3967347dab361d296d39ba19f8241507ef65

Steve.


