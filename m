Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbTJ3Nl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 08:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTJ3Nl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 08:41:56 -0500
Received: from adsl-216-158-28-251.cust.oldcity.dca.net ([216.158.28.251]:3969
	"EHLO fukurou.paranoiacs.org") by vger.kernel.org with ESMTP
	id S262461AbTJ3Nlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 08:41:42 -0500
Date: Thu, 30 Oct 2003 08:41:40 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove useless highmem bounce from loop/cryptoloop
Message-ID: <20031030134137.GD12147@fukurou.paranoiacs.org>
Mail-Followup-To: Ben Slusky <sluskyb@fukurou.paranoiacs.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

The attached patch changes the loop device transfer functions (including
cryptoloop transfers) to accept page/offset pairs instead of virtual
addresses, and removes the redundant kmaps in do_lo_send, do_lo_receive,
and loop_transfer_bio. Per Andrew Morton's request a while back.

Combined with my previous patch (loop-recycle.diff) I believe this makes
loop devices safe for use as swap.

Questions? Comments? Flames?

-- 
Ben Slusky                      | What a waste it is to lose
sluskyb@paranoiacs.org          | one's mind. Or not to have a
sluskyb@stwing.org              | mind is being very wasteful.
PGP keyID ADA44B3B              | How true that is.  -Dan Quayle

--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop-highmem.diff"

--- linux-2.6.0-test/include/linux/loop.h-orig	2003-10-23 07:45:31.000000000 -0400
+++ linux-2.6.0-test/include/linux/loop.h	2003-10-23 07:46:13.000000000 -0400
@@ -34,8 +34,9 @@ struct loop_device {
 	loff_t		lo_sizelimit;
 	int		lo_flags;
 	int		(*transfer)(struct loop_device *, int cmd,
-				    char *raw_buf, char *loop_buf, int size,
-				    sector_t real_block);
+				    struct page *raw_page, unsigned raw_off,
+				    struct page *loop_page, unsigned loop_off,
+				    int size, sector_t real_block);
 	char		lo_file_name[LO_NAME_SIZE];
 	char		lo_crypt_name[LO_NAME_SIZE];
 	char		lo_encrypt_key[LO_KEY_SIZE];
@@ -128,8 +129,10 @@ struct loop_info64 {
 /* Support for loadable transfer modules */
 struct loop_func_table {
 	int number;	/* filter type */ 
-	int (*transfer)(struct loop_device *lo, int cmd, char *raw_buf,
-			char *loop_buf, int size, sector_t real_block);
+	int (*transfer)(struct loop_device *lo, int cmd,
+			struct page *raw_page, unsigned raw_off,
+			struct page *loop_page, unsigned loop_off,
+			int size, sector_t real_block);
 	int (*init)(struct loop_device *, const struct loop_info64 *); 
 	/* release is called from loop_unregister_transfer or clr_fd */
 	int (*release)(struct loop_device *); 
--- linux-2.6.0-test/drivers/block/loop.c-orig	2003-10-30 08:12:17.000000000 -0500
+++ linux-2.6.0-test/drivers/block/loop.c	2003-10-27 09:34:19.000000000 -0500
@@ -75,9 +75,14 @@ static struct gendisk **disks;
 /*
  * Transfer functions
  */
-static int transfer_none(struct loop_device *lo, int cmd, char *raw_buf,
-			 char *loop_buf, int size, sector_t real_block)
+static int transfer_none(struct loop_device *lo, int cmd,
+			 struct page *raw_page, unsigned raw_off,
+			 struct page *loop_page, unsigned loop_off,
+			 int size, sector_t real_block)
 {
+	char	*raw_buf = kmap_atomic(raw_page, KM_USER0) + raw_off;
+	char	*loop_buf = kmap_atomic(loop_page, KM_USER1) + loop_off;
+
 	if (raw_buf != loop_buf) {
 		if (cmd == READ)
 			memcpy(loop_buf, raw_buf, size);
@@ -85,12 +90,19 @@ static int transfer_none(struct loop_dev
 			memcpy(raw_buf, loop_buf, size);
 	}
 
+	kunmap_atomic(raw_page, KM_USER0);
+	kunmap_atomic(loop_page, KM_USER1);
+	cond_resched();
 	return 0;
 }
 
-static int transfer_xor(struct loop_device *lo, int cmd, char *raw_buf,
-			char *loop_buf, int size, sector_t real_block)
+static int transfer_xor(struct loop_device *lo, int cmd,
+			struct page *raw_page, unsigned raw_off,
+			struct page *loop_page, unsigned loop_off,
+			int size, sector_t real_block)
 {
+	char	*raw_buf = kmap_atomic(raw_page, KM_USER0) + raw_off;
+	char	*loop_buf = kmap_atomic(loop_page, KM_USER1) + loop_off;
 	char	*in, *out, *key;
 	int	i, keysize;
 
@@ -106,6 +118,10 @@ static int transfer_xor(struct loop_devi
 	keysize = lo->lo_encrypt_key_size;
 	for (i = 0; i < size; i++)
 		*out++ = *in++ ^ key[(i & 511) % keysize];
+
+	kunmap_atomic(raw_page, KM_USER0);
+	kunmap_atomic(loop_page, KM_USER1);
+	cond_resched();
 	return 0;
 }
 
@@ -162,13 +178,15 @@ figure_loop_size(struct loop_device *lo)
 }
 
 static inline int
-lo_do_transfer(struct loop_device *lo, int cmd, char *rbuf,
-	       char *lbuf, int size, sector_t rblock)
+lo_do_transfer(struct loop_device *lo, int cmd,
+	       struct page *rpage, unsigned roffs,
+	       struct page *lpage, unsigned loffs,
+	       int size, sector_t rblock)
 {
 	if (!lo->transfer)
 		return 0;
 
-	return lo->transfer(lo, cmd, rbuf, lbuf, size, rblock);
+	return lo->transfer(lo, cmd, rpage, roffs, lpage, loffs, size, rblock);
 }
 
 static int
@@ -178,16 +196,15 @@ do_lo_send(struct loop_device *lo, struc
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
 	struct address_space_operations *aops = mapping->a_ops;
 	struct page *page;
-	char *kaddr, *data;
 	pgoff_t index;
-	unsigned size, offset;
+	unsigned size, offset, bv_offs;
 	int len;
 	int ret = 0;
 
 	down(&mapping->host->i_sem);
 	index = pos >> PAGE_CACHE_SHIFT;
 	offset = pos & ((pgoff_t)PAGE_CACHE_SIZE - 1);
-	data = kmap(bvec->bv_page) + bvec->bv_offset;
+	bv_offs = bvec->bv_offset;
 	len = bvec->bv_len;
 	while (len > 0) {
 		sector_t IV;
@@ -204,9 +221,9 @@ do_lo_send(struct loop_device *lo, struc
 			goto fail;
 		if (aops->prepare_write(file, page, offset, offset+size))
 			goto unlock;
-		kaddr = kmap(page);
-		transfer_result = lo_do_transfer(lo, WRITE, kaddr + offset,
-						 data, size, IV);
+		transfer_result = lo_do_transfer(lo, WRITE, page, offset,
+						 bvec->bv_page, bv_offs,
+						 size, IV);
 		if (transfer_result) {
 			/*
 			 * The transfer failed, but we still write the data to
@@ -214,7 +231,8 @@ do_lo_send(struct loop_device *lo, struc
 			 */
 			printk(KERN_ERR "loop: transfer error block %llu\n",
 			       (unsigned long long)index);
-			memset(kaddr + offset, 0, size);
+			memset(kmap_atomic(page, KM_USER0) + offset, 0, size);
+			kunmap_atomic(page, KM_USER0);
 		}
 		flush_dcache_page(page);
 		kunmap(page);
@@ -222,7 +240,7 @@ do_lo_send(struct loop_device *lo, struc
 			goto unlock;
 		if (transfer_result)
 			goto unlock;
-		data += size;
+		bv_offs += size;
 		len -= size;
 		offset = 0;
 		index++;
@@ -261,7 +279,8 @@ lo_send(struct loop_device *lo, struct b
 
 struct lo_read_data {
 	struct loop_device *lo;
-	char *data;
+	struct page *page;
+	unsigned offset;
 	int bsize;
 };
 
@@ -269,7 +288,6 @@ static int
 lo_read_actor(read_descriptor_t *desc, struct page *page,
 	      unsigned long offset, unsigned long size)
 {
-	char *kaddr;
 	unsigned long count = desc->count;
 	struct lo_read_data *p = (struct lo_read_data*)desc->buf;
 	struct loop_device *lo = p->lo;
@@ -280,18 +298,16 @@ lo_read_actor(read_descriptor_t *desc, s
 	if (size > count)
 		size = count;
 
-	kaddr = kmap(page);
-	if (lo_do_transfer(lo, READ, kaddr + offset, p->data, size, IV)) {
+	if (lo_do_transfer(lo, READ, page, offset, p->page, p->offset, size, IV)) {
 		size = 0;
 		printk(KERN_ERR "loop: transfer error block %ld\n",
 		       page->index);
 		desc->error = -EINVAL;
 	}
-	kunmap(page);
 	
 	desc->count = count - size;
 	desc->written += size;
-	p->data += size;
+	p->offset += size;
 	return size;
 }
 
@@ -304,12 +320,12 @@ do_lo_receive(struct loop_device *lo,
 	int retval;
 
 	cookie.lo = lo;
-	cookie.data = kmap(bvec->bv_page) + bvec->bv_offset;
+	cookie.page = bvec->bv_page;
+	cookie.offset = bvec->bv_offset;
 	cookie.bsize = bsize;
 	file = lo->lo_backing_file;
 	retval = file->f_op->sendfile(file, &pos, bvec->bv_len,
 			lo_read_actor, &cookie);
-	kunmap(bvec->bv_page);
 	return (retval < 0)? retval: 0;
 }
 
@@ -569,23 +585,17 @@ static int loop_transfer_bio(struct loop
 {
 	sector_t IV;
 	struct bio_vec *from_bvec, *to_bvec;
-	char *vto, *vfrom;
 	int ret = 0, i;
 
 	IV = from_bio->bi_sector + (lo->lo_offset >> 9);
 
 	__bio_for_each_segment(to_bvec, to_bio, i, from_bio->bi_idx) {
 		from_bvec = &from_bio->bi_io_vec[i];
-
 		if (i >= to_bio->bi_idx) {
-			kmap(from_bvec->bv_page);
-			kmap(to_bvec->bv_page);
-			vfrom = page_address(from_bvec->bv_page) + from_bvec->bv_offset;
-			vto = page_address(to_bvec->bv_page) + to_bvec->bv_offset;
-			ret |= lo_do_transfer(lo, bio_data_dir(to_bio), vto, vfrom,
-						from_bvec->bv_len, IV);
-			kunmap(from_bvec->bv_page);
-			kunmap(to_bvec->bv_page);
+			ret |= lo_do_transfer(lo, bio_data_dir(to_bio),
+				      to_bvec->bv_page, to_bvec->bv_offset,
+				      from_bvec->bv_page, from_bvec->bv_offset,
+				      from_bvec->bv_len, IV);
 		}
 		IV += from_bvec->bv_len >> 9;
 	}
--- linux-2.6.0-test/drivers/block/cryptoloop.c-orig	2003-10-23 07:45:31.000000000 -0400
+++ linux-2.6.0-test/drivers/block/cryptoloop.c	2003-10-23 07:46:13.000000000 -0400
@@ -87,43 +87,49 @@ typedef int (*encdec_ecb_t)(struct crypt
 
 
 static int
-cryptoloop_transfer_ecb(struct loop_device *lo, int cmd, char *raw_buf,
-		     char *loop_buf, int size, sector_t IV)
+cryptoloop_transfer_ecb(struct loop_device *lo, int cmd,
+			struct page *raw_page, unsigned raw_off,
+			struct page *loop_page, unsigned loop_off,
+			int size, sector_t IV)
 {
 	struct crypto_tfm *tfm = (struct crypto_tfm *) lo->key_data;
 	struct scatterlist sg_out = { 0, };
 	struct scatterlist sg_in = { 0, };
 
 	encdec_ecb_t encdecfunc;
-	char const *in;
-	char *out;
+	struct page *in_page, *out_page;
+	unsigned in_offs, out_offs;
 
 	if (cmd == READ) {
-		in = raw_buf;
-		out = loop_buf;
+		in_page = raw_page;
+		in_offs = raw_off;
+		out_page = loop_page;
+		out_offs = loop_off;
 		encdecfunc = tfm->crt_u.cipher.cit_decrypt;
 	} else {
-		in = loop_buf;
-		out = raw_buf;
+		in_page = loop_page;
+		in_offs = loop_off;
+		out_page = raw_page;
+		out_offs = raw_off;
 		encdecfunc = tfm->crt_u.cipher.cit_encrypt;
 	}
 
 	while (size > 0) {
 		const int sz = min(size, LOOP_IV_SECTOR_SIZE);
 
-		sg_in.page = virt_to_page(in);
-		sg_in.offset = (unsigned long)in & ~PAGE_MASK;
+		sg_in.page = in_page;
+		sg_in.offset = in_offs;
 		sg_in.length = sz;
 
-		sg_out.page = virt_to_page(out);
-		sg_out.offset = (unsigned long)out & ~PAGE_MASK;
+		sg_out.page = out_page;
+		sg_out.offset = out_offs;
 		sg_out.length = sz;
 
 		encdecfunc(tfm, &sg_out, &sg_in, sz);
 
 		size -= sz;
-		in += sz;
-		out += sz;
+		in_offs += sz;
+		out_offs += sz;
 	}
 
 	return 0;
@@ -135,24 +141,30 @@ typedef int (*encdec_cbc_t)(struct crypt
 			unsigned int nsg, u8 *iv);
 
 static int
-cryptoloop_transfer_cbc(struct loop_device *lo, int cmd, char *raw_buf,
-		     char *loop_buf, int size, sector_t IV)
+cryptoloop_transfer_cbc(struct loop_device *lo, int cmd,
+			struct page *raw_page, unsigned raw_off,
+			struct page *loop_page, unsigned loop_off,
+			int size, sector_t IV)
 {
 	struct crypto_tfm *tfm = (struct crypto_tfm *) lo->key_data;
 	struct scatterlist sg_out = { 0, };
 	struct scatterlist sg_in = { 0, };
 
 	encdec_cbc_t encdecfunc;
-	char const *in;
-	char *out;
+	struct page *in_page, *out_page;
+	unsigned in_offs, out_offs;
 
 	if (cmd == READ) {
-		in = raw_buf;
-		out = loop_buf;
+		in_page = raw_page;
+		in_offs = raw_off;
+		out_page = loop_page;
+		out_offs = loop_off;
 		encdecfunc = tfm->crt_u.cipher.cit_decrypt_iv;
 	} else {
-		in = loop_buf;
-		out = raw_buf;
+		in_page = loop_page;
+		in_offs = loop_off;
+		out_page = raw_page;
+		out_offs = raw_off;
 		encdecfunc = tfm->crt_u.cipher.cit_encrypt_iv;
 	}
 
@@ -161,39 +173,43 @@ cryptoloop_transfer_cbc(struct loop_devi
 		u32 iv[4] = { 0, };
 		iv[0] = cpu_to_le32(IV & 0xffffffff);
 
-		sg_in.page = virt_to_page(in);
-		sg_in.offset = offset_in_page(in);
+		sg_in.page = in_page;
+		sg_in.offset = in_offs;
 		sg_in.length = sz;
 
-		sg_out.page = virt_to_page(out);
-		sg_out.offset = offset_in_page(out);
+		sg_out.page = out_page;
+		sg_out.offset = out_offs;
 		sg_out.length = sz;
 
 		encdecfunc(tfm, &sg_out, &sg_in, sz, (u8 *)iv);
 
 		IV++;
 		size -= sz;
-		in += sz;
-		out += sz;
+		in_offs += sz;
+		out_offs += sz;
 	}
 
 	return 0;
 }
 
 static int
-cryptoloop_transfer(struct loop_device *lo, int cmd, char *raw_buf,
-		     char *loop_buf, int size, sector_t IV)
+cryptoloop_transfer(struct loop_device *lo, int cmd,
+		    struct page *raw_page, unsigned raw_off,
+		    struct page *loop_page, unsigned loop_off,
+		    int size, sector_t IV)
 {
 	struct crypto_tfm *tfm = (struct crypto_tfm *) lo->key_data;
 	if(tfm->crt_cipher.cit_mode == CRYPTO_TFM_MODE_ECB)
 	{
 		lo->transfer = cryptoloop_transfer_ecb;
-		return cryptoloop_transfer_ecb(lo, cmd, raw_buf, loop_buf, size, IV);
+		return cryptoloop_transfer_ecb(lo, cmd, raw_page, raw_off,
+					       loop_page, loop_off, size, IV);
 	}	
 	if(tfm->crt_cipher.cit_mode == CRYPTO_TFM_MODE_CBC)
 	{	
 		lo->transfer = cryptoloop_transfer_cbc;
-		return cryptoloop_transfer_cbc(lo, cmd, raw_buf, loop_buf, size, IV);
+		return cryptoloop_transfer_cbc(lo, cmd, raw_page, raw_off,
+					       loop_page, loop_off, size, IV);
 	}
 	
 	/*  This is not supposed to happen */

--kORqDWCi7qDJ0mEj--
