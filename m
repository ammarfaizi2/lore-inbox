Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291627AbSBAJOf>; Fri, 1 Feb 2002 04:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291624AbSBAJOa>; Fri, 1 Feb 2002 04:14:30 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:24338 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S291625AbSBAJM6>;
	Fri, 1 Feb 2002 04:12:58 -0500
Date: Thu, 31 Jan 2002 22:21:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd in 2.5.3 does not work, and can cause severe damage when read-write
Message-ID: <20020131212157.GA516@elf.ucw.cz>
In-Reply-To: <20020131132446.GA23990@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020131132446.GA23990@vana.vc.cvut.cz>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>     I've got strange idea and tried to build diskless machine around
> 2.5.3... Besides problem with segfaulting crc32 (it is initialized after 
> net/ipv4/ipconfig.c due to lib/lib.a being a library... I had to hardcode
> lib/crc32.o before --start-group in main Makefile, but it is another
> story) there is bad problem with NBD caused by BIO changes:
> 
> (1) request flags were immediately put into on-wire request format.
>     In the past, we had 0=READ, !0=WRITE. Now only REQ_RW bit determines
>     direction. As nbd-server from nbd distribution package treats any
>     non-zero value as write, it performs writes instead of read. Fortunately
>     it will die due to other consistency checks on incoming request,
>     but...

I have no problem with this.

> (2) nbd servers handle only up to 10240 byte requests. So setting max_sectors
>     to 20 is needed, as otherwise nbd server commits suicide. Maximum request size
>     should be handshaked during nbd initialization, but currently just use
>     hardwired 20 sectors, so it will behave like it did in the past.

But please do not apply this one. Nbd servers should be fixed, and I
already have fix in cvs. (Besides, its trivial). Just make buffer in
server 1MB big.

I do not like idea of handshake.

So, first hunk is fine, but I do not like second one.
									Pavel

> diff -urdN linux/drivers/block/nbd.c linux/drivers/block/nbd.c
> --- linux/drivers/block/nbd.c	Thu Jan 10 18:15:38 2002
> +++ linux/drivers/block/nbd.c	Thu Jan 31 00:24:50 2002
> @@ -155,14 +155,15 @@
>  	unsigned long size = req->nr_sectors << 9;
>  
>  	DEBUG("NBD: sending control, ");
> +	
> +	rw = rq_data_dir(req);
> +	
>  	request.magic = htonl(NBD_REQUEST_MAGIC);
> -	request.type = htonl(req->flags);
> +	request.type = htonl((rw & WRITE) ? 1 : 0);
>  	request.from = cpu_to_be64( (u64) req->sector << 9);
>  	request.len = htonl(size);
>  	memcpy(request.handle, &req, sizeof(req));
>  
> -	rw = rq_data_dir(req);
> -
>  	result = nbd_xmit(1, sock, (char *) &request, sizeof(request), rw & WRITE ? MSG_MORE : 0);
>  	if (result <= 0)
>  		FAIL("Sendmsg failed for control.");
> @@ -517,6 +518,7 @@
>  	blksize_size[MAJOR_NR] = nbd_blksizes;
>  	blk_size[MAJOR_NR] = nbd_sizes;
>  	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_nbd_request, &nbd_lock);
> +	blk_queue_max_sectors(BLK_DEFAULT_QUEUE(MAJOR_NR), 20);
>  	for (i = 0; i < MAX_NBD; i++) {
>  		nbd_dev[i].refcnt = 0;
>  		nbd_dev[i].file = NULL;

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa




