Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162836AbWLBIlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162836AbWLBIlK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 03:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162835AbWLBIlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 03:41:10 -0500
Received: from mailer-b2.gwdg.de ([134.76.10.29]:22743 "EHLO mailer-b2.gwdg.de")
	by vger.kernel.org with ESMTP id S1162836AbWLBIlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 03:41:07 -0500
Date: Sat, 2 Dec 2006 09:40:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [GFS2] Fix crc32 calculation in recovery.c [8/70]
In-Reply-To: <1164888829.3752.318.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0612020939460.1635@yvahk01.tjqt.qr>
References: <1164888829.3752.318.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Commit "[GFS2] split and annotate gfs2_log_head" resulted in an incorrect
>checksum calculation for log headers. This patch corrects the
>problem without resorting to copying the whole log header as
>the previous code used to.
>
>Cc: Al Viro <viro@zeniv.linux.org.uk>
>Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
>---
> fs/gfs2/recovery.c |    9 +++++----
> 1 files changed, 5 insertions(+), 4 deletions(-)
>
>diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
>index 4478162..4acf238 100644
>--- a/fs/gfs2/recovery.c
>+++ b/fs/gfs2/recovery.c
>@@ -136,6 +136,7 @@ static int get_log_header(struct gfs2_jd
> {
> 	struct buffer_head *bh;
> 	struct gfs2_log_header_host lh;
>+static const u32 nothing = 0;
> 	u32 hash;
> 	int error;
> 

At least indent it.

>@@ -143,11 +144,11 @@ static int get_log_header(struct gfs2_jd
> 	if (error)
> 		return error;
> 
>-	memcpy(&lh, bh->b_data, sizeof(struct gfs2_log_header));	/* XXX */
>-	lh.lh_hash = 0;
>-	hash = gfs2_disk_hash((char *)&lh, sizeof(struct gfs2_log_header));
>+	hash = crc32_le((u32)~0, bh->b_data, sizeof(struct gfs2_log_header) -
>+					     sizeof(u32));
>+	hash = crc32_le(hash, (unsigned char const *)&nothing, sizeof(nothing));
>+	hash ^= (u32)~0;
> 	gfs2_log_header_in(&lh, bh->b_data);
>-
> 	brelse(bh);
> 
> 	if (lh.lh_header.mh_magic != GFS2_MAGIC ||
>-- 
>1.4.1


	-`J'
-- 
