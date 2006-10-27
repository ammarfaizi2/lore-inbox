Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946262AbWJ0JPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946262AbWJ0JPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 05:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946263AbWJ0JPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 05:15:12 -0400
Received: from science.horizon.com ([192.35.100.1]:58178 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1946262AbWJ0JPK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 05:15:10 -0400
Date: 27 Oct 2006 05:15:08 -0400
Message-ID: <20061027091508.14771.qmail@science.horizon.com>
From: linux@horizon.com
To: johnstul@us.ibm.com, zippel@linux-m68k.org
Subject: Re: 2.6.19-rc2 and very unstable NTP
Cc: linux-kernel@vger.kernel.org, linux@horizon.com
In-Reply-To: <Pine.LNX.4.64.0610270048470.6761@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> One of the recent changes was removing the in-kernel PPS code. This was
>> done because there were no in-kernel users of the interface (the only
>> ones being I believe in a variant of this LinuxPPS patch). While from
>> the diffstat below it doesn't look like the patch affects the
>> timekeeping code, it would be good to first reproduce the issue without
>> the patch.

> The recent patch by Jim Houston explains the misbehaviour. It seems the 
> ntp daemon uses ADJ_OFFSET_SINGLESHOT for time adjustments, which is 
> rather coarse-grained. By adding proper PPS support one should be able to 
> get a more stable clock, but it's better done by someone who has the 
> hardware to test this.

Actually, I saw that, applied it, rebooted, and immediately reproduced
the problem.  So while clearly a bug, it doesn't appear to be the cause.

And given that, in the course of my experiments, I managed to reproduce
the problem with 2.6.17+linuxpps and 2.6.19-rc3 with the ntp.c patch,
but managed to make it go away with 2.6.19-rc3+linuxpps with the pps
source marked "noselect" (which results in identical kernel activity,
but doesn't actually use the returned timestamp for anything), I'm
looking pretty hard at ntpd right now.

My apologies for the false alarm.


In case anyone cares...

NTP measures the time offset between the local clock and a number of
configured time sources, or peers.  Then it uses an impressively elaborate
scheme for choosing a single system offset from those contributions.
This system offset is the input to the clock discipline control loop.

The basic NTP misbahavior is that the offsets reported in the peerstats
file are diverging from the offsets in the loopstats file.  The loopstats
offsets trace a nice exponential decay toward zero, but the peerstats
proceed at a different rate, overshooting badly, until something notices
and there's a big correction, and things swing the other way.

Trying to draw it in ASCII art, the o points are from peerstats, and
the x points are from loopstats, and the *s are where they coincide:

*                     *                     *
                   o                     o   
 x               o     x               o     
                o                     o      
 ox            o       ox            o       
   x                     x
     x        o            x        o        
__o____ x_x_____________o____ x_x____________
             o     x x             o     x x 
   o            x        o            x      
              x                     x
    o       ox            o       ox         
     o                     o                 
      o     x               o     x          
        o                     o              
           *                     *           

Amplitude about +/- 300 us, half-period about 1100-1200 s, but
rather chaotic.

There are only three peers, which all agree very tightly (GPS input,
PPS input, and a LAN peer which has a GPS clock itself), so I don't see
how a properly functioning ntpd can somehow choose among the three and
get the wrong number like this.  Regardless of what adjtimex() does.
