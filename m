Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264821AbUFYPr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264821AbUFYPr3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 11:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266762AbUFYPr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 11:47:29 -0400
Received: from [66.199.228.3] ([66.199.228.3]:59408 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S264821AbUFYPr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 11:47:26 -0400
Date: Fri, 25 Jun 2004 08:47:17 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200406251547.i5PFlHNS000884@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Cache memory never gets released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
>Are you sure you have a problem?
>...
>This is linux-2.4.26. If you are using an exprimental kernel,
>memory-allocation might be broken but is probably not.

Yes, I am absolutely sure I have a problem. The cached memory gets
lost so I can't ever use it again over time. I have a simple hog.c program
that just allocs blocks of 1M and fills them with data:
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>

/* This program just hogs a lot of memory */

#define SIZE 0x100000
int main(int argc,char **argv)
{
char *p;
int i=0;
        for(;;)
        {
                p=malloc(SIZE);
                if(!p) break;
                memset(p,0,SIZE);
                i+=SIZE;printf("Allocated %dM\n",i/1000000);
//              sleep(1);
        }
        exit(0);
}


On a pristine system I can work the cached line output by "free"
down to around 6M. After usage, over time, the cached amount works its
way up to be basically all of system memory, and I can't ever work it
down. The hog program above runs but the kernel kills it after only
a small amount of memory can be allocated.

I'm not doing anything mysterious. The kernel is stock 2.4.26 except for
some changes to these files:
Documentation/Configure.help
Makefile
arch/i386/config.in
drivers/sound/via82cxxx_audio.c
fs/proc/array.c
fs/proc/proc_misc.c
include/asm-i386/param.h
kernel/signal.c
kernel/sys.c
net/ipv4/icmp.c

Nothing related to caching/memory management has been touched. I've applied
the variable HZ patch so ticks happen 500/second up from 100/second.

Is there any valid reason why cached memory would stay locked at 54M for
example and never go lower, even when there are almost no processes running
on the system?

Thanks--
Dave
PS Is there some way that cached blocks can somehow form interdependencies?
For example block A can't be released until block B is, and vice-versa?
And that these can build up over time? This is the kind of behaviour I'm
seeing.

