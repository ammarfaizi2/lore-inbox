Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbUA3UWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 15:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUA3UWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 15:22:22 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:15501 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S263996AbUA3UWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 15:22:00 -0500
Date: Fri, 30 Jan 2004 21:21:55 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040130202155.GM25833@drinkel.cistron.nl>
References: <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040128222521.75a7d74f.akpm@osdl.org> (from akpm@osdl.org on Thu, Jan 29, 2004 at 07:25:21 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004 07:25:21, Andrew Morton wrote:
> "Miquel van Smoorenburg" <miquels@cistron.nl> wrote:
> >
> > I have a Linux 2.6.2-rc2 NFS file server and another similar
> > box as client. Kernel is compiled for SMP (hyperthreading).
> > In a few seconds, the server locks up. It spins in
> > generic_fillattr(), apparently in the i_size_read() inline function.
> > Server responds to pings and sysrq, but nothing else.
> 
> Is the EIP _always_ inside generic_fillattr()?
> 
> If so then yes, your analysis look right.  I'd say that the inode has been
> corrupted and the seqcount counter has assumed an non-even value.  That
> will cause i_size_read() to lock up.

I added some extra code to i_size_read() and i_size_write(). First,
some debugging code:

--- fs.h.orig	2004-01-30 21:10:28.000000000 +0100
+++ fs.h.v1	2004-01-30 21:11:19.000000000 +0100
@@ -425,6 +425,7 @@
 	} u;
 #ifdef __NEED_I_SIZE_ORDERED
 	seqcount_t		i_size_seqcount;
+	pid_t			seq_pid; /* XXX */
 #endif
 };
 
@@ -450,6 +451,12 @@
 	do {
 		seq = read_seqcount_begin(&inode->i_size_seqcount);
 		i_size = inode->i_size;
+#if 1 /* XXX HACK */
+		if ((++count & 65535) == 0) {
+			printk("i_size_read() seems to be looping - pid %d\n", inode->seq_pid);
+			mdelay(100);
+		}
+#endif
 	} while (read_seqcount_retry(&inode->i_size_seqcount, seq));
 	return i_size;
 #elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
@@ -467,9 +474,20 @@
 static inline void i_size_write(struct inode *inode, loff_t i_size)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+#if 1 /* XXX */
+	inode->seq_pid = current->tgid;
+	write_seqcount_begin(&inode->i_size_seqcount);
+	inode->i_size = i_size;
+	write_seqcount_end(&inode->i_size_seqcount);
+	if (inode->i_size_seqcount.sequence & 1)
+		printk("i_size_write: pid %d: sequence is odd!\n",
+			current->tgid);
+	inode->seq_pid = 0;
+#else
 	write_seqcount_begin(&inode->i_size_seqcount);
 	inode->i_size = i_size;
 	write_seqcount_end(&inode->i_size_seqcount);
+#endif
 #elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
 	preempt_disable();
 	inode->i_size = i_size;

I then started the test that locks up the kernel, and it printed this:

i_size_write: pid 542: sequence is odd!
i_size_write: pid 543: sequence is odd!
i_size_write: pid 542: sequence is odd!

i_size_read() seems to be looping - pid 0
i_size_read() seems to be looping - pid 0
[this keeps on being printed and the kernel is locked up]

It took some time for the i_size_write messages to show up, and they were
spaced 10-30 seconds apart, and during that time the server was still
up - right until the first i_size_read message.

Then I added this patch:

--- fs.h.v1	2004-01-30 21:11:19.000000000 +0100
+++ fs.h	2004-01-30 20:16:35.000000000 +0100
@@ -426,6 +426,7 @@
 #ifdef __NEED_I_SIZE_ORDERED
 	seqcount_t		i_size_seqcount;
 	pid_t			seq_pid; /* XXX */
+	spinlock_t		i_size_lock;
 #endif
 };
 
@@ -475,6 +476,7 @@
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
 #if 1 /* XXX */
+	spin_lock(&inode->i_size_lock);
 	inode->seq_pid = current->tgid;
 	write_seqcount_begin(&inode->i_size_seqcount);
 	inode->i_size = i_size;
@@ -483,6 +485,7 @@
 		printk("i_size_write: pid %d: sequence is odd!\n",
 			current->tgid);
 	inode->seq_pid = 0;
+	spin_unlock(&inode->i_size_lock);
 #else
 	write_seqcount_begin(&inode->i_size_seqcount);
 	inode->i_size = i_size;

(and some code in fs/inode.c to initialize i_size_lock)

Guess what. No more debug output, no more lockups ... is there
anything else I can do to debug this ? Because I'm not really
sure what I'm doing, you see :)

Mike.
