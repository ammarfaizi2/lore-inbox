Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265961AbRFZJVX>; Tue, 26 Jun 2001 05:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265965AbRFZJVO>; Tue, 26 Jun 2001 05:21:14 -0400
Received: from theseus.mathematik.uni-ulm.de ([134.60.166.2]:54735 "HELO
	theseus.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S265962AbRFZJU7>; Tue, 26 Jun 2001 05:20:59 -0400
Message-ID: <20010626092056.20372.qmail@theseus.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Tue, 26 Jun 2001 11:20:56 +0200
To: linux-kernel@vger.kernel.org
Cc: urban@svenskatest.se
Subject: Re: all processes waiting in TASK_UNINTERRUPTIBLE state
In-Reply-To: <OF7B251945.42FE908D-ON85256A76.004C34E9@pok.ibm.com> <200106251705.MAA02325@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200106251705.MAA02325@ccure.karaya.com>; from jdike@karaya.com on Mon, Jun 25, 2001 at 12:05:14PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2001 at 12:05:14PM -0500, Jeff Dike wrote:
> abali@us.ibm.com said:
> > I am running in to a problem, seemingly a deadlock situation, where
> > almost all the processes end up in the TASK_UNINTERRUPTIBLE state.
> > All the process eventually stop responding, including login shell, no
> > screen updates, keyboard etc.  Can ping and sysrq key works.   I
> > traced the tasks through sysrq-t key.  The processors are in the idle
> > state.  Tasks all seem to get stuck in the __wait_on_page or
> > __lock_page.
> 
> I've seen this under UML, Rik van Riel has seen it on a physical box, and we 
> suspect that they're the same problem (i.e. mine isn't a UML-specific bug).
> 
> I've done some poking at the problem, but haven't really learned anything 
> except that something is locking pages and not unlocking them.  Figuring out 
> who that is was going to be my next step.

Could it be smbfs? The following piece of code from smb_writepage
looks like it could return with the page locked:


      static int
      smb_writepage(struct page *page)
      {

	      /*   ....    */

	      /* easy case */
	      if (page->index < end_index)
		      goto do_it;
	      /* things got complicated... */
	      offset = inode->i_size & (PAGE_CACHE_SIZE-1);
	      /* OK, are we completely out? */
	      if (page->index >= end_index+1 || !offset)
		      return -EIO;           <=====   This looks bad!
      do_it:
	      get_page(page);
	      err = smb_writepage_sync(inode, page, 0, offset);
	      SetPageUptodate(page);
	      UnlockPage(page);
	      put_page(page);
	      return err;
      }


   regards     Christian

-- 
THAT'S ALL FOLKS!
