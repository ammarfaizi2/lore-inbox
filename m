Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317949AbSFNQPY>; Fri, 14 Jun 2002 12:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317950AbSFNQPX>; Fri, 14 Jun 2002 12:15:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:56078 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317949AbSFNQPV> convert rfc822-to-8bit; Fri, 14 Jun 2002 12:15:21 -0400
Message-ID: <3D0A1692.6070304@evision-ventures.com>
Date: Fri, 14 Jun 2002 18:15:14 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D09F769.8090704@evision-ventures.com> <20020614151703.GB1120@suse.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Jens Axboe napisa³:
> On Fri, Jun 14 2002, Martin Dalecki wrote:
> 
>>Thu Jun 13 22:59:54 CEST 2002 ide-clean-91
>>
>>- Realize that the only place where ata_do_taskfile gets used is ide-disk.c
>>  move it and its "friends' over there.
> 
> 
> Ehm, isn't that a bit odd? The typical "I'm not looking at the
> interface, if only one person is currently using it then heck lets move
> it" Martin approach (refer to prep_rq_fn cdb builder as well)

Yes this is the usual Marcin aproach. The fscking best road to bloat
is providing interfaces "on the heap" and "just in case", which
then nobody sane uses. Wen one discovers later that they are inadequate,
we try to support them until the end of days becouse
some silly python based incompetently written setup application
turns out to love to having you know what with.

And since application level programming expierence shows me that in 99%
of the cases where interfaces are designed in front of beeing used
they turn out to be inadequate I don't do it.

Won't to see some silly things like the situation described above?
Please just count the number of ioctl for the /dev/random.
90% of them qualify as "debuggin during developement" or are
working against the purpose of the thing. Just one example.
Once another even more striking is the whole /proc/ mess.

> The above is just a minor thing, the reason I'm mailing is really:
> 
> - current 2.5 bk deadlocks reading partition info off disk. Again a
>   locking problem I suppose, to be honest I just got very tired when
>   seeing it happen and didn't want to spend tim looking into it.

2.5.21 + the patches I did doesn't. Likely it's the driverfs?

> I thought IDE locking couldn't get worse than 2.4, but I think you are
> well into doing just that. What exactly are you plans with the channel
> locks? Right now, to me, it seems you are extending the use of them to
> the point where they would be used to serialize the entire request
> operation start? Heck, ide-cd is even holding the channel lock when
> outputting the cdb now.

After extracting out 80% of the host controller register file
access one has to realize that in reality we where releasing the lock
just to regain it immediately. Or alternatively accessing them
without any lock protection at all. (Same goes for BIO ummer layer
memmbers.) This is why they are pushed up. It's just avoiding the
"windows" between unlock and immediate relock and making the real
behaviour more "obvious". You have just realized this.

2.4 prevents the locking problems basically by georgeously
disabling IRQs. Too fine grained locking is a futile exercise.
Unless I see the time spent in system state during concurrent disk
access going really up (it doesn't right now), I don't see any thing
bad in making the locking more coarse. Locks don't came for free and
having fine grained locking isn't justifying itself.

Another "usual Marcin approach" - don't optimze for the sake of it.
See futile unlikely() tagging and inlining in tcq.c for example.
I don't do somethig like that. I have just written too much
numerical code which was really time constrained to do something
like this before looking at benchmarks.
Really constrained means having a program running 7 or "just"
5 *days*. This can make a difference, a difference in hard real
money on the range of multiple kEUR!

Finally - unless there appears some aother way to block access to
busy devices on the generic block layer I do it the only way
we have right now - spinlocks. (... looking forward to working
queue pugging and the work done by Adam richter).
Unless there is a sane way to signal partial completion - we will
be doing it at once. Unless we have a sane async io infrastructure
most of the above will be likely not solved anyway.

> - ata_end_request(). why didn't you just remove the last argument to
>   __ata_end_request() instead just changing the comment saying why we
>   pass nr_secs == 0 in from some sites?

One step after another. Watch for hard_xxx members from struch request
to see why I hesitated please.

> - what's the reasoning behind moving the active request into the
>   ata_device?! we are serializing requests for ata_device's on the
>   ata_channel anyways, which is why it made sense to have the active
>   request there.

Becouse it is going to go away altogether. We need it there
just only for the purpose of the default ide_timer_expiry function, which
is subject to go away since a long time. And finally becouse
it doesn't hurt.

Further on I refer you to the discussion we had (or was it Linus?)
once about the fact that attaching physical properties of the
device to the request queue and replicating those parameters in
every single request struct, is well ... "unpleasant" on behalf of the
upper layers. Loop devices expose the same problem.
Once again just grepping for hard_ memebers of the struct
request makes it obvious.

Somce people say that using the gratest common denominator in
the case of the loop devices is the  solution,
but I think that it's rather a work around.

> And finally a small plea for more testing. Do you even test before
> blindly sending patches off to Linus?! Sometimes just watching how
> quickly these big patches appears makes it impossible that they have
> gotten any kind of testing other than the 'hey it compiles', which I
> think it just way too little for something that could possible screw
> peoples data up very badly. Frankly, _I'm_ too scared to run 2.5 IDE
> currently. The success ratio of posted over working patches is too big.

Fact is: many of the patches are just big becouse they contain
host chip handling cleanups done by others, and becouse
we have just too many different drivers for the same purpose:
ATAPI packet command devices. Which I'm more and more tempted
to scarp... in favour of just ide-scsi.c. But that's another
story. (Adam J. Richter is givng me constant preassure to do just that and I 
start really tending to admitt that he is just right.)

As of testing. Well at least I can assure you that I'm eating my dogfood,
since I run constantly on the patches. (Heck even the time I write this.)
But I don't use kernels from the BK repository at all.
In fact I just don't use BK at all and I don't intend too.

