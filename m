Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVHVVpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVHVVpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVHVVpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:45:24 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:42882 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751271AbVHVVpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:45:23 -0400
Message-ID: <4309CE32.50408@redhat.com>
Date: Mon, 22 Aug 2005 09:08:02 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Suppress deprecated f_maxcount in 'struct file'
References: <20050819043331.7bc1f9a9.akpm@osdl.org>	<1124467911.9329.11.camel@kleikamp.austin.ibm.com>	<20050819122122.0852de3a.akpm@osdl.org>	<43064ED1.40805@cosmosbay.com> <20050819143344.4a6c49b2.akpm@osdl.org> <430656AA.6030805@cosmosbay.com>
In-Reply-To: <430656AA.6030805@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------030503060503020602020602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030503060503020602020602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Eric Dumazet wrote:

> Andrew Morton a écrit :
>
>> Eric Dumazet <dada1@cosmosbay.com> wrote:
>>
>>> Considering :
>>>
>>> [root@dada1 linux-2.6.13-rc6]# find .|xargs grep f_maxcount
>>> ./fs/file_table.c:      f->f_maxcount = INT_MAX;
>>> ./fs/read_write.c:      if (unlikely(count > file->f_maxcount))
>>> ./include/linux/fs.h:   size_t                  f_maxcount;
>>>
>>>
>>> I was wondering if f_maxcount has a real use these days...
>>
>>
>>
>> No, I guess we can just stick a hard-wired INT_MAX in there.
>>
>>
>
> OK here is a patch doing the hard wiring then :)
>
> * struct file cleanup : f_maxcount has an unique value (INT_MAX). Just 
> use the hard-wired value.
>
> Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
>
>------------------------------------------------------------------------
>diff -Nru linux-2.6.13-rc6/fs/read_write.c linux-2.6.13-rc6-ed/fs/read_write.c
>--- linux-2.6.13-rc6/fs/read_write.c	2005-08-07 20:18:56.000000000 +0200
>+++ linux-2.6.13-rc6-ed/fs/read_write.c	2005-08-19 23:51:20.000000000 +0200
>@@ -188,7 +188,7 @@
> 	struct inode *inode;
> 	loff_t pos;
> 
>-	if (unlikely(count > file->f_maxcount))
>+	if (unlikely(count > INT_MAX))
> 		goto Einval;
> 	pos = *ppos;
> 	if (unlikely((pos < 0) || (loff_t) (pos + count) < 0))
>

And depending upon how you feel about read(2) and write(2) returning larger
than can be represented by a ssize_t, you can get rid of this test too and
apply the attached patch to prevent failures occuring in the direct-io
subsystem.

Limiting i/o requests to INT_MAX is starting to seem a little small.

    Thanx...

       ps

Signed-off-by: Peter Staubach <staubach@redhat.com>

--------------030503060503020602020602
Content-Type: text/plain;
 name="devel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="devel"

--- linux-2.6.12/fs/direct-io.c.org	2005-08-22 08:56:40.000000000 -0400
+++ linux-2.6.12/fs/direct-io.c	2005-08-22 08:59:49.000000000 -0400
@@ -1139,6 +1139,12 @@ direct_io_worker(int rw, struct kiocb *i
 }
 
 /*
+ * The maximum size of an i/o request which can handled by block
+ * devices.
+ */
+#define	MAX_DIO_SIZE	((u32)INT_MAX + 1)
+
+/*
  * This is a library function for use by filesystem drivers.
  * The locking rules are governed by the dio_lock_type parameter.
  *
@@ -1174,6 +1180,12 @@ __blockdev_direct_IO(int rw, struct kioc
 	loff_t end = offset;
 	struct dio *dio;
 	int reader_with_isem = (rw == READ && dio_lock_type == DIO_OWN_LOCKING);
+	int nseg;
+	unsigned long segs_reqd;
+	struct iovec *niov = NULL;
+	int asegs;
+	caddr_t nbase;
+	size_t nlen;
 
 	if (rw & WRITE)
 		current->flags |= PF_SYNCWRITE;
@@ -1189,6 +1201,44 @@ __blockdev_direct_IO(int rw, struct kioc
 			goto out;
 	}
 
+	/*
+	 * Check to see if any individual segment is larger than
+	 * 2G.  If so, then break it up into 2G sized chunks.
+	 */
+	segs_reqd = 0;
+	for (seg = 0; seg < nr_segs; seg++)
+		segs_reqd += ((iov[seg].iov_len - 1) / MAX_DIO_SIZE) + 1;
+	if (segs_reqd != nr_segs) {
+		if (segs_reqd > UIO_MAXIOV) {
+			retval = -EINVAL;
+			goto out;
+		}
+		niov = kmalloc(sizeof(*niov) * segs_reqd, GFP_KERNEL);
+		if (!niov) {
+			retval = -ENOMEM;
+			goto out;
+		}
+		nseg = 0;
+		for (seg = 0; seg < nr_segs; seg++) {
+			nbase = iov[seg].iov_base;
+			nlen = iov[seg].iov_len;
+			asegs = (iov[seg].iov_len - 1) / MAX_DIO_SIZE;
+			while (asegs > 0) {
+				niov[nseg].iov_base = nbase;
+				niov[nseg].iov_len = MAX_DIO_SIZE;
+				nbase += MAX_DIO_SIZE;
+				nlen -= MAX_DIO_SIZE;
+				nseg++;
+				asegs--;
+			}
+			niov[nseg].iov_base = nbase;
+			niov[nseg].iov_len = nlen;
+			nseg++;
+		}
+		iov = niov;
+		nr_segs = segs_reqd;
+	}
+
 	/* Check the memory alignment.  Blocks cannot straddle pages */
 	for (seg = 0; seg < nr_segs; seg++) {
 		addr = (unsigned long)iov[seg].iov_base;
@@ -1265,6 +1315,8 @@ __blockdev_direct_IO(int rw, struct kioc
 out:
 	if (reader_with_isem)
 		up(&inode->i_sem);
+	if (niov)
+		kfree(niov);
 	if (rw & WRITE)
 		current->flags &= ~PF_SYNCWRITE;
 	return retval;

--------------030503060503020602020602--
