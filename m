Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbUK0VuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbUK0VuJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 16:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbUK0VuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 16:50:08 -0500
Received: from hermes.domdv.de ([193.102.202.1]:23052 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261334AbUK0VuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 16:50:00 -0500
Message-ID: <41A8F67E.1060908@domdv.de>
Date: Sat, 27 Nov 2004 22:49:50 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040918
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       matthew@wil.cx, dwmw2@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com> <20041127210331.GB7857@mars.ravnborg.org> <41A8ED8F.5010402@domdv.de> <20041127211923.GA21765@mars.ravnborg.org>
In-Reply-To: <20041127211923.GA21765@mars.ravnborg.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Sat, Nov 27, 2004 at 10:11:43PM +0100, Andreas Steinmetz wrote:
> 
>>>If we go for some resturcturing of include/ then we should get rid of
>>>the annoying asm symlink. Following layout deals with that:
>>>
>>>include/<arch>/asm		<= Files from include/asm-<arch>
>>>include/<arch>/mach*		<= Files from include/mach-*
>>>
>>>This layout solve the symlink issue in an elegant way.
>>>We need to do trivial changes to compiler options to make it work. Changing
>>>compiler options is much more relaible than using symlinks.
>>>
>>>Then the userspace part would then be located in:
>>>include/<arch>/user-asm
>>>
>>
>>This complicates things for bi-arch architectures like x86_64 where one 
>>can use a dispatcher directory instead of a symlink to suit include/asm 
>>for 32bit as well as 64bit.
> 
> X86_64 does not create any special symlinks todays so I do not see the point?
> And still a symlink is just the wrong way to solve the problem.
> Adjusting options to the compiler is the way to do it.

Ok, this is not in the kernel, but think of the following: an 
application needs and include/asm header. The application may be 
compiled as 32 bit and as 64 bit. Then you could use a real asm 
directory instead of a symlink and use, e.g. for asm/byteorder.h:

#ifdef __x86_64__
#include <asm-x86_64/byteorder.h>
#else
#include <asm-i386/byteorder.h>
#endif

This way both archs are satisfied from a userspace point of view without 
  having to take care if the source is compiled on 32bit or 64bit. If 
you kill the symlink this neat dispatcher can't really be done anymore 
that easy.
It is not necessary to do anything in the kernel tree here except to 
keep the symlink to allow for this kind of userspace tweaks for certain 
architectures.
This is especially important when there's need to use a include/linux 
header which itself needs an include/asm header as in this case with the 
  the little tweak always the right asm header is included.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
