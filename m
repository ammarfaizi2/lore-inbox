Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQLRW41>; Mon, 18 Dec 2000 17:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130791AbQLRW4J>; Mon, 18 Dec 2000 17:56:09 -0500
Received: from [203.36.158.121] ([203.36.158.121]:52998 "HELO kabuki.eyep.net")
	by vger.kernel.org with SMTP id <S129525AbQLRWzw>;
	Mon, 18 Dec 2000 17:55:52 -0500
To: Andreas Dilger <adilger@turbolinux.com>
cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        David Schwartz <davids@webmaster.com>,
        Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: /dev/random: really secure? 
In-Reply-To: Your message of "Mon, 18 Dec 2000 15:15:54 MDT."
             <200012182215.eBIMFsb14852@webber.adilger.net> 
In-Reply-To: <200012182215.eBIMFsb14852@webber.adilger.net> 
Date: Tue, 19 Dec 2000 20:27:44 +1100
From: Daniel Stone <daniel@kabuki.eyep.net>
Message-Id: <20001218225557Z129525-439+4788@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This would allow you to say "eth0 is my internal network and I'm not
> trying to hack my own system, so use IP traffic on that interface to add
> entropy to the pool, but not packets that are on port 6699/21/23 or reply
> packets".  It would probably just be a matter of adding a new flag to a
> filter rule to say "use packets that match this rule for entropy", and
> then it is up to the user to determine what is safe to use.  The fact
> that it is user configurable makes it even harder for a cracker to know
> what affects the entropy pool.

This isn't from the kernel, but works great in userspace:

iptables -n RANDOM
iptables -A INPUT -i eth0 -j RANDOM
iptables -A RANDOM -p tcp --dport 6699 -j <otherchain/rule>
iptables -A RANDOM -p tcp --dport 21 -j <asabove>
iptables -A RANDOM -p tcp --dport 32 -j <ditto,etc>
iptables -A RANDOM -m state --state ! NEW -j <thisisgettingstupidnow>
iptables -P RANDOM -j ULOG --ulog-nlgroup 32

This sends a message down netlink in ULOG format.
ULOG is a userspace logging extension written by Harald Welte, but it's
extensible like you wouldn't believe, so you could easily do some whacky
stuff with it. Or just hook in to a Netfilter hook and do it all from kernel
land.
ULOG's homepage: http://www.gnumonks.org/gnumonks/projects/project_details?p_id=1

:) d
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
