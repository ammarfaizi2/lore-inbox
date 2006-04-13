Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWDMVl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWDMVl3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 17:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWDMVl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 17:41:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20634 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964979AbWDMVl2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 17:41:28 -0400
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Dan Bonachea <bonachead@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604130750240.14565@g5.osdl.org>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
	 <20060412214613.404cf49f.akpm@osdl.org> <443DE2BD.1080103@yahoo.com.au>
	 <Pine.LNX.4.64.0604130750240.14565@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Apr 2006 22:50:22 +0100
Message-Id: <1144965022.12387.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-04-13 at 08:01 -0700, Linus Torvalds wrote:
> That said, I wouldn't be 100% against it, especially under certain 
> circumstances. However, the circumstances when I think it might be 
> acceptable are fairly specific:
> 
>  - when we use f_pos (ie we'd synchronize write against write, but only 
>    per "struct file", not on an inode basis)
>  - only for files that are marked seekable with FMODE_LSEEK (thus avoiding 
>    the stream-like objects like pipes and sockets)
> 
> Under those two circumstances, I'd certainly be ok with it, and I think we 
> could argue that it is a "good thing". It would be a "f_pos" lock (so we 
> migt do it for reads too), not a "data lock".

The only serious case historically has been O_APPEND which does have
pretty precise semantics. Nowdays we also have pread/pwrite which have
pretty clear semantics and deal with threading. The O_APPEND case is
very important to get correct and 2.4 certainly did so.


Looking at the spec it says the following

"If the O_APPEND flag of the file status flags is set, the file offset
shall be set to the end of the file prior to each write and no
intervening file modification operation shall occur between changing the
file offset and the write operation."

This is what 2.4 took great paints to guarantee for file writes. Now in
actual fact no OS I know of implements this to the extreme (mmap) but
does for the other cases.

Outside of O_APPEND the specification says only that
- The write starts at the file position
- The file position is updated before the syscall returns

It makes no other guarantee I can see.


As such I belive that the O_APPEND case must be kept locked properly and
the non O_APPEND cases are already correctly handled by the kernel. That
seems to argue for f_pos serialization on O_APPEND only.

Alan








