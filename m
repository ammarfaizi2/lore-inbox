Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278209AbRKAHYt>; Thu, 1 Nov 2001 02:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278214AbRKAHYb>; Thu, 1 Nov 2001 02:24:31 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:928 "EHLO twilight.cs.hut.fi")
	by vger.kernel.org with ESMTP id <S278177AbRKAHYU>;
	Thu, 1 Nov 2001 02:24:20 -0500
Date: Thu, 1 Nov 2001 09:24:07 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Riley Williams <rhw@MemAlpha.cx>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Need blocking /dev/null
Message-ID: <20011101092407.H1504@niksula.cs.hut.fi>
In-Reply-To: <20011031112303.A26218@niksula.cs.hut.fi> <Pine.LNX.4.21.0110312256030.28028-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0110312256030.28028-100000@Consulate.UFP.CX>; from rhw@MemAlpha.cx on Wed, Oct 31, 2001 at 11:13:22PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 11:13:22PM +0000, you [Riley Williams] claimed:
> Hi Ville.
> 
> 
> > Certainly have in the sense that you could theoretically do that in
> > user space.
> 
> Are you sure?

In theory, yes.
 
> > find / -name "wanted-but-lost-download" | eat
> 
> Doesn't work - you're piping the stdin there, not stderr as per my
> example above.

Sorry, I wasn't careful enough.

> AFAIK, there's no way to pipe stderr without also piping
> stdout, hence this sort of solution just doesn't work.

One could argue that is a fault of the shell - which again is a userland
thing.

If anything else fails, you could do

% touch y; rm -f x
% ls x y
ls: x: No such file or directory
y
% mkfifo f           
% ls x y 2> f & wc -c f
y
     33 f
rm f

Which of course isn't pretty, but it's doable. Of course, I'm not arguing
that we should get rid of /dev/null and /dev/zero, but that in theory you
could implement them in userspace.

Come to think of it, the biggest gain from /dev/null and /dev/zero comes
propably when you do memmaps. I'm not actually sure whether you could all
tath without /dev/null and /dev/zero - or you could, but with performance
loss.
 
> AFAICS, there is no sane alternative to /dev/null in userspace.

Sane is relative...

> > zerofill | head -c 1440k > /tmp/floppy.img
> 
> How does zerofill know when to stop writing zeros out? After all, if it
> doesn't write enough out for the head call, then it's no longer an
> equivalent to /dev/zero, and it could easily be called with just about
> ANY positive number of bytes, including an infinite number, as in...
> 
> 	zerofill | tr '\0' '@' > /dev/ttyS1
> 
> ...which sends an infinite stream of 0x40 bytes to the serial port.

Of course it writes infinitely. When head terminates the pipe, it exits.
Just try

yes | head -c 10

Or with any characters. It gets SIGPIPE when the other end closes the pipe.

> However...
> 
> 	zerofill 750M  > /tmp/img.cd
> 	zerofill 1440k > /tmp/img.floppy
> 
> ...would be a reasonable userspace equivalent to examples (2) and (3)
> respectively, so that certainly could be done in userspace.

That's equivalent to 

zerofill | head -c 750M > /tmp/img.cd

Unless I missed something.


 
-- v --

v@iki.fi
