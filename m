Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262834AbVDHOk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbVDHOk5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 10:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbVDHOk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 10:40:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5586 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262834AbVDHOkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 10:40:51 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 08 Apr 2005 15:40:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2005-04-08 at 00:37, Mingming Cao wrote:

> Actually, we do not have to do an rbtree link and unlink for every
> window we search.  If the reserved window(old) has no free bit and the
> new reservable window's is right after the old one, no need to unlink
> the old window from the rbtree and then link the new window, just update
> the start and end of the old one.

It still needs to be done under locking to prevent us from expanding
over the next window, though.  And having to take and drop a spinlock a
dozen times or more just to find out that there are no usable free
blocks in the current block group is still expensive, even if we're not
actually fully unlinking the window each time.

I wonder if this can possibly be done safely without locking?  It would
be really good if we could rotate windows forward with no global locks. 
At the very least, a fair rwlock would let us freeze the total layout of
the tree, while still letting us modify individual windows safely.  As
long as we use wmb() to make sure that we always extend the end of the
window before we shrink the start of it, I think we could get away with
such shared locking.  And rw locking is much better for concurrency, so
we might be able to hold it over the whole bitmap search rather than
taking it and dropping it at each window advance.

--Stephen

