Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWIEIig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWIEIig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 04:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWIEIig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 04:38:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35460 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932148AbWIEIif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 04:38:35 -0400
Subject: Re: [PATCH 07/16] GFS2: Directory handling
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609041314470.21005@yvahk01.tjqt.qr>
References: <1157031298.3384.797.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609041314470.21005@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 05 Sep 2006 09:44:14 +0100
Message-Id: <1157445854.3384.965.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-09-04 at 13:35 +0200, Jan Engelhardt wrote:
> >+
> >+	return copied;
> >+fail:
> >+	return (copied) ? copied : error;
> >+}
> >+
> >+typedef int (*gfs2_dscan_t)(const struct gfs2_dirent *dent,
> >+			    const struct qstr *name,
> >+			    void *opaque);
> 
> Collect all the typedefs above all functions (applies to all .c files).
> 
ok

> >+static inline int __gfs2_dirent_find(const struct gfs2_dirent *dent,
> >+				     const struct qstr *name, int ret)
> >+{
> >+	if (dent->de_inum.no_addr != 0 &&
> >+	    be32_to_cpu(dent->de_hash) == name->hash &&
> >+	    be16_to_cpu(dent->de_name_len) == name->len &&
> >+	    memcmp((char *)(dent+1), name->name, name->len) == 0)
> 
> Nocast.
> 
ok

> >+static struct gfs2_dirent *gfs2_dirent_scan(struct inode *inode,
[lines snipped]
> >+	offset = ret;
> >+	prev = NULL;
> >+	dent = (struct gfs2_dirent *)(buf + offset);
> 
> Nocast.
> 
ok
> >+		dent = (struct gfs2_dirent *)(buf + offset);
> 
> 
> >+	if ((char *)cur + cur_rec_len >= bh_end) {
> >+		if ((char *)cur + cur_rec_len > bh_end) {
> >+			gfs2_consist_inode(dip);
> >+			return -EIO;
> >+		}
> >+		return -ENOENT;
> >+	}
> 
> if((char *)cur + cur_rec_len > bh_end) {
> 	gfs2_consist_inode(dip);
> 	return -EIO;
> } else if((char *)cur + cur_rec_len == bh_end)
> 	return -ENOENT;
> 
ok

> >+	tmp = (struct gfs2_dirent *)((char *)cur + cur_rec_len);
> >+
> >+	if ((char *)tmp + be16_to_cpu(tmp->de_rec_len) > bh_end) {
> 
> Aah, this makes my eyes hurt. Though, it is probably a task not too short to
> think of something that would do without casts.
> 
Well I've had a crack at this. I've got it down to one cast. Let me know
if you think thats ok now... I managed to factor out some common code at
the same time.

> >+	leaf->lf_depth = cpu_to_be16(depth);
> >+	leaf->lf_entries = cpu_to_be16(0);
> 
> 0 is said to be portable across all CPUs, therefore
> 
> 	leaf->lf_entries = 0;
> 
> should suffice.
> 
> >+	leaf->lf_next = cpu_to_be64(0);
> 
ok, both now fixed.

> 
> >+		for (x = sdp->sd_hash_ptrs; x--; from++) {
> >+			*to++ = *from;	/*  No endianess worries  */
> >+			*to++ = *from;
> >+		}
> 
> Add /* Hakuna Matata */ and there will never be worries :-)
> 
:-) I had to use google to understand the reference :-)

> >+static int compare_dents(const void *a, const void *b)
> >+{
> >+	struct gfs2_dirent *dent_a, *dent_b;
> >+	uint32_t hash_a, hash_b;
> >+	int ret = 0;
> >+
> >+	dent_a = *(struct gfs2_dirent **)a;
> 
> But in this function you can have it const! Or not?
> 
Yes, and now all converted to const
[lines snipped]
> 		ret = memcmp((char *)(dent_a + 1),
> >+				     (char *)(dent_b + 1),
> >+				     len_a);
> 
> Nocast.
> 
ok

> >+		error = filldir(opaque, (char *)(dent + 1),
> 
> If you case, then cast it directly, in this case, filldir takes "const char *"
> as 2nd type.
> 
ok

> >+	larr = vmalloc((leaves + entries) * sizeof(void*));
>                                                        ^
> Space, to go in line with all the other casts.
> 
fixed

> >+static inline uint32_t gfs2_disk_hash(const char *data, int len)
> >+{
> >+        return crc32_le(0xFFFFFFFF, data, len) ^ 0xFFFFFFFF;
> >+}
> 
> Mind using (uint32_t)-1 or (uint32_t)~0 for that?
> 
~0 is the variant I've chosen.

> >+	memcpy((char*)(dent+1), name->name, name->len);
> 
> Last but not least, nocast.
> 
ok.

The patch is:
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=2bdbc5d73961c040fdc9b30d985fab3047d697a0

Thanks for doing all this review work, btw. I'll be working on your more
recent emails today,

Steve.


