Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVBRN7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVBRN7i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 08:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVBRN7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 08:59:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39660 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261208AbVBRN7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 08:59:36 -0500
Date: Fri, 18 Feb 2005 14:59:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Philip R Auld <pauld@egenera.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bio refcount problem
Message-ID: <20050218135931.GG4056@suse.de>
References: <20050218125414.GA14362@vienna.egenera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218125414.GA14362@vienna.egenera.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18 2005, Philip R Auld wrote:
> Hi,
> 	I think there are some potential issues with the reference
> counting of bios as used in 2.6.10. The __make_request function 
> which is the default block device routine accesses the bio structure 
> after issuing the call to add_request. This means that the bio could 
> have completed before __make_request uses it. 
> 
> The submit_bh path takes an extra reference with an explicit
> bio_get/put pair around the submit_bio, but many other users of
> submit_bio do not. Given that most of the end_io routines remove a
> reference and hence could free the bio this can lead at the least to 
> __make_request mis-reading the sync flag. In more extreme cases it can 
> cause an oops when run with CONFIG_DEBUG_PAGEALLOC.
> 
> The question is what is the preferred fix? I think it may be to simply
> have submit_bio take its own reference (and remove the extra one from 
> submit_bh).
> 
> Alternatively __make_request could be adjusted so that it does not
> access the bio after calling add_request. All it is doing is checking
> the bi_rw field for the sync bit.
> 
> Or make all users of submit_bio take and release and extra reference
> like submit_bh.

The queue lock is still held at that point, so the driver hasn't had a
chance to process the request yet.

-- 
Jens Axboe

