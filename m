Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWAWTaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWAWTaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWAWTaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:30:30 -0500
Received: from kanga.kvack.org ([66.96.29.28]:50826 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932110AbWAWTa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:30:29 -0500
Date: Mon, 23 Jan 2006 14:26:06 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Valdis.Kletnieks@vt.edu
Cc: Al Boldi <a1426z@gawab.com>, Robin Holt <holt@sgi.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <20060123192606.GH1008@kvack.org>
References: <200601212108.41269.a1426z@gawab.com> <20060122123335.GB26683@lnx-holt.americas.sgi.com> <200601232103.07007.a1426z@gawab.com> <200601231840.k0NIelbp017964@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601231840.k0NIelbp017964@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 01:40:46PM -0500, Valdis.Kletnieks@vt.edu wrote:
> A process does a "read(foo, &buffer, 65536);".  buffer is declared as 16
> contiguous 4K pages, none of which are currently in memory.  How many pages do
> you have to read in, and at what point do you issue the I/O? (hint - work this
> problem for a device that's likely to return 64K of data, and again for a
> device that has a high chance of only returning 2K of data.....)

Actually, that is something that the vm could optimize out of the picture 
entirely -- it is a question of whether it is worth the added complexity 
to handle such a case.  copy_to_user already takes a slow path when it hits 
the page fault (we do a lookup on the exception handler already) and could 
test if an entire page is being overwritten, and if so proceed to destroy 
the old mapping and use a fresh page from ram.

That said, for the swap case, it probably happens so rarely that the extra 
code isn't worth it.  glibc is already using mmap() in place of read() for 
quite a few apps, so I'm not sure how much low hanging fruit there is left.  
If someone has an app that's read() heavy, it is probably easier to convert 
it to mmap() -- the exception being pipes and sockets which can't.  We need 
numbers. =-)

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
