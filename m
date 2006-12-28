Return-Path: <linux-kernel-owner+w=401wt.eu-S1754828AbWL1L5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828AbWL1L5z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 06:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754830AbWL1L5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 06:57:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40041 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828AbWL1L5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 06:57:54 -0500
Date: Thu, 28 Dec 2006 11:57:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: Re: [FSAIO][PATCH 7/8] Filesystem AIO read
Message-ID: <20061228115747.GB25644@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
	akpm@osdl.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20061228084252.GG6971@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228084252.GG6971@in.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (in_aio()) {
> +		/* Avoid repeat readahead */
> +		if (kiocbTryRestart(io_wait_to_kiocb(current->io_wait)))
> +			next_index = last_index;
> +	}

Every place we use kiocbTryRestart in this and the next patch it's in
this from, so we should add a little helper for it:

int aio_try_restart(void)
{
	struct wait_queue_head_t *wq = current->io_wait;

	if (!is_sync_wait(wq) && kiocbTryRestart(io_wait_to_kiocb(wq)))
		return 1;
	return 0;
}

with a big kerneldoc comment explaining this idiom (and possible a better
name for the function ;-))

> +
> +		if ((error = __lock_page(page, current->io_wait))) {
> +			goto readpage_error;
> +		}

This should  be

		error = __lock_page(page, current->io_wait);
		if (error)
			goto readpage_error;

Pluse possible naming updates discussed in the last mail.  Also do we
really need to pass current->io_wait here?  Isn't the waitqueue in
the kiocb always guaranteed to be the same?  Now that all pagecache
I/O goes through the ->aio_read/->aio_write routines I'd prefer to
get rid of the task_struct field cludges and pass all this around in
the kiocb.  

