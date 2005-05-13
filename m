Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVEMSUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVEMSUv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbVEMSUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:20:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18874 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262465AbVEMSUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:20:42 -0400
Date: Fri, 13 May 2005 19:20:56 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: James Washer <washer@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, washer@beaverton.ibm.com
Subject: Re: CONFIRMED bug in do_generic_file_read
Message-ID: <20050513182056.GK1150@parcelfarce.linux.theplanet.co.uk>
References: <20050513151744.GH1150@parcelfarce.linux.theplanet.co.uk> <OF77CCCDF4.63E93C67-ON88257000.0060D4EE-88257000.006248F5@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF77CCCDF4.63E93C67-ON88257000.0060D4EE-88257000.006248F5@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 10:55:24AM -0700, James Washer wrote:
> In do_generic_file_read(), when the page is not found, it is created, and 

.. with refcount 1

> __add_to_page_cache() is called, which will in turn call page_cache_get() 
> which gives us a page->count of 1, no?

That would be 2.

> Now, we "goto reapage",  which calls a_op->readpage. If this readpage 
> simply returns an error, without any other actions, we drop  down to the 
> page_cache_release(). Finding the page->count==0, we'll proceed to call 
> __free_page(), which calls __free_pages() which decrements and tests 
> page->count via put_page_testzero(), returning true as page->count is now 
> zero...  and were off to __free_pages_ok() and our panic...
> 
> What did I miss? Forgive me being dense, if I'm missing something here. 
> And thanks again for you help understanding this.

	Think for a minute - we allocate a refcounted object.  That means
getting (the only) reference to it.  That means refcount equal to 1.  It's
a fairly common idiom - not just pages are handled that way.

	What happens is:
* We created a page.  We have a reference to it.
* We put it into cache.  Now there are two ways to reach it - our reference
and global search structure.
* We do ->readpage() - we know that we have a reference, so it's not going
away
* We drop our reference.  That does not affect the presence in cache - it's
not our responsibility anymore.  We are done with this page; if somebody
decides to kick it out of cache, it will be their resposibility to drop the
reference created when putting into cache.
