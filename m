Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbUA3XMF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 18:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUA3XMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 18:12:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:6853 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264364AbUA3XL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 18:11:59 -0500
Date: Fri, 30 Jan 2004 15:13:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: miquels@cistron.nl, linux-kernel@vger.kernel.org, nathans@sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-Id: <20040130151316.40d70ed3.akpm@osdl.org>
In-Reply-To: <20040130225353.A26383@infradead.org>
References: <bv8qr7$m2v$1@news.cistron.nl>
	<20040128222521.75a7d74f.akpm@osdl.org>
	<20040130202155.GM25833@drinkel.cistron.nl>
	<20040130221353.GO25833@drinkel.cistron.nl>
	<20040130143459.5eed31f0.akpm@osdl.org>
	<20040130225353.A26383@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jan 30, 2004 at 02:34:59PM -0800, Andrew Morton wrote:
> > If two CPUs hit i_size_write() at the same time we have a bug.  That
> > function requires that the caller provide external serialisation, via i_sem.
> 
> O_APPEND|O_DIRECT writes could do that under XFS..

Sigh.


diff -puN include/linux/fs.h~i_size_write-check include/linux/fs.h
--- 25/include/linux/fs.h~i_size_write-check	Fri Jan 30 15:09:47 2004
+++ 25-akpm/include/linux/fs.h	Fri Jan 30 15:10:28 2004
@@ -464,9 +464,11 @@ static inline loff_t i_size_read(struct 
 #endif
 }
 
+void i_size_write_check(struct inode *inode);
 
 static inline void i_size_write(struct inode *inode, loff_t i_size)
 {
+	i_size_write_check(inode);
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
 	write_seqcount_begin(&inode->i_size_seqcount);
 	inode->i_size = i_size;
diff -puN mm/filemap.c~i_size_write-check mm/filemap.c
--- 25/mm/filemap.c~i_size_write-check	Fri Jan 30 15:10:23 2004
+++ 25-akpm/mm/filemap.c	Fri Jan 30 15:11:41 2004
@@ -2010,3 +2010,18 @@ out:
 }
 
 EXPORT_SYMBOL_GPL(generic_file_direct_IO);
+
+void i_size_write_check(struct inode *inode)
+{
+	static int count = 0;
+
+	if (down_trylock(&inode->i_sem) == 0) {
+		if (count < 10) {
+			count++;
+			printk("i_size_write() called without i_sem\n");
+			dump_stack();
+		}
+		up(&inode->i_sem);
+	}
+}
+EXPORT_SYMBOL(i_size_write_check);

_

