Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbSAUKgP>; Mon, 21 Jan 2002 05:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281809AbSAUKgG>; Mon, 21 Jan 2002 05:36:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39186 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281214AbSAUKf5>;
	Mon, 21 Jan 2002 05:35:57 -0500
Date: Mon, 21 Jan 2002 11:35:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.3-pre1-aia1 (fwd)
Message-ID: <20020121113549.U27835@suse.de>
In-Reply-To: <Pine.LNX.4.10.10201210149290.13727-200000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201210149290.13727-200000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21 2002, Andre Hedrick wrote:
> @@ -189,13 +189,14 @@
>  	memset(&taskfile, 0, sizeof(task_struct_t));
>  	memset(&hobfile, 0, sizeof(hob_struct_t));
>  
> -	sectors = rq->nr_sectors;
>  	if (sectors == 256)
>  		sectors = 0;
> -	if (command == WIN_MULTWRITE_EXT || command == WIN_MULTWRITE) {
> +	if (command == WIN_MULTWRITE) {
>  		sectors = drive->mult_count;
>  		if (sectors > rq->current_nr_sectors)
>  			sectors = rq->current_nr_sectors;
> +		if (sectors != drive->mult_count)
> +			command = WIN_WRITE;

I think this is too restrictive, something ala

		if (sectors % drive->mult_count)
			command = WIN_WRITE;

should suffice. However, we still need to cover the read... So something
like this maybe:

	if (sectors % drive->mult_count)
		don't use multi write _or_ read, use WIN_{READ,WRITE}

	/* usual setup */

> -	sectors = rq->nr_sectors;
> -	if (sectors == 256)
> +	if (sectors == 65536)
>  		sectors = 0;

Yeah this was my silly, sorry.

-- 
Jens Axboe

