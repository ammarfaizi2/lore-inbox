Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132910AbRDEOiI>; Thu, 5 Apr 2001 10:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132908AbRDEOh7>; Thu, 5 Apr 2001 10:37:59 -0400
Received: from smtp.mountain.net ([198.77.1.35]:29196 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S132909AbRDEOho>;
	Thu, 5 Apr 2001 10:37:44 -0400
Message-ID: <3ACC82DA.11D76D45@mountain.net>
Date: Thu, 05 Apr 2001 10:36:10 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Race in fs/proc/generic.c:make_inode_number()
In-Reply-To: <3ACBFF4C.97AA345F@mountain.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> 
> The proc_alloc_map bitfield is unprotected by any lock, and
> find_first_zero_bit() is not atomic. Concurrent module loading can race
> here.

Hello,

Here is a patch for this. It looks like callers are always in user context
(kmalloc flag GFP_KERNEL), so I used a light spinlock.

Cheers,
Tom
-- 
The Daemons lurk and are dumb. -- Emerson

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
