Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289161AbSAJEpS>; Wed, 9 Jan 2002 23:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289163AbSAJEpI>; Wed, 9 Jan 2002 23:45:08 -0500
Received: from rj.SGI.COM ([204.94.215.100]:23476 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S289161AbSAJEo6>;
	Wed, 9 Jan 2002 23:44:58 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Moving zlib so that others may use it 
In-Reply-To: Your message of "Wed, 09 Jan 2002 22:23:31 MDT."
             <3C3D1743.40900@acm.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 Jan 2002 15:44:47 +1100
Message-ID: <24080.1010637887@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jan 2002 22:23:31 -0600, 
Corey Minyard <minyard@acm.org> wrote:
>Keith Owens wrote:
>>On Wed, 09 Jan 2002 17:32:20 -0600, 
>>Corey Minyard <minyard@acm.org> wrote:
>>>I would like to propose putting zlib in the lib directory and making it 
>>>optionally compile if it is needed.
>>
>>The best option is to build zlib.o for the kernel (not module) and
>>store it in lib.a.  Compile zlib.o if any consumer of zlib has been
>>selected and add a dummy reference to zlib code in vmlinux to ensure
>>that zlib is pulled from the archive if anybody needs it, even if all
>>the consumers are in modules.  Some of the zlib symbols will need to be
>>exported, I will leave that to you.
>>
>Why not just create zlib as a module if all the users are modules (so 
>depmod and modprobe load it)?  That's what everything else does.  And 
>that way, if it's already in the kernel, the module just won't get 
>loaded, but if it's not the module gets loaded.  What you are suggesting 
>seems rather convoluted.

If zlib is a module then it cannot be part of lib/lib.a, it has to be
separate, with changes to the top level Makefile to conditionally
include lib/zlib.o.  I did that originally but the changes to
lib/Makefile and the top level Makefile were worse.  Building zlib as a
module guarantees that you cannot use it in a boot loader, forcing you
to maintain multiple versions of zlib.c.  If you are going to use one
version of zlib then you should try to handle bootloaders as well.

What is convoluted about my solution?  The derivation of CONFIG_ZLIB in
the top level Makefile is ugly but that ugliness is a side effect of
CML1.  CONFIG_ZLIB has to be derived somewhere, it is a smaller patch
to do it in Makefile than to patch 15 arch/*/config.in files.  Apart
from that, the only other niggle is the dummy reference in init/main.c.

>I guess one other option would be to have an explicit user-set tristate 
>like CONFIG_ZLIB, and if anything uses zlib, it could only be modules if 
>CONFIG_ZLIB was a module, etc.

Don't ask the user, they will not understand the problem.  CONFIG_ZLIB
is derived from other configs and possibly ARCH variables, users have
no direct control over CONFIG_ZLIB.

