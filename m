Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTLUUHr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 15:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTLUUHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 15:07:47 -0500
Received: from adsl-216-158-28-251.cust.oldcity.dca.net ([216.158.28.251]:6528
	"EHLO fukurou.paranoiacs.org") by vger.kernel.org with ESMTP
	id S264271AbTLUUHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 15:07:11 -0500
Date: Sun, 21 Dec 2003 15:07:03 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, jariruusu@users.sourceforge.net
Subject: Re: [PATCH] loop.c patches, take two
Message-ID: <20031221200659.GB4721@fukurou.paranoiacs.org>
Mail-Followup-To: Ben Slusky <sluskyb@paranoiacs.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	jariruusu@users.sourceforge.net
References: <20031030134137.GD12147@fukurou.paranoiacs.org> <3FA15506.B9B76A5D@users.sourceforge.net> <20031030133000.6a04febf.akpm@osdl.org> <20031031005246.GE12147@fukurou.paranoiacs.org> <20031031015500.44a94f88.akpm@osdl.org> <20031101002650.GA7397@fukurou.paranoiacs.org> <20031102204624.GA5740@fukurou.paranoiacs.org> <20031221195534.GA4721@fukurou.paranoiacs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <20031221195534.GA4721@fukurou.paranoiacs.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch will localize (and atomicize) the kmaps in loop.c, moving
them from do_lo_send, do_lo_receive, and loop_transfer_bio into the
transform functions. The effect is to eliminate the page,offset ->
vaddr -> page,offset -> vaddr back-and-forth in cryptoloop devices.

I've incorporated Andrew's corrections.

Taken together, the preceding patch and this patch make loop devices
safe for use as swap. Please apply.

-
-Ben


-- 
Ben Slusky                      | Integrity is the key. Once you
sluskyb@paranoiacs.org          | can fake that...
sluskyb@stwing.org              |                -Simon Travaglia
PGP keyID ADA44B3B      

--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop-highmem-mk2.diff"

diff -pu linux-2.6.0/include/linux/loop.h-orig linux-2.6.0/include/linux/loop.h
--- linux-2.6.0/include/linux/loop.h-orig	2003-12-20 21:36:18.579772640 -0500
+++ linux-2.6.0/include/linux/loop.h	2003-12-20 21:37:22.086118208 -0500
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
diff -pu linux-2.6.0/drivers/block/loop.c-orig linux-2.6.0/drivers/block/loop.c
--- linux-2.6.0/drivers/block/loop.c-orig	2003-12-20 21:36:18.614767320 -0500
+++ linux-2.6.0/drivers/block/loop.c	2003-12-20 21:37:42.488016648 -0500
@@ -75,24 +75,34 @@ static struct gendisk **disks;
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
-	if (raw_buf != loop_buf) {
-		if (cmd == READ)
-			memcpy(loop_buf, raw_buf, size);
-		else
-			memcpy(raw_buf, loop_buf, size);
-	}
+	char *raw_buf = kmap_atomic(raw_page, KM_USER0) + raw_off;
+	char *loop_buf = kmap_atomic(loop_page, KM_USER1) + loop_off;
 
+	if (cmd == READ)
+		memcpy(loop_buf, raw_buf, size);
+	else
+		memcpy(raw_buf, loop_buf, size);
+
+	kunmap_atomic(raw_buf, KM_USER0);
+	kunmap_atomic(loop_buf, KM_USER1);
+	cond_resched();
 	return 0;
 }
 
-static int transfer_xor(struct loop_device *lo, int cmd, char *raw_buf,
-			char *loop_buf, int size, sector_t real_block)
-{
-	char	*in, *out, *key;
-	int	i, keysize;
+static int transfer_xor(struct loop_device *lo, int cmd,
+			struct page *raw_page, unsigned raw_off,
+			struct page *loop_page, unsigned loop_off,
+			int size, sector_t real_block)
+{
+	char *raw_buf = kmap_atomic(raw_page, KM_USER0) + raw_off;
+	char *loop_buf = kmap_atomic(loop_page, KM_USER1) + loop_off;
+	char *in, *out, *key;
+	int i, keysize;
 
 	if (cmd == READ) {
 		in = raw_buf;
@@ -106,6 +116,10 @@ static int transfer_xor(struct loop_devi
 	keysize = lo->lo_encrypt_key_size;
 	for (i = 0; i < size; i++)
 		*out++ = *in++ ^ key[(i & 511) % keysize];
+
+	kunmap_atomic(raw_buf, KM_USER0);
+	kunmap_atomic(loop_buf, KM_USER1);
+	cond_resched();
 	return 0;
 }
 
@@ -162,13 +176,15 @@ figure_loop_size(struct loop_device *lo)
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
@@ -178,16 +194,15 @@ do_lo_send(struct loop_device *lo, struc
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
@@ -204,25 +219,28 @@ do_lo_send(struct loop_device *lo, struc
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
+			char *kaddr;
+
 			/*
 			 * The transfer failed, but we still write the data to
 			 * keep prepare/commit calls balanced.
 			 */
 			printk(KERN_ERR "loop: transfer error block %llu\n",
 			       (unsigned long long)index);
+			kaddr = kmap_atomic(page, KM_USER0);
 			memset(kaddr + offset, 0, size);
+			kunmap_atomic(kaddr, KM_USER0);
 		}
 		flush_dcache_page(page);
-		kunmap(page);
 		if (aops->commit_write(file, page, offset, offset+size))
 			goto unlock;
 		if (transfer_result)
 			goto unlock;
-		data += size;
+		bv_offs += size;
 		len -= size;
 		offset = 0;
 		index++;
@@ -232,7 +250,6 @@ do_lo_send(struct loop_device *lo, struc
 	}
 	up(&mapping->host->i_sem);
 out:
-	kunmap(bvec->bv_page);
 	return ret;
 
 unlock:
@@ -261,7 +278,8 @@ lo_send(struct loop_device *lo, struct b
 
 struct lo_read_data {
 	struct loop_device *lo;
-	char *data;
+	struct page *page;
+	unsigned offset;
 	int bsize;
 };
 
@@ -269,7 +287,6 @@ static int
 lo_read_actor(read_descriptor_t *desc, struct page *page,
 	      unsigned long offset, unsigned long size)
 {
-	char *kaddr;
 	unsigned long count = desc->count;
 	struct lo_read_data *p = (struct lo_read_data*)desc->buf;
 	struct loop_device *lo = p->lo;
@@ -280,18 +297,16 @@ lo_read_actor(read_descriptor_t *desc, s
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
 
@@ -304,12 +319,12 @@ do_lo_receive(struct loop_device *lo,
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
 
@@ -567,23 +582,17 @@ static int loop_transfer_bio(struct loop
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
diff -pu linux-2.6.0/drivers/block/cryptoloop.c-orig linux-2.6.0/drivers/block/cryptoloop.c
--- linux-2.6.0/drivers/block/cryptoloop.c-orig	2003-12-20 21:36:18.630764888 -0500
+++ linux-2.6.0/drivers/block/cryptoloop.c	2003-12-20 21:37:22.130111520 -0500
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

--Q0rSlbzrZN6k9QnT--
