Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSGSWxk>; Fri, 19 Jul 2002 18:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSGSWxh>; Fri, 19 Jul 2002 18:53:37 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51934 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S317181AbSGSWxf>;
	Fri, 19 Jul 2002 18:53:35 -0400
Subject: Re: 2.4.19rc2aa1 i_size atomic access
From: Daniel McNeil <daniel@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020719112305.A15517@oldwotan.suse.de>
References: <1026949132.20314.0.camel@joe2.pdx.osdl.net>
	<1026951041.2412.38.camel@IBM-C> <20020718103511.GG994@dualathlon.random>
	<1027037361.2424.73.camel@IBM-C>  <20020719112305.A15517@oldwotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 19 Jul 2002 15:56:36 -0700
Message-Id: <1027119396.2629.16.camel@IBM-C>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-19 at 02:23, Andrea Arcangeli wrote:
> On Thu, Jul 18, 2002 at 05:09:21PM -0700, Daniel McNeil wrote:
> > fstat() was an easy way to test for incorrect reading of i_size,
> > so I could test the cmpxchg8 code to read a 64-bit value.
> 
> yes that's probably the simpler way to reproduce it.
> 
> > This cacheline bouncing is the thing I don't like.  It was not clear
> 
> I don't like it either of course, but I couldn't figure out a way to read 64bit
> atomically without generating it.
> 
> > > 
> > > If you have suggestions that's welcome, thanks.
> > 
> > I'll let you know if I think of any.
> 
> I guess cmpxchg8b is the best way at least for 2.4.
> 
> Andrea

Andrea,

Here is another approach. I added two version fields to the inode
structure. The first one is updated before i_size and the 2nd is
updated after with memory barriers in between.  The i_size_read()
samples the version fields and i_size and loops until it can read
i_size without an i_size update happening at the same time.  It is
not pretty but it does fix the problem and the cache line is not
written by i_size_read() and it should work on all architechtures.
I've tested this on a two proc system.

Let me know what you think,

Daniel

--- linux-2.4.19-rc2aa1/include/linux/fs.h	Fri Jul 19 15:22:08 2002
+++ linux-2.4.19-rc2aa1.new/include/linux/fs.h	Fri Jul 19 15:22:25 2002
@@ -501,6 +501,8 @@
 	atomic_t		i_writecount;
 	unsigned int		i_attr_flags;
 	__u32			i_generation;
+	volatile short		i_attr_version1;
+	volatile short		i_attr_version2;
 	union {
 		struct minix_inode_info		minix_i;
 		struct ext2_inode_info		ext2_i;
@@ -539,7 +541,23 @@
 static inline loff_t i_size_read(struct inode * inode)
 {
 #if BITS_PER_LONG==32
-	return (loff_t) read_64bit((unsigned long long *) &inode->i_size);
+	short v1;
+	short v2;
+	loff_t i_size;
+
+	/*
+	 * retry if i_size was possibly modified while sampling.
+	 */
+	do {
+		v1 = inode->i_attr_version1;
+		v2 = inode->i_attr_version2;
+		rmb();
+		i_size = inode->i_size;
+		rmb();
+	} while (v1 != v2 ||
+		 v1 != inode->i_attr_version1 ||
+		 v1 != inode->i_attr_version2);
+	return i_size;
 #elif BITS_PER_LONG==64
 	return inode->i_size;
 #endif
@@ -548,8 +566,12 @@
 static inline void i_size_write(struct inode * inode, loff_t i_size)
 {
 #if BITS_PER_LONG==32
-	set_64bit((unsigned long long *) &inode->i_size,
-		  (unsigned long long) i_size);
+	inode->i_attr_version1++;       /* changing i_size */
+	wmb();
+	inode->i_size = i_size;
+	wmb();
+	inode->i_attr_version2++;       /* done with change */
+	wmb();
 #elif BITS_PER_LONG==64
 	inode->i_size = i_size;
 #endif

