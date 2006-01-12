Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWALCBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWALCBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 21:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWALCBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 21:01:21 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:41029 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S964976AbWALCBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 21:01:20 -0500
Date: Wed, 11 Jan 2006 21:00:52 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-reply-to: <Pine.LNX.4.61.0601120019430.30994@scrub.home>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <1137031253.9643.38.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <0ISL003ZI97GCY@a34-mta01.direcway.com>
 <200601090109.06051.zippel@linux-m68k.org> <1136779153.1043.26.camel@grayson>
 <200601091232.56348.zippel@linux-m68k.org> <1136814126.1043.36.camel@grayson>
 <Pine.LNX.4.61.0601120019430.30994@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 00:26 +0100, Roman Zippel wrote:
> Hi,
> 
> On Mon, 9 Jan 2006, Ben Collins wrote:
> 
> > > That just means Debian's automatic build for the kernel has been broken for 
> > > years. All normal config targets require user input and no input equals 
> > > default input. Only silentoldconfig will abort if input is not available.
> > 
> > I think that's broken (because I don't see where that behavior is
> > described).
> 
> I'll accept a patch to fix the documentation.
> 
> > IMO, based on the code, it should only go with defaults when
> > -n -y or -m is passed.
> 
> No.
> 
> > Why is it so hard to error when stdin is closed? It's not like that will
> > break anything.
> 
> oldconfig & co are interactive targets, so don't use them in automatic 
> builds. If you some problem with using silentoldconfig, describe it and 
> I'll help to solve it.

First, we need oldconfig because it allows us to look at the build log
and see exactly what happened in the config stage. Silentoldconfig gives
us no feedback for logs.

Now let me see if I get this right:

1) oldconfig was broken when stdin was closed. Meaning, it went into an
infinite loop. This was obviously not the intended outcome.

2) silentoldconfig will, when faced with a closed stdin, abort, and
notify the user.

3) Obviously since current behavior of oldconfig was broken with a
closed stdin, then it was never doing what anyone wanted in this usage
case. Since no one else noticed it, that means that we are the only use
case for this.

4) I send a patch that fixes oldconfig with closed stdin by making it
duplicate what silentoldconfig does, aborting when it needs input and
stdin is closed. Since oldconfig was always broken in this usage case,
this seems the obvious fix, plus it's consistent. This isn't the same as
an empty string (e.g. when hitting enter), which didn't get changed, and
has always meant to use the default value.

5) My patch did not break anything, nor did it change anything that was
already working.

6) In response you make oldconfig work exactly opposite of
silentoldconfig by using the default value for a config option when
stdin is closed (basically acting like the user hit ENTER), and further
break things for me in this usage case, with no purpose, and no reason
for making your change the way you did. Since it was broken, you aren't
helping anyone. We can't have the build system using default values. We
need it to abort.

Did I get this right, or am I imagining that you are being hard headed
about this?

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

