Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVENAEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVENAEZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 20:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVENAES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 20:04:18 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:64692 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262632AbVENACu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 20:02:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n8PvKqTa1Amc6y2JtKxRfgDYSTe7oAoQb+Vh5KKP0dcNgCJeuXmkx1ZKHQGrQhppiPaSsXX7fZPtiZ908Mqwg1i55ll5cICD5vlf/Dij9Gwz+Xr3Wl7cArRrpYWIfKGxXEfrt1jmM4YCT8vP7aTTfWQJsu0CPXTuWYZU0D1mscU=
Message-ID: <fc67f8b705051317023859c443@mail.gmail.com>
Date: Fri, 13 May 2005 20:02:48 -0400
From: Ritesh Kumar <digitalove@gmail.com>
Reply-To: ritesh@cs.unc.edu
To: Jakub Jelinek <jakub@redhat.com>
Subject: Re: NPTL: stack limit limiting number of threads
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20050513202346.GG17420@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <fc67f8b705051312494a0badf7@mail.gmail.com>
	 <20050513202346.GG17420@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/05, Jakub Jelinek <jakub@redhat.com> wrote:
> On Fri, May 13, 2005 at 03:49:48PM -0400, Ritesh Kumar wrote:
> > However, I was most amazed to see that the limit on stack size on
> > FreeBSD (5.3 Release) was 64M by default! I was just wondering, how is
> > FreeBSD able to create about a 1000 threads with that kind of a stack
> > limit. Also, is there anything specific in its implementation which
> > makes it difficult to incorporate in Linux? Wouldn't it be a good idea
> > to remove this "trade-off" between stack limit and number of threads
> > and fail thread creation only when we have run out of address space
> > being *actually used* in the stacks in a process.
> 
> On FreeBSD the default thread stack size is not computed from ulimit -s,
> but is constant.  They apparently only recently increased it to 1MB
> (resp. 2MB on 64-bit arches), from 64K.
> 
> On Linux, the default thread stack size (except with fixed stack LinuxThreads)
> is determined from ulimit -s (with a constant default if ulimit -s is
> unlimited).
> 
> If your threaded application has specific needs for stack sizes, it can
> always pthread_attr_setstacksize to whatever you find appropriate.
> 
> The thread library needs to know the stack size limit before creating
> the thread, that can't be changed dynamically.
> 
>         Jakub
> 

Hi Jakub,
    Thanks for your reply. I actually went ahead after getting your
mail and coded up a small program to check the stack limit
deliberately. The program is shown inline.

#include <stdio.h>

#define BUF_SIZE 1024000

void recurse(int n){
	char ch[BUF_SIZE];
	if(n<=0)
		return;
	else
		recurse(n-1);
}

int main(argc, argv)
	int argc;
	char **argv;
{
	if(argc!=2){
		printf("Usage: %s <n (megabytes)>\n", argv[0]);
		return 1;
	}
	printf("Checking for %dMB\n", atoi(argv[1]));
	recurse(atoi(argv[1]));
}

Its a fairly crude way to find out the actual stack limit. Basically,
the resurse function recurses each time allocating ~1MB of space on
the stack. The program segfaults exactly at the ulimit -s value of
stack size on both linux and freebsd. So it does seem that the ulimit
-s is the value of stack limit used on FreeBSD.


Ritesh
-- 
http://www.cs.unc.edu/~ritesh/
