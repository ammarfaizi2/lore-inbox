Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319213AbSHWTLa>; Fri, 23 Aug 2002 15:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319214AbSHWTL3>; Fri, 23 Aug 2002 15:11:29 -0400
Received: from verein.lst.de ([212.34.181.86]:21768 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S319213AbSHWTL2>;
	Fri, 23 Aug 2002 15:11:28 -0400
Date: Fri, 23 Aug 2002 21:15:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make the page allocator aware of filesystem transactions
Message-ID: <20020823211532.A24068@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	akpm@zip.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In XFS we have large pieces of code that might be called either from
inside a filesystem transaction or not.  Currently we have added a
PF_FSTRANS process flag and fall back to GFP_NOFS when it's set.

I think it might be useful to generalize this at the page allocator
level and always clear __GFP_FS if the process flag is set.

Comments?


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.509, 2002-08-23 22:01:27+02:00, hch@sb.bsdonline.org
  VM: make the page allocator aware of filesystem transactions


 include/linux/sched.h |    1 +
 mm/vmscan.c           |    3 +++
 2 files changed, 4 insertions


diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Fri Aug 23 22:01:58 2002
+++ b/include/linux/sched.h	Fri Aug 23 22:01:58 2002
@@ -400,6 +400,7 @@
 #define PF_FREEZE	0x00010000	/* this task should be frozen for suspend */
 #define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
 #define PF_FROZEN	0x00040000	/* frozen for system suspend */
+#define PF_FSTRANS	0x00080000	/* inside a filesystem transaction */
 
 /*
  * Ptrace flags
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Fri Aug 23 22:01:58 2002
+++ b/mm/vmscan.c	Fri Aug 23 22:01:58 2002
@@ -458,6 +458,9 @@
 	int max_scan;
 	static atomic_t nr_to_refill = ATOMIC_INIT(0);
 
+	if (current->flags & PF_FSTRANS)
+		gfp_mask &= ~__GFP_FS;
+
 	if (kmem_cache_reap(gfp_mask) >= nr_pages)
   		return 0;
 

===================================================================


This BitKeeper patch contains the following changesets:
1.509
## Wrapped with gzip_uu ##


begin 664 bkpatch11051
M'XL(`+:49CT``[55:V^;,!3]C'_%E2I56ZO`M7EG2I7NT6[J'E&Z[M.DR#4F
MH`!&F/0QH?WV>>G61%F6J-T*6#:VN??<<\\U>W"A9=.W,I&1/7BK=-NW]*5]
MJ1-5%7DE;=5,S<)8*;/@-+)6CIF>W_28[1.S,.*MR.!*-KIO4=N]GVEO:]FW
MQF].+]X?CPD9#.!5QJNI/)<M#`:D5<T5+Q(]Y&U6J,IN&U[I4K;<%JKL[K=V
M#)&9VZ>ABW[0T0"]L!,TH91[5";(O"CPEM8R5<KMMB)CCF+LAYWO^>B1UT!M
M'V-`YF#D,!<8ZR/ML_`0S0#!\#)<YP,.&?20O(3_&\4K(N#+ASZ4?":AS234
M?"J!%X42W'@"?LT;"2J%-"^DOM6M+&'AD8LV5Y4F9^#[01B0T9)KTGO@10AR
M)$<[0BM+YZK4@E>V6`TN=N,.`\:\+N5AC(%P`Y'&0M"--/YI)6*NZ2F-NL!S
MW7@GC+P2Q3R1=XITM,AD8F?K@*@74-IY09R&,4^2*+EDKDPW(]IB<(F-!=0+
M%Y+>N'VWO/\!-BGS:JJ&LFBEG<VWXJ6QZ4/JFM>0Q0NA1^ZZSFFT5>?TJ73>
M`Q,3C$XF)^>?Q\<?SXUV[VC]!+WF>O$8+8XV,_P(4;_SD`$E>XE,37`KCBV\
M0<3(-+2<`^-/YXDINK_4&!PXB\2O*'=WNA]:+(3/ZG+X+:]_?FWS^:8Z0731
M\UGGQV:\R&T</#"W[M/E5A22-S"9G)Z,#,^0IXOC3,R;1E8MU(T24FO(N%Y)
M!&AS6IW!7>&OJ6"%@$?E/D!PB65@//N%H7>4%GRJ87\%P'-B6=.TGI1<SV!_
@`-]_XW]!OB[_=$:!8J;GY0!C(YHD]<@/_7B1,D('````
`
end
