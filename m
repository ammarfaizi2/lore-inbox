Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316689AbSEUUsO>; Tue, 21 May 2002 16:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316650AbSEUUsM>; Tue, 21 May 2002 16:48:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34833 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316689AbSEUUsB>; Tue, 21 May 2002 16:48:01 -0400
Date: Tue, 21 May 2002 13:47:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
        <alan@lxorguk.ukuu.org.uk>
Subject: Re: AUDIT: copy_from_user is a deathtrap.
In-Reply-To: <20020516235335.C116@toy.ucw.cz>
Message-ID: <Pine.LNX.4.33.0205211340080.3073-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 May 2002, Pavel Machek wrote:
> I thought POSIX made it explicit that you may SIGSEGV or EFAULT at your
> option. If that SUS rule is stupid, we should just drop it.
> 
> Performance advantage from MMX-copy-to-user is probably well worth it.

Stop this STUPID "it speeds things up" argument.

It's not TRUE.

We still have to do exactly the same things we do right now, because even
if we SIGSEGV we still have to return the right number of bytes
read/written. 

SIGSEGV doesn't mean that the system call wouldn't complete. It removes 
_none_ of the kernel fixup handling, because the SIGSEGV won't be 
delivered until we return to user mode anyway. So please stop mixing these 
two issues up.

There are two completely orthogonal issues:

 - Use SIGSEGV on system calls or not.

   Using SIGSEGV makes the system call vs library routine issue more 
   regular, but it does not change the fact that the system call has to 
   return _something_.

 - system call return value for partially successful read/write. 

   We already have the exact same issue wrt something like SIGINT, and 
   nobody sane would ever suggest that we always return the "whole" thing
   if we're interrupted by an external signal.

   Similarly, it's naive and stupid to suggest we return success if we get 
   interrupted by a SIGSEGV/EFAULT.

On the first issue (SIGSEGV) I'm certainly open to trying that out, 
although I'm fairly certain there was _some_ reason we didn't do this a 
few years ago.

On the second issue, absolutely _nobody_ has shown any reason why we 
should break the existing code that does this correctly, and I've shown 
reasons why breaking it is STUPID.

			Linus

