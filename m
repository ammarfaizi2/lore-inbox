Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWCaJ42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWCaJ42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 04:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWCaJ42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 04:56:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60255 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751305AbWCaJ41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 04:56:27 -0500
Date: Fri, 31 Mar 2006 11:56:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] splice support #2
Message-ID: <20060331095629.GJ14022@suse.de>
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de> <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, Linus Torvalds wrote:
> 
> 
> On Thu, 30 Mar 2006, Jens Axboe wrote:
> > On Thu, Mar 30 2006, Ingo Molnar wrote:
> > >
> > > neat stuff. One question: why do we require fdin or fdout to be a pipe?  
> > > Is there any fundamental problem with implementing what Larry's original 
> > > paper described too: straight pagecache -> socket transfers? Without a
> > > pipe intermediary forced inbetween. It only adds unnecessary overhead.
> > 
> > No, not a fundamental problem. I think I even hid that in some comment
> > in there, at least if it's decipharable by someone else than myself...
> 
> Actually, there _is_ a fundamental problem. Two of them, in fact.
> 
> The reason it goes through a pipe is two-fold:
> 
>  - the pipe _is_ the buffer. The reason sendfile() sucks is that sendfile 
>    cannot work with <n> different buffer representations. sendfile() only 
>    works with _one_ buffer representation, namely the "page cache of the 
>    file".
> 
>    By using the page cache directly, sendfile() doesn't need any extra 
>    buffering, but that's also why sendfile() fundamentally _cannot_ work 
>    with anything else. You cannot do "sendfile" between two sockets to 
>    forward data from one place to another, for example. You cannot do 
>    sendfile from a streaming device.
> 
>    The pipe is just the standard in-kernel buffer between two arbitrary 
>    points. Think of it as a scatter-gather list with a wait-queue. That's 
>    what a pipe _is_. Trying to get rid of the pipe totally misses the 
>    whole point of splice().
> 
>    Now, we could have a splice call that has an _implicit_ pipe, ie if 
>    neither side is a pipe, we could create a temporary pipe and thus 
>    allow what looks like a direct splice. But the pipe should still be 
>    there.
> 
>  - The pipe is the buffer #2: it's what allows you to do _other_ things 
>    with splice that are simply impossible to do with sendfile. Notably, 
>    splice allows very naturally the "readv/writev" scatter-gather 
>    behaviour of _mixing_ streams. If you're a web-server, with splice you 
>    can do
> 
> 	write(pipefd, header, header_len);
> 	splice(file, pipefd, file_len);
> 	splice(pipefd, socket, total_len);
> 
>    (this is all conceptual pseudo-code, of course), and this very 
>    naturally has none of the issues that sendfile() has with plugging etc. 
>    There's never any "send header separately and do extra work to make 
>    sure it is in the same packet as the start of the data".
> 
>    So having a separate buffer even when you _do_ have a buffer like the 
>    page cache is still something you want to do.
> 
> So there.

My point was mainly that the buffer itself need not necessarily be a
pipe, it could be implemented with a pipe just using the same buffer
type. But I guess it doesn't make much sense, the pipe has nice
advantages in itself.

-- 
Jens Axboe

