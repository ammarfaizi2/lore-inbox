Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030643AbWJCWo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030643AbWJCWo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030642AbWJCWo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:44:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4590 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030637AbWJCWoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:44:55 -0400
Date: Tue, 3 Oct 2006 15:44:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [PATCH take2 3/5] dio: formalize bio counters as a dio
 reference count
Message-Id: <20061003154449.daab5dbd.akpm@osdl.org>
In-Reply-To: <20061002232135.18827.28686.sendpatchset@tetsuo.zabbo.net>
References: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>
	<20061002232135.18827.28686.sendpatchset@tetsuo.zabbo.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Oct 2006 16:21:35 -0700 (PDT)
Zach Brown <zach.brown@oracle.com> wrote:

> dio: formalize bio counters as a dio reference count
> 
> Previously we had two confusing counts of bio progress.  'bio_count' was
> decremented as bios were processed and freed by the dio core.  It was used to
> indicate final completion of the dio operation.  'bios_in_flight' reflected how
> many bios were between submit_bio() and bio->end_io.  It was used by the sync
> path to decide when to wake up and finish completing bios and was ignored
> by the async path.
> 
> This patch collapses the two notions into one notion of a dio reference count.
> bios hold a dio reference when they're between submit_bio and bio->end_io.
> 
> Since bios_in_flight was only used in the sync path it is now equivalent
> to dio->refcount - 1 which accounts for direct_io_worker() holding a 
> reference for the duration of the operation.
> 
> dio_bio_complete() -> finished_one_bio() was called from the sync path after
> finding bios on the list that the bio->end_io function had deposited.
> finished_one_bio() can not drop the dio reference on behalf of these bios now
> because bio->end_io already has.  The is_async test in finished_one_bio() meant
> that it never actually did anything other than drop the bio_count for sync
> callers.  So we remove its refcount decrement, don't call it from
> dio_bio_complete(), and hoist its call up into the async dio_bio_complete()
> caller after an explicit refcount decrement.  It is renamed dio_complete_aio()
> to reflect the remaining work it actually does.
> 
> ...
>  
> +static int wait_for_more_bios(struct dio *dio)
> +{
> +	assert_spin_locked(&dio->bio_lock);
> +
> +	return (atomic_read(&dio->refcount) > 1) && (dio->bio_list == NULL);
> +}

This function isn't well-named.

> @@ -1103,7 +1088,11 @@ direct_io_worker(int rw, struct kiocb *i
>  		}
>  		if (ret == 0)
>  			ret = dio->result;
> -		finished_one_bio(dio);		/* This can free the dio */
> +
> +		/* this can free the dio */
> +		if (atomic_dec_and_test(&dio->refcount))
> +			dio_complete_aio(dio);

So...  how come it's legitimate to touch *dio if it can be freed by now? 
(iirc, it's legit, but a comment explaining this oddity is needed).

