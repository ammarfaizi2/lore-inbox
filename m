Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSEMXXN>; Mon, 13 May 2002 19:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314681AbSEMXXM>; Mon, 13 May 2002 19:23:12 -0400
Received: from panzer.kdm.org ([216.160.178.169]:5131 "EHLO panzer.kdm.org")
	by vger.kernel.org with ESMTP id <S314680AbSEMXXG>;
	Mon, 13 May 2002 19:23:06 -0400
Date: Mon, 13 May 2002 17:23:00 -0600
From: "Kenneth D. Merry" <ken@kdm.org>
To: linux-kernel@vger.kernel.org
Cc: viro@math.psu.edu
Subject: atari partitioning problem?
Message-ID: <20020513172300.A995@panzer.kdm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Al Viro CCed, since from the changelog for 2.4.11, it looks like he may
have submitted the patch in question. ]

I was looking through the atari partitioning code (fs/partitions/atari.c)
in 2.4.18 (from what I can see in 2.4.19-pre8, it hasn't changed) and I
noticed something (starting at about line 144) that may be a problem:

			for (; pi < &rs->icdpart[8] && minor < m_lim; minor++, p
i++) {
				/* accept only GEM,BGM,RAW,LNX,SWP partitions */
				if (!((pi->flg & 1) && OK_id(pi->id)))
					continue;
				part_fmt = 2;
				add_gd_partition (hd, minor,
						  be32_to_cpu(pi->st),
						  be32_to_cpu(pi->siz));
			}
			printk(" >");

This code changed in 2.4.11, and was previously:

      for (; pi < &rs->icdpart[8] && minor < m_lim; minor++, pi++)
      { 
        /* accept only GEM,BGM,RAW,LNX,SWP partitions */
        if (pi->flg & 1 &&
            (memcmp (pi->id, "GEM", 3) == 0 ||
             memcmp (pi->id, "BGM", 3) == 0 ||
             memcmp (pi->id, "LNX", 3) == 0 ||
             memcmp (pi->id, "SWP", 3) == 0 ||
             memcmp (pi->id, "RAW", 3) == 0) )
        { 
          part_fmt = 2;
          add_gd_partition (hd, minor, be32_to_cpu(pi->st),
                            be32_to_cpu(pi->siz));
        }
      }
      printk(" >");

Note that the test was reversed, but not fully.  You want only active
partitions of the specified types to be added, but with the code as it is
now, only partitions that are active and *not* of the correct type will get
added.

I think that this patch would probably fix the problem, although I don't
have any hardware to test it.


==== //depot/linux-2.4.18/fs/partitions/atari.c#1 - /usr/home/ken/perforce/linux-2.4.18/fs/partitions/atari.c ====
--- /tmp/tmp.20618.0	Mon May 13 17:01:23 2002
+++ /usr/home/ken/perforce/linux-2.4.18/fs/partitions/atari.c	Mon May 13 16:34:27 2002
@@ -142,7 +142,7 @@
 			printk(" ICD<");
 			for (; pi < &rs->icdpart[8] && minor < m_lim; minor++, pi++) {
 				/* accept only GEM,BGM,RAW,LNX,SWP partitions */
-				if (!((pi->flg & 1) && OK_id(pi->id)))
+				if (!((pi->flg & 1) || !OK_id(pi->id)))
 					continue;
 				part_fmt = 2;
 				add_gd_partition (hd, minor,

Ken
-- 
Kenneth Merry
ken@kdm.org
