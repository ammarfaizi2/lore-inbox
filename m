Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277295AbRJNULh>; Sun, 14 Oct 2001 16:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277296AbRJNUL2>; Sun, 14 Oct 2001 16:11:28 -0400
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:43018 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S277295AbRJNULP>; Sun, 14 Oct 2001 16:11:15 -0400
Posted-Date: Sun, 14 Oct 2001 20:06:01 GMT
Date: Sun, 14 Oct 2001 21:06:00 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Jan Hudec <bulb@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: proc file system
In-Reply-To: <20011010190442.A26980@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0110142051320.6433-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan.

>>>>> I've written a prog interface for my logger utility to make it
>>>>> easy to transport my logging information from kernel to userspace
>>>>> using shell commands. now i want to use tail -f /prog/<mylogfile>.
>>>>> what do i have to do for that to work. when using tail my loginfo
>>>>> gets read form my ringbuffer, but nothing gets printed in the
>>>>> terminal.

>>>> I think you actually want a character device instead of a /proc file.

>>> Could you please explain why? I can't see the advantage (read and
>>> write are fileops; you can have them exactly the same for proc file
>>> and device).

>> Well, to get tail -f to work, minimally you'll have to support
>> maintaining a fileposition, so tell() and seek() have something
>> useful to work on.  It's been a while since I looked at the source
>> for tail, pretty much for similar reasons (wanted to follow a /proc
>> file).  Most /proc files are considered (relatively) fixed-length
>> files, who's contents get updated.  tail -f expects to follow a file
>> that is growing in size.

> ... thus it won't work on char dev at all;-)

Why won't it?

> (but simple cat will do lot better).

> Well, it does not matter what proc files are supposed to be, they
> can behave any way you want. They can even behave like devices. (And
> it even shouldn't be more work)

How about the aspects of /proc files that are outside of your driver's
control...

 1. The actual size of the /proc file is controlled by a variable that
    your driver sets. Your driver gets no indication whatsoever as to
    when that variable is read.

 2. Your driver is required to recreate the ENTIRE /proc file every
    time a read() call is made, and gets NO indication as to which
    part of the file is actually returned to the caller.

Compare these to the requirements of a character device...

 1. There is no actual size stored anywhere - and, as a matter of fact,
    the whole concept of file size is meaningless.

 2. When your driver gets a read() call, it is only required to return
    data that has never before been returned, and not data that has
    been previously read. Indeed, it is an error to return the same
    data twice.

...and the differences you've overlooked become obvious, as does the
reason why your choice of a /proc file is not appropriate for your
stated application.

> AFAIK the only differences remaining are that devices can initialize
> module autoloading and that you can put device node anywhere.

You forgot the above.

>> I don't have sources in front of me, so hopefully someone else will
>> step-up and provide more detail than I have.

An obvious source of relevant information is the klogd kernel log tool,
which already does precicely what you're proposing to do. Indeed, I'd
tend to replace your entire logging module with calls to printk() that
specify a unique logging facility.

Best wishes from Riley.

