Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWGMQza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWGMQza (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWGMQza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:55:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48301 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030241AbWGMQza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:55:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: ak@suse.de, tytso@mit.edu, drepper@redhat.com, arjan@infradead.org,
       rdunlap@xenotime.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <787b0d920607122200m4785f7ddmddf40c079a7460cb@mail.gmail.com>
	<m164i257sl.fsf@ebiederm.dsl.xmission.com>
	<787b0d920607130915q664d298bra8f6fee9286d8109@mail.gmail.com>
Date: Thu, 13 Jul 2006 10:53:58 -0600
In-Reply-To: <787b0d920607130915q664d298bra8f6fee9286d8109@mail.gmail.com>
	(Albert Cahalan's message of "Thu, 13 Jul 2006 12:15:06 -0400")
Message-ID: <m1lkqx30pl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert Cahalan" <acahalan@gmail.com> writes:

> On 7/13/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> "Albert Cahalan" <acahalan@gmail.com> writes:
>> > Andi Kleen writes:
>> >> On Thursday 13 July 2006 01:24, Theodore Tso wrote:
>> >
>> >>> P.S.  I happen to be one those developers who think the binary
>> >>> interface is not so bad, and for compared to reading from /proc/sys,
>> >>> the sysctl syscall *is* faster.  But at the same there, there really
>> >>> isn't anything where really does require that kind of speed, so that
>> >>> point is moot.  But at the same time, what is the cost of leaving
>> >>> sys_sysctl in the kernel for an extra 6-12 months, or even longer,
>> >>> starting from now?
>> >>
>> >> The numerical namespace for sysctl is unsalvagable imho. e.g.
>> >> distributions regularly break it because there is no central
>> >> repository of numbers so it's not very usable anyways in practice.
>> >
>> > Huh? How exactly is this different from system call numbers,
>> > ioctl numbers, fcntl numbers, ptrace command numbers, and every
>> > other part of the Linux ABI?
>>
>> The only practical difference is that what people use is
>> /proc/sys so the binary sysctl interface is not seriously maintained
>> and bugs crop up.
>
> There is a chicken-and-egg problem here then.
> Let's fix it.
>
> I maintain the sysctl program, which most Linux
> distributions run at boot. I agree to switch to the
> binary sysctl interface if somebody will maintain
> the kernel side of things. This will shave a bit of
> time off boot on nearly every Linux box out there.
> The total time saved is probably a human lifetime,
> so it's like saving somebody's life.

:)

I don't want to make any commitments until we have thrashed
this out at kernel summit and OLS.  

>> > Normal sysctl works very well for FreeBSD. I'm jealous.
>> > They also have a few related calls that are very nice.
>> >
>> > Here we fight over a few CPU cycles in the syscall entry path,
>> > then piss away performance by requiring open-read-close and
>> > marshalling everything through decimal ASCII text. WTF? Let's
>> > just have one system call (make_XML_SOAP_request) and be done.
>>
>> There is a cost to open-read-close.  But as a simple benchmark
>> against a file will show reading data from /proc/sys is much slower
>> than reading data from a file.
>>
>> From what I have been able to measure so far, open-read-close only
>> seems to double the cost over sysctl, and access can do the filename
>> resolution about as quickly as sysctl can deal with a binary path.  So
>> I suspect it is the allocation of struct file that makes
>> open-read-close more expensive.  Reading the data is in the noise.
>
> Eh? A factor of two is not "in the noise".

The factor of two comes from just the fd = open(); close(fd); 
Throwing a read into a loop where I am measuring things does not change
the cache hot cost in a measurable way.  Which says the cost
is in the gyrations we use to get to the data, not in getting
the data itself.

The fact that we have bottlenecks even when cache hot is interesting.

>> sysfs current does a lot better than /proc/sys I think it was only
>> 60% heavier than performing the same operation on a real file.
>
> That is still a horrible way to piss away performance.

Agreed.  But it is a lot better than the 5x performance hit of /proc/sys
I see over regular files.

Since I was measuring the cache hot case it may simply be that
generating the data no matter how fast we do it is slower than
simply copying the data.

>> Performance wise there does seem to be a problem with the
>> implementation.  How to fix it I don't yet know.  But I have
>> yet to see ascii text be implicated.
>
> I have more experience with /proc. There, ASCII is
> known to be a problem.
>
> Parsing a 64-bit number is horribly slow on i386.

I can see that.  Of course if that was the only problem
converting the number into hex would make the parsing
trivial again.

> Matching keywords, as is needed for /proc/*/status,
> is also horribly slow. I ended up using gperf to make
> a perfect hash table, then gcc's computed goto for
> jumping to the code, and it still wasn't cheap to do.
> (while /sys lacks this, the extra open-read-close is
> certain to be far worse)

I agree matching keywords and such seems slow.

If the only overhead comes from open-read-close we can
come up with a sys_readfile that doesn't need to actually
open the file for one shot cases.

The cost of a system call (getpid) is largely in the noise 
compared to the cost of sysctl and open-read-close on files.
So I'm not convinced a multiple system call approach is a bad thing.

Regardless of where we go what is clear from my preliminary
investigation is that our interfaces to in kernel data are
slow and there is a lot of room for improvement.

Eric



