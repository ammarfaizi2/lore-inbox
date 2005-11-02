Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965181AbVKBTNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965181AbVKBTNn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 14:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbVKBTNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 14:13:42 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:9640 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S965181AbVKBTNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 14:13:42 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Dave Jones <davej@redhat.com>
Subject: Re: echo 0 > /proc/sys/vm/swappiness triggers OOM killer under 2.6.14.
Date: Wed, 2 Nov 2005 13:13:24 -0600
User-Agent: KMail/1.8
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <53vpu-s9-17@gated-at.bofh.it> <200511010237.01737.rob@landley.net> <20051102073251.GB23297@redhat.com>
In-Reply-To: <20051102073251.GB23297@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511021313.25198.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 01:32, Dave Jones wrote:
> On Tue, Nov 01, 2005 at 02:37:01AM -0600, Rob Landley wrote:
>  > oom-killer: gfp_mask=0x400d2, order=0
>
> something explicitly asked for a highmem page.
>
>  > 0 pages of HIGHMEM
>
> You don't have any.
>
> Calling the oom-killer in this situation seems drastic though.
>
>   Dave

Except that the only difference between this test and the one that succeeds is 
the value of "/proc/sys/vm/swappiness".  With 60 it finishes, with 0 it 
fails.  The same binaries are being run by the same script, and in neither 
case is there highmem in the kernel.

The test system is a User Mode Linux instance, running a shell script in place 
of init.  As a result, there are very few processes running in this system, 
and only one is really active at a time.

At the failure point, the shell script calls the "make" of gcc 4.0.2, and far 
and away the high point of memory usage is gcc's "genattrtab", which creates 
and then compiles a .c file that causes the system to swap for about 5 
minutes before it completes.  (This is an extreme memory hog: Before I 
started feeding UML a swap file, it couldn't complete with only 128 megs of 
ram, but finished with 256.  Now I'm telling UML mem=64M and attaching a 256 
megabyte file to the Usermode Block Device driver, to act as a swap 
partition.)

So at the point of failure, bash is blocked waiting on a child, make is 
blocked waiting on a child, gcc is building its attrtab pig, and nothing else 
(no daemons, not even init) is running on the system.  It's a pretty 
straightforward "the VM goes nuts in a low memory situation" case.

If you'd like to reproduce this, I can send you my build script.  It's 
self-contained, downloads all  the source code it needs automatically, and 
either succeeds or reproduces the problem quite deterministically depending 
on whether or not the "echo 0 > /proc/sys/vm/swappiness" line is present or 
not.

Rob
