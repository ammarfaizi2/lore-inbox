Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUFNTvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUFNTvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 15:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbUFNTvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 15:51:24 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:55546 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S263824AbUFNTvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 15:51:22 -0400
Date: Mon, 14 Jun 2004 21:42:56 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Tim Hockin <thockin@hockin.org>
Cc: Marc Herbert <marc.herbert@free.fr>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] ethtool semantics
Message-ID: <20040614194256.GC22012@k3.hellgate.ch>
Mail-Followup-To: Tim Hockin <thockin@hockin.org>,
	Marc Herbert <marc.herbert@free.fr>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20040607212804.GA17012@k3.hellgate.ch> <20040607145723.41da5783.davem@redhat.com> <20040608210809.GA10542@k3.hellgate.ch> <40C77C70.5070409@tmr.com> <20040609213850.GA17243@k3.hellgate.ch> <20040609151246.1c28c4d9.davem@redhat.com> <Pine.LNX.4.58.0406141458270.16762@fcat> <20040614170138.GA32594@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614170138.GA32594@hockin.org>
X-Operating-System: Linux 2.6.7-rc3-bk6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2004 10:01:38 -0700, Tim Hockin wrote:
> On Mon, Jun 14, 2004 at 03:11:15PM +0200, Marc Herbert wrote:
> > > That is absolutely the correct thing to do, module parameters for
> > > link settings are %100 deprecated, people need to use ethtool for
> > > everything.
> > 
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

My first thought was if a command contains speed/duplex settings
and autoneg is on, manipulate advertised value; if autoneg is off,
force mode. That's not possible due to the way ethtool interacts with
the kernel: It doesn't request a change in a specific field. Instead,
ethtool reads all fields, flips the values it wants to have changed,
then issues a set request for everything (speed, duplex, autoneg,
etc.). In other words: speed/duplex fields are set for every call.

One way out would be to have an explicit third option, say autoneg mask.

That would give:
autoneg on + speed/duplex -> error (only userspace/ethtool can do this!)
autoneg off + speed/duplex -> force mode (driver)
autoneg mask + speed/duplex -> change advertised value (driver)

Many drivers would only support one of these two methods (force mode
presumably), so we'd have to either throw an error if an unsupported
method is requested, or print a notice and use the supported method to
force the requested mode.

Roger
