Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbREULyY>; Mon, 21 May 2001 07:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbREULyP>; Mon, 21 May 2001 07:54:15 -0400
Received: from eriador.apana.org.au ([203.14.152.116]:4879 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S261357AbREULyC>; Mon, 21 May 2001 07:54:02 -0400
Date: Mon, 21 May 2001 21:53:39 +1000
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Soft block sizes for RAM disks
Message-ID: <20010521215339.A3847@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's a slightly different approach to the CRAMFS over RAM disk problem.
This patch (against 2.4) allows the RAM disk block size to be changed
through set_blocksize() without destroying its previous content.  Comments
are welcome.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff -u -r1.1.1.5 -r1.5
--- drivers/block/rd.c	2001/02/09 19:30:22	1.1.1.5
+++ drivers/block/rd.c	2001/05/20 01:36:07	1.5
@@ -197,8 +198,11 @@
 static int rd_make_request(request_queue_t * q, int rw, struct buffer_head *sbh)
 {
 	unsigned int minor;
-	unsigned long offset, len;
-	struct buffer_head *rbh;
+	unsigned int hardsec;
+	unsigned int len;
+	unsigned int size;
+	unsigned long block;
+	unsigned long offset;
 	char *bdata;
 
 	
@@ -221,20 +225,32 @@
 		goto fail;
 	}
 
-	rbh = getblk(sbh->b_rdev, sbh->b_rsector/(sbh->b_size>>9), sbh->b_size);
+	hardsec = (unsigned int) rd_hardsec[minor];
+	block = offset / hardsec;
+	offset %= hardsec;
+	size = len <= hardsec ? len : hardsec;
+
 	/* I think that it is safe to assume that rbh is not in HighMem, though
 	 * sbh might be - NeilBrown
 	 */
 	bdata = bh_kmap(sbh);
-	if (rw == READ) {
-		if (sbh != rbh)
-			memcpy(bdata, rbh->b_data, rbh->b_size);
-	} else
-		if (sbh != rbh)
-			memcpy(rbh->b_data, bdata, rbh->b_size);
+	do {
+		struct buffer_head *rbh;
+
+		rbh = getblk(sbh->b_rdev, block, hardsec);
+		if (sbh != rbh) {
+			if (rw == READ)
+				memcpy(bdata, rbh->b_data + offset, size);
+			else
+				memcpy(rbh->b_data + offset, bdata, size);
+		}
+		mark_buffer_protected(rbh);
+		brelse(rbh);
+		len -= size;
+		bdata += size;
+		block++;
+	} while (len > 0);
 	bh_kunmap(sbh);
-	mark_buffer_protected(rbh);
-	brelse(rbh);
 
 	sbh->b_end_io(sbh,1);
 	return 0;
diff -u -r1.1.1.10 -r1.2
--- fs/buffer.c	2001/04/27 21:23:25	1.1.1.10
+++ fs/buffer.c	2001/05/20 01:36:07	1.2
@@ -711,6 +711,8 @@
 			bh_next = bh->b_next_free;
 			if (bh->b_dev != dev || bh->b_size == size)
 				continue;
+			if (buffer_protected(bh))
+				continue;
 			if (buffer_locked(bh)) {
 				atomic_inc(&bh->b_count);
 				spin_unlock(&lru_list_lock);

--OXfL5xGRrasGEqWY--
