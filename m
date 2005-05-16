Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVEPJlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVEPJlH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 05:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVEPJlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 05:41:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14504 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261519AbVEPJkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 05:40:52 -0400
Date: Mon, 16 May 2005 10:40:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Xavier Roche <roche+kml2@exalead.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [XFS] Kernel (2.6.11) deadlock (kernel hang) in user mode when writing data through mmap on large files (64-bit systems)
Message-ID: <20050516094051.GA20828@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Xavier Roche <roche+kml2@exalead.com>, linux-kernel@vger.kernel.org
References: <427F6310.9020709@exalead.com> <4280D292.2030509@exalead.com> <20050510170129.GA1320@infradead.org> <42831F85.1000208@exalead.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42831F85.1000208@exalead.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 11:19:01AM +0200, Xavier Roche wrote:
> It seems that the file was really *badly* fragmented. The reason, as far 
> as we understand the problem, was:
> 
> - a file "truncated" to _expand_ its size (using ftruncate() with a size 
> MUCH larger that the current size, which is == 0), leading to create a 
> "big sparse file" area
> - sequential write in this file (_NOT_ random) using the corresponding 
> mmapp'ed data segment
> - random (!) flush from kswapd leading to allocate fragmented pages 
> (sparse file)

..

> >You're seeing allocation errors where we are trying to realloc that memory
> >block.
> >Could you try the patches that Nikita posted to -mm that should improve
> >this behaviour?
> 
> Well, the reasons seems to clearly be this anormal number fo fragments - 
> is there any potential solution (in the kernel/mm), or the olny solution 
> is a patch to ensure that ftruncate() is replaced by regulars 
> fwrite()-zero calls ?
> 

Yes.  Currently the kernel is doing very badly about clustering these
kinds of allocations.  Can you test whether the patches at:

	http://marc.theaimsgroup.com/?l=linux-mm&m=111375946911468&w=2
	http://marc.theaimsgroup.com/?l=linux-mm&m=111375947014227&w=2
	http://marc.theaimsgroup.com/?l=linux-mm&m=111375947006819&w=2
	http://marc.theaimsgroup.com/?l=linux-mm&m=111375947029723&w=2
	http://marc.theaimsgroup.com/?l=linux-mm&m=111375947010814&w=2
	http://marc.theaimsgroup.com/?l=linux-mm&m=111375990000352&w=2
	http://marc.theaimsgroup.com/?l=linux-mm&m=111375990030384&w=2
	http://marc.theaimsgroup.com/?l=linux-mm&m=111375990032680&w=2
	http://marc.theaimsgroup.com/?l=linux-mm&m=111375990019453&w=2

make any difference to you?

