Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287381AbSAUQoW>; Mon, 21 Jan 2002 11:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287401AbSAUQoQ>; Mon, 21 Jan 2002 11:44:16 -0500
Received: from dsl-213-023-039-080.arcor-ip.net ([213.23.39.80]:46729 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287381AbSAUQoE>;
	Mon, 21 Jan 2002 11:44:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: yodaiken@fsmlabs.com
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 21 Jan 2002 17:48:30 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, george anzinger <george@mvista.com>,
        Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com>
In-Reply-To: <20020121090602.A13715@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ShcU-0001ip-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 21, 2002 05:06 pm, yodaiken@fsmlabs.com wrote:
> On Mon, Jan 21, 2002 at 05:05:01PM +0100, Daniel Phillips wrote:
> > > I think of "benefit", perhaps naiively, in terms of something that can
> > > be measured or demonstrated rather than just announced.
> > 
> > But you see why asap scheduling improves latency/throughput *in theory*, 
> 
> Nope. And I don't even see a relationship between preemption and asap I/O
> schedulding. What make you think that I/O threads won't be preempted by
> other threads?

Consider a thread reading from disk in such a way that readahead is no help, 
i.e., perhaps the disk is fragmented.  At each step the IO thread schedules a 
read and sleeps until the read completes, then schedules the next one.  At 
the same time there is a hog in the kernel, or perhaps there is 
competition from other tasks using the kernel.  In any event, it will 
frequently transpire that at the time the disk IO completes there is somebody 
in the kernel.  Without preemption the IO thread has to wait until the kernel 
hog blocks, hits a scheduling point or exits the kernel.

The result, without preemption, is:

         IO thread      Kernel hog       Disk
             |              .
             |--------------.-----------> .
             .              |             |
             .              |             |
             .              |             |
             .              |             |
             .              |<------------|
             .              |             .
             .              |             .
             .              |             .
             .<-------------|             .
             |--------------.-----------> .
             .              .             |
             .              .             |
             .              |             |
             .              |             |
             .              |             |
             .              |<------------|
             .              |             .
             .              |             .
             .              |             .
             .<-------------|             .
             |--------------.-----------> .
             .              .             |
             .              .             |
             .              |             |
             .              |             |
             .              |             |
             .              |<------------|
             .              |             .
             .              |             .
             .              |             .
             .<-------------|             .
             .

Whereas with preemption, we have:

         IO thread      Kernel hog       Disk
             |              .
             |--------------.-----------> .
             .              |             |
             .              |             |
             .              |             |
             .              |             |
             .<-------------|-------------|
             |--------------.-----------> .
             .              |             |
             .              |             |
             .              |             |
             .              |             |
             .<-------------|-------------|
             |--------------.-----------> .
             .              |             |
             .              |             |
             .              |             |
             .              |             |
             .<-------------|-------------|
             |

The disk and the IO thread are active a higher portion of the time, while the 
kernel hog gets the same amount of time.  So in this case we have improved 
both latency and throughput.

Naturally I constructed this case to show the effect most clearly.  There are 
many possible variations on the above scenario.  It does seem to explain the 
latency/throughput improvements that have been reported in practice.

--
Daniel
