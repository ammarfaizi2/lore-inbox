Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289156AbSAJEV4>; Wed, 9 Jan 2002 23:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289160AbSAJEVr>; Wed, 9 Jan 2002 23:21:47 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:22145 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S289156AbSAJEVb>;
	Wed, 9 Jan 2002 23:21:31 -0500
Message-ID: <3C3D1743.40900@acm.org>
Date: Wed, 09 Jan 2002 22:23:31 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Moving zlib so that others may use it
In-Reply-To: <25006.1010627525@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

>On Wed, 09 Jan 2002 17:32:20 -0600, 
>Corey Minyard <minyard@acm.org> wrote:
>
>>I'm working on a function that uses zlib in the kernel, and I know of 
>>other places zlib is used (ppp_deflate, jffs2, mcore).  I would expect 
>>more users to come along.
>>
>>I would like to propose putting zlib in the lib directory and making it 
>>optionally compile if it is needed.  It's pretty easy to move the files 
>>around and make a few small changes to the code.  However, how do I 
>>configure such a thing?  I could add something like:
>>
>
>I am assuming that you can satisfy hpa's concerns about using a single
>version of zlib for everybody.  Also note that arch/ppc/boot/lib has
>its own version of zlib which is quite different to the others.  First
>make sure that you can build one version of zlib that works for
>everybody.
>
Every version I found was practically the same (only comment differences 
and one that variable that was initialized in one and not initialized in 
the other).  I think (actually, I know, because I have tested it) 
everyone can use the same one.  I'm not talking about the ones in the 
boot directories, nor the one for inflate_fs, either, just the ones in 
the kernel proper that are named zlib.c and zlib.h.

>Configuring and linking zlib is a problem.  lib/lib.a is an archive
>which means that the linker will only include zlib from lib.a if some
>other code refers to zlib.  That breaks when all users of zlib are in
>modules and nothing in vmlinux refers to zlib, the zlib code is not
>linked into the kernel and modules get unresolved errors.  Linking
>lib.a into the affected modules is not the solution either, the modules
>would pick up all the code from lib.a instead of using the code in the
>kernel with undefined result
>
>The best option is to build zlib.o for the kernel (not module) and
>store it in lib.a.  Compile zlib.o if any consumer of zlib has been
>selected and add a dummy reference to zlib code in vmlinux to ensure
>that zlib is pulled from the archive if anybody needs it, even if all
>the consumers are in modules.  Some of the zlib symbols will need to be
>exported, I will leave that to you.
>
Why not just create zlib as a module if all the users are modules (so 
depmod and modprobe load it)?  That's what everything else does.  And 
that way, if it's already in the kernel, the module just won't get 
loaded, but if it's not the module gets loaded.  What you are suggesting 
seems rather convoluted.

I guess one other option would be to have an explicit user-set tristate 
like CONFIG_ZLIB, and if anything uses zlib, it could only be modules if 
CONFIG_ZLIB was a module, etc.

>
>
>This should do the trick, completely untested.  It assumes that zlib.h
>has been moved to to include/linux and zlib.c to lib.  Against 2.4.17.
>
I already have patches to do all this, actually, I was just trying to 
get some feedback on it and see if the kernel maintainers would be 
interested in this.  I should have said that earlier.

Thanks,

-Corey

