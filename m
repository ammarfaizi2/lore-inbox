Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318839AbSG0WEm>; Sat, 27 Jul 2002 18:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318836AbSG0WEm>; Sat, 27 Jul 2002 18:04:42 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:65499 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S318835AbSG0WEj>; Sat, 27 Jul 2002 18:04:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Robert White <rwhite@pobox.com>
Reply-To: rwhite@pobox.com
To: Russell King <rmk@arm.linux.org.uk>, Ed Vance <EdV@macrolink.com>
Subject: Re: n_tty.c driver patch (semantic and performance correction) (a ll recent versions)
Date: Sat, 27 Jul 2002 15:07:56 -0700
User-Agent: KMail/1.4.1
Cc: "'Theodore Tso'" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
References: <11E89240C407D311958800A0C9ACF7D13A789A@EXCHANGE> <20020726151723.F19802@flint.arm.linux.org.uk>
In-Reply-To: <20020726151723.F19802@flint.arm.linux.org.uk>
X-Evil-Bastard: True (but nice about it)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207271507.56873.rwhite@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree that that is what that line of the text says, my position is that the 
entire statement was was written nieavely, and proveably so.  Throughout the 
entire section the standard (not the linux manual page) discusses "satisfying 
a read" (singular).  The text was written with an "everybody will know 
basically what I mean" aditude that leaves it flawed for strict 
interpretation.  And the linux manual pages still show through enough to use 
as the bases of my argument.

Pre-Summary: My entire position rests on what the original author meant by 
"receive".  That is, is it "receive into the driver" or "receive into the 
user context".  He proveably meant receive into the user context (e.g. the 
read buffer).

The best example to use for the "sloppyness" of writing in the standard and 
manual page is that technically, if it is "receive into the driver", if you 
have both VMIN and VTIME set non-zero, VTIME will not start until "a 
character is received" which, by strict intrepertation of "received (by the 
driver)", discounts the presence of any characters in the buffer.  Restated, 
if it is "receive into the driver" this read will wait for a new character 
even if there are hundreds of characters already buffered.

(CITATION: from the linux manual page: "When both are set, a read will wait 
until at least one character has been received, and then return  as  soon  as 
either  MIN  characters  have been received or time TIME has passed since the 
last character was received.")

This "clearly states" that if you have a meg in the buffer (passed-tense 
received) the driver "will  wait for a character to be received" (imparative 
future tense) but we all know that is dumb...

Even the existing implementation for VMIN and VTIME has them in the user read 
context already, which is why the round-down is only the one compound 
statement.  That clearly shows that "received" is interpreted as "received 
into the user context (read buffer)."

IF the context of "to receive", that is, the boundry between here and not-here 
is fixed, by definition, to the read call itself, the technicalities all 
disapear except one, that one being what to do if VMIN is greater than the 
receive (read) buffer size since, in this more-consistent boundry point "to 
receive" across, the more-than-buffer-sized characters can't ever then be 
received by definition.  The obvious interpretation is then not to wait for 
the unreceivable characters.

There are more examples of the "received by" being the read call, and the 
"received from" being the driver instead of the hardware.  Look at when 
non-raw processing take place.

Having only the raw-mode processing "receive" at the hardware level (with the 
buffer tossed in halfway because we all know that's what it means 8-) doesn't 
make consistent sense.  Especially if it is to preserve a conception that 
isn't ever used "in the wild".

Rob.


On Friday 26 July 2002 07:17, Russell King wrote:
> On Wed, Jun 26, 2002 at 10:48:30AM -0700, Ed Vance wrote:
> > Does the spec say that VMIN behavior depends on the size of a
> > blocking read? No, it says that the read completes when VMIN or
> > more characters have been received. If VMIN is three and two
> > characters have been received, completing a blocking read of any
> > size is a violation. Should we also add a "read buffer size"
> > parameter to select and poll, etc. so they can report that read
> > data is available before satisfying VMIN, too?
> >
> > Ted, Russell, please weigh in on this.
>
> I just found this mail again.  Yes, I agree with your interpretation,
> which reflects the code we presently have, as well as my reading of
> SuS.  The SuS is quite clear that "A pending read shall not be
> satisfied until MIN bytes are received".  It doesn't say "A pending
> read shall not be satisfied until MIN bytes or the number of requested
> bytes in read() are received"
>
> In addition, it also says "MIN represents the minimum number of bytes
> that should be received when the read() function returns successfully."
> Successful completion for read() is defined as "Upon successful
> completion, read() shall return a non-negative integer indicating the
> number of bytes actually read."
>
> So, for _any_ read() to a terminal with MIN set, for this call to
> return data (ie, success) MIN bytes must have been received.
>
> (Note that the behaviour where the number of bytes > MIN seems to be
> a little vague, SuS just talks about "block the calling thread until
> _some_ data becomes available" for the blocking case.)
>
> I'd be interested to know if Ted agrees with my position here; he is
> the author of the tty code, and is presently looking at that area.

