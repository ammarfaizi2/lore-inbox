Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288982AbSAUAcl>; Sun, 20 Jan 2002 19:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288980AbSAUAcf>; Sun, 20 Jan 2002 19:32:35 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:9999 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S288982AbSAUAcR>;
	Sun, 20 Jan 2002 19:32:17 -0500
Message-ID: <3C4B60A1.3030302@namesys.com>
Date: Mon, 21 Jan 2002 03:28:17 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201202110290.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Sun, 20 Jan 2002, Shawn Starr wrote:
>
>>But why should each filesystem have to have a different method of
>>buffering/caching? that just doesn't fit the layered model of the
>>kernel IMHO.
>>
>
>I think Hans will give up the idea once he realises the
>performance implications. ;)
>
>Rik
>

Rik, what reiser4 does is take a slum (a slum is a contiguous in the 
tree order set of
dirty buffers), and just before flushing it to disk we squeeze the 
entire slum as far
to the left as we can, and encrypt any parts of it that we need to 
encrypt, and assign
block numbers to it.  

Tree balancing normally has a tradeoff between memory copies performed on
average per insertion, and tightness in packing nodes.    Squeezing in 
response to
memory pressure greatly optimizes the the number of nodes  we are packed 
into
while only performing one memory copy just before flush time for that 
optimization.
It is MUCH more efficient.  Block allocation ala XFS can be much more 
optimal if
done just before flushing.  Encryption just before flushing rather than 
with every
 modification to a file is also much more efficient.  Committing 
transactions
also have a complex need to be memory pressure driven (complex enough
that I won't describe it here).

So, really, memory pressure needs to push a whole set of events in a well
designed filesystem.  Thinking that you can just pick a page and write it
and write no other pages, all without understanding the optimizations of
the filesystem you write to, is simplistic.

Suppose we do what you ask, and always write the page (as well as some
other pages) to disk.  This will result in the filesystem cache as a whole
receiving more pressure than other caches that only write one page in
response to pressure.  This is unbalanced, leads to some caches having
shorter average page lifetimes than others, and it is therefor 
suboptimal.  Yes?



Hans

