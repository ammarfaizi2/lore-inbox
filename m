Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265811AbTL3XEj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbTL3XCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:02:53 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:65286 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S265811AbTL3XCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:02:03 -0500
Message-ID: <3FF203E5.3020601@murder.cz>
Date: Wed, 31 Dec 2003 00:01:57 +0100
From: "Fox!MURDER" <fox@murder.cz>
User-Agent: Mozilla Thunderbird 0.5a (20031223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: bluefoxicy@linux.net
Subject: Re: Slab allocator . . . cache?  WTF is it?
References: <20031230221859.15F503956@sitemail.everyone.net>
In-Reply-To: <20031230221859.15F503956@sitemail.everyone.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm kind of a kernel-dev newbie but I'll try to explain my understanding 
in BFU-friendly way.
The cache you're seeing here is a memory used to store IO requests and 
data when you request some operation on IO. For example if you are 
writing to hard drive then (if your partition is not mounted with sync 
option or its not some special case) the data you are writing are put in 
the cache and the disk starts writing. And because your memory is fast, 
let's say it can do a 500MiB/s, then your write is completed in 0.1sec 
and your program can continue doing other stuff. Data you requested to 
write to the drive will get written as soon as it is possible (or with a 
small amounts of data as soon as some timer reaches zero - this is to 
provide). But because your disk is able to write only let's say a 
20MiB/s and you are writing a 50MiB file the write without using cache 
would take about 2.5 seconds before your program can continue. So you 
are having a  25 times faster write at user level with cache than 
without. You could probably see it even better when reading lot of small 
files (ie. grepping a lot of text files), where the drive would have to 
seek for each request, but kernel can read ahead more data than was 
actually requested guessing that you will request them later anyway and 
put them in cache. And when you request them you get them at the speed 
of  your memory. So cache has (almost) nothing to do with swap and its 
on the same line as swap just because it fits better:P. Kernel is trying 
to be smart about swap and cache so it will swap out programs out of 
memory when you are really not using them to be able to use the memory 
for cache that can really speed up your system.

Well I believe this is correct, if not please somebody be so kind and 
correct me before beating me with a kernel tarball :).


Tomas Zvala



john moser wrote:

>Mem:    775616k total,   747740k used,    27876k free,    96584k buffers
>Swap:   250480k total,    71340k used,   179140k free,   298852k cached
>
>
>This is somewhat distressing.  Last time this happened, I started opening every
>program I had (including every OpenOffice.org product and every browser I had
>installed), and the "cached" value dropped quickly.
>
>I'm wondering, what IS cache?  It seems to increase even when swap is not used,
>and sometimes when there's no swap partition enabled.  It also seems to cause
>me to run into swap when I have ample ram available, assuming that cache is just
>some sort of cache that is copied from and mirrors another portion of ram for
>some sort of speed increase.  It's wasteful to me, and I want to more understand
>its implimentation and its purpose, and in all honesty limit its impact if possible.
>I got this RAM upgrade because I was using about 676M of RAM total, including swap,
>at peak; and now I find myself using 820M RAM at peak and about 750-800 continually.
>
>As always, i'm not on the list, so I'd prefer to be CC'd replies.
>
>_____________________________________________________________
>Linux.Net -->Open Source to everyone
>Powered by Linare Corporation
>http://www.linare.com/
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
