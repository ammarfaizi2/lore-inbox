Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUEPBYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUEPBYd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 21:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264863AbUEPBYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 21:24:33 -0400
Received: from nacho.zianet.com ([216.234.192.105]:32268 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S264857AbUEPBYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 21:24:12 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Sat, 15 May 2004 19:23:41 -0600
User-Agent: KMail/1.6.1
Cc: adi@bitmover.com, scole@lanl.gov, support@bitmover.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <5.1.0.14.2.20040515130250.00b84ff8@171.71.163.14> <20040514204153.0d747933.akpm@osdl.org>
In-Reply-To: <20040514204153.0d747933.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405151923.41353.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 May 2004 09:41 pm, Andrew Morton wrote:
> Lincoln Dale <ltd@cisco.com> wrote:
> >
> > At 02:53 AM 15/05/2004, Andy Isaacson wrote:
> > >That corruption size really does make me think of network packets, so
> > >I'm tempted to blame it on PPP.  Can you find out the MTU of your PPP
> > >link?  "ifconfig ppp0" or something like that.
> > 
> > 1352 bytes coule be remarkably close to the TCP MSS . . .
> > perhaps there is some interaction with ppp where there is an overrun / lost 
> > packet and the TCP window is mistakenly advanced?
> 
> Steve, if it's a memory stomp then perhaps CONFIG_DEBUG_PAGEALLOC and
> CONFIG_DEBUG_SLAB might pick it up.
> 
> It seems awfully deterministic though.
> 
> 
Second reply with some interesting developments.

I ran Andy's bk exersisor script on a vendor supplied kernel (2.6.3-4mdk) for
36 iterations, with no failures at all.

I then stopped that test, updated the 2.6-tree to the state at 15:00 MDT today,
compiled with the above two DEBUG options, and rebooted with that new
kernel.

I ran Andy's script again, and it caused a failure right away.  Here is a
snipped version of the log:

renumber: can't read SCCS info in "SCCS/s.ChangeSet".
include/asm-x86_64/SCCS/s.i387.h
[list of files snipped]
net/ipv4/SCCS/s.ip_output.c
Your repository should be back to where it was before undo started
We are running a consistency check to verify this.
check passed
Undo failed, repository left locked.
WARNING: deleting orphan file /home/steven/tmp/bk_clone2_0dH5v6
Entire repository is locked by:
        RESYNC directory.
ERROR-Unable to lock repository for update.
1 renumber: can't read SCCS info in "RESYNC/SCCS/s.ChangeSet".
bk: takepatch.c:1343: applyCsetPatch: Assertion `s && s->tree' failed.
2 renumber: can't read SCCS info in "RESYNC/SCCS/s.ChangeSet".
bk: takepatch.c:1343: applyCsetPatch: Assertion `s && s->tree' failed.
3

The digits in column 1 above are an iteration count from the testing script.

I control-c'ed out at that point.
For reference, here is Andy's script again:
#!/bin/sh
x=0
while true; do
        bk clone -qlr40514130hBbvgP4CvwEVEu27oxm46w testing-2.6 foo
        (cd foo; bk pull -q)
        rm -rf foo
        x=`expr $x + 1`
        echo -n "$x "
done

The RESYNC directory in 'foo' does not contain an SCSS directory.
There were no unusual messages in dmesg.

In the spirit of 'rounding up the usual suspects', I'll unset CONFIG_PREEMT
and try again.

Steven
