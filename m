Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTARBzu>; Fri, 17 Jan 2003 20:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbTARBzu>; Fri, 17 Jan 2003 20:55:50 -0500
Received: from fmr05.intel.com ([134.134.136.6]:32484 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S261874AbTARBzs>; Fri, 17 Jan 2003 20:55:48 -0500
Subject: Re: [Pcihpd-discuss] Re: [BUG][2.5]deadlock on cpci hot insert
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pcihpd-discuss <pcihpd-discuss@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0301161752320.22716-100000@rancor.yyz.somanetworks.com>
References: <Pine.LNX.4.44.0301161752320.22716-100000@rancor.yyz.somanetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Jan 2003 18:04:33 -0800
Message-Id: <1042855474.1016.163.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-16 at 21:32, Scott Murray wrote:
[snip]
> Hmm, that's definitely not what I expected.  For reference, my test ZT5550 
> here yields HCF_HCS = 0x31a in a standard (non-RSS) cPCI chassis, which
> means both buses are active in my setup, and I'd expected the same from an
> Active-Active or Locked Active-Active setup in a ZT5084 chassis.  I'll dig 
> deeper in the host controller docs tomorrow as well as try and glean 
> something from the rough 2.2 RSS code Intel/Ziatech released in late 2001.  
> In the meantime, could you describe for me what you've got the "High 
> Availability" options in your ZT5550's BIOS set to?  Also, just so I'm 
> clear on what your setup consists of, am I correct in my assumption that 
> you only have a single ZT5550 in your ZT5084 chassis?
> 
> Thanks,
> 
> Scott

I actually have two ZT5550C boards each using a ZT96073 mezzanine board 
(which contains a hard drive a floppy) and each with ZT4804/ZT4802 rear
panel transition boards.

I do not see anything in my BIOS (v5.15) about "High Availability" options,
but looking through the ZT5550 manual on the pt website, I noticed that
all ZT550 models before revision 'D' only have active-standby mode, so I 
wonder if the bit we are looking at was only used in newer versions of the
ZT5550.

For what it is worth, I messed around with all the possible combinations
of system master and peripheral boards that I had, and noted what HCF_HCS
was in system log.

HCF_HCS is not effected by the placement of the peripheral boards, but
I do see bits flipping on and off for all the different combinations off
system master board placements, and I also see bits flipping depending
on if the system board was freshly inserted, or if I just rebooted the
board without extracting/inserting.

Here is what I observed ==>

HCF_HCS Bit             Observation
-----------             ----------
HCS_HA                  always on
HCS_ACTIVE              on if board is active
HCS_RH_STATE            always off
HCS_HARD_RESET	        on if board was freshly inserted
HCS_SOFT_RESET	        always on
HCS_RH_ALIVE		on if other system master is inserted
HCS_SWITCH_OVER		always off 
HCS_TAKEOVER_TYPE	always off
HCS_BUS1_ACTIVE		always off
HCS_BUS2_ACTIVE		always off
HCS_SPLIT_MODE_ERROR    always off

Like I mentioned before, I suspect that the last three bits are not
implemented on older ZT5550 boards (pre 'D' versions).  In the docs 
you have access too, is there reference to a register we could find 
out which version of 5550 this board is for?  That would make this
easy to solve.

hmm... if HCS_RH_STATE is talking about if the other system board is
active or standby, then we could assume both busses need to be added
if HCS_RH_STATE is not set. That is unless there such thing as being able to 
completely turn off one of the busses.

BTW, I'm going to be at the Linux World show in NY next week, so I
will not be able to try anything new for a week.

    --rustyl

