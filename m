Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264241AbTLUXFk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 18:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbTLUXFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 18:05:40 -0500
Received: from adsl-216-158-28-251.cust.oldcity.dca.net ([216.158.28.251]:33408
	"EHLO fukurou.paranoiacs.org") by vger.kernel.org with ESMTP
	id S264241AbTLUXFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 18:05:39 -0500
Date: Sun, 21 Dec 2003 18:05:24 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: Mika Penttil? <mika.penttila@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       jariruusu@users.sourceforge.net
Subject: Re: [PATCH] loop.c patches, take two
Message-ID: <20031221230522.GD4721@fukurou.paranoiacs.org>
Mail-Followup-To: Ben Slusky <sluskyb@paranoiacs.org>,
	Mika Penttil? <mika.penttila@kolumbus.fi>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	jariruusu@users.sourceforge.net
References: <3FA15506.B9B76A5D@users.sourceforge.net> <20031030133000.6a04febf.akpm@osdl.org> <20031031005246.GE12147@fukurou.paranoiacs.org> <20031031015500.44a94f88.akpm@osdl.org> <20031101002650.GA7397@fukurou.paranoiacs.org> <20031102204624.GA5740@fukurou.paranoiacs.org> <20031221195534.GA4721@fukurou.paranoiacs.org> <3FE6076B.3090908@kolumbus.fi> <20031221211201.GC4721@fukurou.paranoiacs.org> <3FE62617.10604@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE62617.10604@kolumbus.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Dec 2003 01:00:39 +0200, Mika Penttil? wrote:
> AFAICS, this code path is never taken. You don't queue block device writes 
> for the loop thread.

Yes I do, in loop_end_io_transfer. If we allocated fewer pages for the copy
bio than contained in the original bio, then those pages are recycled for
the next write.

@@ -413,7 +411,7 @@ static int loop_end_io_transfer(struct b
 	if (bio->bi_size)
 		return 1;
 
-	if (err || bio_rw(bio) == WRITE) {
+	if (err || (bio_rw(bio) == WRITE && bio->bi_vcnt == rbh->bi_vcnt)) {
 		bio_endio(rbh, rbh->bi_size, err);
 		if (atomic_dec_and_test(&lo->lo_pending))
 			up(&lo->lo_bh_mutex);

-- 
Ben Slusky                | "Looks like yet another megatrend
sluskyb@paranoiacs.org    |  has come and gone without affecting
sluskyb@stwing.org        |  me in any way whatsoever."
PGP keyID ADA44B3B        |                     www.theonion.com
