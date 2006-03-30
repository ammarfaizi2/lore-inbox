Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWC3FNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWC3FNu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWC3FNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:13:50 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:44685 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751050AbWC3FNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:13:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=W4jD0+1aXUD/GRPGZs7KHC8yEqDWjFST98c0kR9JpCYWBCQKRpQu0R8TQjrduHDJcAG+MKmwbUjZ+qKep5avxYF8RecIO9R8cclDrRh4geCeTDcXRAwvFZbpoKOGTAtxA4Ze4dy89bEv4lRuXdtDPhLl1Ji8LNjXBYyIDWmVn0E=  ;
Message-ID: <442B4447.9050700@yahoo.com.au>
Date: Thu, 30 Mar 2006 13:36:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][RFC] splice support
References: <20060329122841.GC8186@suse.de>
In-Reply-To: <20060329122841.GC8186@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Looks nice!

Jens Axboe wrote:

>Hi,
>
>Since my initial posting back in December, I've had some private queries
>about the state of splice support. The state was pretty much that it was
>a little broken, if one attempted to do file | file splicing. The
>original patch migrated pages from one file to another in this case,
>which got vm ugly really quickly. And it wasn't always the right thing
>to do, since it would mean that splicing file1 to file2 would move
>file1's page cache to file2. Sometimes this is what you want, sometimes
>it is 
>

Page migration now generalised vmscan.c and introduced remove_mapping
function, which should help keep things clean.

Moving a page onto and off the LRU is an interesting problem, though.
But possibly you could just leave it on the LRU and transfer the pagecache
reference over to the pipe. vmscan would find extra pages on the LRU at
times, but they would go away when pipe releases the page.

Moving a page from a pipe to a filesystem might be harder, because you
don't know if it came from a filesystem (still on LRU) or not (in which
case you need to add it to LRU). If only you can keep track of this
information as the page gets passed around... hmm the PG_private will be
free to use because a filesystem must always drop its buffers before
remove_mapping can run. One would also need to take care of replacing
an existing page I guess.

Hmm... I think it can work, falling back to copies if we get stuck
anywhere.

Unless someone beats me to it, I'll try coding something up when I get
a bit more free time.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
