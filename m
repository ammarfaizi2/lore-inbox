Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWDMWkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWDMWkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 18:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWDMWkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 18:40:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49300 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751072AbWDMWkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 18:40:16 -0400
Date: Thu, 13 Apr 2006 15:40:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Dan Bonachea <bonachead@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
In-Reply-To: <1144965022.12387.23.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604131531440.3701@g5.osdl.org>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu> 
 <20060412214613.404cf49f.akpm@osdl.org> <443DE2BD.1080103@yahoo.com.au> 
 <Pine.LNX.4.64.0604130750240.14565@g5.osdl.org> <1144965022.12387.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Apr 2006, Alan Cox wrote:
> 
> The only serious case historically has been O_APPEND which does have
> pretty precise semantics. Nowdays we also have pread/pwrite which have
> pretty clear semantics and deal with threading. The O_APPEND case is
> very important to get correct and 2.4 certainly did so.

pread/pwrite automatically is safe.

Our O_APPEND handling should be safe - although since we do it at a FS 
level it actually depends on the filesystem itself. Most (all that use the 
generic routines at least) filesystems will get the inode semaphore for 
writing, and do the position handling within that semaphore.

So we follow the specs, but..

> Outside of O_APPEND the specification says only that
> - The write starts at the file position
> - The file position is updated before the syscall returns
> 
> It makes no other guarantee I can see.

Right. I think this is purely a "quality of implementation" issue. We 
already follow the spec, the question is whether we want to be better than 
that.

> As such I belive that the O_APPEND case must be kept locked properly and
> the non O_APPEND cases are already correctly handled by the kernel. That
> seems to argue for f_pos serialization on O_APPEND only.

f_pos doesn't really matter for O_APPEND, since we'll ignore it, and use 
the file size as the position. Which is why the patch I sent out doesn't 
matter (and which is why we already get O_APPEND right - we check the file 
size within the inode semaphore/mutex).

		Linus
