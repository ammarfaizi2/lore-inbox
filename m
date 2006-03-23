Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWCWQv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWCWQv6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWCWQv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:51:58 -0500
Received: from relay04.roc.ny.frontiernet.net ([66.133.182.167]:18644 "EHLO
	relay04.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S1751351AbWCWQv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:51:56 -0500
From: Bryan Holty <lgeek@frontiernet.net>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] scsi: properly count the number of pages in scsi_req_map_sg()
Date: Thu, 23 Mar 2006 10:51:51 -0600
User-Agent: KMail/1.9.1
Cc: Dan Aloni <da-x@monatomic.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, brking@us.ibm.com,
       dror@xiv.co.il
References: <20060321083830.GA2364@localdomain> <20060321161912.GA32051@localdomain> <20060323145203.GA13637@infradead.org>
In-Reply-To: <20060323145203.GA13637@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603231051.51519.lgeek@frontiernet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 08:52, Christoph Hellwig wrote:
> On Tue, Mar 21, 2006 at 06:19:12PM +0200, Dan Aloni wrote:
> > These scatterlists can be generated using the sg driver. Though I am
> > actually running a customized version of the sg driver, it seems the
> > conversion from a userspace array of sg_iovec_t to scatterlist stays
> > the same and also applies to the original driver (see
> > st_map_user_pages()).
>
> What kernel version did you reproduce this with?  Since 2.6.16 sg should
> obey all request size/alingment limitations.  If not that's a bug in
> scsi_execute_async and it's helpers and should be fixed there.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I am able to reproduce this with 2.6.16-rc5 - 2.6.16.  There is a problem in 
scsi_req_map_sg which is called by scsi_execute_async.

Currently, scsi_req_map_sg assumes every sgl entry is page aligned.  It will 
cause later slab corruption by under-allocating the number of bio entries if 
sgl[0].offset + sgl[last].length > PAGE_SIZE.

Dan pointed this out, and I have submitted a patch that I believe correctly 
fixes the issue.  Just waiting for some feedback.

--
 Bryan Holty
