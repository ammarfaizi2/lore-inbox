Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLFQYu>; Wed, 6 Dec 2000 11:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130679AbQLFQYk>; Wed, 6 Dec 2000 11:24:40 -0500
Received: from chaos.analogic.com ([204.178.40.224]:43394 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129406AbQLFQYd>; Wed, 6 Dec 2000 11:24:33 -0500
Date: Wed, 6 Dec 2000 10:53:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <Pine.LNX.4.10.10012051645080.811-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.95.1001206104447.26831A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Linus Torvalds wrote:

> 
> 
> On Wed, 6 Dec 2000, Kai Germaschewski wrote:
> 
> > 
> > On Tue, 5 Dec 2000, H. Peter Anvin wrote:
> > 
> > > If you have had A20M# problems with any kernel -- recent or not --
> > > *please* try this patch, against 2.4.0-test12-pre5:
> > 
> > Just a datapoint: This patch doesn't fix the problem here (Sony
> > PCG-Z600NE). Still the spontaneous reboot exactly the moment I expect to
> > get my console back from resumeing.
> 
> Can you test whether it's the "and 0xfe" or the "or $2" that does it for
> you?
> 
> Right now we know that the Olivetti M4 has problems with the "or $2". I'd
> like to know if this is the same bit #1, or whether it's #0.
> 
> [ And I agree with Peter - if somebody knows BIOS programming and how to
>   use "int 15" to enter protected mode, then that migth well be the
>   easiest solution. The only real reason the linux setup code does it by
>   hand is that the original code was written that way - and it was written
>   that way because I had never used the BIOS in my life before, _and_ I
>   wanted to learn the i386. Both of which were valid reasons back in 1991.
>   Neither of which is probably a very good reason ten years later ;]
> 
> 		Linus
> 
> -

The protected-mode switch in INT 15 is probably the least tested BIOS
function ever. I wouldn't trust it, and relying on it will put further
burden on embedded Linux developers, many of whom don't even have a
BIOS. It is 'least tested' because there is no way provided to get
back to real-mode. This implies that somebody probably 'tested' it
once, verified that some simple 32-bit function executed for a
few microseconds, then declared; "It works!".

Many new chip-sets snoop for the sequence:

	Write 0xd1 to port 0x64
	Write 0xN1 to port 0x60

... Where 'N' are any bits and the LSB enables A<20> propagation.

The writes have to be in sequence, therefore, one must read 0x60
first, OR in bit 0. Write 0xD1 to 0x64, then write the new enable-
value to port 0x60.

It takes about 700 to 1500 microseconds for a real keyboard controller
to enable the A<20> propagation bit. It takes only a few hundred
nanoseconds for the virtual sequence, above, to do the same thing.

On all machines I have looked at, including several lap-tops, the
'fast' A<20> enable port is R/W. This means that you don't have to
crash the machine by setting some secret reserved bit. Just read first,
OR in your A<20> bit, then write.

You can experiment by booting DOS (or free-DOS), and play using DEBUG.
Setting A<20> while in real-mode DOS won't hurt anything. You can even
check for wrap beyond FFFF:0000 from DEBUG to see if the bit is enabled.

I suggest that a "universal" sequence is the D1/N1 sequence shown above
(this will work with real keyboard controllers), you don't have to
wait for completion of the last command as long as you don't have
more than two commands in sequence. This is because the controller
doesn't know if you ever read the status, and it will execute the
next command, if one exists, as soon as it writes the completion status
from the previous.

The next step of the "universal" sequence, if the previous doesn't
work, would be to enable the fast A<20> bit (only) in port 0x92.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
