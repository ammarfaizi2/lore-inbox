Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261662AbSKCFdH>; Sun, 3 Nov 2002 00:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSKCFdH>; Sun, 3 Nov 2002 00:33:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4880 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261662AbSKCFdG>; Sun, 3 Nov 2002 00:33:06 -0500
Date: Sat, 2 Nov 2002 21:39:39 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Oliver Xymoron <oxymoron@waste.org>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <Pine.GSO.4.21.0211022358430.25010-100000@steklov.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0211022128050.2633-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Nov 2002, Alexander Viro wrote:
> 
> If you want that place to retain some capabilities -
> s/nosuid/capmask=.../ in the above.

Ok, I get your example, but nope, I don't think it will work.

Why? Because then the suid check will work, and not only will you get all 
capabilities (_if_ the suid was root), you will also have changed your ID 
(since that was how you got enough capabilities to be able to mask them 
off).

Which you do _not_ want to do.  You just want the capabilities, you don't 
necessarily want to run as somebody else (or if you do, that "somebody 
else" might well be "nobody"). So suid vs capabilities are different: you 
may even want them to be complementary.

In other words, it would actually make perfect sense to have 

  -r-sr-sr-x    1 nobody  mail  451280 Apr  8  2002 /usr/bin/sendmail

  mount --bind --capability=chown,bindlow /usr/bin/sendmail /usr/bin/sendmail

ie have it be suid nobody:mail (to _remove_ any vestige of normal user
rights but give it write permission on the mail directory), and then
separately giving it specific capabilities to allow it to chown files it
creates and bind to port 25).

(yeah, maybe that's a bad example, I dunno what sendmail actually wants to
do).

In the above, the suid'ness of the binary is totally independent of the 
capabilities: the suid bits don't have any meaning for the capability set, 
since it's not about root, but the suid bits _do_ have meaning from a 
filesystem permission standpoint.

		Linus

