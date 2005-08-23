Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVHXHuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVHXHuf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVHXHuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:50:35 -0400
Received: from intranet.networkstreaming.com ([24.227.179.66]:28867 "EHLO
	networkstreaming.com") by vger.kernel.org with ESMTP
	id S1750744AbVHXHue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:50:34 -0400
Message-ID: <430BA4B3.5000502@davyandbeth.com>
Date: Tue, 23 Aug 2005 17:35:31 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Willy Tarreau <willy@w.ods.org>, bert hubert <bert.hubert@netherlabs.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: select() efficiency / epoll
References: <42E162B6.2000602@davyandbeth.com> <20050722212454.GB18988@outpost.ds9a.nl> <430AF11A.5000303@davyandbeth.com> <20050823182405.GA21301@outpost.ds9a.nl> <430B01FB.2070903@davyandbeth.com> <20050823191254.GB10110@alpha.home.local> <430B077A.10700@davyandbeth.com> <20050823194557.GC10110@alpha.home.local> <430B0EAE.9080504@davyandbeth.com> <20050823202018.GA28724@alpha.home.local> <Pine.LNX.4.63.0508231618420.7257@localhost.localdomain> <430B5802.5050200@davyandbeth.com> <Pine.LNX.4.63.0508232202580.10064@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.63.0508232202580.10064@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Aug 2005 07:50:10.0218 (UTC) FILETIME=[73CF68A0:01C5A880]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>
> There is no known problem in using epoll_ctl() in one thread while 
> another does epoll_wait().
> I suggest you to ask Valgrind to take a look at you binary. Since I 
> have no clue of what your software does, please create the *minimal* 
> code snippet that exploit the eventual problem, and post it.
>
Yes, I have pretty much confirmed this. And unfortunately I tried to 
make a minimal code snippet which demonstrates the problem, but wasn't 
able to do that before I figured out a work-around.  I may still try to 
create something for you to test against so you can fix it.  But I'm 
going to have to continue to work with the existing implementation since 
I'm going to be running this code on some production servers where 
updating the kernel might not be an option.

The work-around is as follows:

1) I create a queue that can hold operations to perform on the epoll 
structure and I protect it with a mutex.

2) Other threads (when needing to modify the epoll) lock the mutex and 
enque the operation into the operation queue instead of calling 
epoll_ctl itself (i.e. add this socket for reading.. add this socket for 
writing, remove this socket.. etc) *and* then cancel the epoll_wait() 
   I implemented the cancel by having a pipe() always being watched for 
read, and write a byte to it when I want to cancel (is there a better way?)
   There are several operations that could be supported 
(add/remove/modify/change userdata/etc), but I only need two myself.

3) There's only one thread that actually does the epoll_wait().  When 
epoll_wait() returns, (I first drain the cancel pipe so it never fills 
up) I handle what events need handling, and then lock the operations 
queue mutex, perform all the operations in the queue then clear the queue



So, this works for me now.

Thanks for all your guys' info.

-- Davy

P.S.   Davide, I still might get you that snipped, but it's not a 
trivial snippet as you can imagine... and timing is everything to the 
problem :( .. and also the question of WHERE it corrupts memory.. it 
seemed to be unpredictable so far.

