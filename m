Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbUK0SOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbUK0SOz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 13:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUK0SOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 13:14:17 -0500
Received: from smtp1.freeserve.com ([193.252.22.158]:50838 "EHLO
	mwinf3006.me.freeserve.com") by vger.kernel.org with ESMTP
	id S261290AbUK0SMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 13:12:49 -0500
Message-ID: <4040305.1101579168561.JavaMail.www@wwinf3001>
From: Felix Bellaby <member@bellaby.freeserve.co.uk>
Reply-To: member@bellaby.freeserve.co.uk
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: RAID10 overwrites partition tables
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.92.168.167]
Date: Sat, 27 Nov 2004 19:12:48 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 27, Neil Brown wrote
>>    	 mdadm --level 10 does not seem to respect disk partition boundaries.
> 
> Hmmm, yes, thanks.
>
> I think the following should fix the bug.  It only affects 'resync'
> not normal IO or recovery (after a drive has failed).
> ...
> diff ./drivers/md/raid10.c~current~ ./drivers/md/raid10.c
>  --- ./drivers/md/raid10.c~current~	2004-11-16 16:33:50.000000000 +1100
> +++ ./drivers/md/raid10.c	2004-11-27 11:00:06.000000000 +1100
> @@ -1150,6 +1150,7 @@ static void sync_request_write(mddev_t *
>  		md_sync_acct(conf->mirrors[d].rdev->bdev, tbio->bi_size >> 9);
>  
>  		tbio->bi_sector += conf->mirrors[d].rdev->data_offset;
> +		tbio->bi_bdev = conf->mirrors[d].rdev->bdev;
>  		generic_make_request(tbio);
>  	}
 
Thanks, the adjustments to the bio before the generic_make_request do the trick
nicely.

Note that the version of raid10.c in the current Fedora 3 series does not include
either of the adjustments so the patch required against that version becomes:

diff ./drivers/md/raid10.c~ ./drivers/md/raid10.c
 --- ./drivers/md/raid10.c~	2004-11-16 16:33:50.000000000 +1100
+++ ./drivers/md/raid10.c     2004-11-27 11:00:06.000000000 +1100
@@ -1145,6 +1145,8 @@
                atomic_inc(&r10_bio->remaining);
 		md_sync_acct(conf->mirrors[d].rdev->bdev, tbio->bi_size >> 9);
 
+	       tbio->bi_sector += conf->mirrors[d].rdev->data_offset;
+	       tbio->bi_bdev = conf->mirrors[d].rdev->bdev;
 	 	generic_make_request(tbio);
 	}

Thanks again,

Felix

 

-- 

Whatever you Wanadoo:
http://www.wanadoo.co.uk/time/

This email has been checked for most known viruses - find out more at: http://www.wanadoo.co.uk/help/id/7098.htm
