Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSF0QfO>; Thu, 27 Jun 2002 12:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSF0QfM>; Thu, 27 Jun 2002 12:35:12 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:4235 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S316885AbSF0QfE>; Thu, 27 Jun 2002 12:35:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Robert White <rwhite@pobox.com>
Reply-To: rwhite@pobox.com
To: Ed Vance <EdV@macrolink.com>, "'Theodore Tso'" <tytso@mit.edu>,
       "'Russell King'" <rmk@arm.linux.org.uk>
Subject: Re: n_tty.c driver patch (semantic and performance correction) (a ll recent versions)
Date: Thu, 27 Jun 2002 09:37:17 -0700
X-Mailer: KMail [version 1.4.5]
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <11E89240C407D311958800A0C9ACF7D13A789A@EXCHANGE>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A789A@EXCHANGE>
X-Evil-Bastard: True (but nice about it)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206270937.17335.rwhite@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

Actualy you are wrong about the "Standard".  The Linux manual pages only say 
the read will return when so many characters have been received.  
Alternately, the System V Interface Definition (in every version I have been 
able to find on the net) speaks in terms of "satisfying the read" .  Both are 
silent on the issue of what to do if the read is asking for less than VMIN 
character.

That is, since theVMIN/VIME mechanisim exists only with respect to each 
individual read request and not with respect to any kind of driver state, 
there is no inferrance or onus that says the state applies to anything other 
than the receipt of charactersfrom the driver too the read itself.

That is, the context for the word "received" MUST BE "received into the read 
buffer."  [or perhaps "received into the user context"].  How so, you may 
ask?

If "received" is in respect to the UART (e.g. the machine/hardware boundry) 
then it would be ture that if there were 100 characters in the driver's 
internal buffer, VMIN were 1, VTIM were 1, and a read were issued but nomore 
characters were "received" by the UART then the read would never return.  
That is, by the standard, "one character must be received to start the timer, 
and one character must berceived minimum" so if "receied" means"into the 
driver" instedof "into the user context" the 100 characters in the buffer, 
having been received in the past would not relate the read (and so on od 
nasium 8-)   That would be rediculous.

Since in every stated and useful sense the VMIN and VTIME mechanisims exist 
spesfically and expressley for the purpose of satisfying individual read 
requests, that is in terms of the user-context/program "receiving" data from 
the abstract "device" at the file interface, data that can not possibly 
relate to a read because it is "out of bounds"  is immaterial to the act by 
defintion.  So waiting for the user context to receive characters it has not 
asked for and can not possibly receive is a "bad thing".

The "waiting for data that can't be returned" and/or the inconsistent 
application of the concept of "received" serves nobodies interests.

I was going to simply dismiss that bit of hyperboli (sp?) about poll as a 
cheap bit of bad "debate technique" but I'v decided to respond.

Poll aready and explicitly addresses the size of the read and/or write as one 
character, so tossing it in as if it were an example was logcally junct.  
Addintionally, to make the example work you "threw in" with a comment about 
"adding an argument to poll."  The reason that this was fatuous is that the 
parameter you would "add"  to poll would be disruptive (which is why you put 
it in 8-) but the information is already provided in the read, the buffer 
length IS ALREADY being passed.  The analogy and the allegation of dificulty 
or disruption is inapplicable.

Rob.

PS I am using a horribly lossy link and an almost unreadable font (I love 
traveling on business 8-) so please excuse the particularly bad spelling, 
grammar, and puncuation... 8-)

On Wednesday 26 June 2002 10:48, Ed Vance wrote:
> Hi Robert,
>
> On Sat, June 15, 2002, Robert White wrote:
> > The n_tty line discipline module contains a "semantic error"
> > that limits its speed and usefullness in many uses.  The
> > attached patch directly addresses serial performance in a
> > completely backwards-compatable way.
> >
> > In particular, the current handling of VMIN hugely limits,
> > complicates, and/or slows down optimal serial use.  The most
> > obvius example is that if you call read(2) with a buffer size
> > less than the current value of VMIN, the line discipline will
> > insist that the read call wait for characters that can not be
> > returned to that call.  The POSIX standard is silent on the
> > subject of whether this is right or wrong.  Common sense says
> > it is wrong.
>
> Ten years ago, I would have agreed with you. I suggested a very
> similar change for VTIME=0;VMIN>0 behavior back then, while we
> were porting SVR4 to proprietary hardware. This was for
> compatibility with the way reads were handled on a previous
> non-un*x product. It was deemed a spec violation, so we added an
> ioctl to implement the compatible behavior.
>
> Does the spec say that VMIN behavior depends on the size of a
> blocking read? No, it says that the read completes when VMIN or
> more characters have been received. If VMIN is three and two
> characters have been received, completing a blocking read of any
> size is a violation. Should we also add a "read buffer size"
> parameter to select and poll, etc. so they can report that read
> data is available before satisfying VMIN, too?
>
> Ted, Russell, please weigh in on this.
>
> Best regards,
> Ed
>
> ----------------------------------------------------------------
> Ed Vance              edv@macrolink.com
> Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
> ----------------------------------------------------------------

