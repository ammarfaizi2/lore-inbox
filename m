Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTFJNI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 09:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTFJNI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 09:08:27 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:55749 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S262633AbTFJNIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 09:08:25 -0400
Message-ID: <3EE5DE7E.4090800@techsource.com>
Date: Tue, 10 Jun 2003 09:34:54 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: select for UNIX sockets?
References: <MDEHLPKNGKAHNMBLJOLKOEKFDIAA.davids@webmaster.com> <m3isredh4e.fsf@defiant.pm.waw.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Krzysztof Halasa wrote:
> "David Schwartz" <davids@webmaster.com> writes:

>>	The kernel does not remember that you got a write hit on 'select'
>>and use
>>it to somehow ensure that your next 'write' doesn't block. A 'write' hit
>>from 'select' is just a hint and not an absolute guarantee that whatever
>>'write' operation you happen to choose to do won't block.
> 
> 
> A "write" hit from select() is not a hit - it's exactly nothing and this
> is the problem.
> Have you at least looked at the actual code? unix_dgram_sendmsg() and
> datagram_poll()?


I think the issue here is not what it means when select() returns but 
what it means when it DOESN'T return (well, blocks).

In my understanding, one of select()'s purposes is to keep processes 
from having to busy-wait, burning CPU for nothing.  Your guarantee with 
select() is that if it blocks, then the write target(s) definately 
cannot accept data.  The inverse is not true, although the inverse is 
very likely:  if select() does not block, then it's extremely likely 
that the target can accept SOME data.  But it it certainly can't accept 
ALL data you want to give it if you want to give it a lot of data.

If you were to use blocking writes, and you sent too much data, then you 
would block.  If you were to use non-blocking writes, then the socket 
would take as much data as it could, then return from write() with an 
indication of how much data actually got sent.  Then you call select() 
again so as to wait for your next opportunity to send some more of your 
data.

It may be that some operating systems have large or expandable queues 
for UNIX sockets.  As a result, you have been able to send a lot of data 
with a blocking write without it blocking.  I can see how it would be an 
advantage to function that way, up to a certain point, after which you 
start eating too much memory for your queue.  However, what you have 
experienced is not universally guaranteed behavior.  What Linux does is 
canonically correct; it's just a variant that you're not used to.  If 
you were to change your approach to fit the standard, then you would get 
more consistent behavior across multiple platforms.

Up to this point, I believe you have been riding on luck, not guaranteed 
behavior.

