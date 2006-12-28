Return-Path: <linux-kernel-owner+w=401wt.eu-S1754864AbWL1POM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864AbWL1POM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 10:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754868AbWL1POM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 10:14:12 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:57941 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754867AbWL1POK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 10:14:10 -0500
Date: Thu, 28 Dec 2006 20:48:30 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, linux-aio@kvack.org, akpm@osdl.org,
       drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
Subject: Re: [FSAIO][PATCH 7/8] Filesystem AIO read
Message-ID: <20061228151830.GB10156@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20061228084252.GG6971@in.ibm.com> <20061228115747.GB25644@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228115747.GB25644@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 11:57:47AM +0000, Christoph Hellwig wrote:
> > +	if (in_aio()) {
> > +		/* Avoid repeat readahead */
> > +		if (kiocbTryRestart(io_wait_to_kiocb(current->io_wait)))
> > +			next_index = last_index;
> > +	}
> 
> Every place we use kiocbTryRestart in this and the next patch it's in
> this from, so we should add a little helper for it:
> 
> int aio_try_restart(void)
> {
> 	struct wait_queue_head_t *wq = current->io_wait;
> 
> 	if (!is_sync_wait(wq) && kiocbTryRestart(io_wait_to_kiocb(wq)))
> 		return 1;
> 	return 0;
> }

Yes, we can do that -- how about aio_restarted() as an alternate name ?

> 
> with a big kerneldoc comment explaining this idiom (and possible a better
> name for the function ;-))
> 
> > +
> > +		if ((error = __lock_page(page, current->io_wait))) {
> > +			goto readpage_error;
> > +		}
> 
> This should  be
> 
> 		error = __lock_page(page, current->io_wait);
> 		if (error)
> 			goto readpage_error;
> 
> Pluse possible naming updates discussed in the last mail.  Also do we
> really need to pass current->io_wait here?  Isn't the waitqueue in
> the kiocb always guaranteed to be the same?  Now that all pagecache

We don't have have the kiocb available to this routine. Using current->io_wait
avoids the need to pass the iocb down to deeper levels just for the sync vs
async checks, also allowing such routines to be shared by other code which
does not use iocbs (e.g. generic_file_sendfile->do_generic_file_read
->do_generic_mapping_read) without having to set up dummy iocbs.

Does that clarify ? We could abstract this away within a lock page wrapper,
but I don't know if that makes a difference.

> I/O goes through the ->aio_read/->aio_write routines I'd prefer to
> get rid of the task_struct field cludges and pass all this around in
> the kiocb.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

