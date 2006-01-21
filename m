Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWAUDwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWAUDwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 22:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWAUDwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 22:52:36 -0500
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:51916 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932292AbWAUDwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 22:52:36 -0500
Message-ID: <43D1B001.4010707@cfl.rr.com>
Date: Fri, 20 Jan 2006 22:52:33 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: sendfile() with 100 simultaneous 100MB files
References: <9e4733910601201353g36284133xf68c4f6eae1344b4@mail.gmail.com>
In-Reply-To: <9e4733910601201353g36284133xf68c4f6eae1344b4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I took a look at that article, and well, it looks a bit off to me.  I 
looked at the code it refered to and it mmap's the file and optionally 
copies from the map to a private buffer before writing to the socket.

The double buffering that is enabled by LOCAL_BUFFERING is a complete 
and total waste of both cpu and ram.  There is no reason to allocate 
more ram and waste more cpu cycles to make a second copy of the data 
before passing it to the network layer.  The mmap and madvice though, is 
a good idea, and I imagine it is causing the kernel to perform large 
block readahead.

If you really want to be able to simultainiously push hundreds of 
streams efficiently though, you want to use zero copy aio, which can 
have tremendous benefits in throughput and cpu usage.  Unfortunately, I 
believe the current kernel does not support O_DIRECT on sockets.

I last looked at the kernel implementation of sendfile about 6 years 
ago, but I remember it not looking very good.  I believe it WAS only 
transfering a single page at a time, and it was still making a copy from 
fs cache to socket buffers, so it wasn't really doing zero copy IO ( 
though it was one less copy than doing a read and write ).

About that time I was writing an ftp server on the NT kernel and 
discovered zero copy async IO.  I ended up using a small thread pool and 
an IO completion port to service the async IO requests.  The files were 
mmaped in 64 KB chunks, three at a time, and queued asynchronously to 
the socket which was set to use no kernel buffering.  This allowed a 
PII-233 machine to push 11,820 KB/s ( that's real KB, not salesman's ) 
over a single session on a 100Base-T network, and saturate dual network 
interfaces with multiple connections, all using less than 1% of the cpu, 
because the NICs were able to directly perform scatter/gather DMA on the 
filesystem cache pages.

I'm hopefull that the Linux kernel will be able to do this soon as well, 
when the network stack supports O_DIRECT on sockets.

Jon Smirl wrote:
> I was reading this blog post about the lighttpd web server.
> http://blog.lighttpd.net/articles/2005/11/11/optimizing-lighty-for-high-concurrent-large-file-downloads
> It describes problems they are having downloading 100 simultaneous 100MB files.
> 
> In this post they complain about sendfile() getting into seek storms and
> ending up in 72% IO wait. As a result they built a user space
> mechanism to work around the problems.
> 
> I tried looking at how the kernel implements sendfile(), I have
> minimal understanding of how the fs code works but it looks to me like
> sendfile() is working a page at a time. I was looking for code that
> does something like this...
> 
> 1) Compute an adaptive window size and read ahead the appropriate
> number of pages.  A larger window would minimize disk seeks.
> 
> 2) Something along the lines of as soon as a page is sent age the page
> down in to the middle of page ages. That would allow for files that
> are repeatedly sent, but also reduce thrashing from files that are not
> sent frequently and shouldn't stay in the page cache.
> 
> Any other ideas why sendfile() would get into a seek storm?
> 
> --
> Jon Smirl
> jonsmirl@gmail.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

