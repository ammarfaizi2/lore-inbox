Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161234AbWALUGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161234AbWALUGh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161238AbWALUGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:06:36 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:44188 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161234AbWALUGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:06:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=BCYhoECEK/zo9n8QcpKE4/I3MvSMssRSJiTDV6fzFl854wLt67TVbY+FJ/VUHu7S59T5YBEJ+GV+lSXNZPxWJUblnscv07+c+sAOdiA6pKf9vMjkJ70wbeq4G/R/0c98ENV9BSSEjVLvRYN1dpVI+Qw7HXu1NviTTYcxrveVpbc=
Date: Thu, 12 Jan 2006 23:23:41 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Subject: Lockups while unpacking huge tarballs (was Re: 2.6.15-$SHA1: VT <-> X sometimes odd)
Message-ID: <20060112202341.GA7913@mipter.zuzino.mipt.ru>
References: <20060110162305.GA7886@mipter.zuzino.mipt.ru> <43C4F114.9070308@gmail.com> <20060111153822.GA7879@mipter.zuzino.mipt.ru> <20060112192856.GA7938@mipter.zuzino.mipt.ru> <Pine.LNX.4.64.0601121119100.3535@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601121119100.3535@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 11:23:54AM -0800, Linus Torvalds wrote:
> On Thu, 12 Jan 2006, Alexey Dobriyan wrote:
> > Now it's vim saving 5k proggie while X tarball was unpacking on reiserfs.
> > :wq and vim freezes. Switching to another virtual "desktops" works and
> > everything in general works except vim. But switching to VT and back
> > sends system to hell.
>
> This may be fixed by the current -git tree:
>
> 	commit 1bc691d3, Tejun Heo <htejun@gmail.com>:
>
> 	[PATCH] fix queue stalling while barrier sequencing

It isn't. My HEAD is 9f5974c8734d83d4ab7096ed98136a82f41210d6 and I see
this patch in git log output.

> or if that isn't it, and you have an IDE drive, can you try if the
> appended trivial patch makes a difference?

> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -101,7 +101,7 @@ int __ide_end_request(ide_drive_t *drive
>  	 * for those
>  	 */
>  	nbytes = nr_sectors << 9;
> -	if (!rq->errors && rq_all_done(rq, nbytes)) {
> +	if (0 && !rq->errors && rq_all_done(rq, nbytes)) {
>  		rq->data_len = nbytes;
>  		blkdev_dequeue_request(rq);
>  		HWGROUP(drive)->rq = NULL;

With this one-liner two X tarballs and one Firefox tarballs were
successfully unpacked while I was hitting :w.

Without it just one X tarball doesn't pass. It's even reproducable.

