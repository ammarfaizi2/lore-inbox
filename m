Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129518AbQLMAtq>; Tue, 12 Dec 2000 19:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbQLMAtg>; Tue, 12 Dec 2000 19:49:36 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:40715 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129518AbQLMAta>; Tue, 12 Dec 2000 19:49:30 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 13 Dec 2000 11:17:19 +1100 (EST)
Message-ID: <14902.49167.834682.925490@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
cc: Jasper Spaans <jasper@spaans.ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] raid5 crash with 2.4.0-test12 [Was: Linux-2.4.0-test12]
In-Reply-To: message from Linus Torvalds on Tuesday December 12
In-Reply-To: <14902.45844.964925.199379@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.10.10012121539000.2348-100000@penguin.transmeta.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 12, torvalds@transmeta.com wrote:
> 
> 
> On Wed, 13 Dec 2000, Neil Brown wrote:
> >
> > Could you add this test to the top of md_make_request as well, because
> > requests to raid5 don't go through generic_make_request.
> 
> Sure they do. Everything that calls ll_rw_block() or submit_bh() will go
> through generic_make_request.
> 
> Neil, you're probably thinking about __make_request(), which only triggers
> for "normal" devices.

Yes... you are right.  Alright, I can't escape it any other way so I
guess I must admit that  it is a raid5 bug.

But how can raid5 be calling b_end_io on a buffer_head that was never
passed to generic_make_request?
Answer, it snoops on the buffer cache to try to do complete stripe
writes.
The following patch disabled that code.

NeilBrown

--- drivers/md/raid5.c	2000/12/13 00:13:54	1.1
+++ drivers/md/raid5.c	2000/12/13 00:14:07
@@ -1009,6 +1009,7 @@
 	struct buffer_head *bh;
 	int method1 = INT_MAX, method2 = INT_MAX;
 
+#if 0
 	/*
 	 * Attempt to add entries :-)
 	 */
@@ -1039,6 +1040,7 @@
 			atomic_dec(&bh->b_count);
 		}
 	}
+#endif
 	PRINTK("handle_stripe() -- begin writing, stripe %lu\n", sh->sector);
 	/*
 	 * Writing, need to update parity buffer.
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
