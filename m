Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131742AbRDFPtB>; Fri, 6 Apr 2001 11:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131756AbRDFPsv>; Fri, 6 Apr 2001 11:48:51 -0400
Received: from smtp.mountain.net ([198.77.1.35]:11278 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S131742AbRDFPsc>;
	Fri, 6 Apr 2001 11:48:32 -0400
Message-ID: <3ACDE4F5.BF04F941@mountain.net>
Date: Fri, 06 Apr 2001 11:47:01 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: smaneesh@in.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Race in fs/proc/generic.c:make_inode_number()
In-Reply-To: <3ACBFF4C.97AA345F@mountain.net> <3ACC82DA.11D76D45@mountain.net> <20010406173129.A14391@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni wrote:
> 
> Just a couple of points:
> 
> On Thu, Apr 05, 2001 at 10:36:10AM -0400, Tom Leete wrote:
> [...]
> > +spinlock_t proc_alloc_map_lock = RW_LOCK_UNLOCKED;
> > +
> Why not make this static?
> Initializer should be SPIN_LOCK_UNLOCKED.
> 

Thanks, you're right on both counts.

Linus, Alan, this version is more correct. I also checked for other uses of
proc_alloc_map[], The only case is in deallocation, and it looks ok to me.

Tom

-- 
The Daemons lurk and are dumb. -- Emerson

diff -u linux-2.4.3/fs/proc/generic.c.orig linux-2.4.3/fs/proc/generic.c
--- linux-2.4.3/fs/proc/generic.c.orig	Thu Apr  5 10:03:02 2001
+++ linux-2.4.3/fs/proc/generic.c	Thu Apr  5 10:22:48 2001
@@ -192,13 +192,22 @@
 
 static unsigned char proc_alloc_map[PROC_NDYNAMIC / 8];
 
+spinlock_t proc_alloc_map_lock = RW_LOCK_UNLOCKED;
+
 static int make_inode_number(void)
 {
-	int i = find_first_zero_bit((void *) proc_alloc_map, PROC_NDYNAMIC);
-	if (i<0 || i>=PROC_NDYNAMIC) 
-		return -1;
+	int i;
+	spin_lock(&proc_alloc_map_lock);
+	i = find_first_zero_bit((void *) proc_alloc_map, PROC_NDYNAMIC);
+	if (i<0 || i>=PROC_NDYNAMIC) {
+		i = -1;
+		goto out;
+	}
 	set_bit(i, (void *) proc_alloc_map);
-	return PROC_DYNAMIC_FIRST + i;
+	i += PROC_DYNAMIC_FIRST;
+out:
+	spin_unlock(&proc_alloc_map_lock);
+	return i;
 }
 
 static int proc_readlink(struct dentry *dentry, char *buffer, int buflen)
