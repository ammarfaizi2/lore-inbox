Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVH2XeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVH2XeY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbVH2XeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:34:24 -0400
Received: from mail.intersys.com ([198.133.74.1]:50440 "EHLO
	mail.intersystems.com") by vger.kernel.org with ESMTP
	id S932067AbVH2XeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:34:24 -0400
Message-ID: <43139B62.7010502@intersystems.com>
Date: Mon, 29 Aug 2005 19:33:54 -0400
From: Ray Fucillo <fucillo@intersystems.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Rik van Riel <riel@redhat.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: process creation time increases linearly with shmem
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au> <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com> <430E6FD4.9060102@yahoo.com.au> <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org> <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com> <Pine.LNX.4.58.0508261052330.3317@g5.osdl.org> <Pine.LNX.4.61.0508261917360.8477@goblin.wat.veritas.com> <Pine.LNX.4.63.0508261910080.8057@cuia.boston.redhat.com> <Pine.LNX.4.58.0508261621410.3317@g5.osdl.org> <43108136.1000102@yahoo.com.au> <Pine.LNX.4.61.0508280500450.3323@goblin.wat.veritas.com> <43115E67.1050305@yahoo.com.au>
In-Reply-To: <43115E67.1050305@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> How does the following look? (I changed the comment a bit). Andrew, please
> apply if nobody objects.

Nick, I applied this latest patch to a 2.6.12 kernel and found that it 
does resolve the problem.  Prior to the patch on this machine, I was 
seeing about 23ms spent in fork for ever 100MB of shared memory segment. 
  After applying the patch, fork is taking about 1ms regardless of the 
shared memory size.

Many thanks to everyone for your help on this.

FWIW, an interesting side effect of this occurs when I run the database 
with this patch internally on a Linux server that uses NIS.  Its an 
unrelated problem and not a kernel problem.  Its due to the children 
calling initgroups()...  apparently when you have many processes making 
simultaneous initgroups() calls something starts imposing very long 
waits in increments of 3 seconds, so some processes return from 
initgroups() in a few ms and other processes complete in 3, 6, 9, up to 
21 seconds (plus a few ms).  I'm not sure what the story is with that, 
though its clearly not a kernel issue.  If someone happens to have the 
answer or a suggestion, great, otherwise I'll persue that elsewhere as 
necessary.  (I can reproduce this by simply adding a call to 
initgroups() call in the child of the forktest program that I sent earlier)


