Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289227AbSAJFL6>; Thu, 10 Jan 2002 00:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289289AbSAJFLm>; Thu, 10 Jan 2002 00:11:42 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:30593 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S289227AbSAJFL0>;
	Thu, 10 Jan 2002 00:11:26 -0500
Message-ID: <3C3D22F8.1080201@acm.org>
Date: Wed, 09 Jan 2002 23:13:28 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Moving zlib so that others may use it
In-Reply-To: <24080.1010637887@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

>On Wed, 09 Jan 2002 22:23:31 -0600, 
>Corey Minyard <minyard@acm.org> wrote:
>
>>Keith Owens wrote:
>>
>>>On Wed, 09 Jan 2002 17:32:20 -0600, 
>>>Corey Minyard <minyard@acm.org> wrote:
>>>
>>>>I would like to propose putting zlib in the lib directory and making it 
>>>>optionally compile if it is needed.
>>>>
>>>The best option is to build zlib.o for the kernel (not module) and
>>>store it in lib.a.  Compile zlib.o if any consumer of zlib has been
>>>selected and add a dummy reference to zlib code in vmlinux to ensure
>>>that zlib is pulled from the archive if anybody needs it, even if all
>>>the consumers are in modules.  Some of the zlib symbols will need to be
>>>exported, I will leave that to you.
>>>
>>Why not just create zlib as a module if all the users are modules (so 
>>depmod and modprobe load it)?  That's what everything else does.  And 
>>that way, if it's already in the kernel, the module just won't get 
>>loaded, but if it's not the module gets loaded.  What you are suggesting 
>>seems rather convoluted.
>>
>
>If zlib is a module then it cannot be part of lib/lib.a, it has to be
>separate, with changes to the top level Makefile to conditionally
>include lib/zlib.o.  I did that originally but the changes to
>lib/Makefile and the top level Makefile were worse.  Building zlib as a
>module guarantees that you cannot use it in a boot loader, forcing you
>to maintain multiple versions of zlib.c.  If you are going to use one
>version of zlib then you should try to handle bootloaders as well.
>
Hmm.  It worked fine for me.  I made it a module, and it put it into 
kernel/lib in
/lib/modules/2.4.17 and it did not put it in lib/lib.a  I make it a 
non-module, and
it gets included in lib/lib.a. My diff was the same as yours for the 
Makefile.

I don't know about the bootloaders.  I'm not sure you can make the 
requirement
to have them compiled the same as the kernel, since they may have different
compilation requirements in the boot loader.

>What is convoluted about my solution?  The derivation of CONFIG_ZLIB in
>the top level Makefile is ugly but that ugliness is a side effect of
>CML1.  CONFIG_ZLIB has to be derived somewhere, it is a smaller patch
>to do it in Makefile than to patch 15 arch/*/config.in files.  Apart
>from that, the only other niggle is the dummy reference in init/main.c.
>
The problem is that if you come along later and compile a new module that
needs it, it won't work.  That's a fairly common thing I do, I expect 
other kernel
developers do the same.  And the dummy ref thing is a little ugly.

>>I guess one other option would be to have an explicit user-set tristate 
>>like CONFIG_ZLIB, and if anything uses zlib, it could only be modules if 
>>CONFIG_ZLIB was a module, etc.
>>
>
>Don't ask the user, they will not understand the problem.  CONFIG_ZLIB
>is derived from other configs and possibly ARCH variables, users have
>no direct control over CONFIG_ZLIB.
>
Yeah, I agree, it was just a random thought that occured to me.

Thanks,

-Corey

