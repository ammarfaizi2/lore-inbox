Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbTKEUgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 15:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbTKEUgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 15:36:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62168 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263157AbTKEUge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 15:36:34 -0500
Date: Wed, 5 Nov 2003 21:36:33 +0100
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org, Alex Lyashkov <shadow@itt.net.ru>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: Linux 2.4 quota (accounting?) bug ...
Message-ID: <20031105203633.GD9697@atrey.karlin.mff.cuni.cz>
References: <20031025162640.GA24020@DUK2.13thfloor.at> <20031025163128.GA20786@atrey.karlin.mff.cuni.cz> <20031025174225.GB24020@DUK2.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025174225.GB24020@DUK2.13thfloor.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> On Sat, Oct 25, 2003 at 06:31:28PM +0200, Jan Kara wrote:
> >   Hi,
> > 
> > > a friend of mine, made me aware of the following
> > > imbalance, which looks like a minor accounting bug 
> > > to me, but might be a quota bug ...
> >   Sorry but the code seems correct to me - we get reference to dquot by
> > get_dquot_ref() and than we put the reference by dqput(). dqput() is
> > correct because something nasty might happen in the mean time and so we
> > might be the last holders of the dquot. What do you think is wrong?
> 
> dqput() does dqstats.drops++;
> which isn't correct if this should be the same as
> put_dquot_ref(), but maybe I'm just irritated by 
> strange statistics on some kernels showing more
> drops than lookups+allocated after sync/quotaoff
  So I finally got to fixing the bug. The patch (also with a deletition
of unnecessary variable) is attached. Marcello please apply.

									Honza

---------------------cut here-------------------------------------------

diff -ruX ../kerndiffexclude linux-2.4.22-um/fs/dquot.c linux-2.4.22-fixstat/fs/dquot.c
--- linux-2.4.22-um/fs/dquot.c	Mon Aug 25 13:44:43 2003
+++ linux-2.4.22-fixstat/fs/dquot.c	Wed Nov  5 21:21:58 2003
@@ -392,6 +392,7 @@
 		 * is enough since if dquot is locked/modified it can't be
 		 * on the free list */
 		get_dquot_ref(dquot);
+		dqstats.lookups++;
 		if (dquot->dq_flags & DQ_LOCKED)
 			wait_on_dquot(dquot);
 		if (dquot_dirty(dquot))
@@ -622,7 +623,6 @@
 		dqput(dquot);
 		return NODQUOT;
 	}
-	++dquot->dq_referenced;
 	dqstats.lookups++;
 
 	return dquot;
@@ -642,7 +642,6 @@
 	if (dquot->dq_flags & DQ_LOCKED)
 		printk(KERN_ERR "VFS: dqduplicate(): Locked quota to be duplicated!\n");
 	get_dquot_dup_ref(dquot);
-	dquot->dq_referenced++;
 	dqstats.lookups++;
 
 	return dquot;
Only in linux-2.4.22-fixstat/include/linux: modules
diff -ruX ../kerndiffexclude linux-2.4.22-um/include/linux/quota.h linux-2.4.22-fixstat/include/linux/quota.h
--- linux-2.4.22-um/include/linux/quota.h	Mon Aug 25 13:44:44 2003
+++ linux-2.4.22-fixstat/include/linux/quota.h	Wed Nov  5 21:27:44 2003
@@ -222,8 +222,6 @@
 	loff_t dq_off;			/* Offset of dquot on disk */
 	short dq_type;			/* Type of quota */
 	short dq_flags;			/* See DQ_* */
-	unsigned long dq_referenced;	/* Number of times this dquot was 
-					   referenced during its lifetime */
 	struct mem_dqblk dq_dqb;	/* Diskquota usage */
 };
 
