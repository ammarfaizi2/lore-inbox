Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751655AbVIZQJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbVIZQJj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbVIZQJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:09:39 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:37287 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751654AbVIZQJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:09:38 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 26 Sep 2005 17:09:36 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 1/4] NTFS: Fix sparse warnings that have crept in over
 time.
In-Reply-To: <Pine.LNX.4.58.0509260746130.3308@g5.osdl.org>
Message-ID: <Pine.LNX.4.60.0509261654550.29344@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509261427520.32257@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0509261431270.32257@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0509260746130.3308@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005, Linus Torvalds wrote:
> On Mon, 26 Sep 2005, Anton Altaparmakov wrote:
> >
> > NTFS: Fix sparse warnings that have crept in over time.
> 
> I think this is wrong.
> 
> What was the warning that caused this (and the two other things that look 
> the same)?

fs/ntfs/mft.c:2577:24: warning: incompatible types for operation (&)
fs/ntfs/mft.c:2577:24:    left side has type unsigned long long [unsigned] 
[usertype] <noident>
fs/ntfs/mft.c:2577:24:    right side has type bad type enum MFT_REF_CONSTS 
[toplevel] MFT_REF_MASK_CPU
fs/ntfs/mft.c:2577:24: warning: cast from unknown type

> >  #define MK_MREF(m, s)	((MFT_REF)(((MFT_REF)(s) << 48) |		\
> > -					((MFT_REF)(m) & MFT_REF_MASK_CPU)))
> > +					((MFT_REF)(m) & (u64)MFT_REF_MASK_CPU)))
> 
> Also, side note: how you defined "MFT_REF_MASK_CPU" is pretty debatable in 
> the first place:
> 
> 	typedef enum {
> 	        MFT_REF_MASK_CPU        = 0x0000ffffffffffffULL,
> 	        MFT_REF_MASK_LE         = const_cpu_to_le64(0x0000ffffffffffffULL),
> 	} MFT_REF_CONSTS;
> 
> and this just _happens_ to work with gcc, but it's not real C.
> 
> The issue? "enum" is really an integer type. As in "int". Trying to put a 
> larger value than one that fits in "int" is not guaranteed to work.

Yes, that is true but as you say it does work with gcc.

> There's another issue, namely that the type of the snum is not only of 
> undefined size (is it the same size as an "int"? Is it an "unsigned long 
> long"?) but the "endianness" of it is also now totally undefined. You have 
> two different endiannesses inside the _same_ enum. What is the type of the 
> enum?

Good question.  "confused"?  (-;

> You _really_ probably should use just
> 
> 	#define MFT_REF_MASK_CPU 0x0000ffffffffffffULL
> 	#define MFT_REF_MASK_LE const_cpu_to_le64(MFT_REF_MASK_CPU)
> 
> instead. That way the type of that thing is well-defined.

Yes, that is probably better given it is not possible to have them both be 
the same type (by definition).

> Depending on what warning you're trying to shut up, that may well fix it 
> too. Because now "MFT_REF_MASK_CPU" is clearly a regular constant, while 
> MFT_REF_MASK_LE is clearly a little-endian constant. Before, they were of 
> the same enum type, which made it very unclear what the hell they were.

Yes, I would expect it to fix it.

In fact I just did it and yes, it fixes it, too.  The repository I asked 
you to pull from is now updated with the below patch added which reverts 
the wrong layout.h parts and changes the enum to two defines as per your 
suggestion.

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git/HEAD

Thanks for the comments.  (-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

---

NTFS: Re-fix sparse warnings in a more correct way, i.e. don't use an enum with
      different types in it but #define the two constants instead.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/layout.h |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

e2fcc61ef0d654887b651bd99ffcb52f7344b836
diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h
+++ b/fs/ntfs/layout.h
@@ -308,22 +308,19 @@ typedef le16 MFT_RECORD_FLAGS;
  * The _LE versions are to be applied on little endian MFT_REFs.
  * Note: The _LE versions will return a CPU endian formatted value!
  */
-typedef enum {
-	MFT_REF_MASK_CPU	= 0x0000ffffffffffffULL,
-	MFT_REF_MASK_LE		= const_cpu_to_le64(0x0000ffffffffffffULL),
-} MFT_REF_CONSTS;
+#define MFT_REF_MASK_CPU 0x0000ffffffffffffULL
+#define MFT_REF_MASK_LE const_cpu_to_le64(0x0000ffffffffffffULL)
 
 typedef u64 MFT_REF;
 typedef le64 leMFT_REF;
 
 #define MK_MREF(m, s)	((MFT_REF)(((MFT_REF)(s) << 48) |		\
-					((MFT_REF)(m) & (u64)MFT_REF_MASK_CPU)))
+					((MFT_REF)(m) & MFT_REF_MASK_CPU)))
 #define MK_LE_MREF(m, s) cpu_to_le64(MK_MREF(m, s))
 
-#define MREF(x)		((unsigned long)((x) & (u64)MFT_REF_MASK_CPU))
+#define MREF(x)		((unsigned long)((x) & MFT_REF_MASK_CPU))
 #define MSEQNO(x)	((u16)(((x) >> 48) & 0xffff))
-#define MREF_LE(x)	((unsigned long)(le64_to_cpu(x) &		\
-					(u64)MFT_REF_MASK_CPU))
+#define MREF_LE(x)	((unsigned long)(le64_to_cpu(x) & MFT_REF_MASK_CPU))
 #define MSEQNO_LE(x)	((u16)((le64_to_cpu(x) >> 48) & 0xffff))
 
 #define IS_ERR_MREF(x)	(((x) & 0x0000800000000000ULL) ? 1 : 0)
