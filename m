Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265270AbUEZARA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbUEZARA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 20:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbUEZARA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 20:17:00 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:13325 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S265272AbUEZAQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 20:16:42 -0400
Message-ID: <40B3E1DF.10001@mauve.plus.com>
Date: Wed, 26 May 2004 01:16:31 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: Pavel Machek <pavel@ucw.cz>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405251655.43185.rob@landley.net> <20040525220826.GC1609@elf.ucw.cz> <200405251816.05497.rob@landley.net>
In-Reply-To: <200405251816.05497.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Tuesday 25 May 2004 17:08, Pavel Machek wrote:
> 
> 
>>>Doesn't asynchronous sendfile has the little problem your process can
>>>exit before the sendfile is complete?
>>
>>Hmm, it has...
>>
>>
>>>I'm not sure how much of a help it really is, since fork() isn't brain
>>>surgery if you want it to be asynchronous, and the lifetime rules are
>>>really explicit then.  (With a ps that does thread grouping, this isn't
>>>too bad from a clutter standpoint, even.  And you automatically get a
>>>SIGCHLD when the sendfile is complete, too...)
>>
>>Right.
>>
>>
>>>Of course if the syscall can make the sendfile outlive the process that
>>>fired it off, then by all means it sounds good.  I dunno how much extra
>>>work that is for the kernel, though.
>>
>>Well, it would be "interesting" to stop that sendfile then. You could
>>not kill it etc.
> 
> 
> Well, logically what you're doing is redirecting an existing filehandle so it 
> points to something else.  Instead of reading from this pipe, you're now 
> reading from this file or from this network socket, or this other process's 
> stdout.  So any intermediate processes going away is theoretically okay as 
> long as the anchors at each end remain (process/filesystem/network connection 
> generating the data, process/filesystem/network connection receiving the 
> data).
> 
> The easy way to make the semantics work out right is that such an asynchronous 
> sendfile would effectively close the file in question from the point of view 
> of the process that did the sendfile.  It would pretty much have to be part 
> of the semantics of any asynchronous sendfile call: welding together the two 
> filehandles would behave like a single direction shutdown(2) as far as the 
> process that called sendfile is concerned.  (That way, if you do an async 
> sendfile in each direction, the filehandle is closed both ways, but you don't 
> HAVE to if you don't want to.  You can feed data to a child process from a 
> script file or something, and just deal with the responses coming back.)
> 
> This would mean that in theory the process that did the sendfile could go away 
> without too much ambiguity about what should happen.  (The bits that are 
> already closed from the process's point of view are unaffected by the process 
> exiting.)  I dunno what's needed to clean that up in the kernel.
> 
> I also don't know if it's a good idea, because as you noticed the fire and 
> forget nature of the thing means that killing it afterwards is something we 
> haven't got a semantic for if the thing at the other end is NOT a pipe to a 
> processes.  (We kill processes.  We don't have a kill for network connections 
> or for files in the filesystem that are no longer associated with any 
> process.  This is theoretically existing problem, by the way.  Check out 
> SO_LINGER in man 7 socket...)
> 

A while back (2.2?) I was using a util that came with netpipes, sockdown.
Give it a socket FD, and it would close the socket.
It wasn't intended for it, but I found that it was really handy to
be able to shut other programs network connections.
For example, tin gets wedged talking to a server that won't do something, and
you just do
sockdown </proc/tin/fd/nn
And it shuts.

Mildly annoyingly, this stopped working in 2.4.
I suppose it'd be totally insane for init to inherit descriptors for open network
connections.
