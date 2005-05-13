Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVEMPRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVEMPRo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 11:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVEMPRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 11:17:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56477 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262405AbVEMPRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 11:17:32 -0400
Date: Fri, 13 May 2005 16:17:44 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: James Washer <washer@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, washer@beaverton.ibm.com
Subject: Re: CONFIRMED bug in do_generic_file_read
Message-ID: <20050513151744.GH1150@parcelfarce.linux.theplanet.co.uk>
References: <20050513075743.GG1150@parcelfarce.linux.theplanet.co.uk> <OFF1B70B69.DFDD4B59-ON88257000.004A3F64-88257000.004B2949@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF1B70B69.DFDD4B59-ON88257000.004A3F64-88257000.004B2949@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 06:42:50AM -0700, James Washer wrote:
> Al, relax.. as I said, I don't know much about page cache code. 
> 
> So, let me ask a question, if I can, with out upsetting you further.
> 
> You say the analysis is, ah, incorrect.
> 
> Can you help me understand what a readpage routine SHOULD do with a page 
> when it finds it cannot "arrange" a successful read? Is simply returning 
> an error incorrect behaviour? If so, what should the readpage do?

It is a perfectly acceptable behaviour.  And it works just fine - e.g.
nfs_readpage() does that in quite a few cases.

What you are missing is the fact that page_cache_release() frees the
page only when it drops the final reference.  And pages are pinned
down while they are in page cache.

If you see page_cache_release() right after ->readpage() triggering that
check, you've got out of ->readpage() with
	* only one reference to page remaining
	* one reference to that page acquired earlier in do_generic_file_read()
and not dropped until now.
	* one reference to that page acquired back when it had been put
in page cache.  Matching page_cache_release() would be done when page
is removed from page cache, but places that do it would remove the page
from cache first.  Which would set ->mapping to NULL.

Conclusion: something had done an unbalanced page_cache_release().  That
happened after the moment when do_generic_file_read() had found the page
and pinned it down and before the end of ->readpage().  Most likely -
->readpage() itself or something called by it.
the page, but
