Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132260AbRCWAYJ>; Thu, 22 Mar 2001 19:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132284AbRCWAYD>; Thu, 22 Mar 2001 19:24:03 -0500
Received: from owns.warpcore.org ([216.81.249.18]:6786 "EHLO owns.warpcore.org")
	by vger.kernel.org with ESMTP id <S132260AbRCWAXw>;
	Thu, 22 Mar 2001 19:23:52 -0500
Date: Thu, 22 Mar 2001 18:20:48 -0600
From: Stephen Clouse <stephenc@theiqgroup.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
Message-ID: <20010322182048.B1406@owns.warpcore.org>
In-Reply-To: <3AB9313C.1020909@missioncriticallinux.com> <Pine.LNX.4.21.0103212047590.19934-100000@imladris.rielhome.conectiva> <20010322124727.A5115@win.tue.nl> <20010322142831.A929@owns.warpcore.org> <3C9BCD6E.94A5BAA0@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline; filename="msg.pgp"
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C9BCD6E.94A5BAA0@evision-ventures.com>; from dalecki@evision-ventures.com on Sat, Mar 23, 2002 at 01:33:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sat, Mar 23, 2002 at 01:33:50AM +0100, Martin Dalecki wrote:
> AMEN! TO THIS!
> Uptime of a process is a much better mesaure for a killing candidate
> then it's size.

Thing is, if you take a good study of mm/oom_kill.c, it *does* take start time
into account, as well as CPU time.  The problem is that a process (like Oracle,
in our case) using ludicrous amounts of memory can still rank at the top of the 
list, even with the time-based reduction factors, because total VM is the
starting number in the equation for determining what to kill.  Oracle or what
not sitting at 80 MB for a day or two will still find a way to outrank the
newly-started 1 MB shell process whose malloc triggered oom_kill in the first
place.

If anything, time really needs to be a hard criterion for sorting the final list
on and not merely a variable in the equation and thus tied to vmsize.

This is why the production database boxen aren't running 2.4 yet.  I can control
Oracle's usage very finely (since it uses a fixed memory pool preallocated at
startup), but if something else decides to fire up on there (like the nightly
backup and maintenance routine) and decides it needs just a pinch more memory
than what's available -- ick.  2.2.x doesn't appear to enforce new memory 
allocation with a sniper rifle -- the new process just suffers a pleasant ("Out
of memory!") or violent (SIGSEGV) death.

- -- 
Stephen Clouse <stephenc@theiqgroup.com>
Senior Programmer, IQ Coordinator Project Lead
The IQ Group, Inc. <http://www.theiqgroup.com/>

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8

iQA/AwUBOrqW3wOGqGs0PadnEQLZUwCfWTr8HwAChQamWWvWWzZcX5DZ8PAAnROB
Ja25OAQu3W1h7Ck0SU/TfKj8
=VlQt
-----END PGP SIGNATURE-----
