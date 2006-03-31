Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWCaMUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWCaMUs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 07:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWCaMUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 07:20:48 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:24225 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751341AbWCaMUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 07:20:47 -0500
Date: Fri, 31 Mar 2006 14:18:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] splice support #2
Message-ID: <20060331121817.GA11810@elte.hu>
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de> <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

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

with pipe-based buffering this approach has still the very same problems 
that sendfile() has with packet boundaries, because it's not enough to 
have "large enough" buffering (like a pipe has), the pipe also has to be 
drained, and the networking layer has to know the precise boundary of 
data.

the right solution to the packet boundary problem is to pass in a proper 
"does userspace expect more data right now" flag, or to let userspace 
'flush' the socket independently - which is independent of the 
pipe-in-slice issue. This solution already exists: the MSG_MORE flag.

	Ingo
