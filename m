Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWC3RRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWC3RRe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 12:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWC3RRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 12:17:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29580 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750729AbWC3RRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 12:17:33 -0500
Date: Thu, 30 Mar 2006 09:17:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] splice support #2
In-Reply-To: <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0603300905270.27203@g5.osdl.org>
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu>
 <20060330120512.GX13476@suse.de> <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Mar 2006, Linus Torvalds wrote:
> 
> Actually, there _is_ a fundamental problem. Two of them, in fact.

Actually, four.

The third reason the pipe buffer is so useful is that it's literally a 
stream with no position.

That may sound bad, but it's actually a huge deal. It's why standard unix 
pipelines are so powerful. You don't pass around "this file, this offset, 
this length" - you pass around a simple fd, and you can feed that fd data 
without ever having to worry about what the reader of the data does. The 
reader cannot seek around to places that you didn't want him to see, and 
the reader cannot get confused about where the end is.

The 4th reason is "tee". Again, you _could_ perhaps do "tee" without the 
pipe, but it would be a total nightmare. Now, tee isn't that common, but 
it does happen, and in particular it happens a lot with certain streaming 
content.

Doing a "tee" with regular pipes is not that common: you usually just use 
it for debugging or logging (ie you have a pipeline you want to debug, and 
inserting "tee" in the middle is a good way to keep the same pipeline, but 
also being able to look at the intermediate data when something went 
wrong).

However, one reason "tee" _isn't_ that common with regular pipe usage is 
that normal programs never need to do that anyway: all the pipe data 
always goes through user space, so you can trivially do a "tee" inside of 
the application itself without any external support. You just log the data 
as you receive it. 

But with splice(), the whole _point_ of the system call is that at least a 
portion of the data never hits a user space buffer at all. Which means 
that suddenly "tee" becomes much more important, because it's the _only_ 
way to insert a point where you can do logging/debugging of the data.

Now, I didn't do the "tee()" system call in my initial example thing, and 
Jens didn't add it either, but I described it back in Jan-2005 with the 
original description. It really is very fundamental if you ever want to 
have a "plugin" kind of model, where you plug in different users to the 
same data stream.

The canonical example is getting video input from an mpeg encoder, and 
_both_ saving it to a file and sending it on in real-time to the app that 
shows it in a window. Again, having the pipe is what allows this.

		Linus
