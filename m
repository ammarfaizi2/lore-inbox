Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316634AbSE0Sq4>; Mon, 27 May 2002 14:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316613AbSE0Sqz>; Mon, 27 May 2002 14:46:55 -0400
Received: from pcp607045pcs.galitn01.tn.comcast.net ([68.53.58.57]:38156 "HELO
	gibbs.dhs.org") by vger.kernel.org with SMTP id <S316581AbSE0Sqy>;
	Mon, 27 May 2002 14:46:54 -0400
Subject: Re: 2.4 SRMMU bug revisited
From: Colin Gibbs <colin@gibbs.dhs.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org, tcallawa@redhat.com,
        sparclinux@vger.kernel.org, aurora-sparc-devel@linuxpower.org
In-Reply-To: <20020527092408.GD345@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 27 May 2002 13:46:38 -0500
Message-Id: <1022525198.19147.29.camel@monolith>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 04:24, Tomas Szepe wrote:

> I finally got round to trying the patches out and --
> 
> unfortunately, things got even worse. While before the machine would
> oops (still allowing one to ssh in and reboot) under heavy loads, now
> it doesn't bother to log the slightest notice that something might
> have broken, and freezes entirely (it can be pinged, though).
> 
> I can't say I like these fixes much.
> 
> 
> T.

What kinds of heavy loads? If you were triggering the out of nocache
memory BUG, then this patch may help. I fixes a bug where fork fails and
calls destroy_context on the parent's mm or more precisely a memcpy'd
duplicate of it. In that case when fork returns to the parent, it
continuously faults.

But if your load does not fork heavily, then this is probably not the
problem.


Colin

--- 2.4.19-pre4/kernel/fork.c	Thu Mar 28 19:49:36 2002
+++ tortoise-19-pre4/kernel/fork.c	Sun Apr 21 22:01:18 2002
@@ -336,6 +336,9 @@
 	if (!mm_init(mm))
 		goto fail_nomem;
 
+	if (init_new_context(tsk,mm))
+		goto free_pt;
+
 	down_write(&oldmm->mmap_sem);
 	retval = dup_mmap(mm);
 	up_write(&oldmm->mmap_sem);
@@ -347,9 +350,6 @@
 	 * child gets a private LDT (if there was an LDT in the parent)
 	 */
 	copy_segments(tsk, mm);
-
-	if (init_new_context(tsk,mm))
-		goto free_pt;
 
 good_mm:
 	tsk->mm = mm;

