Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316632AbSGBFgQ>; Tue, 2 Jul 2002 01:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316636AbSGBFgP>; Tue, 2 Jul 2002 01:36:15 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:39893 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S316632AbSGBFgP>;
	Tue, 2 Jul 2002 01:36:15 -0400
Date: Tue, 2 Jul 2002 02:43:22 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020702024322.F2295@almesberger.net>
References: <3D212757.5040709@quark.didntduck.org> <32193.1025585595@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32193.1025585595@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, Jul 02, 2002 at 02:53:15PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> For netfilter, the use count reflects the number of packets being
> processed.  Complex and potentially high overhead.

Good example - netfilter may access a huge number of tiny
modules when working on a packet. While this by itself is a
performance issue, the need to keep reference counts right
doesn't necessarily help.

> All of this requires that the module information be passed in multiple
> structures and assumes that all code is careful about reference
> counting the code it is about to execute.

It's not really just the module information. If I can, say, get
callbacks from something even after I unregister, I may well
have destroyed the data I need to process the callbacks, and
oops or worse.

> There has to be a better way!

Well yes, there are other approaches that make sure something is
not used, e.g.

If you can a) make sure no new references are generated, and b)
send a sequential marker through the subsystem, you can be sure
that all references are gone, when the marker re-emerges. (Or use
multiple markers, e.g. one per CPU.)

Likewise, if you can disable restarting of a subsystem, and then
wait until the subsystem is idle, you're safe. E.g. tasklet_disable
works like this.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
