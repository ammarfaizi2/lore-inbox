Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVA0RnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVA0RnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVA0RkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:40:15 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:8626 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262101AbVA0RiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:38:16 -0500
Message-ID: <41F92721.1030903@comcast.net>
Date: Thu, 27 Jan 2005 12:38:41 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org> <20050127101322.GE9760@infradead.org>
In-Reply-To: <20050127101322.GE9760@infradead.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> 
> The patch below replaces the existing 8Kb randomisation of the userspace
> stack pointer (which is currently only done for Hyperthreaded P-IVs) with a 
> more general randomisation over a 64Kb range.
> 

64k of stack randomization is trivial to evade.  Know the alignment, and
stick branch instructions (or a stream of no-ops if they align)
periodically so that....

[   ]|STACK---STACK---NONONOSHELLCODE
STACK---STACK---NONONOSHELLCODE
- ----------------------^
|
- -- You jump here in any case.

Now, in PaX, there's a randomization over something like a 256M range
for the stack IIRC.  Who does a 256M stack overflow?  It's several gigs
on 64 bit archs I think.  I think it's 16 bits with 4k (12 bit) pages,
so.... 28 bits... 268435456.... 256M, yes.  I'm pretty sure this is 24 +
12 on amd64 for example, so 64 gigs.

If your stack base is within 256M of ESP, you're safe.  It's also fairly
implausible--definitely non-trivial--to do a 256M stack buffer overflow.
 Programmatically it's no different; but in real life, that's 256M that
has to be in a corrupted jpeg, mp3 file, or network transmission.
Somebody's gonna notice.  64 gig doesn't happen.

Your patch 5/6 for mmap rand is also small.  1M is trivial, though I'd
imagine mmap() rand would pose a bit more confusion in some cases at
least, even for small ranges.

Still, this is a joke, like OpenBSD's stackgap.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+ScghDd4aOud5P8RAk3zAJ9u3eav0l/Uhd3tQJ7uhDch+bepmACfeuYT
bQH8NCKkDXpmOPsXjVZ9cw4=
=e6OC
-----END PGP SIGNATURE-----
