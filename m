Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284736AbRLZSLY>; Wed, 26 Dec 2001 13:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbRLZSLQ>; Wed, 26 Dec 2001 13:11:16 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:516 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S284746AbRLZSLB>; Wed, 26 Dec 2001 13:11:01 -0500
Posted-Date: Wed, 26 Dec 2001 14:54:40 GMT
Date: Wed, 26 Dec 2001 14:54:38 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley H Williams <rhw@MemAlpha.cx>
To: Andrew Morton <akpm@zip.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT wierd behavior..
In-Reply-To: <9vlgsd$1b7$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0112261442160.924-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Linus.

>> RETURN VALUE
>>
>>     Upon successful completion, write() and pwrite() will return the
>>     number of bytes actually written to the file associated with
>>     fildes. This number will never be greater than nbyte. Otherwise,
>>     -1 is returned and errno is set to indicate the error.
>>
>> I take that to mean that if an error occurs, we return that
>> error regardless of how much was written.

> I disagree.
>
> Note that writing 15 characters out of 30 is also a "successful write" -
> it's just a _partial_ write.
>
> So it is acceptable to return an intermediate value.

In the "Linux Device Drivers" book, the author writes quite a lot of
drivers for virtual devices that actually rely on the ability to return
short writes in many cases. Many of the standard UNIX utilities rely on
just the same behaviour as well.

>> Which makes sense.  Consider this code...
>>
>>	open(file)
>>	write(100k)
>>	close(fd)

...which ought to look like this code...

	open(file)
	ptr = fillbuffer(100k)
	endptr = ptr + 100k
	while (ptr < endptr) {
		result += write(ptr, endptr - ptr)
		if (result > 0)
			ptr += result
		else
			ERROR
	}
	close(file)

...as anything else is just plain buggy and can't be otherwise.

>> if the write gets an IO error halfway through, it looks like
>> the caller never gets to hear about it at present.

> No, the caller _does_ get to hear about it. If the caller cares
> about robust handling, it will notice "Hmm, I tried to write 100k
> bytes, but the system only wrote 50k, what's up"?
>
> Note that the caller _has_ to do this anyway, or it wouldn't be able
> to handle things like interruptible NFS mounts, sockets, pipes,
> out-of-disk errors etc etc.

It's also not exactly hard to do the right thing - there's little extra
in the revised code snippet to the original one.

> And if the caller does _not_ care about robustness, then who cares?
> It's going to ignore whatever we return anyway.

Precicely why that sort of code is so essential.

Best wishes from Riley.

