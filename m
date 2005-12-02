Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVLBR7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVLBR7c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 12:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVLBR7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 12:59:32 -0500
Received: from fep32-0.kolumbus.fi ([193.229.0.63]:28390 "EHLO
	fep32-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1750851AbVLBR7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 12:59:31 -0500
Date: Fri, 2 Dec 2005 19:59:37 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Hugh Dickins <hugh@veritas.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Ryan Richter <ryan@tau.solarneutrino.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <Pine.LNX.4.61.0512021325020.1507@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.63.0512021932590.4506@kai.makisara.local>
References: <20051129092432.0f5742f0.akpm@osdl.org> 
 <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local> 
 <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <1133468882.5232.14.camel@mulgrave>
 <Pine.LNX.4.63.0512012304240.5777@kai.makisara.local>
 <Pine.LNX.4.61.0512021325020.1507@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2005, Hugh Dickins wrote:

> On Thu, 1 Dec 2005, Kai Makisara wrote:
> > On Thu, 1 Dec 2005, James Bottomley wrote:
> > > 
> > > On a side note, I have Kai's patch in the scsi-rc-fixes tree which I'm
> > > getting ready to push.  Can we get a consensus on whether it should be
> > > removed before I merge upwards?
> 
> I too need to decide whether to base my little sg.c,st.c patchset
> on top of Kai's (as I see in 2.6.15-rc3-mm1, I presume) or on top
> of 2.6.15-rc4.
> 
> > I think it should be removed because it is based partly on a wrong 
> > assumption: asynchronous writes are _not_ done together with direct i/o. 
> > (I have also experimentally verified that this does not happen.)
> 
> I'm assuming from this that I'd best base on 2.6.15-rc4;
> but by all means overrule me if you've changed your mind.
> 
> > The patch includes the patch I sent sent to linux-scsi on Nov 21. Nobody 
> > has commented it and I don't know if the user pages have to be explicitly 
> > marked dirty after the HBA has read data there. If they have to, then this 
> > earlier patch is valid.
> 
> What I see in 2.6.15-rc3-mm1 looks like three patches.
> 
> One to do with resetting sg_segs to 0 at various points:
> I've no appreciation of that patch at all.  If it would help you for
> me to add that into my little set, please send me a comment for it.
> 
I include at the end of this message the patch I sent to linux-scsi 
earlier. It should clarify what are the useful parts of the later patch.

I think the release_buffering() call at the end of st_read must say 1. All 
returns use the same path (except the one returning -ERESTARTSYS).

This is the comment related to this part:
- the number of s/g segments has not always been zeroed when the page
  pointers become invalid

The changes setting sg_segs to 0 don't fix any known bugs. They will be 
necessary if/when Mike Christie's patches will be merged later. You can 
omit these things now if you want.

> One to add an "is_read" argument to release_buffering.  Yes, that's
> a part of my set too, though in my case called "dirtied" (and I believe
> that the call at the end of st_read can say 0, because that's just for
> an error path: when it's really dirtied user memory, it'll be read_tape
> that does the release_buffering).  sg.c was always saying dirtied, even
> when writing from memory; st.c was always saying not dirtied, even when
> reading into memory.  Usually the latter is okay, get_user_pages has
> said dirty in advance; but under pressure there's a window whereby it's
> not good enough.  And SetPageDirty can be counter-productive these days,
> so your patch is incomplete in that regard: I'll explain more in mine.
> 
Good, I will leave sorting out these things to to you. Any naming is OK 
with me.

I think the release_buffering() call at the end of st_read must say 1. All 
returns use the same path (except the one returning -ERESTARTSYS).

st.c did set pages dirty after reading before 2.6.0-test4. It disappeared 
when code was rearranged and I don't have any notes about why.

> One to move around where release_buffering is called from:
> that's the part you've decided was wrong, or at least unnecessary.
> 
It is unnecessary but does not cause any problems. It is wrong because it 
hints that asynchronous writes could be done with direct i/o.

> > If not, I will send a patch for 2.6.16 to remove the latent code.
> 
> I didn't understand that bit, but I probably don't need to.
> 
After the previous comments, you don't need to :-) The meaning was that I 
would remove the extra parameter and code setting pages dirty from 
sgl_unmap_pages() if that code would never be used.

> Hugh
> 
Thanks for looking at the code.

Kai

----------
This patch is against 2.6.15-rc2 and fixes the following two bugs in the SCSI
tape driver:
- the pages dirtied by reading data to user space have not been marked dirty
- the number of s/g segments has not always been zeroed when the page
  pointers become invalid

Signed-off-by: Kai Makisara <kai.makisara@kolumbus.fi>
---
--- linux-2.6.15-rc2/drivers/scsi/st.c	2005-11-20 22:10:00.000000000 +0200
+++ linux-2.6.15-rc2-k1/drivers/scsi/st.c	2005-11-20 22:33:25.000000000 +0200
@@ -17,7 +17,7 @@
    Last modified: 18-JAN-1998 Richard Gooch <rgooch@atnf.csiro.au> Devfs support
  */
 
-static char *verstr = "20050830";
+static char *verstr = "20051120";
 
 #include <linux/module.h>
 
@@ -1449,14 +1449,15 @@ static int setup_buffering(struct scsi_t
 
 
 /* Can be called more than once after each setup_buffer() */
-static void release_buffering(struct scsi_tape *STp)
+static void release_buffering(struct scsi_tape *STp, int is_read)
 {
 	struct st_buffer *STbp;
 
 	STbp = STp->buffer;
 	if (STbp->do_dio) {
-		sgl_unmap_user_pages(&(STbp->sg[0]), STbp->do_dio, 0);
+		sgl_unmap_user_pages(&(STbp->sg[0]), STbp->do_dio, is_read);
 		STbp->do_dio = 0;
+		STbp->sg_segs = 0;
 	}
 }
 
@@ -1729,7 +1730,7 @@ st_write(struct file *filp, const char _
  out:
 	if (SRpnt != NULL)
 		scsi_release_request(SRpnt);
-	release_buffering(STp);
+	release_buffering(STp, 0);
 	up(&STp->lock);
 
 	return retval;
@@ -1787,7 +1788,7 @@ static long read_tape(struct scsi_tape *
 	SRpnt = *aSRpnt;
 	SRpnt = st_do_scsi(SRpnt, STp, cmd, bytes, DMA_FROM_DEVICE,
 			   STp->device->timeout, MAX_RETRIES, 1);
-	release_buffering(STp);
+	release_buffering(STp, 1);
 	*aSRpnt = SRpnt;
 	if (!SRpnt)
 		return STbp->syscall_result;
@@ -2058,7 +2059,7 @@ st_read(struct file *filp, char __user *
 		SRpnt = NULL;
 	}
 	if (do_dio) {
-		release_buffering(STp);
+		release_buffering(STp, 1);
 		STbp->buffer_bytes = 0;
 	}
 	up(&STp->lock);
@@ -3670,6 +3671,7 @@ static void normalize_buffer(struct st_b
 	}
 	STbuffer->frp_segs = STbuffer->orig_frp_segs;
 	STbuffer->frp_sg_current = 0;
+	STbuffer->sg_segs = 0;
 }
 
 
