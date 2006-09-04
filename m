Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWIDOMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWIDOMe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWIDOMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:12:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48043 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751053AbWIDOMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:12:33 -0400
Subject: Re: [PATCH 04/16] GFS2: Daemons and address space operations
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609031245240.31445@yvahk01.tjqt.qr>
References: <1157031127.3384.791.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609031245240.31445@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 04 Sep 2006 15:13:08 +0100
Message-Id: <1157379188.3384.926.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2006-09-03 at 13:13 +0200, Jan Engelhardt wrote:
> >+static void buf_lo_before_commit(struct gfs2_sbd *sdp)
> >+{
[some lines snipped]
> >+
> >+	offset += (sizeof(__be64) - 1);
> 
> -()
> 
ok.

> >+		ld = (struct gfs2_log_descriptor *)bh->b_data;
> >+		ptr = (__be64 *)(bh->b_data + offset);
> 
> Hm too bad that b_data (include/linux/buffer_head.h) is a char*.
> 
Indeed.

> >+	gfs2_replay_incr_blk(sdp, &start);
> >+
> >+	for (; blks; gfs2_replay_incr_blk(sdp, &start), blks--) {
> >+		blkno = be64_to_cpu(*ptr++);
> >+
> >+		sdp->sd_found_blocks++;
> >+
> >+		if (gfs2_revoke_check(sdp, blkno, start))
> >+			continue;
> >+
> >+		error = gfs2_replay_read_block(jd, start, &bh_log);
> >+                if (error)
> >+                        return error;
> 
> Last two lines do not match your usual indent.
> 
ok, now fixed.

> >+static void buf_lo_after_scan(struct gfs2_jdesc *jd, int error, int pass)
> >+{
> >+	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
> >+	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
> >+
> >+	if (error) {
> >+		gfs2_meta_sync(ip->i_gl,
> >+			       DIO_START | DIO_WAIT);
> 
> gfs2_meta_sync() would fit on one line.
ok.

> >+	offset += (2*sizeof(__be64) - 1);
> 
> >+#ifndef __LOPS_DOT_H__
> >+#define __LOPS_DOT_H__
> 
> +struct gfs2_log_operations;
> 
> Making sure every .h file would "compile" on its own, this also means #include
> <linux/list.h> for the below, f.ex..
> 
Is this really a requirement? I suspect there are a fair few exception
to this over the kernel code.

> >+
> >+static inline void lops_init_le(struct gfs2_log_element *le,
> >+				const struct gfs2_log_operations *lops)
> >+{
> >+	INIT_LIST_HEAD(&le->le_list);
> >+	le->le_ops = lops;
> >+}
> >+
> >+#endif /* __LOPS_DOT_H__ */
> 
> >+MODULE_DESCRIPTION("Global File System");
> >+MODULE_AUTHOR("Red Hat, Inc.");
> >+MODULE_LICENSE("GPL");
> 
> Maybe there should be at least one humna person listen in AUTHOR.
> 
Ok, I'll get back to you on that one :-)

> >+static const struct address_space_operations aspace_aops = {
> >+	.writepage = gfs2_aspace_writepage,
> >+	.releasepage = gfs2_releasepage,
> >+};
> 
> Not all multi-line structs (such as these) have a , on the last element.
> 
Are you saying that they should all end in a , or that they should not,
or even just that it should be consistent?

> >+void gfs2_attach_bufdata(struct gfs2_glock *gl, struct buffer_head *bh,
> >+			 int meta)
> >+{
[code snipped]
> >+	INIT_LIST_HEAD(&bd->bd_list_tr);
> >+	if (meta) {
> >+		lops_init_le(&bd->bd_le, &gfs2_buf_lops);
> >+	} else {
> >+		lops_init_le(&bd->bd_le, &gfs2_databuf_lops);
> >+	}
> 
> -{}
> 
ok.


> Hm, how about
> 
> void gfs2_inum_in(struct gfs2_inum *no, void *buf)
> {
> 	const struct gfs2_inum *str = buf;
> 
> 	no->no_formal_ino = be64_to_cpu(str->no_formal_ino);
> 	no->no_addr = be64_to_cpu(str->no_addr);
> }
> 
> That is, making the 2nd argument a void*, and the cast can go away. The callers
> most likely also can have their casts dropped, since to-void* is also implicit.
> Also applies to
> 
Yes, and also I've updated all the other similar functions as requested.

> >+++ b/fs/gfs2/ops_address.c
> >+	if (likely(file != &gfs2_internal_file_sentinal)) {
> 
> The thing is usually called "sentinel". Alan might prove me wrong that both
> spelling variants are possible :-)
> 
I think you are right, so I've changed it.

> >+static int gfs2_commit_write(struct file *file, struct page *page,
> >+			     unsigned from, unsigned to)
> >+{
[code snipped]
> >+		kaddr = kmap_atomic(page, KM_USER0);
> >+		memcpy(dibh->b_data + sizeof(struct gfs2_dinode) + from,
> >+		       (char *)kaddr + from, to - from);
> 
> Nocast kaddr + from.
> 
ok.

> >+static void stuck_releasepage(struct buffer_head *bh)
> >+{
> >+static unsigned limit = 0;
> 
> Is this really ok to have?
> 
I think so. I don't really care about the odd race here. All I want to
do is ensure that in the (very unlikely, I hope) situation of this
function being called, we don't land up generating huge amounts of
debugging information. Usually only the first message will have the
useful information in it, so this was just to ensure that we are not
flooded. I have made a slight change to it though. Let me know if you'd
like some further changes in this area.

Patches relating to this email:
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=82ffa51637f9239aaddd3151fb0d41c657f760db
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=38c60ef228596c8e331437ea9287ce035706b107
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=dd538c832aaf8e35c46c98a825fa9dacee3cf226
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=0bd5996a00346fee772cbdebc5666fd4e514089b

Steve.


