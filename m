Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUIGJnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUIGJnB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 05:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUIGJnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 05:43:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47852 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267772AbUIGJm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 05:42:58 -0400
Date: Tue, 7 Sep 2004 11:35:59 +0200
From: Jens Axboe <axboe@suse.de>
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/3] uml-ubd-no-empty-queue
Message-ID: <20040907093559.GL6323@suse.de>
References: <20040906174447.238788D1E@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906174447.238788D1E@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06 2004, blaisorblade_spam@yahoo.it wrote:
> 
> Avoid using, in the UBD driver, the elv_queue_empty function. It's for
> the block layer only; in fact, the Anticipatory Scheduler can return NULL
> with elv_next_request() even if the queue is not empty, because it waits
> for the process to send another request before seeking on the disk.
> 
> In fact, if (with uml-ubd-any-elevator) we let UBD use any scheduler,
> elevator=as will make the UBD driver Oops, if we don't have this patch.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
> ---
> 
>  uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-no-empty-queue arch/um/drivers/ubd_kern.c
> --- uml-linux-2.6.8.1/arch/um/drivers/ubd_kern.c~uml-ubd-no-empty-queue	2004-08-29 14:40:51.313410952 +0200
> +++ uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c	2004-08-29 14:40:51.315410648 +0200
> @@ -1038,8 +1038,7 @@ static void do_ubd_request(request_queue
>  	int err, n;
>  
>  	if(thread_fd == -1){
> -		while(!elv_queue_empty(q)){
> -			req = elv_next_request(q);
> +		while((req = elv_next_request(q)) != NULL){
>  			err = prepare_request(req, &io_req);
>  			if(!err){
>  				do_io(&io_req);
> @@ -1048,9 +1047,8 @@ static void do_ubd_request(request_queue
>  		}
>  	}
>  	else {
> -		if(do_ubd || elv_queue_empty(q))
> +		if(do_ubd || (req = elv_next_request(q)) == NULL)
>  			return;
> -		req = elv_next_request(q);
>  		err = prepare_request(req, &io_req);
>  		if(!err){
>  			do_ubd = ubd_handler;

Patch is correct.

-- 
Jens Axboe

