Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317271AbSFRCAD>; Mon, 17 Jun 2002 22:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317269AbSFRCAC>; Mon, 17 Jun 2002 22:00:02 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:36090 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S317268AbSFRB74>; Mon, 17 Jun 2002 21:59:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Robert White <rwhite@pobox.com>
Reply-To: rwhite@pobox.com
To: Ed Vance <EdV@macrolink.com>
Subject: Re: n_tty.c driver patch (semantic and performance correction) (a ll recent versions)
Date: Mon, 17 Jun 2002 19:00:03 -0700
X-Mailer: KMail [version 1.4.5]
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       "'Theodore Tso'" <tytso@mit.edu>
References: <11E89240C407D311958800A0C9ACF7D13A7881@EXCHANGE>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A7881@EXCHANGE>
X-Evil-Bastard: True (but nice about it)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206171900.03955.rwhite@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you cite a single example of where the standard explicitly states that the 
a read of fewer bytes than VMIN should, none the less, block for the receipt 
of characters that can not be returned by the read?

You will find the standard is silent on the matter.  While it does say that 
the read will block until VMIN characters have been received it has no 
statement on what to do if less than VMIN characters have been requested in 
the particular read.  If I recall correctly (but it has been a while), Sun's 
implementation will return less than VMIN characters without waiting for the 
"extra" characters to be received.

Reguardless, the revise-down part can not possibly affect application 
portability.

Simply put, the patch provided is vanishingly close to* 100% user-space 
compatable with the stated intent of VMIN (and VTIME) as an upper limit on 
how long to wait for a read.  In particular, the downward revision behaviour 
will break absolutely no code.  (I haven't even been able to find an example 
of code where VMIN is greater than 1 and not explicitly reset to the expected 
packet read size).  [ *I use "vanishingly close to" instead of "is" because 
of a single case where VMIN is 255 and VTIME is 0, see below. ]

Since the entire purpose of the VMIN and VTIME is to allow reads to complete 
based on certain minimums.  If the minimum to receive is greater than the 
minimum that *can be returned" waiting for the extra, returnable characters 
is pointless.

When you read the manual pages it is clear the presumption is that the 
read-buffer-size is/would be bigger than the value of MIN.

===== Begin Quote (from sun termio(7i) since that's what I can cite ===== 

     MIN represents the minimum number of characters that  should
     be  received  when  the read is satisfied (that is, when the
     characters are returned to the user).  TIME is  a  timer  of
     0.10-second  granularity  that is used to timeout bursty and
     short-term data transmissions.  The four possible values for
     MIN and TIME and their interactions are described below.

     Case A: MIN > 0, TIME > 0
          In this case, TIME serves as  an  intercharacter  timer
          and is activated after the first character is received.
          Since it is an intercharacter timer, it is reset  after
          a  character  is received.  The interaction between MIN
          and TIME is as follows:  as soon as  one  character  is
          received,  the intercharacter timer is started.  If MIN
          characters are received before the intercharacter timer
          expires  (note  that the timer is reset upon receipt of
          each character), the read is satisfied.  If  the  timer
          expires before MIN characters are received, the charac-
          ters received to that point are returned to  the  user.
          Note  that if TIME expires, at least one character will
          be returned because  the  timer  would  not  have  been
          enabled  unless a character was received.  In this case
          (MIN > 0, TIME > 0), the read sleeps until the MIN  and
          TIME  mechanisms  are  activated  by the receipt of the
          first character.  If the number of characters  read  is
          less than the number of characters available, the timer
          is not reactivated and the subsequent read is satisfied
          immediately.
 
     Case B: MIN > 0, TIME = 0
          In this case, since the value  of  TIME  is  zero,  the
          timer  plays  no  role  and  only MIN is significant. A
          pending read is not satisfied until MIN characters  are
          received  (the pending read sleeps until MIN characters
          are received).  A program that uses this case  to  read
          record based terminal I/O may block indefinitely in the
          read operation.

     Case C: MIN = 0, TIME > 0
          In this case, since MIN = 0, TIME no longer  represents
          an intercharacter timer:  it now serves as a read timer
          that is activated as soon as a read is done.  A read is
          satisfied  as soon as a single character is received or
          the read timer expires.  Note that, in  this  case,  if
          the  timer  expires,  no character is returned.  If the
          timer does not expire, the only way  the  read  can  be
          satisfied is if a character is received.  In this case,
          the read will not  block  indefinitely  waiting  for  a
          character;  if no character is received within TIME*.10
          seconds after the read is initiated, the  read  returns
          with zero characters.

     Case D: MIN = 0, TIME = 0
          In this case, return  is  immediate.   The  minimum  of
          either the number of characters requested or the number
          of characters currently available is  returned  without
          waiting for more characters to be input.

  Comparison of the different cases of MIN, TIME interaction
     Some points to note about MIN and TIME:

     1.   In the following explanations, note that  the  interac-
          tions  of  MIN and TIME are not symmetric. For example,
          when MIN > 0 and TIME = 0, TIME has  no  effect.   How-
          ever, in the opposite case, where MIN = 0 and TIME > 0,
          both MIN and TIME play a role in that MIN is  satisfied
          with the receipt of a single character.

     2.   Also note that in case A (MIN >  0,  TIME  >  0),  TIME
          represents  an  intercharacter timer, whereas in case C
          (MIN = 0, TIME > 0), TIME represents a read timer.

     These two points highlight the dual purpose of the  MIN/TIME
     feature.   Cases  A  and  B,  where MIN > 0, exist to handle
     burst mode activity (for example, file  transfer  programs),
     where  a  program would like to process at least MIN charac-
     ters at a time.  In case  A,  the  intercharacter  timer  is
     activated  by  a  user  as  a safety measure; in case B, the
     timer is turned off.

     Cases C and  D  exist  to  handle  single  character,  timed
     transfers.   These  cases  are  readily adaptable to screen-
     based applications that need  to  know  if  a  character  is
     present in the input queue before refreshing the screen.  In
     case C, the read is timed, whereas in case D, it is not.

     Another important note is that MIN is always just a minimum.
     It  does not denote a record length.  For example, if a pro-
     gram does a read of 20 bytes, MIN is 10, and  25  characters
     are  present,  then  20  characters  will be returned to the
     user.

===== End Quote =====

Once again, notice the presumption that read would always supply a buffer 
equal to or larger than VMIN.  Nowhere does it mention anything about "upper" 
and "lower" parts of drivers it only addresses single reads and timing and 
return conditions to that read.  Since it is "silent" on the matter of what 
to do when the read size in less than MIN and it is "kind of dumb" to wait to 
return characters that can't be returned.  The downward revision code is 
completely within the spirit and structure of the standard.  It is also 
essentially impossible to break existing code by adding this fix.  (Existing 
code would already be hanging, or already be in bounds, or be part of a 
streaming dataset, and so on.)

The "bad thing" in the way it has been implemented currently is that when the 
packet sizes varry it takes a lot of time repeatedly reseting VMIN or 
bouncing in and out of kernel context and copying buffers because VMIN is 
artifically small (see pppd etc).  I am "fairly certain" that no other 
implementation would wait for unreturnable characters anyway since there is 
no real way to deal with the unreturnd characters that would result in 
predictable code.

As for the enhancement part.  The mod "could" jam up code in the single 
spesific case where VMIN==255 and VTIME==0 and the read size was larger than 
the received data could ever be.  I have found zero such instances.  Granted 
I do not have a psychic line into every piece of code everywhere.  I havn't 
even found a single instance of VMIN==255 and VTIME==0 (which, I reiterate, 
is the only case where the enhancement could possibly break code that wasn't 
already broken).

Find me one instance of code in the wild where:
 VMIN==255 and VTIME==0;
or
 VMIN=255 and VTIME>0 and performance isn't improved by the patch;
or
 VMIN < 255 and performance isn't unchanged-or-improved by the patch
and I'll bow my head in shame and go away.  8-)

So the floating down is a hard fix, and is actually hugely useful when dealing 
with small-event protocols.  The floating up is also hugely useful but there 
is a diminishingly miniscule chance of boning something.  The float-down fix 
doesn't violate a single standard (unless I am missing something).  and 
finally, the utility of the floating-up enhancement greatly outweighs the 
chance of it messing something up.

As I type this I can see that a guardian case of not floating up if TIME==0 
might be a conservatively useful case, but I dout it has any real-world 
value.

(in case you care for an example)
The real-world project that started me down this road was dealing with SIM 
cards (a.k.a. "Java Cards", "Smart Cards" etc) which (for protocol "T=0") 
operate at about 9600 baud and which return frames (who's variable lengths 
are known before the read) of data between 2 and 258 bytes, which can be 
paded with any number of 0x60(s), and which signal an error by "becomming 
unresponsive."  Lets face it, any protocol with a frame that includes a 
length component with one-byte encoding will, perforce, tend to overflow the 
255 value inherant in the VMIN data type because any framing on the payload 
will be longer thant the maximum payload of 255.

Also consider that virutally every serial protocol in use today has a larger 
than 255 character maximum frame.

I have been using the patch on several production systems (actually full time 
development boxes, so "production in development environment" whatever the 
distinction may be worth) and have found zero cases where there was any 
problems and the applications being developed with the fixed behavior have 
had a several-fold improvement in performance.

I think you will find the patch worth it in the long run and I doubt that, 
should you use your greater-access to the code and user base, you would find  
a single case where it breaks, invalidates, or confuses a single person or 
program on the planet.

Rob White.


On Monday 17 June 2002 10:27, Ed Vance wrote:
> On Sat, June 15, 2002 at 9:01 PM, Robert White wrote:
> > Kernel Versions: 2.2, 2.4, 2.5 (all of them since 1996 really 8-)
> >
> > The n_tty line discipline module contains a "semantic error" that
> > limits its speed and usefulness in many uses.  The attached patch
> > directly addresses serial performance in a completely backwards-
> > compatible way.
> >
> > In particular, the current handling of VMIN hugely limits,
> > complicates, and/or slows down optimal serial use.  The most
> > obvious example is that if you call read(2) with a buffer size less
> > than the current value of VMIN, the line discipline will insist
> > that the read call wait for characters that can not be returned to
> > that call.  The POSIX standard is silent on the subject of whether
> > this is right or wrong.  Common sense says it is wrong.
>
> Hi,
>
> IIRC, the way VMIN>0,VTIME=0 is supposed to work is to make characters
> available to the top level queue to be read when the low level input
> queue contains VMIN or more characters. Until that moment, there are
> no characters available to a read of any buffer size regardless of how
> many characters have been received at the low level. This is why a
> single character read blocks when at least one character has been
> received but not yet VMIN characters. Only data in the top level queue
> can be read. If the line discipline has not yet released data to the
> top level queue because of VMIN, then no data can be read, but this is
> not an error.
>
> Many have been tempted to change the behavior of this part of the
> system. IMHO, it is not worth tossing away application portability.
>
> Standards compliance can feel a bit like vertigo while instrument
> flying. Sometimes one has to just stare at the artificial horizon and
> say "I believe it" to one's self until the gut is convinced.
>
> Best regards,
> Ed
>
> ----------------------------------------------------------------
> Ed Vance              edv@macrolink.com
> Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
> ----------------------------------------------------------------

