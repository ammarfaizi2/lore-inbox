Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVBRMya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVBRMya (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 07:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVBRMya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 07:54:30 -0500
Received: from roadrunner-base.egenera.com ([63.160.166.46]:17382 "EHLO
	coyote.egenera.com") by vger.kernel.org with ESMTP id S261352AbVBRMyZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 07:54:25 -0500
Date: Fri, 18 Feb 2005 07:54:14 -0500
From: Philip R Auld <pauld@egenera.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: bio refcount problem
Message-ID: <20050218125414.GA14362@vienna.egenera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I think there are some potential issues with the reference
counting of bios as used in 2.6.10. The __make_request function 
which is the default block device routine accesses the bio structure 
after issuing the call to add_request. This means that the bio could 
have completed before __make_request uses it. 

The submit_bh path takes an extra reference with an explicit
bio_get/put pair around the submit_bio, but many other users of
submit_bio do not. Given that most of the end_io routines remove a
reference and hence could free the bio this can lead at the least to 
__make_request mis-reading the sync flag. In more extreme cases it can 
cause an oops when run with CONFIG_DEBUG_PAGEALLOC.

The question is what is the preferred fix? I think it may be to simply
have submit_bio take its own reference (and remove the extra one from 
submit_bh).

Alternatively __make_request could be adjusted so that it does not
access the bio after calling add_request. All it is doing is checking
the bi_rw field for the sync bit.

Or make all users of submit_bio take and release and extra reference
like submit_bh.

Thoughts?


Cheers,

Phil


-- 
Philip R. Auld, Ph.D.  	        	       Egenera, Inc.    
Software Architect                            165 Forest St.
(508) 858-2628                            Marlboro, MA 01752
