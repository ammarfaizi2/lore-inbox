Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTFKAiX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTFKAiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:38:22 -0400
Received: from mail.ithnet.com ([217.64.64.8]:32265 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S262386AbTFKAiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:38:18 -0400
Date: Wed, 11 Jun 2003 02:51:47 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, willy@w.ods.org, marcelo@conectiva.com.br,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030611025147.04ecb2bd.skraw@ithnet.com>
In-Reply-To: <144290000.1055268419@caspian.scsiguy.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<144290000.1055268419@caspian.scsiguy.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003 12:07:00 -0600
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:

> >> I never said that it wasn't serios, I just haven't seen any indication
> >> that this problem is caused by my driver.  There is a big difference.
> >> If your complaint is that I typically help people to solve their problems
> >> *off-list*, then I'm sorry if that offends your sensibilities.
> >
> > It does not offend my sensibilities, it is simply damaging the available
> > information about typical problems and their solving. If you don't do it
> > open, there is no way for others to follow your thoughts and debugging and
> > therefore you are confronted hundred times with the same questions. People
> > have no choice but asking you, because your debugging cases are hidden.
> 
> 99% of the problems have to do with broken interrupt routing.  There is
> plenty of information about this issue on the mailing lists, but people
> still ask me.

You should state an exact definition of "broken interrupt routing" in this
case. The only thing I would call a broken interrupt routing is if an interrupt
does not show up at all. Everything else is in my eyes a broken interrupt
handling in the driver (generally spoken). A driver has (in my programming
world) to cope with:
- interrupts showing up immediately during the currently running interrupt
handling (immediate recausing)
- multiple interrupt causes per one shot (software or interrupt controller were
to lazy for producing single interrupts per cause)
- lost interrupts (may cause error condition of course but at least a message
in some log)
- continous interrupts (handler has to know when he is too long inside
interrupt and give the rest of the system a chance to survive)
- optimistic interrupt requeuing (handler has to know from the past what is the
right flow of interrupt causes in a multiple caused interrupt, though hardware
may be unable to tell him).

> I just don't believe that this is true.  Most of the questions that people
> email me directly are questions that are easily answered by a google search.
> In otherwords, the information is already readily available.  It is just
> easier to send email than to actually investigate a potential solution
> to the problem.  So, people send email and ask the same questions, and
> get the same answers.

Do you have a FAQ?

> >> >> a buffer layer bug, or a filesystem bug.
> >> >
> >> > /dev/tape with a filesystem? Have you read what we are talking about?
> >>
> >> Where did you get the data to place on the tape?  /dev/zero?
> >
> > Don't be silly. If reading a file from some hd would be a problem in
> > itself, then we could all go home and have a beer. You are talking about
> > the minimum requirement for an os.
> 
> You're the one being silly.  You are oversimplifying what it takes to
> do I/O and the components that are involved in doing that I/O.  If you
> don't understand that the load on several components in the kernel changes,
> often in subtle but important ways, when you change the target of your
> I/O, then I don't know what to say to you.

Data corruption is nothing subtle. We are not talking about performance tweaks,
we are talking about the basics. Something like "a synchronous action (like
reading during a verify) has to be synchronous". We are not talking about a
hardware related problem on scsi bus. We are not talking about the box
stumbling over a massive data flood. We are talking about reading a file/device
to a memory buffer and doing a cmp action between two of those. If your os is
not able to perform something like this you can do virtually nothing, not even
booting (because your reading action corrupts the data).

> >> >>  When testing our drivers against RHAS2.1 we found that the stock
> >> >> kernel had data corruption issues very similar to what your are talking
> >> >> about when run on very fast, hyperthreading, SMP machines.  The data
> >> >> corruption occurred with any SCSI controller we tried, regardless of
> >> > vendor.
> >> >
> >> > My question is: is it solved?
> >>
> >> My understanding is that it was fixed in 2.4.18 level kernels, but since
> >> I don't know the root cause of the corruption, it could have just been
> >> made more difficult to reproduce.
> >
> > Can you point to some URL where information about this is available?
> 
> https://rhn.redhat.com/errata/RHSA-2003-147.html

The scenario described there is unlikely for my case because 
a) I have only 3 GB of mem
b) no hints are available that UP can solve the problem on the same hardware 


> > No, it is only the most simple one. Unfortunately scsi-driver development
> > is everything but simple for the standard problem case. It requires the
> > ability to set up equipment just like the discussed case for reproduction
> > of the problem.  Of course only for cases the author cannot reproduce
> > inside his software via brain.  All information needed to reproduce the
> > main problem is available in this thread.
> 
> To reproduce your problem, I need the same MB, memory configuration, drive
> types, a 3ware card, and the same tape drive you have.  I have tried various
> backup scenarios with *other hardware* and have failed to reproduce your
> problem.

I have talked to others with similar problems and none has the same mb or a
3ware controller. All have problems with streamers on aic. All solutions I
heard so far were done by replacing aic by whatever strange controller they got
their hands on.

> >> I suggest you go browse the code that is exercised by such an activity
> >> before you say that.
> >
> > What kind of a statement is this?
> 
> Its one way of saying that you need to understand all of the code involved
> with turing a write syscall into a call into the aic7xxx driver.  If you
> review the code path, you'll find that there are thousands of lines of
> code involved that have nothing to do with SCSI or the aic7xxx driver.
> To say that you have created a simple example that proves that the problem
> is in the aic7xxx driver is naive at best.

To tell me it is not is just as good. 

> In this case, the information you have so far provided points away from
> the aic7xxx driver.  I don't say that in all cases that I investigate,
> but I believe it to be true in this case.  If past experience is any guide,
> 80-90% of the problems like this that I have debugged (and that I could
> actually replicate) were induced by using the aic7xxx driver, but turned
> out to be bugs in other components in the system.  The aic7xxx driver
> happens to be one of the more agressive SCSI drivers in the system and
> that can often lead to finding bugs in other components.

Agressive is indeed a good term for it. And it describes exactly what I don't
like about it. The primary goal of a driver (in my eyes) is to make some
connected hardware work as expected. It is definitely not its primary goal to
be overly brilliant and therefore detecting bugs in other subsystems. I have
told you months ago that a symbios driven systems feels somehow smoother and
faster - elegant. Whereas aic gives you the feeling someone tried to kick the
systems butt with a big hammer. Its a matter of style and _defensiveness_. 
As long as you ride it agressively don't complain a lot of people go after you
for explanations.
And btw: you win nothing with your way, not even performance.

> > Back to the facts:
> > Simple question: you say its not a problem inside the driver. Ok. Question:
> > how to you prove that? Can you specify a test setup (program or something)
> > I can check to see that there is no problem with the general SMP tape usage
> > of the aic driver? I mean you must have seen something working, or not?
> 
> The only way to do this is to find the actual bug.  The problem feels like
> a VM or FS race condition most likely caused by having the source controller
> and the destination controller on separate interrupts in the apic case so
> that you have real concurrency in the system.  In the non apic case, it looks
> like everyone shares the same interrupt, so you cannot field interrupts
> for both the 3ware and the aic7xxx driver at the same time.  I also say
> this because data corruption is something that is very difficult for the
> aic7xxx driver to acomplish without there being some kind of error message
> from the driver.

Well, at least I managed to get some interesting statement from you after all.
I have to think about this a bit.

> I have lots of test setups that show the aic7xxx and aic79xx driver working
> just fine in PIII and P4 dual and quad configurations with and without apic
> interrupt routing and writing to tape.

This does only mean you have not yet met something similar to my setup. It does
not really prove a lot.

>  There's not much more that I can
> do here without having your exact system here or having more information.

Well, the thing is, I try to achieve information. But since the whole issue is
all about lots of data I try to find an intelligent way to locate the cause of
it all. I am not very confident that analysis of the trashed data will lead
somewhere. I think narrowing the code path that leads to the problem by
multiple distinct test scenarios looks more/faster promising. Can you think of
something reducing the test complexity (not using tar, not comparing to a file
or whatever)?

Regards,
Stephan

