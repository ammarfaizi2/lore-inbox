Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbTICGlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 02:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTICGlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 02:41:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51156 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263702AbTICGlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 02:41:10 -0400
Date: Wed, 3 Sep 2003 08:40:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Huh <tejun@aratech.co.kr>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] ide task_map_rq() preempt count imbalance
Message-ID: <20030903064057.GA14833@suse.de>
References: <20030903055257.GA31635@atj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903055257.GA31635@atj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03 2003, Tejun Huh wrote:
>  Hello,
> 
>  2.5 kernel continued to fail on my test machine with a lot of
> scheduling while atomic messages.  The offending function was
> include/linux/ide.h:task_sectors() which calls task_map_rq() followed
> by process_that_request_first(), taskfile_{input|output}_data() and
> task_unmap_rq().
> 
> static inline void *task_map_rq(struct request *rq, unsigned long *flags)
> {
> 	/*
> 	 * fs request
> 	 */
> 	if (rq->cbio)
> 		return rq_map_buffer(rq, flags);
> 
> 	/*
> 	 * task request
> 	 */
> 	return rq->buffer + blk_rq_offset(rq);
> }
> 
> static inline void task_unmap_rq(struct request *rq, char *buffer, unsigned long *flags)
> {
> 	if (rq->cbio)
> 		rq_unmap_buffer(buffer, flags);
> }
> 
>  rq_[un]map_buffer() eventually call into k[un]map_atomic() which
> adjust preempt_count().  The problem is that rq->cbio is cleared by
> process_that_request_first() before calling task_unmap_rq(), so the
> preempt_count() isn't decremented properly.
> 
>  As it seems that rq->cbio test is to avoid the cost of calling into
> k[un]map_atomic, I just removed the optimization and it worked for me.
> 
>  I'm not familiar with ide and block layer.  If I got something wrong,
> please point out.
> 
> -- 
> tejun
> 
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.1412  -> 1.1413 
> #	 include/linux/ide.h	1.72    -> 1.73   
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/09/03	tj@atj.dyndns.org	1.1413
> # - task_[un]map_rq() preempt count imbalance fixed.
> # --------------------------------------------
> #
> diff -Nru a/include/linux/ide.h b/include/linux/ide.h
> --- a/include/linux/ide.h	Wed Sep  3 14:50:20 2003
> +++ b/include/linux/ide.h	Wed Sep  3 14:50:20 2003
> @@ -853,22 +853,12 @@
>  
>  static inline void *task_map_rq(struct request *rq, unsigned long *flags)
>  {
> -	/*
> -	 * fs request
> -	 */
> -	if (rq->cbio)
> -		return rq_map_buffer(rq, flags);
> -
> -	/*
> -	 * task request
> -	 */
> -	return rq->buffer + blk_rq_offset(rq);
> +	return rq_map_buffer(rq, flags);
>  }
>  
>  static inline void task_unmap_rq(struct request *rq, char *buffer, unsigned long *flags)
>  {
> -	if (rq->cbio)
> -		rq_unmap_buffer(buffer, flags);
> +	rq_unmap_buffer(buffer, flags);
>  }
>  
>  #endif /* !CONFIG_IDE_TASKFILE_IO */

This doesn't work, it's perfectly legit to use task_map_rq() on a
non-bio backed request. You need to fix this differently.

-- 
Jens Axboe

