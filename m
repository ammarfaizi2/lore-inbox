Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWIDLjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWIDLjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWIDLjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:39:15 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:51683 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964840AbWIDLjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:39:14 -0400
Date: Mon, 4 Sep 2006 13:35:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 07/16] GFS2: Directory handling
In-Reply-To: <1157031298.3384.797.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609041314470.21005@yvahk01.tjqt.qr>
References: <1157031298.3384.797.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+
>+	return copied;
>+fail:
>+	return (copied) ? copied : error;
>+}
>+
>+typedef int (*gfs2_dscan_t)(const struct gfs2_dirent *dent,
>+			    const struct qstr *name,
>+			    void *opaque);

Collect all the typedefs above all functions (applies to all .c files).

>+static inline int __gfs2_dirent_find(const struct gfs2_dirent *dent,
>+				     const struct qstr *name, int ret)
>+{
>+	if (dent->de_inum.no_addr != 0 &&
>+	    be32_to_cpu(dent->de_hash) == name->hash &&
>+	    be16_to_cpu(dent->de_name_len) == name->len &&
>+	    memcmp((char *)(dent+1), name->name, name->len) == 0)

Nocast.

>+static struct gfs2_dirent *gfs2_dirent_scan(struct inode *inode,
>+					    void *buf,
>+					    unsigned int len, gfs2_dscan_t scan,
>+					    const struct qstr *name,
>+					    void *opaque)
>+{
>+	struct gfs2_dirent *dent, *prev;
>+	unsigned offset;
>+	unsigned size;
>+	int ret = 0;
>+
>+	ret = gfs2_dirent_offset(buf);
>+	if (ret < 0)
>+		goto consist_inode;
>+
>+	offset = ret;
>+	prev = NULL;
>+	dent = (struct gfs2_dirent *)(buf + offset);

Nocast.

>+		dent = (struct gfs2_dirent *)(buf + offset);


>+	if ((char *)cur + cur_rec_len >= bh_end) {
>+		if ((char *)cur + cur_rec_len > bh_end) {
>+			gfs2_consist_inode(dip);
>+			return -EIO;
>+		}
>+		return -ENOENT;
>+	}

if((char *)cur + cur_rec_len > bh_end) {
	gfs2_consist_inode(dip);
	return -EIO;
} else if((char *)cur + cur_rec_len == bh_end)
	return -ENOENT;

>+	tmp = (struct gfs2_dirent *)((char *)cur + cur_rec_len);
>+
>+	if ((char *)tmp + be16_to_cpu(tmp->de_rec_len) > bh_end) {

Aah, this makes my eyes hurt. Though, it is probably a task not too short to
think of something that would do without casts.

>+	leaf->lf_depth = cpu_to_be16(depth);
>+	leaf->lf_entries = cpu_to_be16(0);

0 is said to be portable across all CPUs, therefore

	leaf->lf_entries = 0;

should suffice.

>+	leaf->lf_next = cpu_to_be64(0);


>+		for (x = sdp->sd_hash_ptrs; x--; from++) {
>+			*to++ = *from;	/*  No endianess worries  */
>+			*to++ = *from;
>+		}

Add /* Hakuna Matata */ and there will never be worries :-)

>+static int compare_dents(const void *a, const void *b)
>+{
>+	struct gfs2_dirent *dent_a, *dent_b;
>+	uint32_t hash_a, hash_b;
>+	int ret = 0;
>+
>+	dent_a = *(struct gfs2_dirent **)a;

But in this function you can have it const! Or not?

>+	hash_a = be32_to_cpu(dent_a->de_hash);
>+
>+	dent_b = *(struct gfs2_dirent **)b;
>+	hash_b = be32_to_cpu(dent_b->de_hash);
>+
>+	if (hash_a > hash_b)
>+		ret = 1;
>+	else if (hash_a < hash_b)
>+		ret = -1;
>+	else {
>+		unsigned int len_a = be16_to_cpu(dent_a->de_name_len);
>+		unsigned int len_b = be16_to_cpu(dent_b->de_name_len);
>+
>+		if (len_a > len_b)
>+			ret = 1;
>+		else if (len_a < len_b)
>+			ret = -1;
>+		else
>+			ret = memcmp((char *)(dent_a + 1),
>+				     (char *)(dent_b + 1),
>+				     len_a);

Nocast.

>+		error = filldir(opaque, (char *)(dent + 1),

If you case, then cast it directly, in this case, filldir takes "const char *"
as 2nd type.

>+	larr = vmalloc((leaves + entries) * sizeof(void*));
                                                       ^
Space, to go in line with all the other casts.

>+static inline uint32_t gfs2_disk_hash(const char *data, int len)
>+{
>+        return crc32_le(0xFFFFFFFF, data, len) ^ 0xFFFFFFFF;
>+}

Mind using (uint32_t)-1 or (uint32_t)~0 for that?

>+	memcpy((char*)(dent+1), name->name, name->len);

Last but not least, nocast.


Otherwise just stuff already mentioned.

Jan Engelhardt
-- 

-- 
VGER BF report: H 0.0146386
