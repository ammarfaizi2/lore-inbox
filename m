Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTIITzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264431AbTIITzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:55:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39040 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264432AbTIITzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:55:43 -0400
Date: Tue, 9 Sep 2003 21:55:49 +0200
From: Jens Axboe <axboe@suse.de>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk API update (and bug fix) to CDU535 cdrom driver
Message-ID: <20030909195549.GR4755@suse.de>
References: <3F5DDEA8.6040901@terra.com.br> <20030909143341.GA18257@suse.de> <3F5DEA0D.6030701@terra.com.br> <20030909153536.GH18257@suse.de> <3F5E12EC.6040502@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5E12EC.6040502@terra.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09 2003, Felipe W Damasio wrote:
> 	Hi Jens,
> 
> Jens Axboe wrote:
> >held! Ugh, and the request function do_cdu535_request calls
> >schedule_timeout with the queue lock held (that is held when that
> >function is entered), that is very buggy as well. Should also use
> >set_current_state() right above that call, not open code it (that also
> >misses a memory barrier). Same function also has problems with request
> >handling. You should kill:
> >
> >	if (!(req->flags & REQ_CMD))
> >		continue;       /* FIXME */
> >
> >that is very broken, make that:
> >
> >	if (!blk_fs_request(req)) {
> >		end_request(req, 0);
> >		continue;
> >	}
> >
> >and kill these two lines:
> >
> >	if (rq_data_dir(req) != READ)
> >		panic("Unknown SONY CD cmd");
> >
> >they are screwy too.
> >
> >Care to fix the things I outlined above?
> 
> 	This patch I think fixes all these, doesn't it?
> 
> 	It applies on top of my latest cli-sti-removal patch that I sent you.

That needed changes too, as per my last mail. Please send one complete
patch with all the fixes in, thanks.

-- 
Jens Axboe

