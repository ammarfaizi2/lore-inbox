Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbULEHDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbULEHDz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 02:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbULEHDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 02:03:54 -0500
Received: from picard.ine.co.th ([203.152.41.3]:437 "EHLO picard.ine.co.th")
	by vger.kernel.org with ESMTP id S261267AbULEHDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 02:03:50 -0500
Subject: Re: 2.6.9, 64bit, 4GB memory => panics ...
From: Rudolf Usselmann <rudi@asics.ws>
Reply-To: rudi@asics.ws
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412042321080.6378@montezuma.fsmlabs.com>
References: <1102072834.31282.1450.camel@cpu0>
	 <20041203113704.GD2714@holomorphy.com> <1102225183.3779.15.camel@cpu0>
	 <Pine.LNX.4.61.0412042321080.6378@montezuma.fsmlabs.com>
Content-Type: text/plain
Organization: ASICS.ws - Solutions for your ASICS & FPGA needs -
Message-Id: <1102230225.3778.75.camel@cpu0>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 05 Dec 2004 14:03:46 +0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-05 at 13:26, Zwane Mwaikambo wrote:
> Make sure that you have the following option in your kernel;
> 
> CONFIG_SERIAL_8250_CONSOLE=y
> 
...
> 
> 7:35:respawn:/sbin/agetty 38400 ttyS0
> 
> Finally all you need is a program on the monitoring system, minicom 
> should suffice if you have nothing else.
> 
> 	Zwane

Thanks a lot Zwane, appreciate these tips !

I am now trying to be better prepared for my next 4gb test, and
have been working on a small program that should "eat memory".
I'm not sure I am doing the right thing though ...

The idea was to create an app that would consume a lot of memory
without touching any other system resources.

At first I used ksysguard to watch the memory consumption.
Interestingly enough, it was "wired": The VmSize column seems
to jump randomly, once I get 1,051 than I will see 3,148,615
than I will get 2,789 than I might see 1,073,976 than it will
give me 3,148 .... all during the same run of my mem eater app.

... just mentioning it here in case there is a connection between
my problem and this wired display ...

Now this testing was done with 2GB at first ... no kernel panics
with 2GB.

Than I decided to use /proc/meminfo, but that suggests that I
am not using all memory at all ! With 2GB malloc fails after
510 iterations (510 MB ???) ... (I have a 10GB swap partition)
And /proc/meminfo confirms that:
MemTotal:      2056528 kB
MemFree:       1526424 kB

About 1/2 gig is used, I checked limits, and that said unlimited ...
What else can block memory usage ? May be I just need to start my
app several times ?!

Hmm, after forking mem eater 6 times I get:
MemTotal:      2056528 kB
MemFree:        610000 kB
Which is almost the same as after 4 and 5 spins ...

Any ideas/suggestion ?

Thanks a lot guys & gals !

Kind Regards,
rudi


// -------------------------- eat mem ---------------------------------

#include "stdio.h"
#include "stdlib.h"

int main() {

int mem[10000];
int i, n;

for(i=0;i<2000;i++) {
	printf("Doing alloc %0d ...\n",i);
	mem[i] = (int)malloc(1024*1024*1024);
	if(mem[i] == NULL)
		printf("Malloc failed ...\n");
	else
		for(n=0;n<(1024*1024*1024);n=n+640)	mem[i] = n;
   }

while(1);

return(0);
}

// --------------------------------------------------------------------

