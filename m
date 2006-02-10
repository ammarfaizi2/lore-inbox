Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWBJQFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWBJQFk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWBJQFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:05:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21200 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751269AbWBJQFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:05:38 -0500
Date: Fri, 10 Feb 2006 08:05:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <43EC3961.3030904@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
 <20060209001850.18ca135f.akpm@osdl.org> <43EAFEB9.2060000@yahoo.com.au>
 <20060209004208.0ada27ef.akpm@osdl.org> <43EB3801.70903@yahoo.com.au>
 <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au>
 <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au>
 <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au>
 <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au>
 <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au>
 <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au>
 <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au>
 <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Feb 2006, Nick Piggin wrote:
> 
> This is a Linux implementation detail. As such it would make sense to
> introduce a new Linux specific MS_ flag for this.
> ..
> Definitely. And when the app gives us a hint that it really wants the
> data on the disk, starting it as early as possible is also a good
> optimisation.

But that's what MS_SYNC is. MS_SYNC says "I need this data written now".

MS_ASYNC moves it into the page cache. That makes 100% sense. Then it will 
be written by the regular dirty page writeout. That makes 100% sense. 

> I don't think there's anything wrong with your fadvise additions.
> I'd rather see MS_ASYNC start IO immediately and add another MS_
> flag for Linux to propogate bits.

Why? I miss the _reason_ you want to do this.

The current MS_ASYNC behaviour is the sane one. It's the one that doesn't 
cause the harddisk to start ticking senselessly. It's the one that allows 
a person on a laptop to say "don't write dirty data every 5 seconds - do 
it just every hour".

In contrast, _your_ proposal is just inflexible and inconvenient.

If somebody really really wants to "start flushing data now", then he can 
do so, but that actually has absolutely zero to do with "msync()" any 
more. A person who wants the flushing to start "now" might want to flush 
any random dirty buffers.

Your suggestion is no different from saying "we should make every 
'write()' call start the IO". Which is obviously crap.

		Linus
