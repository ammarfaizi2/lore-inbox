Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129323AbRB0RwD>; Tue, 27 Feb 2001 12:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129435AbRB0Rvx>; Tue, 27 Feb 2001 12:51:53 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:1408
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S129323AbRB0Rvk>; Tue, 27 Feb 2001 12:51:40 -0500
Date: Tue, 27 Feb 2001 09:51:25 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200102271751.f1RHpP401022@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: iv@spylog.com, <linux-kernel@vger.kernel.org>
Subject: Re: Memory allocation
In-Reply-To: <004901c0a0de$2647d6c0$0e04a8c0@iv>
In-Reply-To: <004901c0a0de$2647d6c0$0e04a8c0@iv>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

>I encountered with problem: one process can not allocate more then 2Gb of
>memory. 

This is a problem that I have run into myself.  I am no kernel expert,
but I think I understand how this issue.  Here is how the standard
kernel maps the 4Gb 32-bit address space from the process's point of
view:

128MB	 program executable mapped (twice)
128MB +	 program heap
1GB	 mmap() starts here
3GB	 kernel

You can see this for yourself by looking at /proc/pid/maps, where pid
is the PID of the process in question.  

Now glibc()'s malloc uses mmap() for 'large' allocations, so you get
2GB maximum memory.  The way around this is to change the various
numbers in the left-hand column.

For example, you can try the patch per-process-3.5G-IA32-no-PAE-1, at
/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test11-pre5/ on
ftp.kernel.org.  This will make the kernel space start at 3.5G (so
that CONFIG_4G is required to use more than 384MB of physical RAM) and
the mmap() space start at 224MB, giving 3G288MB of address space for
mmap().  Note that only 96MB is then available for {two copies of your
executable plus your program heap}.

This is more or less the most you can do, but your needs may be best
suited by something in between. The above patch is quite short, so it
is easy to figure out how to do that.  The only hidden restriction is
that the size of the kernel space must be a power of 2: 2GB, 1GB,
512MB, etc.  As explained to me, this is so that the kernel can easily
test a pointer to see whether it is to kernel space or user space.

Cheers,
Wayne




