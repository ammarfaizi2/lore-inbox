Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWCaCbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWCaCbm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 21:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWCaCbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 21:31:42 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:46462 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751189AbWCaCbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 21:31:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=LhlQ8aNl2qL70rw0YAPY19vBWnh5+Hvo5REn+eoU4LIXcbRlNJeH1fCcIXSeCOfwRcfBThCeOAQBUU3cMl2uuG0rwdBRS19f+dygojjoQ1lWR86Haf4c8BEombE3nBkn4MPNgf9yHvAfGtTJKFIXQAjCBMt1m0EWpExIxoJJxwo=  ;
Message-ID: <442C7EF5.8090703@yahoo.com.au>
Date: Fri, 31 Mar 2006 10:59:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jeff Garzik <jeff@garzik.org>, Jens Axboe <axboe@suse.de>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] splice support #2
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de> <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org> <442C440B.2090700@garzik.org> <Pine.LNX.4.64.0603301259220.27203@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603301259220.27203@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> splice() really can handle any fd->fd move.
> 
> The reason you want to have a pipe in the middle is that you have to 
> handle partial moves _some_ way. And the pipe being the buffer really does 
> allow that, and also handles the case of "what happens when we received 
> more data than we could write".
> 
> So the way to do copies is
> 
> 	int pipefd[2];
> 	unsigned long copied = 0;
> 
> 	if (pipe(pipefd) < 0)
> 		error
> 
> 	for (;;) {
> 		int nr = splice(in, pipefd[1], MAX_INT, 0);
> 		if (nr <= 0)
> 			break;
> 		do {
> 			int ret = splice(pipefd[0], out, nr, 0);
> 			if (ret <= 0) {
> 				error: couldn't write 'nr' bytes
> 				break;
> 			}
> 
> 			nr -= ret;
> 		} while (nr);
> 	}
> 	close(pipefd[0]);
> 	close(pipefd[1]);
> 

I think it makes sense to have a 64-bit length. It just seems
cleaner because it is in userspace units of file offset. Also,
might you be able to do a single file-sized file<->file splice,
and have it do a remote copy on a suitable network fs, or a
whole-file COW on some local fs (maybe not, as splice doesn't
deal with metadata... I don't know the tricky details of fses).

But your argument against a 64-bit length seemed to involve
limiting the usage that sys_splice would see. Make it 64-bit
instead and someone might come up with something that you
hadn't thought of. Is there any downside?

No offsets :(
Don't they only increase flexibility? Or would you prefer to
add a new sys_psplice for that?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
