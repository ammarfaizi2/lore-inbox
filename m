Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318696AbSIKKx1>; Wed, 11 Sep 2002 06:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318708AbSIKKx1>; Wed, 11 Sep 2002 06:53:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43160 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318696AbSIKKx0>;
	Wed, 11 Sep 2002 06:53:26 -0400
Date: Wed, 11 Sep 2002 12:58:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Oleg Drokin <green@namesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: 2.5 Problem Status Report
Message-ID: <20020911105807.GF1089@suse.de>
References: <20020911112808.A6341@namesys.com> <Pine.LNX.4.44.0209110937190.5764-100000@localhost.localdomain> <20020911120551.A937@namesys.com> <20020911102507.GA1364@suse.de> <20020911102926.GB1364@suse.de> <20020911144740.A911@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020911144740.A911@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11 2002, Oleg Drokin wrote:
> Hello!
> 
> On Wed, Sep 11, 2002 at 12:29:26PM +0200, Jens Axboe wrote:
> 
> > > ok I see the bug. it's due to the imbalanced nature of ide_map_buffer()
> > > vs ide_unmap_buffer(). i'll cook up a fix right away.
> > Does this make it work?
> 
> No. It fails exactly like without the patch.

Hmm, ok I'll try and reproduce it here then.

> > --- include/linux/ide.h~	2002-09-11 12:27:14.000000000 +0200
> > +++ include/linux/ide.h	2002-09-11 12:27:29.000000000 +0200
> > @@ -597,9 +597,10 @@
> >  	return rq->buffer + task_rq_offset(rq);
> >  }
> >  
> > -extern inline void ide_unmap_buffer(char *buffer, unsigned long *flags)
> > +extern inline void ide_unmap_buffer(struct request *rq, char *buffer, unsigned long *flags)
> >  {
> > -	bio_kunmap_irq(buffer, flags);
> > +	if (rq->bio)
> > +		bio_kunmap_irq(buffer, flags);
> >  }
> >  
> >  /*
> 
> Perhaps you forgot to make sure rq->bio is zeroed on unmapping/freeing?

rq->bio must not be zeroed or free'd or anything like that. ok I see
what happens now. does this patch work for you? just back out the other
patch first (well you don't have to, but might as well).

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.639   -> 1.640  
#	 include/linux/bio.h	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/11	axboe@burns.home.kernel.dk	1.640
# clean up with bio_kmap_irq() thing properly. remove the micro optimization
# of _not_ calling kmap_atomic() if this isn't a highmem page. we could
# keep that and do the inc_preempt_count() ourselves, but I'm not sure
# it's worth it and this is cleaner.
# --------------------------------------------
#
diff -Nru a/include/linux/bio.h b/include/linux/bio.h
--- a/include/linux/bio.h	Wed Sep 11 12:57:45 2002
+++ b/include/linux/bio.h	Wed Sep 11 12:57:45 2002
@@ -215,17 +215,11 @@
 {
 	unsigned long addr;
 
-	local_save_flags(*flags);
-
-	/*
-	 * could be low
-	 */
-	if (!PageHighMem(bio_page(bio)))
-		return bio_data(bio);
-
 	/*
-	 * it's a highmem page
+	 * might not be a highmem page, but the preempt/irq count
+	 * balancing is a lot nicer this way
 	 */
+	local_save_flags(*flags);
 	local_irq_disable();
 	addr = (unsigned long) kmap_atomic(bio_page(bio), KM_BIO_SRC_IRQ);
 

-- 
Jens Axboe

