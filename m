Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWIDQ74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWIDQ74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 12:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWIDQ74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 12:59:56 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:64401 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964893AbWIDQ7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 12:59:55 -0400
Date: Mon, 4 Sep 2006 18:55:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 09/16] GFS2: Extended attribute & ACL support
In-Reply-To: <1157031403.3384.801.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609041835590.28823@yvahk01.tjqt.qr>
References: <1157031403.3384.801.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+#if 0
>+	else if ((ip->i_di.di_flags & GFS2_DIF_EA_PACKED) &&
>+		 er->er_type == GFS2_EATYPE_SYS)
>+		return 1;
>+#endif

>+/**
>+ * ea_get_unstuffed - actually copies the unstuffed data into the
>+ *                    request buffer
>+ * @ip:
>+ * @ea:
>+ * @data:
>+ *
>+ * Returns: errno
>+ */

There are more of these. If you have the time, please fill in.

>+			*dataptr++ = cpu_to_be64((uint64_t)bh->b_blocknr);

At least on i386, this cast seems unnecessary, since

include/asm-i386/byteorder.h:
static __inline__ __attribute_const__ __u64 ___arch__swab64(__u64 val)          

but someone else should probably prove me right/wrong.

>+	if (private)
>+		ea_set_remove_stuffed(ip, (struct gfs2_ea_location *)private);

private is a void *, ergo nocast.

>+	gfs2_glock_dq_uninit(&al->al_ri_gh);

Another Ken Preslan gem? al_ri_gh_t then.

>+		return (5 + (ea->ea_name_len + 1));
()

>+unsigned int gfs2_ea_name2type(const char *name, char **truncated_name)
>+{
>+	unsigned int type;
>+
>+	if (strncmp(name, "system.", 7) == 0) {
>+		type = GFS2_EATYPE_SYS;
>+		if (truncated_name)
>+			*truncated_name = strchr(name, '.') + 1;

Since we already know where the dot is (otherwise, strncmp would have failed),
we can omit the relookup with strchr:

	*truncated_name = name + sizeof("system.") - 1;

>+	} else if (strncmp(name, "user.", 5) == 0) {
>+		type = GFS2_EATYPE_USR;
>+		if (truncated_name)
>+			*truncated_name = strchr(name, '.') + 1;
>+	} else if (strncmp(name, "security.", 9) == 0) {
>+		type = GFS2_EATYPE_SECURITY;
>+		if (truncated_name)
>+			*truncated_name = strchr(name, '.') + 1;

Similarly.



Jan Engelhardt
-- 
