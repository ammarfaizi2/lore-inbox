Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268204AbTALDLR>; Sat, 11 Jan 2003 22:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268208AbTALDLR>; Sat, 11 Jan 2003 22:11:17 -0500
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.5]:3471 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S268204AbTALDLQ>; Sat, 11 Jan 2003 22:11:16 -0500
Date: Sat, 11 Jan 2003 22:18:04 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: [OT] Noise on lkml (was Re: Nvidia and its choice to read the	GPL
 "differently")
In-reply-to: <3E20C899.8090204@tmsusa.com>
To: J Sloan <joe@tmsusa.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042341484.1033.119.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <7BFCE5F1EF28D64198522688F5449D5A03C0F4@xchangeserver2.storigen.com>
 <1042250324.1278.18.camel@RobsPC.RobertWilkens.com>
 <20030111020738.GC9373@work.bitmover.com>
 <1042251202.1259.28.camel@RobsPC.RobertWilkens.com>
 <20030111021741.GF9373@work.bitmover.com>
 <1042252717.1259.51.camel@RobsPC.RobertWilkens.com>
 <20030111214437.GD9153@nbkurt.casa-etp.nl>
 <1042322012.1034.6.camel@RobsPC.RobertWilkens.com>
 <3E20C899.8090204@tmsusa.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 20:44, J Sloan wrote:
> I won't even begin to put together a point by
> point correction, it's all too tedious, and it's
> possible that you are here just to annoy and
> wear down the developers anyway -

I've only written a total of maybe 5-6 messages to the list, and maybe 4
of them were off topic because of a previous off-topic message by
somebody else (such as yours).  I don't see how "i" am specifically
designed to wear down developers, though I'll apologize for any comments
I made earlier about the simplicity of kernel development:  I should
comment that it was kernel development I was doing (professionally) when
I had my first two mental breakdowns, so it should be no surprise to
discover that despite the fact that superficially it seemed like easy
work at the time, it can be a stress inducing kind of work which is
somewhat tedious in nature (trying to get various hardware to work just
right, or reversing bit/byte orders for various platforms or that sort
of thing).  

> Please start sending in patches or discussing
> kernel code, or even doing testing - if not, you
> might wish to seek out a different forum for
> your messages, where you might find a more
> receptive audience - I'll refrain from making
> specific suggestions at this time.

I fixed a bug in my kernel (2.4.20), and here's the unified diff with
the hack I put in place, it's not a fix because I don't know enough
about the floppy driver to fix it the right way--- it's called a hack. 
I'm sure if I looked at the problem longer I could fix it right, but it
looks like in 2.5.56 the floppy driver has been rewritten somewhat, but
the problem, I believe, is still there and reproducable (code to
reproduce it is below).

<---Begin--->

--- floppy.c.orig	2003-01-07 21:51:49.000000000 -0500
+++ floppy.c	2003-01-10 15:54:56.000000000 -0500
@@ -3874,7 +3874,7 @@
 		UCLEARF(FD_DISK_CHANGED);
 		if (cf)
 			UDRS->generation++;
-		if (NO_GEOM){
+		if (/*NO_GEOM*/1){
 			/* auto-sensing */
 			int size = floppy_blocksizes[MINOR(dev)];
 			if (!size)


<---End--->

Please note that the above error fixes the following test case.  IF you
have no floppy in the A: drive and run the following test.c code
repeatedly you will find you get different results every time you run
it.  I left the commented sections in the code to illustrate that it
only happens with fd0u1440 as opposed to fd0.

<---Begin--->
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>

#define O_LARGEFILE	0100000

 main()
{	
	int fd,bits;

/*	fd=open("/dev/fd0",O_WRONLY|O_CREAT|O_TRUNC);*/

	/*fd=open("/dev/fd0",O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE);*/
	fd=open("/dev/fd0u1440",O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE);
	
	printf ("fd=%d\n",fd);
	perror("error was: ");
}
<---End--->

Note that O_LARGEFILE isn't meaningful, it was put there because I was
imitating a system call that I saw the "dd" command making when doing an
"strace" (System Call Trace) do when it was failing.

This is a silly and trivial bug, but someone reported it.  Until I get
some acknowledgement of any kind on my first kernel patch submittal, it
seems silly to submit more, even if the acknowledgement is someone
telling me "try to fix it the right way so it doesn't break anything
else" which may involve adding a few more lines of code.

-Rob

