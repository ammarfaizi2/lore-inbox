Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHJYK>; Thu, 8 Feb 2001 04:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBHJYA>; Thu, 8 Feb 2001 04:24:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51079 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129031AbRBHJXx>;
	Thu, 8 Feb 2001 04:23:53 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14978.25940.810790.934587@pizda.ninka.net>
Date: Thu, 8 Feb 2001 01:22:28 -0800 (PST)
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
        linux-kernel@vger.kernel.org
Subject: Re: dentry cache order 7 is broken
In-Reply-To: <20010208002212.Q12227@sfgoth.com>
In-Reply-To: <Pine.LNX.4.33.0102072302030.5947-100000@twinlark.arctic.org>
	<14978.21605.98365.252519@pizda.ninka.net>
	<20010208002212.Q12227@sfgoth.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mitchell Blank Jr writes:
 >   1. The inode-cache has the exact same problem, but it'll require a lot
 >      of RAM to run into it.  The buffer and page caches don't have the
 >      same problem.

Yep, fix attached.  You just need 1GB ram to hit that case.

 >   2. Given that D_HASHBITS is not a constant I wonder if there isn't
 >      a more efficient hash to be found.  But I guess I'll leave that
 >      to the hashing experts.

For the moment anything is better than when you hit this
bug :-)

--- fs/inode.c.~1~	Sun Feb  4 20:45:36 2001
+++ fs/inode.c	Thu Feb  8 01:21:07 2001
@@ -729,7 +729,8 @@
 static inline unsigned long hash(struct super_block *sb, unsigned long i_ino)
 {
 	unsigned long tmp = i_ino + ((unsigned long) sb / L1_CACHE_BYTES);
-	tmp = tmp + (tmp >> I_HASHBITS) + (tmp >> I_HASHBITS*2);
+	tmp = tmp + (tmp >> I_HASHBITS) +
+		(tmp >> (I_HASHBITS+(I_HASHBITS/2)));
 	return tmp & I_HASHMASK;
 }
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
