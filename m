Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLPJOA>; Sat, 16 Dec 2000 04:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLPJNk>; Sat, 16 Dec 2000 04:13:40 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:23823 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129183AbQLPJNa>; Sat, 16 Dec 2000 04:13:30 -0500
Date: Sat, 16 Dec 2000 00:42:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Barry K. Nathan" <barryn@pobox.com>, Rusty Russell <rusty@linuxcare.com>,
        Marc Boucher <marc@mbsi.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: test13pre2 - netfilter modiles compile failure
In-Reply-To: <Pine.LNX.4.10.10012160015521.11822-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10012160031450.11822-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2000, Linus Torvalds wrote:
> 
> So "ip_nf_compat-objs" should really just be
> 
> 	ip_nf_compat-objs := ip_fw_compat.o ip_fw_compat_redir.o ip_fw_compat_masq.o
> 
> which looks much saner at least for the built-in case (ie no duplicate
> object files in the multi-lists, and the multi-lists have sane entries).

This makes it work when compiled into the kernel.

However, it also makes it fail spectacularly when modular, because it
appears that what the Makefile tried to do was to have some group of
object-files be a library that is compiled into all the modules, and the
above change will basically remove it from the "ip_nf_compat" module -
making that module not see the routines it wants to see.

There are two solutions for this:

 - the DRM "true library" solution, as shown by drivers/char/drm/Makefile.

   This is closest to what the code tried to do before, and might be the
   right solution for the "ip_nf_compat" module. However, it does result
   in the same code being duplicated in multiple modules. Not very nice.

 - export more symbols (and mark the object files that export them as
   "export-objs"), so that they are visible across module boundaries.
   This is probably worth doing for at least the symbols

	register_firewall(), ip_fw_masq_timeouts() and
	unregister_firewall()

   so that "ipchains" and "ipfwadm" could just cleanly be separate modules
   on top of the "ip_fw_compat" module.

Anyway, these kinds of things are really up to the netfilter people.

Rusty? Help me out, and I won't ever call "netfilter" a heap of stinking
dung again. Do we have a deal?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
