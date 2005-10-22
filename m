Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbVJVRyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVJVRyn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVJVRyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:54:43 -0400
Received: from [81.2.110.250] ([81.2.110.250]:58064 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750747AbVJVRym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:54:42 -0400
Subject: Re: BUG in the block layer (partial reads not reported)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jens Axboe <axboe@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0510221117160.3707-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.0510221117160.3707-100000@netrider.rowland.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 22 Oct 2005 19:23:10 +0100
Message-Id: <1130005390.15961.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-10-22 at 11:40 -0400, Alan Stern wrote:
> 	Handling an error somewhere in the middle of the medium, and
> 
> 	Handling an error beyond the real end of the medium.
> 
> The mm and block subsystems have no way at all to retrieve partial data
> for the first case.  Even though only one hardware sector may be bad,

The block layer can handle this at the bottom level but the caches above
it cannot. 

> failure to read an entire page means that none of the good sectors on that
> page will be accessible.  While annoying, it's understandable and I don't 
> see any simple way to accomodate such partial reads.

Agreed it is hairy with things like mmap. One way is to use raw I/O and
disable readahead.

> The second case appears to be more tractable, as you said.  In fact,
> do_generic_mapping_read() in mm/filemap.c will recheck the inode's size
> after a successful read, to avoid copying data beyond the end of the
> device.
> 
> Could part of the problem also be that the set_capacity() call, used to
> revise the device size downward when the CD driver realizes it is smaller
> than originally thought, doesn't update the inode?  Should the driver call
> bd_set_size() as well?  (In addition to completing the read successfully
> with garbage data beyond the actual EOF.)

Beats me. Perhaps Jens can enlighten us and I can improve the ide-cd
driver code further as well.

