Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbUEKGdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUEKGdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUEKGcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:32:45 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:11971 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S262205AbUEKGYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:24:12 -0400
Message-ID: <40A0718E.5060603@cosmosbay.com>
Date: Tue, 11 May 2004 08:24:14 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: Andre Ben Hamou <andre@bluetheta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Multithread select() bug
References: <409FF38C.7080902@bluetheta.com> <409FFADD.7050204@cosmosbay.com> <409FFE22.4050508@bluetheta.com> <40A002CE.4020906@cosmosbay.com> <40A009D9.9090404@bluetheta.com>
In-Reply-To: <40A009D9.9090404@bluetheta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Ben Hamou wrote:

>
> I see where you're coming from, in that there is a potential race 
> condition as to the socket being connected as I reach the select call.
>
> This is an important concern but it is, I think, orthogonal to the 
> original problem as there are two possible socket states at the point 
> at which select gets called (as far as I can see)...
>
> 1. The socket is in its connected state
> 2. The socket has already been closed by the parent thread
>
> As I understand it, if 1 is true (which corresponds to my original 
> post), then select should return the moment the socket gets closed 
> and, if 2 is true (which I believe corresponds to your concern), then 
> select should return immediately anyway as the socket would not block 
> if read from.
>
> Sorry to be a pest, but I'm trying to get this clear in my head. Is it 
> possible I've over-estimated the thread-safety of the select and close 
> calls?
>
As the safety of what you are trying to do cannot be guaranted, you 
should not even try to do that.
Then, apart from this safety showstopper, you should consider that what 
you assumed is simply wrong :
- Some Operating Systems do something special to signal blocked threads 
(blocked on a read()/write()/select()/poll()) if the underlying file 
handle is closed.
- linux does NOT. And this is done for several reasons. These reasons 
are known and were discussed on this list at several occasions.

So the rule is : close() syscall should be serialized, according to a 
synchronization of your choice, so that no other thread could be using 
the file descriptor at the same time.
If you want to 'send some signal to the blocked thread' in a portable 
way, you could setup a pipe to be able to send a special message on it. 
The 'worker thread' could add the read side of the pipe (pipefd[0]) to 
its select fd set, and will be notified of the Thread 2) willing to 
dismantle your socket, using a standard write(pipefd[1]). This will be 
portable : When the 'worker thread' returns from select() call, it can 
then close the socket fd himself.

By the way, prefer poll() syscall to select() one. Poll is much more 
scalable/efficient if you have only one or two fd to monitor.

See you
Eric

> Cheers,
>
> Andre Ben Hamou
> Imperial College London
>

