Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264959AbUGBWFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbUGBWFl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 18:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUGBWFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 18:05:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:31891 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264959AbUGBWFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 18:05:38 -0400
Date: Fri, 2 Jul 2004 15:08:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
Message-Id: <20040702150819.646b6103.akpm@osdl.org>
In-Reply-To: <m2u0wqqdpl.fsf@telia.com>
References: <m2lli36ec9.fsf@telia.com>
	<m2u0wqqdpl.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> This code leaks a module reference. The patch below fixes it. I'm not
> sure it's correct, but do_open() also does module_put() after
> put_disk().
> 
> Signed-off-by: Peter Osterlund <petero2@telia.com>
> 
> ---
> 
>  linux-petero/fs/partitions/check.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -puN fs/partitions/check.c~packet-refcnt fs/partitions/check.c
> --- linux/fs/partitions/check.c~packet-refcnt	2004-07-02 23:18:22.000000000 +0200
> +++ linux-petero/fs/partitions/check.c	2004-07-02 23:18:23.000000000 +0200
> @@ -151,6 +151,7 @@ const char *__bdevname(dev_t dev, char *
>  	if (disk) {
>  		buffer = disk_name(disk, part, buffer);
>  		put_disk(disk);
> +		module_put(disk->fops->owner);
>  	} else {
>  		snprintf(buffer, BDEVNAME_SIZE, "unknown-block(%u,%u)",
>  				MAJOR(dev), MINOR(dev));

Yes, there's certainly a leak there.  It's surprising that it hasn't been
noted before.

But:

const char *__bdevname(dev_t dev, char *buffer)
{
	struct gendisk *disk;
	int part;

	disk = get_gendisk(dev, &part);
	if (disk) {
		buffer = disk_name(disk, part, buffer);
		put_disk(disk);
	} else {
		snprintf(buffer, BDEVNAME_SIZE, "unknown-block(%u,%u)",
				MAJOR(dev), MINOR(dev));
	}

get_gendisk() did an internal module_get() in kobj_lookup().  It would seem
to be logical that the module_put() should be in kobject_put(), called from
put_disk().  But surely if we made that change 1000 things would explode.

Greg, Al?

