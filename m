Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289585AbSAWAVA>; Tue, 22 Jan 2002 19:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289588AbSAWAUu>; Tue, 22 Jan 2002 19:20:50 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:46349 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289585AbSAWAUn>; Tue, 22 Jan 2002 19:20:43 -0500
Message-ID: <3C4E00E3.5050105@namesys.com>
Date: Wed, 23 Jan 2002 03:16:35 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Chris Mason <mason@suse.com>, Andreas Dilger <adilger@turbolabs.com>,
        Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201222014370.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Wed, 23 Jan 2002, Hans Reiser wrote:
>
>>Yes, it should get twice as much pressure, but that does not mean it
>>should free twice as many pages, it means it should age twice as many
>>pages, and then the accesses will un-age them.
>>
>>Make more sense now?
>>
>
>So basically you are saying that each filesystem should
>implement the code to age all pages equally and react
>equally to memory pressure ...
>
>... essentially duplicating what the current VM already
>does!
>
>regads,
>
>Rik
>
If the object appropriate for the subcache is either larger (reiser4 
slums), or smaller (have to reread that code to remember whether 
dentries can reasonably be coded to be squeezed over to other pages, I 
think so, if yes then they are an example of smaller, maybe someone can 
say something on this) than a page, then you ought to age objects with a 
granularity other than that of a page.   You can express the aging in 
units of pages (and the subcache can convert the units), but the aging 
should be applied in units of the object being cached.

Just to confuse things, there are middle ground solutions as well.  For 
instance, reiser4 slums are variable size, and can even have maximums if 
we want it.  If we are lazy coders (and we might be), we could even 
choose to track aging at page granularity, and be just like the generic 
VM code, except for the final flush moment when we will consider 
flushing 64 nodes to disk to count as 64 agings that our cache yielded 
up as its fair share.  With regards to that last sentence, I need more 
time to think about whether that is really reasonably optimal to do and 
simpler to code.

Consider an analogy with reiser4 plugins.  One of my constant battles is 
that my programmers want to take all the code that they think most 
plugins will have to do, and force all plugin authors to do it that way 
by not making the mostly common code part of the  generic plugin 
templates.  The right way to do it is to create generic templates, let 
the plugin authors add their couple of function calls that are unique to 
their plugin to the generic template code, and get them to use the 
generic template for reasons of convenience not compulsion.  I am asking 
you to create a cache plugin architecture for VM.  It will be cool, 
people will use it for all sorts of weird and useful optimizations of 
obscure but important to someone caches (maybe even dcache if nothing 
prevents relocating dcache entries, wish I could remember), trust me.:) 
 It is probably more important to caches other than ReiserFS that there 
be this kind of architecture (we could survive the reduction in 
optimality from flushing more than our fair share, it wouldn't kill us, 
but I like to ask for the right design on principle, and I think that 
for other caches it really will matter.  It is also possible that some 
future ReiserFS I don't yet imagine will more significantly benefit from 
such a right design.)

Ok, so it seems we are it seems much less far apart now than we were 
previously.:)

I remain curious about what dinner cooked by you using fresh Brazilian 
ingredients tastes like.  The tantalizing thought still lurks in the 
back of my mind where you planted it.:)   I MUST generate a business 
requirement for going to Brazil.....:-)

Hans


