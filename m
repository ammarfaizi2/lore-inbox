Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269372AbUIYSGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269372AbUIYSGb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 14:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269375AbUIYSGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 14:06:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:27277 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269372AbUIYSG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 14:06:27 -0400
Date: Sat, 25 Sep 2004 11:06:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeremy Allison <jra@samba.org>
cc: YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
In-Reply-To: <20040925174406.GP580@jeremy1>
Message-ID: <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org>
 <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1>
 <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Sep 2004, Jeremy Allison wrote:
> 
> Thanks. Not only that. st_blocks is a UNIX standard, it's not
> in POSIX. I always try to keep the core fileserving code as
> close to POSIX as possible to allow people to do crazy things
> (like porting it to Windows :-).

Ehh, what's the problem with just having a simple config flag, and just 
export whatever the underlying server exports. At least it won't be the 
total mess that samba clearly makes of it now.

You cannot claim that the number samba now puts there makes _any_ sense.  
Why the apparent 1MB minimum limit? And if it's just the size of the file
in bytes, then why bother with it at all? And if you cannot get a 
blocksize from the OS, why make up a nonsensical number?

In other words, your arguments do not make any sense. 

Let's go through this:

 - you argue that you can't depend on st_blocks. 

   This implies that _any_ number you use for "number of bytes" _or_ 
   "number of blocks" used on disk has _zero_ to do with reality.

   This implies that the whole exercise is pointless, and you shouldn't 
   fill in the value at all.

 - assuming you _do_ look at st_blocks on the server, you argue that you 
   cannot make sense of it.

   Ok, so there may be broken systems out there. Tough. If you can't make 
   sense of the number, why are you trying to export it again?

In other words, neither of your arguments make any sense. You'd be better 
off just initializing the field with plain zero, and not lying to the 
client with a number that has no relevance to anything at all, and expect 
the client to sort it out.

My argument is that if the only thing the client can really use the 
information for is st_blocks (or equivalent) _anyway_, then just export 
it. And if you think

		unsigned long st_blocks = 0;

	#ifdef HOST_HAS_ST_BLOCKS
		st_blocks = stat->st_blocks;
	#endif

is too ugly yo have in a header file somewhere, then why bother with 
trying to put any number in there in the first place? What was the point 
of:

	CIFS Extensions for UNIX systems V1
	LARGE_INTEGER NumOfBlocks
	Number of file system block used to store file

again?  Was it a CIFS Extension for POSIX? Or was it for UNIX like the 
documentation specifies? Was it bytes, or was it blocks, like the 
documentation says?

Methinks you've been looking too much at what MS does over the wire, and 
that has made you think that it makes total sense to send random numbers 
over the wire. Maybe so - maybe it's how you have to think if you make a 
samba server. But if so, just _say_ so, instead of making arguments that 
make no sense.

		Linus
