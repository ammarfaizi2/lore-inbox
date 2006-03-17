Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752545AbWCQGUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbWCQGUb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 01:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752544AbWCQGUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 01:20:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58057 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751210AbWCQGUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 01:20:30 -0500
Date: Thu, 16 Mar 2006 22:17:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 010 of 13] md: Only checkpoint expansion progress
 occasionally.
Message-Id: <20060316221743.71a21520.akpm@osdl.org>
In-Reply-To: <1060317044814.16208@suse.de>
References: <20060317154017.15880.patches@notabene>
	<1060317044814.16208@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.de> wrote:
>
> diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
>  --- ./drivers/md/raid5.c~current~	2006-03-17 11:48:58.000000000 +1100
>  +++ ./drivers/md/raid5.c	2006-03-17 11:48:58.000000000 +1100
>  @@ -1747,8 +1747,9 @@ static int make_request(request_queue_t 

That's a fairly complex function..

I wonder about this:

	spin_lock_irq(&conf->device_lock);
	if (--bi->bi_phys_segments == 0) {
		int bytes = bi->bi_size;

		if ( bio_data_dir(bi) == WRITE )
			md_write_end(mddev);
		bi->bi_size = 0;
		bi->bi_end_io(bi, bytes, 0);
	}
	spin_unlock_irq(&conf->device_lock);

bi_end_io() can be somewhat expensive.  Does it need to happen under the lock?
