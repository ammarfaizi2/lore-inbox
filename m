Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbUDYQvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUDYQvJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 12:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUDYQvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 12:51:09 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:60594 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263166AbUDYQvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 12:51:06 -0400
Date: Sun, 25 Apr 2004 17:50:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: CaT <cat@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm4 tmpfs, free and free memory reporting
In-Reply-To: <20040425130338.GB2011@zip.com.au>
Message-ID: <Pine.LNX.4.44.0404251737200.13626-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Apr 2004, CaT wrote:
> I noticed that the OoM killer was being rather brutal to my tasks
> even though free was reporting that I had 150meg of ram left. It wasn't
> until much later that I realise that I have tmpfs being used as /tmp
> and I checked that. Once I cleaned that up a big all was well. The
> hassle was, the memory used by tmpfs was being reported as being used
> by the cache. That may be so internally but shouldn't it be reported
> as actually used ram as it cannot be dumped for processes like a normal
> disk cache can and therefore cannot be considered to be 'free' ram.

If you have swap enabled (do you?) then tmpfs pages get written out
to swap under memory pressure, and so it is like normal disk cache.  

If you don't have swap enabled, yes, there's nowhere else for it to
go; but I'd say perhaps you were then unwise to allow so much of your
memory to be used for tmpfs mounts - not been bumping up that nice
size=50% have you ;-?

But there's certainly scope for suspicion, as to whether the vmscan
algorithms deal effectively with sending tmpfs to swap.  Should
page_mapping_inuse be so reluctant to write out tmpfs swap?  Should
shmem_writepage call swap_writepage directly instead of giving tmpfs
pages another go around the lists?  (Andrea recently found 2.4 cases
which convinced him it should call swap_writepage directly.)

We've made no change in the face of those doubts because nobody was
complaining of current behaviour; and it makes some sense to be a
little reluctant to swap out tmpfs pages - it is supposed to be a
ram-based filesystem, after all.  But if complaints do accumulate,
let's look into changing some decisions there.

Hugh

