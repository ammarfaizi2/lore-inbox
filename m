Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286978AbSABM0L>; Wed, 2 Jan 2002 07:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286979AbSABM0B>; Wed, 2 Jan 2002 07:26:01 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:59398 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286978AbSABMZr>;
	Wed, 2 Jan 2002 07:25:47 -0500
Date: Wed, 2 Jan 2002 10:25:23 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <brian@worldcontrol.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17 vs 2.2.19 vs rml new VM
In-Reply-To: <20020102013305.A5272@top.worldcontrol.com>
Message-ID: <Pine.LNX.4.33L.0201021015390.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002 brian@worldcontrol.com wrote:

> I tried rmap-10 new VM and under my typical load my desktop machine
> froze repeatedly.  Seemed the memory pool was going down the drain
> before the freeze. Meaning apps were failing and getting stuck in
> various odd states.

There's a stupid logic inversion bug in rmap-10, which is
fixed in rmap-10a. Andrew Morton tracked it down about an
hour after I released rmap-10.

Basically in wakeup_kswapd() user processes go to sleep
if the pressure on the VM is _really_ high *and* the user
process has all the same GFP options set as kswapd itself,
so the process can sleep on kswapd.

	if ((gfp_mask & GFP_KSWAPD) == GFP_KSWAPD)
		return;

Thinking about it, rmap-10a doesn't do the right thing,
either, releasing patches at 4 am isn't the right thing ;)

In vmscan.c, line 707 _should_ be:

	if ((gfp_mask & GFP_KSWAPD) != GFP_KSWAPD)
		return;

This way tasks which cannot safely sleep on kswapd will
return immediately, allowing only tasks which _can_
sleep on kswapd to go for a break.

Oh well, time for testing and releasing rmap-11 ;)

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

