Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751872AbWIGUr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWIGUr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 16:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWIGUr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 16:47:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49284 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751863AbWIGUr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 16:47:56 -0400
Date: Thu, 7 Sep 2006 22:48:08 +0200
From: Jan Kara <jack@suse.cz>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       sct@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
Message-ID: <20060907204808.GC22549@atrey.karlin.mff.cuni.cz>
References: <20060901101801.7845bca2.akpm@osdl.org> <1157472702.23501.12.camel@dyn9047017100.beaverton.ibm.com> <20060906124719.GA11868@atrey.karlin.mff.cuni.cz> <1157555559.23501.25.camel@dyn9047017100.beaverton.ibm.com> <20060906153449.GC18281@atrey.karlin.mff.cuni.cz> <1157559545.23501.30.camel@dyn9047017100.beaverton.ibm.com> <20060906162723.GA14345@atrey.karlin.mff.cuni.cz> <1157563016.23501.39.camel@dyn9047017100.beaverton.ibm.com> <20060906172733.GC14345@atrey.karlin.mff.cuni.cz> <1157641877.7725.13.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157641877.7725.13.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> >   Ugh! Are you sure? For this path the buffer must be attached (only) to
> > the running transaction. But then how the commit code comes to it?
> > Somebody would have to even manage to refile the buffer from the
> > committing transaction to the running one while the buffer is in wbuf[].
> > Could you check whether someone does __journal_refile_buffer() on your
> > marked buffers, please? Or whether we move buffer to BJ_Locked list in
> > the write_out_data: loop? Thanks.
> > 
> > 							
> 
> I added more debug in __journal_refile_buffer() to see if the marked
> buffers are getting refiled. I am able to reproduce the problem,
> but I don't see any debug including my original prints. (It looks as 
> if none of my debug code exists) - its really confusing. 
> 
> I will keep looking and get back to you.
> 
> I may try Andrew's buffer debug patch - if I get desperate.
  Ho, hum, I think I see what is hapenning. I think we steal the buffer
from commit in journal_dirty_data() (called e.g. from ext3_writepage()).
There we also take care of writing out the buffer so it's mostly OK.
Except that the commit code still keeps the reference to the buffer in
wbuf[]. So the right solution along the lines of your one would be to
check that each buffer in wbuf[] is buffer_jbd(), belongs to the right
transaction and list and only in that case run submit_bh() on it...

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
