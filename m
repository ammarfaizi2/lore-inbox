Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWGMQPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWGMQPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWGMQPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:15:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:22567 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932475AbWGMQPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:15:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=An3wXqG8pxaB1EHLsuiWraI8bqUx8JsB9VICaTrJirw/k6we07b9Q55K7zpU3iczBJtVaYj3RBgYYGwujLdHJxWy4qb/9XmINExU9/TH1fYNbuKE2O9qp8xBJmK4HLBC97m7JZuxZJTTEjyN170tna2+Z5p5WBOQTxoy0H+57AA=
Message-ID: <787b0d920607130915q664d298bra8f6fee9286d8109@mail.gmail.com>
Date: Thu, 13 Jul 2006 12:15:06 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
Cc: ak@suse.de, tytso@mit.edu, drepper@redhat.com, arjan@infradead.org,
       rdunlap@xenotime.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org
In-Reply-To: <m164i257sl.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607122200m4785f7ddmddf40c079a7460cb@mail.gmail.com>
	 <m164i257sl.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Albert Cahalan" <acahalan@gmail.com> writes:
> > Andi Kleen writes:
> >> On Thursday 13 July 2006 01:24, Theodore Tso wrote:
> >
> >>> P.S.  I happen to be one those developers who think the binary
> >>> interface is not so bad, and for compared to reading from /proc/sys,
> >>> the sysctl syscall *is* faster.  But at the same there, there really
> >>> isn't anything where really does require that kind of speed, so that
> >>> point is moot.  But at the same time, what is the cost of leaving
> >>> sys_sysctl in the kernel for an extra 6-12 months, or even longer,
> >>> starting from now?
> >>
> >> The numerical namespace for sysctl is unsalvagable imho. e.g.
> >> distributions regularly break it because there is no central
> >> repository of numbers so it's not very usable anyways in practice.
> >
> > Huh? How exactly is this different from system call numbers,
> > ioctl numbers, fcntl numbers, ptrace command numbers, and every
> > other part of the Linux ABI?
>
> The only practical difference is that what people use is
> /proc/sys so the binary sysctl interface is not seriously maintained
> and bugs crop up.

There is a chicken-and-egg problem here then.
Let's fix it.

I maintain the sysctl program, which most Linux
distributions run at boot. I agree to switch to the
binary sysctl interface if somebody will maintain
the kernel side of things. This will shave a bit of
time off boot on nearly every Linux box out there.
The total time saved is probably a human lifetime,
so it's like saving somebody's life.

> > Normal sysctl works very well for FreeBSD. I'm jealous.
> > They also have a few related calls that are very nice.
> >
> > Here we fight over a few CPU cycles in the syscall entry path,
> > then piss away performance by requiring open-read-close and
> > marshalling everything through decimal ASCII text. WTF? Let's
> > just have one system call (make_XML_SOAP_request) and be done.
>
> There is a cost to open-read-close.  But as a simple benchmark
> against a file will show reading data from /proc/sys is much slower
> than reading data from a file.
>
> From what I have been able to measure so far, open-read-close only
> seems to double the cost over sysctl, and access can do the filename
> resolution about as quickly as sysctl can deal with a binary path.  So
> I suspect it is the allocation of struct file that makes
> open-read-close more expensive.  Reading the data is in the noise.

Eh? A factor of two is not "in the noise".

> sysfs current does a lot better than /proc/sys I think it was only
> 60% heavier than performing the same operation on a real file.

That is still a horrible way to piss away performance.

> Performance wise there does seem to be a problem with the
> implementation.  How to fix it I don't yet know.  But I have
> yet to see ascii text be implicated.

I have more experience with /proc. There, ASCII is
known to be a problem.

Parsing a 64-bit number is horribly slow on i386.

Matching keywords, as is needed for /proc/*/status,
is also horribly slow. I ended up using gperf to make
a perfect hash table, then gcc's computed goto for
jumping to the code, and it still wasn't cheap to do.
(while /sys lacks this, the extra open-read-close is
certain to be far worse)
