Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbRIBR5d>; Sun, 2 Sep 2001 13:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbRIBR5Y>; Sun, 2 Sep 2001 13:57:24 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:30957 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S267650AbRIBR5L>;
	Sun, 2 Sep 2001 13:57:11 -0400
From: thunder7@xs4all.nl
Date: Sun, 2 Sep 2001 19:57:17 +0200
To: parisc-linux@lists.parisc-linux.org
Cc: linux-kernel@vger.kernel.org
Subject: [SOLVED + PATCH]: documented Oops running big-endian reiserfs on parisc architecture
Message-ID: <20010902195717.A21209@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <20010902105538.A15344@middle.of.nowhere> <20010902150023.U5126@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010902150023.U5126@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2001 at 03:00:23PM +0100, Matthew Wilcox wrote:
> On Sun, Sep 02, 2001 at 10:55:38AM +0200, thunder7@xs4all.nl wrote:
> > ReiserFS version 3.6.25
> > bonnie[163]: Unaligned data reference 28
> 
> > which makes the error somewhere around here in 
> > fs/reiserfs/namei.c, function reiserfs_add_entry, after call to
> > padd_item, before call to reiserfs_find_entry:
> > 
> >     padd_item ((char *)(deh + 1), ROUND_UP (namelen), namelen);
> > 
> >     /* entry is ready to be pasted into tree, set 'visibility' and 'stat data in entry' attributes */
> >     mark_de_without_sd (deh);
> >     visible ? mark_de_visible (deh) : mark_de_hidden (deh);
> > 
> >     /* find the proper place for the new entry */
> >     memset (bit_string, 0, sizeof (bit_string));
> >     de.de_gen_number_bit_string = (char *)bit_string;
> >     retval = reiserfs_find_entry (dir, name, namelen, &path, &de);
> 
> I suspect mark_de_without_sd is an inlined function/macro and this will
> be where the unaligned data reference is happening.
> 
Correct. And the comments just above there about alignment are very
enlightening; it seems that the IBM/S390 architecture has some special
needs, and I just tested that my PA-RISC kernel has the same needs.
Thus I am able to present a real bugfix.

This patch allows me to run bonnie on a reiserfs partition with pa-risc
linux.

--- linux/include/linux/reiserfs_fs.h   Sun Sep  2 21:54:25 2001
+++ linux-new/include/linux/reiserfs_fs.h       Sun Sep  2 20:47:27 2001
@@ -924,7 +924,7 @@
 #define DEH_Visible 2

 /* 64 bit systems (and the S/390) need to be aligned explicitly -jdm */
-#if BITS_PER_LONG == 64 || defined(__s390__)
+#if BITS_PER_LONG == 64 || defined(__s390__) || defined(__hppa__)
 #   define ADDR_UNALIGNED_BITS  (3)
 #endif

This applies to linux-2.4.9-pa13 with
endian-safe-reiserfs-for-2.4.8.patch and to 2.4.9-ac5.

Please apply,
Jurriaan
-- 
It is well to remember, my son, that the entire population of the
universe, with one trifling exception, is composed of others.
        John Andrew Holmes
GNU/Linux 2.4.9-ac5 SMP/ReiserFS 2x1402 bogomips load av: 0.98 0.83 0.37
