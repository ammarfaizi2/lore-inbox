Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVDFJv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVDFJv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 05:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVDFJv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 05:51:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15288 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262155AbVDFJvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 05:51:43 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1112765751.3874.14.camel@localhost.localdomain>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1112781070.1981.34.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 06 Apr 2005 10:51:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-04-06 at 06:35, Mingming Cao wrote:

> It seems we are holding the rsv_block while searching the bitmap for a
> free bit.  

Probably something to avoid!

> In alloc_new_reservation(), we first find a available to
> create a reservation window, then we check the bitmap to see if it
> contains any free block. If not, we will search for next available
> window, so on and on. During the whole process we are holding the global
> rsv_lock.  We could, and probably should, avoid that.  Just unlock the
> rsv_lock before the bitmap search and re-grab it after it.  We need to
> make sure that the available space that are still available after we re-
> grab the lock. 

Not necessarily.  As long as the windows remain mutually exclusive in
the rbtree, it doesn't matter too much if we occasionally allocate a
full one --- as long as that case is rare, the worst that happens is
that we fail to allocate from the window and have to repeat the window
reserve.

The difficulty will be in keeping it rare.  What we need to avoid is the
case where multiple tasks need a new window, they all drop the lock,
find the same bits free in the bitmap, then all try to take that
window.  One will succeed, the others will fail; but as the files in
that bit of the disk continue to grow, we risk those processes
*continually* repeating the same stomp-on-each-others'-windows operation
and raising the allocation overhead significantly.

> Another option is to hold that available window before we release the
> rsv_lock, and if there is no free bit inside that window, we will remove
> it from the tree in the next round of searching for next available
> window.

Possible, but not necessarily nice.  If you've got a nearly-full disk,
most bits will be already allocated.  As you scan the bitmaps, it may
take quite a while to find a free bit; do you really want to (a) lock
the whole block group with a temporary window just to do the scan, or
(b) keep allocating multiple smaller windows until you finally find a
free bit?  The former is bad for concurrency if you have multiple tasks
trying to allocate nearby on disk --- you'll force them into different
block groups.  The latter is high overhead.

--Stephen

