Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264949AbUEVJii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUEVJii (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 05:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265202AbUEVJii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 05:38:38 -0400
Received: from canuck.infradead.org ([205.233.217.7]:43270 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S264949AbUEVJig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 05:38:36 -0400
Date: Sat, 22 May 2004 05:38:30 -0400
From: hch@infradead.org
To: Andrew Morton <akpm@osdl.org>, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
Message-ID: <20040522093830.GA3532@infradead.org>
Mail-Followup-To: hch@infradead.org, Andrew Morton <akpm@osdl.org>,
	axboe@suse.de, linux-kernel@vger.kernel.org
References: <20040522013636.61efef73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522013636.61efef73.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +disk-barrier-core.patch
> +disk-barrier-core-tweaks.patch
> +disk-barrier-ide.patch
> +disk-barrier-ide-symbol-expoprt.patch
> +disk-barrier-ide-warning-fix.patch
> +disk-barrier-scsi.patch
> 
>  Support for IDE and SCSI barriers
> 
> +disk-barrier-dm.patch
> +disk-barrier-md.patch
> 
>  Via device mapper and raid as well.

Some comments on the API and the SCSI part:

 - issue_flush_fn prototype choice is bad, the request_queue_t argument
   wile always be disk->queue so it's not needed and only causes
   confusion.
 - issue_flush sounds a little strange to me, what about cache_flush
   or sync_cache instead?
 - scsi_drive.issue_flush should take a scsi_device * as first parameter,
   not struct device * - makes life for bother caller and callee easier.
 - should probably add a small helper to get the scsi_driver from the
   gendisk instead of duplicating the code, ala:

static inline struct scsi_driver *scsi_disk_driver(struct gendisk *disk)
{
	return *(struct scsi_driver **) disk->private_data;
}

 - the WCE check should move into sd_sync_cache
 - NULL scsi_disk can't happen for sd_issue_flush, no need to check,
   and thus the disctinction of sd_issue_flush vs sd_sync_cache can
   go and sd_shutdown can simply call the cache flush method.
