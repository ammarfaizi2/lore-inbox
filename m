Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbTLUW4P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 17:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTLUW4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 17:56:15 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:61701 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S264254AbTLUW4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 17:56:12 -0500
Message-ID: <3FE62617.10604@kolumbus.fi>
Date: Mon, 22 Dec 2003 01:00:39 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Slusky <sluskyb@paranoiacs.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       jariruusu@users.sourceforge.net
Subject: Re: [PATCH] loop.c patches, take two
References: <20031030134137.GD12147@fukurou.paranoiacs.org> <3FA15506.B9B76A5D@users.sourceforge.net> <20031030133000.6a04febf.akpm@osdl.org> <20031031005246.GE12147@fukurou.paranoiacs.org> <20031031015500.44a94f88.akpm@osdl.org> <20031101002650.GA7397@fukurou.paranoiacs.org> <20031102204624.GA5740@fukurou.paranoiacs.org> <20031221195534.GA4721@fukurou.paranoiacs.org> <3FE6076B.3090908@kolumbus.fi> <20031221211201.GC4721@fukurou.paranoiacs.org>
In-Reply-To: <20031221211201.GC4721@fukurou.paranoiacs.org>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 22.12.2003 00:58:14,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 22.12.2003 00:57:23,
	Serialize complete at 22.12.2003 00:57:23
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 static inline void loop_handle_bio(struct loop_device *lo, struct bio *bio)
 {
 	int ret;
+	struct bio *rbh;
 
-	/*
-	 * For block backed loop, we know this is a READ
-	 */
 	if (lo->lo_flags & LO_FLAGS_DO_BMAP) {
 		ret = do_bio_filebacked(lo, bio);
 		bio_endio(bio, bio->bi_size, ret);
-	} else {
-		struct bio *rbh = bio->bi_private;
+	} else if (bio_rw(bio) == WRITE) {
+		/*


AFAICS, this code path is never taken. You don't queue block device writes for the loop thread.


+		 * Write complete, but more pages remain;
+		 * encrypt and write some more pages
+		 */
+		loop_recycle_buffer(lo, bio);



--Mika



