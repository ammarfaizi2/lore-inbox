Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUIONx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUIONx0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266386AbUIONvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:51:55 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:59841 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266459AbUIONty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:49:54 -0400
Subject: Re: truncate shows non zero data beyond the end of the inode with
	MAP_SHARED
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, an.li.wang@intel.com
In-Reply-To: <20040915122920.GA4454@dualathlon.random>
References: <20040915122920.GA4454@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095252382.19921.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Sep 2004 13:46:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-15 at 13:29, Andrea Arcangeli wrote:
> I've been told we're not posix compliant the way we handle MAP_SHARED
> on the last page of the inode. Basically after we map the page into
> userspace people can make the data beyond the i_size non-zero and we
> should clear it in the transition from page_mapcount 1 -> 0.  The bug
> is that if you truncate-extend, the new data will not be guaranteed to
> be zero.

I've heard this a couple of times but in fact SuS v3 says

--
If the size of the mapped file changes after the call to mmap() as a
result of some other operation on the mapped file, the effect of
references to portions of the mapped region that correspond to added or
removed portions of the file is unspecified.
--

Note it says "after the call to mmap" not after the file size change.

The guarantees it does make are:
- After the mmap completes the bytes in the end area after EOF are zero
- The bytes in question are not written back to the file
  [although a file size change hits the first quoted rule]

Essentially the rule is "don't extend the file on writes to the gap"

BTW: there is no such thing as a useful SuSv3 implementation of mmap
because the documentation contains an error which requires every
reference to the mmapped object cause a bus error 8)



