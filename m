Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263827AbUFNTgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbUFNTgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 15:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUFNTg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 15:36:29 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:32697 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263824AbUFNTgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 15:36:09 -0400
Date: Mon, 14 Jun 2004 21:32:42 +0200 (CEST)
From: Marc Herbert <marc.herbert@free.fr>
X-X-Sender: mherbert@fcat
To: Tim Hockin <thockin@hockin.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] ethtool semantics
In-Reply-To: <20040614170138.GA32594@hockin.org>
Message-ID: <Pine.LNX.4.58.0406142044060.1607@fcat>
References: <20040607212804.GA17012@k3.hellgate.ch> <20040607145723.41da5783.davem@redhat.com>
 <20040608210809.GA10542@k3.hellgate.ch> <40C77C70.5070409@tmr.com>
 <20040609213850.GA17243@k3.hellgate.ch> <20040609151246.1c28c4d9.davem@redhat.com>
 <Pine.LNX.4.58.0406141458270.16762@fcat> <20040614170138.GA32594@hockin.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2004, Tim Hockin wrote:

> > This is precisely the reason why I am concerned about having "rich"
> > ethtool semantics. A unified, standard interface is great,... as long
> > it does not leave behind some features, like setting the advertised
> > values in autoneg. As a user of these features, I hope driver
> > developers will NOT remove those module_param features that cannot
> > migrated to ethtool.
>
> So propose a sane semantic that handles all three cases:
> * autoneg on
> * autoneg off
> * autoneg on but limited

Looking at the examples I mentioned earlier in the thread, one can
draw the following two simple solutions:

	  1. "Max speed advertised" solution

		autoneg |         on            off
	  speed         |
	  --------------|-----------------------------
			|
	  <empty>       | advertise all      force  10
	  10            | adv. 10            force  10
	  100           | adv. 10|100        frc.  100
	  1000          | adv. 10|100|1000   frc. 1000


	  2. "Fixed speed advertised" solution

		autoneg |         on            off
	  speed         |
	  --------------|-----------------------------
			|
	  <empty>       | advertise all      force  10
	  10            | adv.   10          force  10
	  100           | adv.  100          frc.  100
	  1000          | adv. 1000          frc. 1000


You can easily figure out similar and shorter tables for half/full
duplex (considering that duplex > half).

A 3rd solution which kind of avoids the dilemma between 1. and 2. is
to give the user full control on advertised bits, as does (did?) the
e1000 driver and its "AutoNeg" module_param. This third solution is
often less user friendly and probably not very useful. And it would
require a new argument to ethtool, whereas the first two solutions do
not.

If given the choice, I would vote for solution 1., but it probably
does not make much difference with solution number 2 in practice.

Auto negociation of flow control is unfortunately more complex, as you
can see in this discussion with Rich Seifert in
comp.dcom.lans.ethernet for those interested
 http://groups.google.com/groups?threadm=87hdvnd0x3.fsf%40free.fr
But I believe flow control issues do not have any influence on the
above, so... first things first: no need to dive into this at this
point.

Obviously this message ignores legacy code, hardware bugs and others
"small matters of implementation". I suspect Roger Luethi has both a
knowledge of the related code and an opinion on this issue.

