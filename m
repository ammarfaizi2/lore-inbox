Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbVHZRAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbVHZRAv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbVHZRAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:00:51 -0400
Received: from mail.intersys.com ([198.133.74.1]:29446 "EHLO
	mail.intersystems.com") by vger.kernel.org with ESMTP
	id S965112AbVHZRAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:00:50 -0400
Message-ID: <430F4A9E.3060903@intersystems.com>
Date: Fri, 26 Aug 2005 13:00:14 -0400
From: Ray Fucillo <fucillo@intersystems.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au> <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com> <430E6FD4.9060102@yahoo.com.au> <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org> <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com> <430F26AA.80901@yahoo.com.au>
In-Reply-To: <430F26AA.80901@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> OK let's see how Ray goes, and try it when 2.6.14 opens...

Working on that now - I'll let you know.

> Yeah I guess that's a good idea. Patch looks pretty good.
> Just a minor issue with the comment, it is not strictly
> just assuming the child will exec... IMO it is worthwhile
> in Ray's case even if his forked process _eventually_ ends
> up touching all the shared memory pages, it is better to
> avoid many ms of fork overhead.

Yes, in our database system the child will immediately touch some shmem 
pages, and may eventually touch most of them (and would almost never 
exec()).  Fork performance is critical in usage scenarios where an 
end-user database request forks a new server process from one master 
server process.

However, there is still a need that the child, once successfully forked, 
is operational reasonably quickly.  I suspect that Ross's idea of paging 
in everything after the first fault would not be optimal for us, because 
we'd still be talking about hundreds of ms of work done before the child 
does anything useful.  It would still be far better than the behavior we 
have today because that time would no longer be synchronous with the 
fork().  Of course, it sounds like our app might be able to make use of 
the hugetlb stuff can mitigate this problem in the future...
