Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752138AbWCNEOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbWCNEOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 23:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbWCNEOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 23:14:49 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:14427 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752138AbWCNEOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 23:14:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ZlGGDvU3YUG1z8rfzbJxygtH1Z5/vc1TYVIY0vABHEAX5H7vH7ccZ0dCtt6h501tu6Vhz+ZZwemydCIvJObG6qltdUa/QMreREpshbPJS+fKuz0x0HwZeu0dMEyahgXxlP+o3PGolX+J3PUL28we2E3f0bKEqKQ9r24KI1I2iQQ=  ;
Message-ID: <4416432E.1050904@yahoo.com.au>
Date: Tue, 14 Mar 2006 15:14:38 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Nick Piggin <npiggin@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: A lockless pagecache for Linux
References: <20060207021822.10002.30448.sendpatchset@linux.site> <Pine.LNX.4.64.0603131528180.13687@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0603131528180.13687@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Fri, 10 Mar 2006, Nick Piggin wrote:
> 
> 
>>I'm writing some stuff about these patches, and I've uploaded a
>>**draft** chapter on the RCU radix-tree, 'radix-intro.pdf' in above
>>directory (note the bibliography didn't make it -- but thanks Paul
>>McKenney!)
> 
> 
> Ah thanks. I had a look at it. Note that the problem with the radix tree 
> tags is that these are inherited from the lower layer. How is the 
> consistency of these guaranteed? Also you may want to add a more elaborate 
> intro and conclusion. Typically these summarize other sections of the 
> paper.
> 

Thanks for looking at it. Yeah in the intro I say that I'm considering
a simplified radix-tree (without tags or gang lookups) to start with.
At the end I say how tags are handled... it isn't quite clear enough
for my liking yet though.

Intro and conclusion - yes they should be better. It _is_ a chapter from
a larger document, however I want it to still stand alone as a good
document.

What happens is: read-side tag operations (ie. tag lookups etc) are done
under lock. Ie. they are not made lockless.

> What you are proposing is to allow lockless read operations right? No 
> lockless write? The concurrency issue that we currently have is multiple 
> processes faulting in pages in different ranges from the same file. I 
> think this is a rather typical usage scenario. Faulting in a page from a 
> file for reading requires a write operation on the radix tree. The 
> approach with a lockless read path does not help us. This proposed scheme 
> would only help if pages are already faulted in and another process starts
> using the same pages as an earlier process.
> 

Yep, lockless reads only to start with. I think you'll see some benefit
because the read(2) and ->nopage paths also take read-side locks, so your
write side will no longer have to contend with them.

It won't be a huge improvement in scalability though, maybe just a constant
factor.

> Would it not be better to handle the radix tree in the same way as a page 
> table? Have a lock at the lowest layer so that different sections of the 
> radix tree can be locked by different processes? That would enable 
> concurrent writes.
> 

Yeah this is the next step. Note that it is not the first step because I
actually want to _speed up_ single threaded lookup paths, rather than
slowing them down, otherwise it will never get accepted.

It also might add quite a large amount of complexity to the radix tree, so
it may no longer be suitable for a generic data structure anymore (depends
how it is implemented). But the write side should be easier than the
read-side so I don't think there is too much to worry about. I already have
some bits and pieces to make it fine-grained.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
