Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276659AbRJPUDB>; Tue, 16 Oct 2001 16:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276671AbRJPUCw>; Tue, 16 Oct 2001 16:02:52 -0400
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:36704 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S276659AbRJPUCk>; Tue, 16 Oct 2001 16:02:40 -0400
Posted-Date: Tue, 16 Oct 2001 18:56:45 GMT
Date: Tue, 16 Oct 2001 19:56:45 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Gerhard Mack <gmack@innerfire.net>
cc: Eric W Biederman <ebiederm@xmission.com>,
        Ulrich Drepper <drepper@cygnus.com>, Andi Kleen <ak@suse.de>,
        Alex Larsson <alexl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
In-Reply-To: <Pine.LNX.4.10.10110030822130.3933-100000@innerfire.net>
Message-ID: <Pine.LNX.4.21.0110150049220.6433-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerhard.

>>>> For stat is also requires a changed glibc ABI -- the glibc/2.4
>>>> stat64 structure reserved an additional 4 bytes for every
>>>> timestamp, but these either need to be used to give more seconds
>>>> for the year 2038 problem or be used for the ms fractions. y2038
>>>> is somewhat important too.

>>> The fields are meant for nanoseconds. The y2038 will definitely be
>>> solved by time-shifting or making time_t unsigned. In any way
>>> nothing of importance here and now. Especially since there won't be
>>> many systems which are running today and which have a 32-bit time_t
>>> be used then. For the rest I'm sure that in 37 years there will be
>>> the one or the other ABI change.

>> Right.  Given current uptimes and being optimistic the fix for y2038
>> is probably needed by 2030 or just a little later.  But in any case
>> 64 bit systems should be maxing out by then, and the conversion to
>> 128 bit systems should have already happened on the server side.  
>> 32 bit systems will likely be limited to embedded and legacy systems
>> by then.

> Why do I get the feeling no one has learned from the problems the
> computer industry had with 2 digit date fields?

Precicely my feeling. Let's see what the various field widths do for the
y2038 problem, assuming a signed field and that we retain the current
date origin of Jan 1 00:00:00 UTC 1970 for the new routines:

	Field Width	Rollover Date	  Time
	~~~~~~~~~~~	~~~~~~~~~~~~~	~~~~~~~~
	    32		19 Jan   2038	 3:14:08
	    33		 7 Feb   2106	 6:28:16
	    34		16 Mar   2242	12:56:32
	    35		30 May   2514	 1:53:04
	    36		26 Oct   3058	 3:46:08
	    37		20 Aug   4147	 7:32:16
	    38		 8 Apr   6325	15:04:32
	    39		14 Jul  10680	 6:09:04
	    40		25 Jan  19391	12:18:08
	    41		20 Feb  36812	 0:36:16
	    42		10 Apr  71654	 1:12:32
	    43		19 Jul 141338	 2:25:04
	    44		 4 Feb 280707	 4:50:08
	    45		 8 Mar 559444	 9:40:16

I somehow don't see the need to go any further with this table...

We can get some really decent rollover dates by expanding the field
width, and the basic question comes down to how far ahead we wish to
push the problem - noting that the WinXX Y2K problem has only been
pushed back to be the Y10K problem now.

The other side of the equation is that we need to increase the
resolution with which we give out timestamps, and it appears to me that
the simplest means would be to change the kernel to use a smaller unit
to record timestamps. The current set of calls would then convert this
to seconds, and we would provide a new set of calls that returned the
raw values as used in the kernel.

Assuming the field widths have to be a complete number of bytes, we need
to determine what the minimum resolution is to allow us to record times
up to 00:00:00 GMT on the 1st of January in whatever year we wish to be
able to record up to. Here's what we would need to use for the given
field sizes to handle up to the following years:

Field  Year   Year   Year   Year   Year   Year   Year   Year   Year
Width  2038   2500   5000   10000  25000  50000 100000 250000 500000
~~~~~ ~~~~~~ ~~~~~~ ~~~~~~ ~~~~~~ ~~~~~~ ~~~~~~ ~~~~~~ ~~~~~~ ~~~~~~
  32    1  s
  40    4 ms  31 ms 174 ms 461 ms
  48   16 us 119 us 680 us 1.8 ms 5.1 ms  11 ms  22 ms  56 ms 112 ms
  56   60 ns 465 ns 2.7 us 7.1 us  21 us  43 us  86 us 218 us 437 us
  64  233 ps 1.8 ns  11 ns  28 ns  79 ns 165 ns 336 ns 849 ns 1.8 us
  72  909 fs 7.1 ps  41 ps 108 ps 308 ps 642 ps 1.4 ns 3.4 ns 6.7 ns
  80  3.6 fs  28 fs 159 fs 420 fs 1.2 ps 2.6 ps 5.2 ps  13 ps  27 ps
~~~~~ ~~~~~~ ~~~~~~ ~~~~~~ ~~~~~~ ~~~~~~ ~~~~~~ ~~~~~~ ~~~~~~ ~~~~~~

I note that with the recent Y2K changes, WinXX software will next hit
rollover in case (C), and we don't want to be worse than that. Also, to
keep the conversion routines for the current functions simple, we need
to choose an interval that divides exactly into one second.

I would therefore conclude that we could aim for any of the following:

	Field Width	Unit of Time	Rollover Month
	~~~~~~~~~~~	~~~~~~~~~~~~	~~~~~~~~~~~~~~

	   40 bits	    500 ms	  May  10680
			      1  s	  Sep  19390

	   48 bits	   2500 us	  Apr  13119
			      5 ms	  Jul  24268	*
			     10 ms	  Jan  46567
			     25 ms	  Jul 113462
			    125 ms	  Sep 559432

	   56 bits	     10 us	  Nov  13386
			     25 us	  Feb  30512	*
			     50 us	  Mar  59054
			    100 us	  May 116138
			    500 us	  Nov 572811

	   64 bits	     50 ns	  Jul  16583
			    100 ns	  Feb  31197	*
			    250 ns	  Oct  75037
			    500 ns	  Jul 148105
			   1000 ns	  Jan 294241
			   2500 ns	  Jul 732647

	   72 bits	    125 ps	  Sep  11322
			    250 ps	  May  20675
			    500 ps	  Sep  39380	*
			      1 ns	  May  76791
			     10 ns	  Oct 750183

	   80 bits	    500 fs	  Feb  11547
			   1000 fs	  Apr  21124
			   1250 fs	  Nov  25912	*
			   2500 fs	  Sep  49855
			      5 ps	  May  97741
			     10 ps	  Sep 193512
			     25 ps	  Nov 480826

Allowing that WinXX software is now only susceptible to the Y10K
problem, we can't afford to do worse than that, and the sooner we
sort this out, the better for all concerned as far as I can tell.

My personal choices at each field width would be those marked with an
asterisk, and this is based on the principle of using the shortest time
interval possible that is consistant with being able to record up to
around AD 25000 in a signed field.

My overall preference would be to go straight to 64 bit date fields and
define them as storing the time in units of 100 nanoseconds, but it has
apparently been decided that we will use 48 bit fields, if what I've
seen on this list is correct.

> Odds are legacy systems will be running something people for
> whatever reason couldn't replace.

Most probably...

Best wishes from Riley.

