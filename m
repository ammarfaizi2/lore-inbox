Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267754AbUIJTFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267754AbUIJTFI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUIJTFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:05:08 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:1114 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S267754AbUIJTEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:04:37 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/1] uml:fix ubd deadlock on SMP
Date: Fri, 10 Sep 2004 21:01:18 +0200
User-Agent: KMail/1.6.1
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
References: <20040908172503.384144933@zion.localdomain> <200409092044.54512.blaisorblade_spam@yahoo.it> <20040909122906.N1973@build.pdx.osdl.net>
In-Reply-To: <20040909122906.N1973@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409102101.18860.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 September 2004 21:29, Chris Wright wrote:
> * BlaisorBlade (blaisorblade_spam@yahoo.it) wrote:
> > Yes, thanks a lot for your help.
>
> Rename ubd_finish() to __ubd_finsh() and remove ubd_io_lock from it.
> Add wrapper, ubd_finish(), which grabs lock before calling __ubd_finish().
> Update do_ubd_request to use the lock free __ubd_finish() to avoid
> deadlock.  Also, apparently prepare_request is called with ubd_io_lock
> held, so remove locks there.

> Signed-off-by: Chris Wright <chrisw@osdl.org>
Ok, this is good. And it's the only one which has been discussed upon, Andrew, 
so you can merge the rest.
> ===== arch/um/drivers/ubd_kern.c 1.38 vs edited =====
> --- 1.38/arch/um/drivers/ubd_kern.c	2004-09-07 23:33:13 -07:00
> +++ edited/arch/um/drivers/ubd_kern.c	2004-09-09 12:18:01 -07:00
> @@ -396,14 +396,20 @@
>   */
>  int intr_count = 0;
>
> -static void ubd_finish(struct request *req, int error)
> +static inline void ubd_finish(struct request *req, int error)
> +{
> + 	spin_lock(&ubd_io_lock);
> +	__ubd_finish(req, error);
> +	spin_unlock(&ubd_io_lock);
> +}
> +
> +/* call ubd_finish if you need to serialize */
> +static void __ubd_finish(struct request *req, int error)
>  {
>  	int nsect;
>
>  	if(error){
> - 		spin_lock(&ubd_io_lock);
>  		end_request(req, 0);
> - 		spin_unlock(&ubd_io_lock);
>  		return;
>  	}
>  	nsect = req->current_nr_sectors;
> @@ -412,11 +418,10 @@
>  	req->errors = 0;
>  	req->nr_sectors -= nsect;
>  	req->current_nr_sectors = 0;
> -	spin_lock(&ubd_io_lock);
>  	end_request(req, 1);
> -	spin_unlock(&ubd_io_lock);
>  }
>
> +/* Called without ubd_io_lock held */
>  static void ubd_handler(void)
>  {
>  	struct io_thread_req req;
> @@ -965,6 +970,7 @@
>  	return(0);
>  }
>
> +/* Called with ubd_io_lock held */
>  static int prepare_request(struct request *req, struct io_thread_req
> *io_req) {
>  	struct gendisk *disk = req->rq_disk;
> @@ -977,9 +983,7 @@
>  	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
>  		printk("Write attempted on readonly ubd device %s\n",
>  		       disk->disk_name);
> - 		spin_lock(&ubd_io_lock);
>  		end_request(req, 0);
> - 		spin_unlock(&ubd_io_lock);
>  		return(1);
>  	}
>
> @@ -1029,6 +1033,7 @@
>  	return(0);
>  }
>
> +/* Called with ubd_io_lock held */
>  static void do_ubd_request(request_queue_t *q)
>  {
>  	struct io_thread_req io_req;
> @@ -1040,7 +1045,7 @@
>  			err = prepare_request(req, &io_req);
>  			if(!err){
>  				do_io(&io_req);
> -				ubd_finish(req, io_req.error);
> +				__ubd_finish(req, io_req.error);
>  			}
>  		}
>  	}
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM.
> Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
