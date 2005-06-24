Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263226AbVFXI0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbVFXI0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 04:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbVFXI0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 04:26:15 -0400
Received: from holomorphy.com ([66.93.40.71]:28093 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263226AbVFXIY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 04:24:59 -0400
Date: Fri, 24 Jun 2005 01:24:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       hugh@veritas.com, pbadari@us.ibm.com, linux-scsi@vger.kernel.org
Subject: Re: [patch][rfc] 5/5: core remove PageReserved
Message-ID: <20050624082432.GF3334@holomorphy.com>
References: <42BA5F37.6070405@yahoo.com.au> <42BA5F5C.3080101@yahoo.com.au> <42BA5F7B.30904@yahoo.com.au> <42BA5FA8.7080905@yahoo.com.au> <42BA5FC8.9020501@yahoo.com.au> <42BA5FE8.2060207@yahoo.com.au> <20050623095153.GB3334@holomorphy.com> <20050623215011.0b1e6ef2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623215011.0b1e6ef2.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>>  An answer should be devised for this. My numerous SCSI CD-ROM devices
>>  (I have 5 across several different machines of several different arches)
>>  are rather unlikely to be happy with /* FIXME: XXX ... as an answer.
[...]
>>  Mutatis mutandis for my SCSI tape drive.

On Thu, Jun 23, 2005 at 09:50:11PM -0700, Andrew Morton wrote:
> This scsi code is already rather wrong.  There isn't much point in just
> setting PG_dirty and leaving the page marked as clean in the radix tree. 
> As it is we'll lose data if the user reads it into a MAP_SHARED memory
> buffer.
> set_page_dirty_lock() should be used here.  That can sleep.
> The above two functions are called under write_lock_irqsave() (at least)
> and might be called from irq context (dunno).  So we cannot use
> set_page_dirty_lock() and we don't have a ref on the page's inode.  We
> could use set_page_dirty() and be racy against page reclaim.
> But to get all this correct (and it's very incorrect now) we'd need to punt
> the page dirtying up to process context, along the lines of
> bio_check_pages_dirty().
> Or, if st_unmap_user_pages() and sgl_unmap_user_pages() are not called from
> irq context then we should arrange for them to be called without locks held
> and use set_page_dirty_lock().

This all sounds very reasonable. I was originally more concerned about
the new FIXME getting introduced but this sounds like a good way to
resolve the preexisting FIXME's surrounding all this.


-- wli
