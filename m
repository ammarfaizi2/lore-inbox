Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVA0Gu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVA0Gu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 01:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVA0Gu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 01:50:58 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:51427 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262516AbVA0Gum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 01:50:42 -0500
Message-ID: <41F88F59.6040904@comcast.net>
Date: Thu, 27 Jan 2005 01:51:05 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: /proc parent &proc_root == NULL?
References: <41F82218.1080705@comcast.net> <41F84313.4030509@osdl.org> <41F8530C.6010305@comcast.net> <20050127031539.GK8859@parcelfarce.linux.theplanet.co.uk>            <41F86176.3010000@comcast.net> <200501270640.j0R6eD7N000647@turing-police.cc.vt.edu>
In-Reply-To: <200501270640.j0R6eD7N000647@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Valdis.Kletnieks@vt.edu wrote:
> On Wed, 26 Jan 2005 22:35:18 EST, John Richard Moser said:
> 
> 
>>This particular problem pertains to proc_misc.c and trying to create a
>>hook for some grsecurity protections that alter the modes on certain
>>/proc entries.  The chunk of the patch I'm trying to immitate is:
> 
> 
>>+#ifdef CONFIG_GRKERNSEC_PROC_ADD
>>+       create_seq_entry("cpuinfo", gr_mode, &proc_cpuinfo_operations);
>>+#else
>>        create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
>>+#endif
> 
> 
> An alternate way to approach this - leave the permissions alone here.
> 
> And then use the security_ops->inode_permission() hook to do something like:
> 
> 	if ((inode == cpuinfo) && (current->fsuid))
> 		 return -EPERM;
> 
> Writing the proper tests for whether it's the inode you want and whether to
> give the request the kiss-of-death are left as an excersize for the programmer.. ;)
> 
> You may want to use a properly timed initcall() to create a callback that
> happens after proc_misc_init() happens, but before userspace gets going, and
> walk through the /proc tree at that time and cache info on the files you care
> about, so you don't have to re-walk /proc every time permission() gets called....

mmm.  I'd thought about that actually-- for modules to get a whack at
this they'd have to be compiled in.  Loaded as modules would break the
security.

Perhaps both.  I could give modules a "Hook" that gave them a crack at
/proc on load, as well as put a hook in *read**read**read**read*
proc_permission()?  (I wrote one there already!  :)

Also, before it expires

http://rafb.net/paste/results/tZ5Jp878.html

Nice for a simple learning excercise huh?  Modules aren't aware of
stacking, and there's no mandatory dummy code (a la security/dummy.c);
but each hook calls a function that does a loop (based on a C99 variadic
macro) through things, so the lack of a dummy module is kind of offset.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+I9ZhDd4aOud5P8RAvDyAJ9m7KLA9+KzLg2colO3uhRXaxzOXACfQekQ
eHDZYuZ33Qtbz9q0fgaUhmw=
=k7kW
-----END PGP SIGNATURE-----
