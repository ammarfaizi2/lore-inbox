Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277099AbRJDDVI>; Wed, 3 Oct 2001 23:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277098AbRJDDU5>; Wed, 3 Oct 2001 23:20:57 -0400
Received: from femail28.sdc1.sfba.home.com ([24.254.60.18]:48566 "EHLO
	femail28.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277099AbRJDDUt>; Wed, 3 Oct 2001 23:20:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: drepper@redhat.com, ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Date: Wed, 3 Oct 2001 19:20:39 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110031249.HAA50103@tomcat.admin.navo.hpc.mil> <m1r8sk1tuq.fsf@frodo.biederman.org>
In-Reply-To: <m1r8sk1tuq.fsf@frodo.biederman.org>
MIME-Version: 1.0
Message-Id: <01100319203903.00728@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 October 2001 14:06, Eric W. Biederman wrote:

> > But not modify a busy executable.
>
> Have ld-linux.so set the MAP_DENYWRITE bit when it is mapping
> the library.

And of course since the FSF wrote it, it's not quite that simple...

>/* The right way to map in the shared library files is MAP_COPY, which
>   makes a virtual copy of the data at the time of the mmap call; this
>   guarantees the mapped pages will be consistent even if the file is
>   overwritten.  Some losing VM systems like Linux's lack MAP_COPY.  All we
>   get is MAP_PRIVATE, which copies each page when it is modified; this
>   means if the file is overwritten, we may at some point get some pages
>   from the new version after starting with pages from the old version.  */

I.E. it seems like they go out of their way to ALLOW writing to the libaries. 
 (I assume they KNOW the difference between MAP_DENYWRITE, MAP_COPY, and 
MAP_PRIVATE...?)

This look right to anybody else?  Or am I about to wander into weird 
side-effect land?  (Is there a reason they DON'T want a read-only mapping?  
Are they writing data into those pages, perhaps doing the linking fixup 
stuff?  What?)

--- elf/dl-load.bak Wed Oct  3 18:53:37 2001
+++ elf/dl-load.c   Wed Oct  3 18:55:57 2001
@@ -48,7 +48,7 @@
    means if the file is overwritten, we may at some point get some pages
    from the new version after starting with pages from the old version.  */
 #ifndef MAP_COPY
-# define MAP_COPY      MAP_PRIVATE
+# define MAP_COPY      MAP_DENYWRITE
 #endif
 
 /* Some systems link their relocatable objects for another base address

I should just try this and see what it does.  On a machine I don't mind 
reinstalling from scratch.  Which means I need to dig up a spare keyboard for 
my junk machine...  (And figure out how to get glibc's ./configure script to 
realise that linuxthreads is, in fact, there in the source directory.  It's 
right there.  Use it.  Don't yell at me it's not there.  I didn't make this 
SRPM, I changed one line...  Sigh...)

In the morning...

Rob
