Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSF2E3o>; Sat, 29 Jun 2002 00:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317192AbSF2E3n>; Sat, 29 Jun 2002 00:29:43 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:41195 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S317180AbSF2E3j>; Sat, 29 Jun 2002 00:29:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Robert White <rwhite@pobox.com>
Reply-To: rwhite@pobox.com
To: Ed Vance <EdV@macrolink.com>
Subject: Re: n_tty.c driver patch (semantic and performance correction) (all recent versions)
Date: Fri, 28 Jun 2002 21:31:55 -0700
X-Mailer: KMail [version 1.4.5]
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       "'Theodore Tso'" <tytso@mit.edu>
References: <11E89240C407D311958800A0C9ACF7D13A78A2@EXCHANGE>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A78A2@EXCHANGE>
X-Evil-Bastard: True (but nice about it)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206282131.55271.rwhite@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My final comment on the mater (I am known around the office for my long 
emails... sorry 8-):

It is clear to me that you didn't really read what I wrote.

Consider:

I make the assertion "The linux manual pages only say the read will return 
when so many characters have been received" and then you CORRECT me by saying 
"The Linux termios man page says rather clearly that 'If only MIN is set, the 
read will not return before MIN characters have been
received'"

Ok, so the "only" didn't belong in my sentence but we were saying the same 
thing.  That is at least a little indicitive of the respondent not really 
reading the original.  But it continues.

I make an observation about how the (three messages back now) sender made an 
allusion to this correction being like "adding a buffer length parameter to 
poll"  When I point out that that allusion isn't applicable because the poll 
semantics really say "can read/write at least one character" (and therefore 
there is already a "buffer" length implicit in the spec, and further, "adding 
a buffer length to the poll would disrupt things in a way that USING the 
length already available in the read would not and blah blah blah).

Well, your response to my comment is that "that isn't how poll works" and then 
lecture me on how it does work, which was my essential lecture to the prior 
poster.

Ok so you are not reading what I have written on this matter with any 
attentiveness.  Let me put it in VERY SIMPLE WORDS.

-- Making a read wait for characters it can't accept is unilaterally stupid, 
at best it creates a relyance on "hidden magic state" that makes for 
unstable.

-- Living with the 1980 idea of the maximum reasonable frame size for 
any/every serial protocol is stupid.

-- Putting in an alternate ioctl (instead of putting in a two-statemet fix) 
that would largely duplicate the old behavior while releiving the stupid 
limits is (wait for it...) stupid, it rases code size and the level of 
complexity disproportionately and will tend to remain unused by the very 
people it would most benefit.

-- Decrying a fix you havn't tried because it "violates" a (porely written and 
demonstrably flawed) standard in a way that doesn't break a single existing 
program is not exactly "foreward thinking."

Or perhaps as a decomposition:

1) The current behavior is *STUPID* when MIN > read_buf_length.  I defy you to 
show me one program that deliberately uses this technique on any *NIX 
platform.

1a) NOTE: I didn't say I defy you to write one nor did I defy you to give the 
"pre-cache a few frames" theoretical example.  (that example still decomposes 
into inefficency, as the cost of prefetching frames into the buffer but then 
reading them via seprate calls is more costly over the domain of time than 
waitig for the frames individually "if necessary")

1b) I further defy you, should you find such a program, to show this patch 
adversely effecting it in any way.

2) People have been whining about the serial performance of linux for years.  
The fact remains that the repeated switches in and out of the kernel to 
satisfy fragmentary reads is almost certianly to blame.

2a) If the program knows the frame sizes of expected reads, and those frame 
sizes varry, the problem is compounded heniously (more than doubled) by 
actively manipulating VMIN. (repeadtely calling the ioclt to change this 
value)

2b) Virtually every program written today that does any sort of serial frame 
processing not only has a tight loop around the read() call to do frame 
assembly, it invariably ends up actually iterating into that loop for every 
read.  Each iteration is two context switches and some work.

2c) The current behavior MANDATES sucky performance in large-frame protocols.

2c1) Have you ever profiled X, Y, or Z modem performance?

2d) Have you ever dealt with vairable framed protocols that interract with 
specialty devices? (The "T equals 0" protocol for talking to smart-card 
readers is a perfect example of an application that improves by an order of 
magnitude with this patch.  Set VMIN to 255 with the patch on and your reads 
will always return the proper frame size which varry from 2 to 258;  But you 
can't use VMIN = VTIME = 0 because you need the timeout, and so on...)

3) The values of VMIN greater than 1 are almost unilaterally unheard of "in 
the wild" because the mechanisim sucks.  In the few cases where you find such 
a program this patch will, at the least, have a zero-sum effect; at the most 
it will speed the program up.

3a) For various reasons, interractive programs will continue to generally be 
written as VMIN = 1, VTIME = 1 reguardless of this patch. (somewhat by 
definition, this patch doesn't apply to interractive programs.)

4) The current VMIN behavior was thought up back when 1200 baud was rather a 
lot and CPUs weren't that fast.  As the CPU speed rises with respect to 
serial device speed the cost in context switches will approach 2 switches per 
character received.

5) "ioctl is your friend" isn't true here.

5a) adding another whole IOCTL et al would be needlessly adding to a module 
that is already quite large.  (compared to this tiny adjustment)

Ok, well, now I am just ranting.

Seriously, try this thing and look for one single bad case asside from the 
obvious "purest" objection.  Describing this patch as "pollution" is hardly 
applicable.

Rob.


On Friday 28 June 2002 11:12, Ed Vance wrote:
> Hi Rob,
>
> On Thu, June 27, 2002 at 9:37 AM, Robert White wrote:
> > Actually you are wrong about the "Standard".  The Linux manual
> > pages only say the read will return when so many characters
> > have been received.  Alternately, the System V Interface
> > Definition (in every version I have been able to find on the
> > net) speaks in terms of "satisfying the read" .  Both are
> > silent on the issue of what to do if the read is asking for
> > less than VMIN characters.
>
> The Linux termios man page says rather clearly that "If only MIN
> is set, the read will not return before MIN characters have been
> received". Your change would create cases where the read _will_
> return before MIN characters have been received. That is a conflict.


>
> > That is, since the VMIN/VTIME mechanism exists only with respect
> > to each individual read request and not with respect to any
> > kind of driver state, there is no inference or onus that says
> > the state applies to anything other than the receipt of
> > characters from the driver to the read itself.
> >
> > That is, the context for the word "received" MUST BE "received
> > into the read buffer."  [or perhaps "received into the user
> > context"].  How so, you may ask?
> >
> > If "received" is in respect to the UART (e.g. the machine/
> > hardware boundary) then it would be true that if there were 100
> > characters in the driver's internal buffer, VMIN were 1, VTIME
> > were 1, and a read were issued but no more characters were
> > "received" by the UART then the read would never return.
> > That is, by the standard, "one character must be received to
> > start the timer, and one character must perceived minimum" so
> > if "received" means "into the driver" instead of "into the user
> > context" the 100 characters in the buffer, having been received
> > in the past would not relate the read (and so on ad nauseum 8-)
> > That would be ridiculous.
>
> Termio, etc. specify the API, not the kernel's implementation of the
> API. All such driver software implements at least two levels of
> buffering to deal with the raw vs. canonical mode. The received data
> does not go directly to the user buffer. The data moves into the user
> buffer only when the read completes. Usually, the data received by
> the UART is handed up to a "line discipline" layer. In Streams
> implementations, there are (at least) three levels of buffering below
> the user's buffer: driver raw queue, line discipline private line
> assembly queue, and the stream head's queue.
>
> > Since in every stated and useful sense the VMIN and VTIME
> > mechanisms exist specifically and expressly for the purpose of
> > satisfying individual read requests, that is in terms of the
> > user-context/program "receiving" data from the abstract "device"
> > at the file interface, data that can not possibly relate to a
> > read because it is "out of bounds"  is immaterial to the act by
> > definition.  So waiting for the user context to receive
> > characters it has not asked for and cannot possibly receive is
> > a "bad thing".
>
> It operates as specified and does what you tell it to through the API.
> That is neither good nor bad, per se. That's just compliance. If you
> tell it to do something that you don't want, that's not a driver bug.
>
> > The "waiting for data that can't be returned" and/or the
> > inconsistent application of the concept of "received" serves
> > nobody's interests.
>
> Please make your good changes in a way that does not conflict with the
> existing API. Ioctl is your friend.
>
> > I was going to simply dismiss that bit of hyperbole about
> > poll as a cheap bit of bad "debate technique" but I've decided
> > to respond.
>
> Surprise.
>
> > Poll already and explicitly addresses the size of the read and/
> > or write as one character, so tossing it in as if it were an
> > example was logically junct.  Additionally, to make the example
> > work you "threw in" with a comment about "adding an argument to
> > poll."  The reason that this was fatuous is that the parameter
> > you would "add"  to poll would be disruptive (which is why you
> > put it in 8-) but the information is already provided in the
> > read, the buffer length IS ALREADY being passed.  The analogy
> > and the allegation of difficulty or disruption is inapplicable.
>
> That's not how poll and select are used. For the read case, Poll and
> Select are active when waiting for the availability of data. When data
> becomes available, they return and you post a read to scoop up the new
> data. There is no pending read during poll and select to supply a read
> buffer length to the driver.
>
> I have no problem with innovation. Just don't pollute the existing API.
>
> Regards,
> Ed
>
> ----------------------------------------------------------------
> Ed Vance              edv@macrolink.com
> Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
> ----------------------------------------------------------------

