Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVANXtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVANXtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVANXtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:49:03 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:48622 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262031AbVANXs6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 18:48:58 -0500
Date: Fri, 14 Jan 2005 15:48:17 -0800
From: Greg KH <greg@kroah.com>
To: Robert Wisniewski <bob@watson.ibm.com>
Cc: trz@us.ibm.com, karim@opersys.com, richardj_moore@uk.ibm.com,
       michel.dagenais@polymtl.ca, linux-kernel@vger.kernel.org,
       ltt-dev@shafik.org
Subject: Re: [PATCH 3/4] relayfs for 2.6.10: locking/lockless implementation
Message-ID: <20050114234817.GA6786@kroah.com>
References: <16872.19899.179380.51583@kix.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16872.19899.179380.51583@kix.watson.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

On Fri, Jan 14, 2005 at 05:57:21PM -0500, Robert Wisniewski wrote:
> Greg,
>      There are a couple variables used throughout relayfs code that could
> be modified at any point "simultaneously" by different processes.  These
> variables were not declared volatile, thus when we modify them we need to
> tell the compiler to refetch from memory as another process could have
> changed out from under the current stream of execution since the last time
> there were accessed in the function.  An alternative would be to mark the
> variables that we care about as volatile.

marking them volatile does not protect across cpus.  Just using a normal
atomic_t will work properly.

> I am not sure how best to make
> that tradeoff (i.e., always forcing a refetch by marking a variable
> volatile or only at points were we know we need to by memory clobbering) or
> on what side the Linux community comes down on.  We certainly would be
> happy to go either way with the relayfs code, i.e., mark them variable and
> used the standard atomic operations.

Just use atomic_t and don't mess with volatile.  See the archives for
why that (volatile) doesn't work like that.

> That explains compare_and_store, atomic_add, and atomic_sub.

No it doesn't, why do your own version of this function with the
barrier() function?

> It does not explain the memory clobbering around the atomic set
> operation, which I'm guessing was there just to be consistent with the
> other operations, and could, I believe, be removed.  Hopefully that
> helps answer the question.  If it doesn't please feel free to ask
> more.  Thanks.

So these can just be removed, and the code changed to use the proper
atomic calls?  If so, please do so.

thanks,

greg k-h
