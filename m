Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267336AbSLRTAQ>; Wed, 18 Dec 2002 14:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267334AbSLRTAQ>; Wed, 18 Dec 2002 14:00:16 -0500
Received: from fmr04.intel.com ([143.183.121.6]:35325 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S267344AbSLRS7o>; Wed, 18 Dec 2002 13:59:44 -0500
Message-Id: <200212181907.gBIJ7XP12936@unix-os.sc.intel.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: Multithreaded coredump patch where?
Date: Wed, 18 Dec 2002 08:13:25 -0800
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <5.2.0.9.0.20021216182325.042a2b60@mail.isolaweb.it> <5.2.0.9.0.20021217105617.00aa31e0@mail.isolaweb.it>
In-Reply-To: <5.2.0.9.0.20021217105617.00aa31e0@mail.isolaweb.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 December 2002 03:05 am, Roberto Fichera wrote:
> >I haven't rebased the patches I posted back in June for a while now.
> >
> >Attached is the patch I posted for the 2.4.18 vanilla kernel.  Its a bit
> >controversial, but it seems to work for a number of folks.  Let me know if
> >you have any troubles re-basing it.
>
> Only one hunk failed on include/asm-ia64/elf.h but fixed by hand.
> Why do you say a bit controversial ? One difference that I have
> notice is in coredump size after your patch. However seem to be
> working well for now. I'll try later on a SMP machine.

There are 2 issues with this implementation that will likely not effect you.


First, when dumping core of MT applications with LOTS of threads the pthread 
library signals all the threads in the  application to exit.  Sometimes 
the process that is dumping core fails to suspend other threads in the 
application before some exit.  The result of this is that for such 
applications you will not see them in the core file.  

You have to work at it to see this failure.  The way I reproduce this is to 
run a test application with about 555 pthread threads in it and send it a 
sig_quit.  When I look at the core file wont have all 555 threads.  SMP makes 
this effect a bit more noticeable.

Ingo's design to fix this change the exit path for thread to wait for the 
core file to get dumped before finishing the process clean up.  I like this 
approach, I just wish I thought of it ;)

Second, the controversial issue is in the way my design pauses the other 
threads in the MT application.  Its not semaphore lock safe.  Although no 
instance of the following failure has been seen, it is possible with new 
kernel code.

If one of the processes in the MT application is currently holding semaphore 
lock when the dumping process pauses it, AND the dumping process does any 
blocking operation that could attempt to grab this same semaphore, THEN the 
core dump will deadlock.  Boom.

My patch is good for developers, pending the back port of Ingo's version.

Do let me know how it works out for you.

--mgross

