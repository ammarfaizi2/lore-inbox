Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275672AbRIZWmW>; Wed, 26 Sep 2001 18:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275673AbRIZWmO>; Wed, 26 Sep 2001 18:42:14 -0400
Received: from adsl-63-195-80-148.dsl.snfc21.pacbell.net ([63.195.80.148]:2186
	"EHLO pincoya.com") by vger.kernel.org with ESMTP
	id <S275672AbRIZWl5> convert rfc822-to-8bit; Wed, 26 Sep 2001 18:41:57 -0400
Date: Wed, 26 Sep 2001 15:55:22 -0700
From: Gordon Oliver <gordo@pincoya.com>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Allow net devices to contribute to /dev/random
Message-ID: <20010926155522.C4828@furble>
Reply-To: gordo@pincoya.com
In-Reply-To: <1001461026.9352.156.camel@phantasy> <9or70g$i59$1@abraham.cs.berkeley.edu> <1001465531.10701.61.camel@phantasy> <9orbfo$jca$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <9orbfo$jca$1@abraham.cs.berkeley.edu>; from daw@mozart.cs.berkeley.edu on Tue, Sep 25, 2001 at 18:36:56 -0700
X-Mailer: Balsa 1.2.pre3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I would actually suggest breaking out a longer discussion of the
risks associated with the patch into Documentation, and _strongly_
suggesting that the person configuring the kernel read it before
enabling the option. Then a statement that this may put the security
of /dev/random at risk would probably be enough.

  So let's start with the possible conditions are.
What I can see are the following:
   1) network card on visible net:
	- BadGuy can monitor the network traffic, extracting
	  timing information. Given enough knowledge about the
	  latency of the network card, all network entropy might
	  be known (making it non-secure). If the network is
	  the only, or primary, source of entropy this leads
	  to compromise
   2) network card on private net:
	- BadGuy must plug into private net to monitor the traffic,
	  any external monitoring is very likely to fail to get
	  much useful information.
   3) TSC not used to add randomness:
	- Prediction of time between interrupts becomes much easier
	  (jiffies are a big target).
   4) Systems that are largely quiescent could lead to easier prediction
      of latencies, and thus easier compromise.

In any case the following must be true for this to cause problems:
   a) The network must be the primary source of entropy (this
      will be common in the case where the patch is useful)
   b) BadGuy must monitor from time 0 (boot of system) to get
      useful information
   c) BadGuy must have information about what network card the system
      has, or _very_ good statistical information about delay to
      interrupt & timing in general.
   d) BadGuy must have information about how long the processing for
      the interrupt handler takes, as the randomness addition is done
      _after_ all processing. This also causes interesting problems
      for prediction if more than one event is handled at once.
   e) BadGuy must have access to information of network traffic on
      all the networks that are attached to the computer.

Now none of this guarantees security (but then again, very little will
_guarantee_ security.

I may have missed some stuff here... (caveat emptor)

Just as a comment, I actually like the patch, and would certainly be
willing to use it for a computer on a private network...
	-gordo
