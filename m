Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSLZFlJ>; Thu, 26 Dec 2002 00:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbSLZFlI>; Thu, 26 Dec 2002 00:41:08 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:28038 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S261907AbSLZFlH>; Thu, 26 Dec 2002 00:41:07 -0500
Message-ID: <3E0A9AEE.90009@kegel.com>
Date: Wed, 25 Dec 2002 22:00:14 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: re: problem with rt-sigio: lost events
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner wrote:
> I am having trouble with sigio.  I tried to integrate it in a event
> notification framework of mine that already speaks poll and epoll.
> I want sigio for backwards compatibility with 2.4 kernels.
> 
> So I used the description from Dan's C10k web site and got it working.
> My test application is a trivial web server for static web pages only.
> 
> My first problem is that sigio will not signal POLLOUT on freshly
> connected connections. 

That's as designed (and epoll behaves that way, too, doesn't it?);
when applications start using sigio or epoll on a socket, they
have to assume it's readable/writable initially.  There was a huge
argu^H^H^H^H thread about that recently with subject
"epoll (was Re: [PATCH] async poll for 2.5)"

 > It doesn't change when I read the HTTP header.
> So I added a kludge that calls poll() when the application wants to
> switch from reading to writing or vice versa.  That is quite ugly but it
> works.

Sounds fishy... but I'd need to see your code to know more.

> The second problem is that once I start hammering the server with
> request (as opposed to running wget manually from the command line), the
> server just stops serving requests.  strace shows this pattern:
> 
>   sigtimedwait signals an event on fd #3 (the listening socket)
>   accept is called, returns #4
>   fd 4 is set non-blocking
>   F_SETOWN, F_SETSIG, SETFL O_ASYNC
>   sigtimedwait times out.
>   sigtimedwait is called again, times out again.
> 
> Why is that?  Googling seemed to indicate that there could be a race
> condition here after the accept.  Should I be running poll on the socket
> right away?  Or just blindly call the read handler?

Yes. Blindly call the handler, and do I/O until you get an
EWOULDBLOCK.  That's precisely what you're supposed to do when
you start using sigio on an fd.

> Is anyone actually successfully using sigio for anything?  So far it
> does not look very reliable to me.

It works ok, once you get used to its oddities.
sys_epoll works better, but sigio isn't terrible as a fallback.
- Dan

-- 
Dan Kegel
Linux User #78045
http://www.kegel.com

