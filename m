Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263644AbUD0BMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263644AbUD0BMn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 21:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUD0BMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 21:12:43 -0400
Received: from web12824.mail.yahoo.com ([216.136.174.205]:58534 "HELO
	web12824.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263644AbUD0BMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 21:12:38 -0400
Message-ID: <20040427011237.33342.qmail@web12824.mail.yahoo.com>
Date: Mon, 26 Apr 2004 18:12:37 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page writeback
To: Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

During page reclamation when the scanner encounters a
dirty page and invokes writepage(), if the FS layer
returns WRITEPAGE_ACTIVATE as NFS does, I think the
page should not be placed on the active as is
presently done.  This can cause a lot of extraneous
swapout activity because in the presence of a large
active list, the pages being written out will not be
reclaimed quickly enough.  It also seems counter
intuitive since the scanner has just determined that
the page has not been recently referenced.

Shouldn't the following code from shrink_list():

res = mapping->a_ops->writepage(page, &wbc);
if (res < 0)
	handle_write_error(mapping, page, res);
if (res == WRITEPAGE_ACTIVATE) {
	ClearPageReclaim(page);
	goto activate_locked;
}

read:

res = mapping->a_ops->writepage(page, &wbc);
if (res < 0)
	handle_write_error(mapping, page, res);
if (res == WRITEPAGE_ACTIVATE) {
	ClearPageReclaim(page);
	goto keep_locked;
}

I can observe the benefit of this change if I run a dd
on an NFS mount with the active list full of mostly
mapped pages.  The stock kernel ends up paging out
quite a bit of memory whereas the modified kernel does
not.

Comments?

Thanks,
Shantanu



	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
