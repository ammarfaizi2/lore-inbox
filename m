Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281213AbRKHAvy>; Wed, 7 Nov 2001 19:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281215AbRKHAvq>; Wed, 7 Nov 2001 19:51:46 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:6052 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281213AbRKHAvc>; Wed, 7 Nov 2001 19:51:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: /proc discussions
Date: Thu, 8 Nov 2001 01:54:21 +0100
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E161YM0-00055o-00@the-village.bc.nu>
In-Reply-To: <E161YM0-00055o-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <161dPS-18sUaWC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 November 2001 20:27, Alan Cox wrote:
> > Here's my go at a new design for /proc. I designed it from a userland
> > point of view and tried not to drown myself into details.
> Did you have to change the subject line. It makes it harder to kill file
> when people keep doing that

There is an easy way for you, or even better, Linus to stop these discussions:

Just say, in unambigous words, what kind of patch you would accept, if any. 
The open questions are: in which format should data (from driver and kernel) 
be exported? How can the kernel, drivers and devices be configured from user 
space?
Even better, you could also say a few words about the possible disadvantages 
that the decision has and why we shouldn't care. Something like "performance 
is irrelevant", "it doesn't matter if the format cannot be changed without 
breaking user applications", "for every format there must be a strict 
definition of how to parse it so that the new fields can be added later", "we 
don't need to define the format as long at it is readable for human readers", 
"if you need a pretty format write some user space tool that formats it", "it 
doesnt matter if each file uses a completely different format", "it is not 
acceptable to break any user space applications before 2.x", "strict typing 
is irrelevant"...


I REALLY do have problems to define any proc interface without having at 
least one of the disadvantages above. I have spent some time to find LT 
statements about proc/sysctl in order to find out which way may have a chance 
to get into the kernel (this time is possibly better spent than writing 
another proc replacement :). Maybe I have missed some important ones, in 
essence they are:

4 Nov 2001:
"In short: /proc is ASCII, and will so remain while I maintain a kernel.
Anything else is stupid.
Handling spaces and newlines is easy enough - see the patches from Al
Viro, for example."

4 Nov 2000:
"[context added]
>        create_proc_entries(NULL,
>                "test:{bar:{x:%d,y:%d,z:%d},foo:%f}",
>                &x, &y, &z, foo_fun);
>
> creates a "/proc/test" directory, which further contains a
> subdirectory "bar" and a file "foo". The "bar" subdirectory contains
> three files "x", "y" and "z".
> 
> The formatting argument "%d" takes a pointer to an integer. When
> reading such a file (in this case "x", "y", or "z"), the value is
> shown as ascii. Writing to the file (again in ascii) updates the
> value. The "%f" formatting argument allows you to pass an arbitrary
> user function for generating output. Clearly, there are potentially
> quite a number of standard/useful formatting arguments.
> 
> I've done a quick, dirty, unfinished implementation of this idea, so
> people can get the picture. Attached.
> 
> Many people will hate this because (1) it's doing parsing within the
> kernel, (2) it tends to favour ascii I/O, (3) it tends to favour deep
> directory hierarchies,(4) it uses recursion :-)

I like the idea a lot: it's simple, it's clean, and it does make it truly
trivial to build up a simple /proc architecture.
"

7 Jan 2000:
"In contrast, sysctl isn't all that performance-sensitive, AND they are
extremely hierarchical, AND they depend on configuration and timing. 

In short, sysctl NEEDS:
 - "naming": you cannot name the sysctl space with a number: it is much
   too dynamic for that. How do you enumerate drivers? Give them random
   numbers?
 - "listing": showing which sysctl's are there, in a hierarchical manner.
   Again, a listing is useless with a number.
 - "hierarchy". You have different devices, but they have the same
   controls. Do they get the same name? Yes. But in different places in
   the hierarchy.

In short, you NEED a filesystem. You need to be able to "ls" the thing.
You need to be able to search the thing. You need to be doing all the
things you can do with a real filesystem."

6 Jan 2000:
"The thing to do is to create a

        /proc/drivers/<drivername>/ 

directory. The /proc/drivers/ directory is already there, so you'd
basically do something like

        create_proc_info_entry("driver/mydriver/status", 0, NULL, 
mydriver_status_read);
"

1 Jan 1998:
"- I think it should be a separate filesystem type. It was a mistake in
 the first place to overload /proc as much as we did, we shouldn't
 continue that (I should really have split out the "per-process" things
 and the "global" things to two separate filesystems). "


Is the 4-Nov-2000 mail combined with 1-Jan-1998 the answer?

bye...



