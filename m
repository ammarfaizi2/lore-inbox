Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWBJTon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWBJTon (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWBJTon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:44:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56986 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751086AbWBJTom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:44:42 -0500
Date: Fri, 10 Feb 2006 11:44:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <43ECE97F.1080902@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0602101138480.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
 <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au>
 <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au>
 <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au>
 <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au>
 <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au>
 <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au>
 <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au>
 <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au>
 <20060209231432.03a09dee.akpm@osdl.org> <43EC8A06.40405@yahoo.com.au>
 <Pine.LNX.4.64.0602100815580.19172@g5.osdl.org> <43ECC69D.1010001@yahoo.com.au>
 <Pine.LNX.4.64.0602100904330.19172@g5.osdl.org> <43ECD471.9080203@yahoo.com.au>
 <Pine.LNX.4.64.0602101011350.19172@g5.osdl.org> <43ECE97F.1080902@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Feb 2006, Nick Piggin wrote:
> > 
> > Your pattern would actually be
> > 
> > 	.. dirty offset 100-200 ..
> > 	fadvice(fd, 100, 200, FADV_WRITE_START);
> > 
> > 	.. dirty offset 200-300 ..
> > 	fadvice(fd, 200, 300, FADV_WRITE_START);
> > 
> > 	.. dirty offset 300-400 ..
> > 	fadvice(fd, 300, 400, FADV_WRITE_START);
> > 
> > 	.. dirty offset 400-415 .. (for the next transaction)
> > 
> 
> - IOW if the app or OS crashed here it would be possible to see 400-415 on
> the disk and none of the previous transactions (assuming we don't know
> the page size).

If the app/OS crashed here, nothing would matter. We haven't committed 
anything at all yet. We've just started the IO. What is at 400-415 simply 
doesn't matter, because nobody would have any reason to look at it.

(Besides, it's not at all clear that 400-415 would or would not be on 
disk. It depends on entirely on timing and buffering of the IO system at 
that point - the fact that its dirty in memory doesn't mean that it ever 
made it into the IO buffer that was started).

> > 	fadvice(fd, 100, 400, FADV_JUST_WAIT); (for the previous one)

This is the one that waits for it to finish, so _now_ we can update the 
pointers (elsewhere) to that log (and if the app/OS crashes before that, 
nobody will even know about it).

See?

> I'm not convinced. You above example was bogus.

No, your understanding was incomplete. I'm talking about just parts of a 
much bigger transaction. 

A single write on its own is almost never a transaction unless your system 
is _purely_ log-based (which it could be, of course. Not in my example).

		Linus
