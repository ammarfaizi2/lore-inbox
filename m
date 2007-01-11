Return-Path: <linux-kernel-owner+w=401wt.eu-S1751416AbXAKTVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbXAKTVB (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXAKTVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:21:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42985 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbXAKTVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:21:00 -0500
Date: Thu, 11 Jan 2007 19:20:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org,
       raisch@de.ibm.com
Subject: Re: [PATCH/RFC 2.6.21 3/5] ehca: completion queue: remove use of do_mmap()
Message-ID: <20070111192056.GB24623@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openfabrics-ewg@openib.org,
	openib-general@openib.org, raisch@de.ibm.com
References: <200701112008.37236.hnguyen@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701112008.37236.hnguyen@linux.vnet.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 08:08:36PM +0100, Hoang-Nam Nguyen wrote:
> Hello Roland and Christoph H.!
> This is a patch for ehca_cq.c. It removes all direct calls of do_mmap()/munmap()
> when creating and destroying a completion queue respectively. 
> Thanks
> Nam

This patch looks good, but there are some issues with the surrounding code:

> +		if (my_cq->ownpid != cur_pid) {
> +			ehca_err(device, "Invalid caller pid=%x ownpid=%x "
> +				 "cq_num=%x",
> +				 cur_pid, my_cq->ownpid, my_cq->cq_number);
> +			return -EINVAL;
> +		}

(for other reviewers: this is not new code, just moved around)

Owner tracking by pid is really dangerous.  File descriptors can be
passed around by unix sockets, a single process can have files open
more than once, etc..

It seems ehca wants to prevent threads other than the creating one
from performing most operations.  Can you explain the reason for this?

>  	spin_lock_irqsave(&ehca_cq_idr_lock, flags);
>  	while (my_cq->nr_callbacks)
>  		yield();

Calling yield is a very bad idea in general.  You should probably
add a waitqueue that gets woken when nr_callbacks reaches zero to
sleep effectively here.

