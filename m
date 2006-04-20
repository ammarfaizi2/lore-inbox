Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWDTKvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWDTKvl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWDTKvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:51:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46623 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750727AbWDTKvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:51:40 -0400
Date: Thu, 20 Apr 2006 12:52:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
       sgunderson@bigfoot.com
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages.
Message-ID: <20060420105209.GC13279@suse.de>
References: <20060420160549.7637.patches@notabene> <1060420062955.7727@suse.de> <20060420003839.1a41c36f.akpm@osdl.org> <17479.21320.361708.237802@cse.unsw.edu.au> <20060420025211.784222d5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420025211.784222d5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20 2006, Andrew Morton wrote:
> >  Does Jens know that?
> > __generic_file_splice_read seems to violate this principle!
> 
> It looks OK from a quick read (but the code duplication is saddening)

Yes, it saddens me too. There really are a bunch of cases to check for
on each page that is shared with do_generic_mapping_read(), I'll see if
I can do something about that.

> > So when I have a cleared head and a bit more time I'll see if I can
> > come up with a better patch which only looks at ->index under
> > ->tree_lock.
> 
> tree_lock will stabilise ->index, yes.
> 
> But I think we'd be OK assuming that ->index is stable.  Although that may
> break if splice() is concurrently pulling the page out of pagecache and
> stuffing it into a pipe.  

Putting the page in the pipe is a simple reference operations. However,
we can migrate a page from a pipe into the page cache in another address
space. If we do that, we will lock the page first though. And the actual
->index change is inside the tree_lock, outside of splice itself.

So with splice migrating pages, ->index and ->mapping can and will
change but only with the page locked.

-- 
Jens Axboe

