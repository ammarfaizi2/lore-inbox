Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbUA3WOH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 17:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbUA3WOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 17:14:07 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:1423 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S264434AbUA3WOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 17:14:02 -0500
Date: Fri, 30 Jan 2004 23:13:53 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org,
       Nathan Scott <nathans@sgi.com>
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040130221353.GO25833@drinkel.cistron.nl>
References: <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org> <20040130202155.GM25833@drinkel.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040130202155.GM25833@drinkel.cistron.nl> (from miquels@cistron.nl on Fri, Jan 30, 2004 at 21:21:55 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004 21:21:55, Miquel van Smoorenburg wrote:
> I added some extra code to i_size_read() and i_size_write(). First,
> some debugging code:
> I then started the test that locks up the kernel, and it printed this:
> 
> i_size_write: pid 542: sequence is odd!
> i_size_write: pid 543: sequence is odd!
> i_size_write: pid 542: sequence is odd!
> 
> i_size_read() seems to be looping - pid 0
> i_size_read() seems to be looping - pid 0
> [this keeps on being printed and the kernel is locked up]
> 
> It took some time for the i_size_write messages to show up, and they were
> spaced 10-30 seconds apart, and during that time the server was still
> up - right until the first i_size_read message.
> 

Okay, I added a patch to make the sequence increments atomic. Now
i_size_write() still sometimes ends up with an odd sequence, but
i_size_read() doesn't lock up anymore.

What lock exactly is supposed to protect i_size_write, since it
appears that i_size_write is being called without proper locking ?
(Am I right?)


--- fs.h.v1	2004-01-30 21:11:19.000000000 +0100
+++ fs.h	2004-01-30 21:55:17.000000000 +0100
@@ -426,6 +426,7 @@
 #ifdef __NEED_I_SIZE_ORDERED
 	seqcount_t		i_size_seqcount;
 	pid_t			seq_pid; /* XXX */
+	spinlock_t		i_size_lock;
 #endif
 };
 
@@ -441,6 +442,7 @@
  */
 #include <linux/delay.h>
 #include <linux/sched.h>
+#include <asm/atomic.h>
 static inline loff_t i_size_read(struct inode *inode)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
@@ -476,9 +478,11 @@
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
 #if 1 /* XXX */
 	inode->seq_pid = current->tgid;
-	write_seqcount_begin(&inode->i_size_seqcount);
+	atomic_inc((atomic_t *)&inode->i_size_seqcount.sequence);
+	smp_wmb();
 	inode->i_size = i_size;
-	write_seqcount_end(&inode->i_size_seqcount);
+	smp_wmb();
+	atomic_inc((atomic_t *)&inode->i_size_seqcount.sequence);
 	if (inode->i_size_seqcount.sequence & 1)
 		printk("i_size_write: pid %d: sequence is odd!\n",
 			current->tgid);
