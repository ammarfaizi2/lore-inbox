Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751606AbWJMH4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbWJMH4U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 03:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWJMH4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 03:56:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12012 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751606AbWJMH4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 03:56:19 -0400
Date: Fri, 13 Oct 2006 09:56:14 +0200
From: Jan Kara <jack@suse.cz>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Eric Sandeen <esandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Eric Sandeen <sandeen@sandeen.net>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
Message-ID: <20061013075613.GB29170@atrey.karlin.mff.cuni.cz>
References: <452C4C47.2000107@sandeen.net> <20061011103325.GC6865@atrey.karlin.mff.cuni.cz> <452CF523.5090708@sandeen.net> <20061011142205.GB24508@atrey.karlin.mff.cuni.cz> <1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com> <452DAA26.6080200@redhat.com> <20061012122820.GK9495@atrey.karlin.mff.cuni.cz> <20061012094036.e1a3f9f1.akpm@osdl.org> <452EA06F.4060701@redhat.com> <452EB9C5.4000404@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452EB9C5.4000404@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Eric Sandeen wrote:
> >Andrew Morton wrote:
> >
> >  
> >>On Thu, 12 Oct 2006 14:28:20 +0200
> >>Jan Kara <jack@suse.cz> wrote:
> >>
> >>  
> >>    
> >>>Where can we call
> >>>journal_dirty_data() without PageLock?
> >>>    
> >>>      
> >>block_write_full_page() will unlock the page, so ext3_writepage()
> >>will run journal_dirty_data_fn() against an unlocked page.
> >>
> >>I haven't looked into the exact details of the race, but it should
> >>be addressable via jbd_lock_bh_state() or j_list_lock coverage
> >>    
> >I'm testing with something like this now; seem sane?
> >
> >journal_dirty_data & journal_unmap_data both check do 
> >jbd_lock_bh_state(bh) close to the top... journal_dirty_data_fn has 
> >checked buffer_mapped before getting into journal_dirty_data, but that 
> >state may
> >change before the lock is grabbed.  Similarly re-check after we drop the 
> >lock.
> >
> >  
> This is exactly  the solution I proposed earlier (to check 
> buffer_mapped() before calling submit_bh()).
> But at that time, Jan pointed out that the whole handling is wrong.
  Yes, and it was. However it turned out that there are more problems
than I thought ;).

> But if this is the only case we need to handle, I am okay with this band 
> aid :)
  I think Eric's patch may be a part of it. But we still need to check whether
the buffer is not after EOF before submitting it (or better said just
after we manage to lock the buffer). Because while we are waiting for
the buffer lock, journal_unmap_buffer() can still come and steal the
buffer - at least the write-out in journal_dirty_data() definitely needs
the check if I haven't overlooked something.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
