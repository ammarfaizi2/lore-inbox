Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWIHIZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWIHIZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 04:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWIHIZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 04:25:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54461 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751007AbWIHIZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 04:25:17 -0400
Date: Fri, 8 Sep 2006 10:25:32 +0200
From: Jan Kara <jack@suse.cz>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       sct@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
Message-ID: <20060908082531.GA28397@atrey.karlin.mff.cuni.cz>
References: <20060906124719.GA11868@atrey.karlin.mff.cuni.cz> <1157555559.23501.25.camel@dyn9047017100.beaverton.ibm.com> <20060906153449.GC18281@atrey.karlin.mff.cuni.cz> <1157559545.23501.30.camel@dyn9047017100.beaverton.ibm.com> <20060906162723.GA14345@atrey.karlin.mff.cuni.cz> <1157563016.23501.39.camel@dyn9047017100.beaverton.ibm.com> <20060906172733.GC14345@atrey.karlin.mff.cuni.cz> <1157641877.7725.13.camel@dyn9047017100.beaverton.ibm.com> <20060907223048.GD22549@atrey.karlin.mff.cuni.cz> <4500F2B2.4010204@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4500F2B2.4010204@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> Jan Kara wrote:
> >  I've been looking more at the code and I have revived my patch fixing
> >this part of the code. I've mildly tested the patch. Could you also give
> >it a try? Thanks.
> >
> >								Honza
> >  
> >------------------------------------------------------------------------
> >
> >Original commit code assumes, that when a buffer on BJ_SyncData list is 
> >locked,
> >it is being written to disk. But this is not true and hence it can lead to 
> >a
> >potential data loss on crash. Also the code didn't count with the fact that
> >journal_dirty_data() can steal buffers from committing transaction and 
> >hence
> >could write buffers that no longer belong to the committing transaction.
> >Finally it could possibly happen that we tried writing out one buffer 
> >several
> >times.
> >
> >The patch below tries to solve these problems by a complete rewrite of the 
> >data
> >commit code. We go through buffers on t_sync_datalist, lock buffers needing
> >write out and store them in an array. Buffers are also immediately refiled 
> >to
> >BJ_Locked list or unfiled (if the write out is completed). When the array 
> >is
> >full or we have to block on buffer lock, we submit all accumulated buffers 
> >for
> >IO.
> >
> >Signed-off-by: Jan Kara <jack@suse.cz>
> >
> >  
> I have been running 4+ hours with this patch and seems to work fine. I 
> haven't hit any
> assert yet :)
> 
> I will let it run till tomorrow. I will let you know, how it goes.
  Great, thanks. BTW: Do you have any performance tests handy? The
changes are big enough to cause some unexpected performance regressions,
livelocks... If you don't have anything ready, I can setup and run
something myself.  Just that I don't like this testing too much ;).

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
