Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131163AbQLHWyT>; Fri, 8 Dec 2000 17:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131803AbQLHWyJ>; Fri, 8 Dec 2000 17:54:09 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:40034 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131163AbQLHWx6>; Fri, 8 Dec 2000 17:53:58 -0500
Message-ID: <3A315F23.6110A7CD@sgi.com>
Date: Fri, 08 Dec 2000 14:22:27 -0800
From: Rajagopal Ananthanarayanan <ananth@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-4SGI_20smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7
In-Reply-To: <90rjbg$8eso1$1@fido.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 8 Dec 2000, Daniel Phillips wrote:
> >
> > [ flush-buffers taking the page lock ]
> >
> > This is great when you have buffersize==pagesize.  When there are
> > multiple buffers per page it means that some of the buffers might have
> > to wait for flushing just because bdflush started IO on some other
> > buffer on the same page.  Oh well.  The common case improves in terms
> > being proveably correct and the uncommon case gets worse a tiny bit.
> > It sounds like a win.
> 
> Also, I think that we should strive for a setup where most of the dirty
> buffer flushing is done through "page_launder()" instead of using
> sync_buffers all that much at all.
> 
> I'm convinced that the page LRU list is as least as good as, if not better
> than, the dirty buffer timestamp stuff. And as we need to have the page
> LRU for other reasons anyway, I'd like the long-range plan to be to get
> rid of the buffer LRU completely. It wastes memory and increases
> complexity for very little gain, I think.
> 

I think flushing pages instead of buffers is a good direction to take.
Two things:

1. currently bdflush is setup to use page_launder only
   under memory pressure (if (free_shortage() ... )
   Do you think that it should call page_launder regardless?

2. There are two operations here:
	a. starting a write-back, periodically.
        b. freeing a page, which may involve taking the page
            out of a inode mapping, etc. IOW, what page_launder does.
   bdflush primarily does (a). If we want to move to page-oriented
   flushing, we atleast need extra information in the _page_ structure
   as to whether it is time to flush the page back.


--------------------------------------------------------------------------
Rajagopal Ananthanarayanan ("ananth")
Member Technical Staff, SGI.
--------------------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
