Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWDMXT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWDMXT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWDMXT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:19:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35744 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932090AbWDMXTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:19:25 -0400
Date: Thu, 13 Apr 2006 16:19:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dan Bonachea <bonachead@comcast.net>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
In-Reply-To: <1144969908.12387.39.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604131612000.3701@g5.osdl.org>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu> 
 <20060412214613.404cf49f.akpm@osdl.org> <443DE2BD.1080103@yahoo.com.au> 
 <Pine.LNX.4.64.0604130750240.14565@g5.osdl.org>  <1144965022.12387.23.camel@localhost.localdomain>
  <6.2.5.6.2.20060413145913.03436f38@comcast.net> <1144969908.12387.39.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Apr 2006, Alan Cox wrote:
> 
> Interesting. That pretty much conflicts with what write(2) itself is
> defined as in the same specification

They may mean that writes get "as much atomicity" between threads as 
specified in other places (which is not a whole lot). In which case we're 
certainly totally according to spec (since Linux has exactly the same 
guarantees for threads as for anything else - since we just don't even 
_care_ if it's a thread or not).

It may be that the extra POSIX wording comes from user-space thread 
libraries that did "magic things" with select loops etc for IO using 
non-blocking file descriptors (which, together with some latency 
guarantees, could turn a single write into a series of smaller blocked 
writes).

That would explain the POSIX wording - that they are supposed to be "as 
thread safe" as a native write, even when they are wrapped inside a magic 
threaded IO library. Maybe the "in the effects specified in IEEE Std 
1003.1-2001" part is exactly about the fact that write is _not_ actually 
specified to be totally atomic by the _normal_ POSIX stuff, but that they 
wanted to make it clear that it's supposed to be "as atomic" as it's 
supposed to be.

Hmm? Trying to be a language lawyer over a spec is always painful. I'd 
suspect that the people who wrote that part didn't even really think about 
it a lot, they just meant that they were "thread safe" in the sense that 
you can call them concurrently without the system blowing up.

		Linus
