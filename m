Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264355AbUEIPgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264355AbUEIPgd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 11:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbUEIPgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 11:36:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:58779 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264357AbUEIPgT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 11:36:19 -0400
Date: Sun, 9 May 2004 21:03:16 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, wli@holomorphy.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: dentry bloat.
Message-ID: <20040509153316.GE4007@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org> <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org> <20040508204239.GB6383@in.ibm.com> <409DDDAE.3090700@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409DDDAE.3090700@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 09:28:46AM +0200, Manfred Spraul wrote:
> What's the prupose of d_move_count?
> AFAICS it protects against a double rename: first to different bucket, 
> then back to original bucket. This changes the position of the dentry in 
> the hash chain and a concurrent lookup would skip entries.
> d_lock wouldn't prevent that.

Actually, what may happen is that since the dentries are added
in the front, a double move like that would result in hash chain
traversal looping. Timing dependent and unlikely, but d_move_count
avoided that theoritical possibility. It is not about skipping
dentries which is safe because a miss would result in a real_lookup()
anyway. If we do the comparison within d_lock, then atleast
we are guaranteed to get the right file. The remaining question
is whether we violate POSIX rename semantics in some twisted way.


> But I think d_bucket could be removed: for __d_lookup the test appears 
> to be redundant with the d_move_count test. The remaining users are not 
> performance critical, they could recalculate the bucket from d_parent 
> and d_name.hash.

Yes, afaics, d_move_count can effectively be used to work around
the possibility of the dentry moving to a different hash bucket.

Thanks
Dipankar
