Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317477AbSF1SKN>; Fri, 28 Jun 2002 14:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317476AbSF1SKM>; Fri, 28 Jun 2002 14:10:12 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:17674 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S317475AbSF1SKG>; Fri, 28 Jun 2002 14:10:06 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A78A2@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'rwhite@pobox.com'" <rwhite@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       "'Theodore Tso'" <tytso@mit.edu>
Subject: RE: n_tty.c driver patch (semantic and performance correction) (a
	 ll recent versions)
Date: Fri, 28 Jun 2002 11:12:21 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, June 27, 2002 at 9:37 AM, Robert White wrote:
> 
> Actually you are wrong about the "Standard".  The Linux manual 
> pages only say the read will return when so many characters 
> have been received.  Alternately, the System V Interface 
> Definition (in every version I have been able to find on the 
> net) speaks in terms of "satisfying the read" .  Both are 
> silent on the issue of what to do if the read is asking for 
> less than VMIN characters.

The Linux termios man page says rather clearly that "If only MIN 
is set, the read will not return before MIN characters have been 
received". Your change would create cases where the read _will_ 
return before MIN characters have been received. That is a conflict. 

> That is, since the VMIN/VTIME mechanism exists only with respect 
> to each individual read request and not with respect to any 
> kind of driver state, there is no inference or onus that says 
> the state applies to anything other than the receipt of 
> characters from the driver to the read itself.
> 
> That is, the context for the word "received" MUST BE "received 
> into the read buffer."  [or perhaps "received into the user 
> context"].  How so, you may ask?
> 
> If "received" is in respect to the UART (e.g. the machine/
> hardware boundary) then it would be true that if there were 100 
> characters in the driver's internal buffer, VMIN were 1, VTIME 
> were 1, and a read were issued but no more characters were 
> "received" by the UART then the read would never return.  
> That is, by the standard, "one character must be received to 
> start the timer, and one character must perceived minimum" so 
> if "received" means "into the driver" instead of "into the user 
> context" the 100 characters in the buffer, having been received 
> in the past would not relate the read (and so on ad nauseum 8-)   
> That would be ridiculous.

Termio, etc. specify the API, not the kernel's implementation of the 
API. All such driver software implements at least two levels of 
buffering to deal with the raw vs. canonical mode. The received data 
does not go directly to the user buffer. The data moves into the user 
buffer only when the read completes. Usually, the data received by 
the UART is handed up to a "line discipline" layer. In Streams 
implementations, there are (at least) three levels of buffering below 
the user's buffer: driver raw queue, line discipline private line 
assembly queue, and the stream head's queue. 

> Since in every stated and useful sense the VMIN and VTIME 
> mechanisms exist specifically and expressly for the purpose of 
> satisfying individual read requests, that is in terms of the 
> user-context/program "receiving" data from the abstract "device" 
> at the file interface, data that can not possibly relate to a 
> read because it is "out of bounds"  is immaterial to the act by 
> definition.  So waiting for the user context to receive 
> characters it has not asked for and cannot possibly receive is 
> a "bad thing".

It operates as specified and does what you tell it to through the API. 
That is neither good nor bad, per se. That's just compliance. If you 
tell it to do something that you don't want, that's not a driver bug. 

> The "waiting for data that can't be returned" and/or the 
> inconsistent application of the concept of "received" serves 
> nobody's interests.

Please make your good changes in a way that does not conflict with the 
existing API. Ioctl is your friend. 

> 
> I was going to simply dismiss that bit of hyperbole about 
> poll as a cheap bit of bad "debate technique" but I've decided 
> to respond.

Surprise. 

> Poll already and explicitly addresses the size of the read and/
> or write as one character, so tossing it in as if it were an 
> example was logically junct.  Additionally, to make the example 
> work you "threw in" with a comment about "adding an argument to 
> poll."  The reason that this was fatuous is that the parameter 
> you would "add"  to poll would be disruptive (which is why you 
> put it in 8-) but the information is already provided in the 
> read, the buffer length IS ALREADY being passed.  The analogy 
> and the allegation of difficulty or disruption is inapplicable.

That's not how poll and select are used. For the read case, Poll and 
Select are active when waiting for the availability of data. When data 
becomes available, they return and you post a read to scoop up the new 
data. There is no pending read during poll and select to supply a read 
buffer length to the driver.

I have no problem with innovation. Just don't pollute the existing API. 

Regards,
Ed

----------------------------------------------------------------
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
