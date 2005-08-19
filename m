Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932729AbVHSWBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbVHSWBS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 18:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVHSWBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 18:01:18 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:30309 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932729AbVHSWBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 18:01:18 -0400
Message-ID: <430656AA.6030805@cosmosbay.com>
Date: Sat, 20 Aug 2005 00:01:14 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Suppress deprecated f_maxcount in 'struct file'
References: <20050819043331.7bc1f9a9.akpm@osdl.org>	<1124467911.9329.11.camel@kleikamp.austin.ibm.com>	<20050819122122.0852de3a.akpm@osdl.org>	<43064ED1.40805@cosmosbay.com> <20050819143344.4a6c49b2.akpm@osdl.org>
In-Reply-To: <20050819143344.4a6c49b2.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040606070307010306060108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040606070307010306060108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton a écrit :
> Eric Dumazet <dada1@cosmosbay.com> wrote:
> 
>>Considering :
>>
>>[root@dada1 linux-2.6.13-rc6]# find .|xargs grep f_maxcount
>>./fs/file_table.c:      f->f_maxcount = INT_MAX;
>>./fs/read_write.c:      if (unlikely(count > file->f_maxcount))
>>./include/linux/fs.h:   size_t                  f_maxcount;
>>
>>
>>I was wondering if f_maxcount has a real use these days...
> 
> 
> No, I guess we can just stick a hard-wired INT_MAX in there.
> 
> 

OK here is a patch doing the hard wiring then :)

* struct file cleanup : f_maxcount has an unique value (INT_MAX). Just use the hard-wired value.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------040606070307010306060108
Content-Type: text/plain;
 name="supress_f_maxcount"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="supress_f_maxcount"

diff -Nru linux-2.6.13-rc6/fs/file_table.c linux-2.6.13-rc6-ed/fs/file_table.c
--- linux-2.6.13-rc6/fs/file_table.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/fs/file_table.c	2005-08-19 23:51:20.000000000 +0200
@@ -89,7 +89,6 @@
 	rwlock_init(&f->f_owner.lock);
 	/* f->f_version: 0 */
 	INIT_LIST_HEAD(&f->f_list);
-	f->f_maxcount = INT_MAX;
 	return f;
 
 over:
diff -Nru linux-2.6.13-rc6/fs/read_write.c linux-2.6.13-rc6-ed/fs/read_write.c
--- linux-2.6.13-rc6/fs/read_write.c	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/fs/read_write.c	2005-08-19 23:51:20.000000000 +0200
@@ -188,7 +188,7 @@
 	struct inode *inode;
 	loff_t pos;
 
-	if (unlikely(count > file->f_maxcount))
+	if (unlikely(count > INT_MAX))
 		goto Einval;
 	pos = *ppos;
 	if (unlikely((pos < 0) || (loff_t) (pos + count) < 0))
diff -Nru linux-2.6.13-rc6/include/linux/fs.h linux-2.6.13-rc6-ed/include/linux/fs.h
--- linux-2.6.13-rc6/include/linux/fs.h	2005-08-07 20:18:56.000000000 +0200
+++ linux-2.6.13-rc6-ed/include/linux/fs.h	2005-08-19 23:51:20.000000000 +0200
@@ -594,7 +594,6 @@
 	unsigned int		f_uid, f_gid;
 	struct file_ra_state	f_ra;
 
-	size_t			f_maxcount;
 	unsigned long		f_version;
 	void			*f_security;
 

--------------040606070307010306060108--
