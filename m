Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTJETNs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbTJETNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:13:48 -0400
Received: from dns2.welch-spires.org ([63.224.205.131]:33506 "EHLO
	linux.superlucidity.net") by vger.kernel.org with ESMTP
	id S263759AbTJETNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:13:44 -0400
Message-ID: <3F806D51.9030701@superlucidity.net>
Date: Sun, 05 Oct 2003 12:13:21 -0700
From: Zach Welch <zwelch@superlucidity.net>
Organization: Superlucidity Services, LLC
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3) Gecko/20030826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] input: do not suppress 0 value relative events
References: <200310040223.01664.dtor_core@ameritech.net> <20031004073656.GA3756@ucw.cz> <200310040248.27501.dtor_core@ameritech.net> <20031004080137.GA3816@ucw.cz>
In-Reply-To: <20031004080137.GA3816@ucw.cz>
X-Enigmail-Version: 0.74.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF59FDBB74E12EA338506F66C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF59FDBB74E12EA338506F66C
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Vojtech Pavlik wrote:
> On Sat, Oct 04, 2003 at 02:48:27AM -0500, Dmitry Torokhov wrote:
> 
>>On Saturday 04 October 2003 02:36 am, Vojtech Pavlik wrote:
>>
>>>On Sat, Oct 04, 2003 at 02:22:57AM -0500, Dmitry Torokhov wrote:
>>>
>>>>  Input: input susbsystem should not drop 0 value relative events,
>>>>         otherwise unsuspecting programs will loose transitions from
>>>>         non-zero to 0 deltas. We should not require userland authors
>>>>         to consult with kernel implementation details all the time,
>>>>         but follow the principle of least surprise and report
>>>>         everything.
>>>
>>>Certain devices will then generate an endless stream of zero-movement
>>>relative events, which is not good.
>>>
>>>Because 'relative' means that there is no movement when there is no
>>>event, where exactly lies the problem? What application has a problem
>>>with this? Many mice don't ever report zero values, so that application
>>>will probably not work even without the (value==0) check ...
>>
>>But the problem is not only repetitive zeros are not reported but also that
>>transition from non-zero to zero delta is not reported either.
>>
>>OK, since you telling me there are devices which never stop generating 
>>events we could go the way absolute events done and suppress repeated data.
>>Should I try that? 
>>
>>As far as application goes it was my modified version of GPM - pretty much
>>every other event is not repeated unless changed so I did not reset the
>>internal state and expected get an event telling me the last delta. I am
>>OK with data not being repeated but I want to get event for transition
>>to 0.
> 
> 
> That works for ABSOLUTE events. They're not repeated, and you always
> get the value when it changes.
> 
> RELATIVE events are very different - if you don't get an event, there
> is no movement. If you get one, even repeated, that means there was some
> movement and you must process every single (even repeated) event, since
> that's what gives the total movement.
> 
> Not "repeating" relative data doesn't work, since there is nothing like
> "current" value of a relative valuator - if there is any, then it's the
> sum of all previous events. Try thinking of relative as of an first
> derivative of absolute - and see why you can never get a zero relative
> event.
> 
> You're trying to treat relative as absolute - why?

The lack of a zero motion event makes it impossible to track the
velocity of relative motion input device without effectively resorting
to using a timer to generate the null event. User space is not informed
when the device has returned to rest - and zero is certainly a valid
velocity value. As such, I view this simply as a user's quest for that
missing velocity value.

Dmitry suggests the application sets a state of "current" relative
motion and wants to see the transition back to 0 in order to clear that
state. As such, the following bit of logic seems to be desired:

-	if (... || (value == 0))
+	if (... || ((value == 0) && (dev->lastvalue == 0))
		return;
+	dev->lastvalue = value;
	 break;

I don't like the idea of adding the lastvalue field to input_dev, but
this might send exactly one zero relative movement event. We still
have to deal with devices that simply never generate the required null
event anyway, and this change also introduces an inconsistancy with past
behavior. So this is still not a complete solution.

Vojtech's "derivative" explanation seems to intend to point out the lack
of repeated absolute events, and thus the delta between two events will
always be non-zero. If that is the case, then relative behaves in a
similar manner, not sending events if there's not data. That's fine,
except let's now consider what this design means when looking at the
real derivative motion of these two modes - it leaves a discontinuity.

Without events for zero relative motion, one can not generate accurate
acceleration data - each device will presumably be able to generate
events at different rates. By the same token, you can't really track
velocity using absolute events, as the input system would need to pass
at least one duplicate event with identical position. To track
acceleration with absolute positioning devices, it seems you might also
want to generate a second duplicate event at the same position.

Consider an absolute positioning example: a device moves one pixel
right, waits for a bit, then moves one step left. Without a zero event,
there is an instantaneous and abrubt change in velocity, whereas the
zero event allows the vector to come to rest before reversing direction.
In a purely mouse event driven application, this might produce very
different results with the former case being more correct.

I can imagine a configurable mechanism for relative motion input
devices to optionally generate zero value relative events (or duplicate
absolute events), and producers of such events should be burdened with
either sending them or telling the input layer to emulate them during
registration (specifying the timeout interval).

While a user-space library could be developed to manage this, it seems
that the problem should really be solved in the kernel - if the device
can actually generate these null events, we would otherwise be throwing
this information away. As we can have user-level input devices, that
possibility exists and seems reasonable to support.

Certainly, the trackIR device (for which I maintain the Linux kernel and
user-space drivers) provides a data stream to an application that
processes it for absolute coordinate information. This can be sent into
the input layer directly or used in sequence to emulate relative motion
events. The application currently drops zero events knowing that they
will simply be dropped in the input layer, but that is only for today....

While this application *can* get access to and thus generate repeated
absolute events for this device, that information will only be
accessible from within its frameworks. Seems to me that it would be more
valuable if available from the input layer to all applications.

On the other end, consumers of the input layer can benefit from these
events... but most likely not. For fear's sake, it should exist as is
today by default, and this added functionality enabled when specifically
requested. If nearly every application finds this extra behavior useful
and gets upgraded to support it, perhaps we can change the default
during 2.7 - for now, it seems like it would be playing with fire.

That's just my take, but maybe I'm missing something.

Cheers,

Zach Welch
Superlucidity Services


--------------enigF59FDBB74E12EA338506F66C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/gG1a26HWsJhW7jcRAsnCAKC2kqpoAryF38vUIU12Ypc+bcLeSgCfYf6B
FlmSd85Zd23ltAJ0+Y7Cprw=
=sIM0
-----END PGP SIGNATURE-----

--------------enigF59FDBB74E12EA338506F66C--

