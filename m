Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSEYJOY>; Sat, 25 May 2002 05:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSEYJOU>; Sat, 25 May 2002 05:14:20 -0400
Received: from bs1.dnx.de ([213.252.143.130]:46503 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S314325AbSEYJNI>;
	Sat, 25 May 2002 05:13:08 -0400
Date: Sat, 25 May 2002 10:59:42 +0200
From: Robert Schwebel <robert@schwebel.de>
To: linux-kernel@vger.kernel.org
Cc: Karim Yaghmour <karim@opersys.com>
Subject: Realtime Linux Situation
Message-ID: <20020525105942.R598@schwebel.de>
In-Reply-To: <Pine.LNX.4.44.0205241440210.28644-100000@home.transmeta.com> <3CEEC729.74625C2B@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 07:05:13PM -0400, Karim Yaghmour wrote:
> To get the real picture, you must understand what has happened to the
> various real-time projects in existence: RTAI and RTLinux. Today, RTAI
> has clearly taken the lead as the primary real-time addition to Linux.
> But it only got there because all the developers who work on it today
> were, at one point or another, very interested in making contributions to
> RTLinux. In every instance, they were turned down or dismissed by Victor.
> And in most instances, those who were turned down went to work on RTAI.

Being one of the RTAI developers, I can strongly support what Karim says
here. In the begining everyone tried to help with RT-Linux, as people have
been used to in the Linux community. But it quickly turned out that
FSM-Labs is not interested in contributions; whole ports of RT-Linux
disappeared magicaly after being sent in (ask Wolfgang Denk about some
PowerPC stuff). Nobody knows how much of the stuff went into the closed
source version of RTL. That's simply not what developers were used to, so
everybody switched over to RTAI, where people are working together and
respecting each other. 

> Hence, someone who currently wants to do real-time in Linux digs a little
> and finds RTLinux and RTAI. He then tries to get the latest and greatest
> in RTLinux and realizes that the GPL RTLinux is actually a
> bait-and-switch. So he takes a closer look at RTAI, but as soon as he
> does this he sees all these warnings given out by Victor about RTAI and
> decides to drop Linux altogether and use another OS.

People from the industry are really, really interested in using Linux for
their realtime applications, but if you tell them about the patent
situation they just use another OS. Not because one could not find a
legally correct solution for them, but simply because of the FUD.

To understand the situation it is important do realize that in the realtime
world simple _applications_ must be _implemented_ as modules (not taking
LXRT into account here). 

Here's how a typical realtime application (a motor controller) looks like:

 ------------------------------------------------------------
 | Controlling Application: sets parameters, communication  |     (1)
 | over ethernet, fieldbusses, webserver, ... (user space)  |   
 ------------------------------------------------------------
                             |
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 + Application: for example a special controlling algorithm +     (2)
 +                                                          +
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
          |                                        |
 ===================                      ===================
 | Driver for the  |                      |  Driver for     |     (3)
 | A/D  Converter  |                      |  an actuator    |
 ===================                      ===================
          |                                        |
 -------------------                      -------------------
 |  A/D Converter  |                      | D/A Converter   |     (4)
 -------------------                      -------------------
          |                                        |
 -------------------                      -------------------
 | Position Sensor |                      | Actuator (Motor)|     (5)
 -------------------                      -------------------

In this scheme layers (2) and (3) must fulfill realtime requirements. If
this would be a non-realtime application you would simply put (2) into user
space and make it a normal process. Unfortunately, with RTAI/RTL you must
implement it as a module to get realtime performance (which is necessary,
because you have to calculate the output values from the input values in a
fixed timing scheme). 

What we have in the "normal" Linux world is that the drivers (3) are
implemented as modules, and I perfectly agree with anyone who says that
_drivers_ should be GPL. I propose this for all of my customers, and until
now noone of them had an objection. 

But with applications it is different: think of a motion controller
manufacturer: his IP is the controll algorithm, and he simply cannot make
it open source. 

> One last thing: Clearly, if non-GPL applications were not allowed with
> Linux, we wouldn't be talking today. The same holds for non-GPL RT apps.

This is what I said above: the application (2) from the realtime scenario
is the logical equivalient to normal user processes in vanilla Linux. So if
the situation would really be that non-GPL RT-applications are not allowed
then Linux is dead in the embedded world - people will simply not consider
to use it any more. It would be completely equivalent to forbiding closed
source user space applications on Linux. 

Robert

PS: before anybody objects: like Karim I did not sell a single closed
    source program so far. What we are talking about here is _acceptance_ 
    of a technology in an application field, not about personal enrichment. 
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+
