Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbUEFMZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUEFMZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 08:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUEFMZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 08:25:40 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:49287 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S262052AbUEFMZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 08:25:25 -0400
Date: Thu, 6 May 2004 13:23:42 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: Simon Trimmer <simon@urbanmyth.org>
cc: kim.jensen2@hp.com, <linux-kernel@vger.kernel.org>
Subject: Re: microcode_ctl question (fwd)
In-Reply-To: <Pine.LNX.4.53.0405052017190.31452@calcium.webfusion.co.uk>
Message-ID: <Pine.LNX.4.44.0405061307310.3358-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

(cc'd linux-kernel so they can also participate in the discussion)

The microcode driver could be enhanced to support the operation which Kim 
is asking for, i.e. to query for the current revision (and possibly other 
flags). But we should carefully design the API, namely to take care 
of multiple CPUs potentially having multiple revisions of microcode. So, 
the user application should first interrogate the number of CPUs 
present, by some other means (e.g. reading /proc/cpuinfo or calling 
sysconf(_NPROCESSORS_ONLN), which is the same thing btw) and then pass
to the ioctl the address of a data structure like this:

struct microcode_query {
	unsigned int sig; /* signature */
	unsigned int pf;  /* processor flags */
	unsigned int rev; /* revision */
} microcode_query[]; /* as many elements as the number of cpus present */

then the driver would do an IPI with collect_cpu_info() as a function 
which would fill in all the data and the rest of the ioctl code would just 
copy it back to userspace. The only problem here is for the application to 
not get confused about the ordering of CPUs.

The driver would order them in the "natural", i.e. smp_processor_id() 
order and so that should be the order expected by the applications (maybe 
this should be documented somewhere after such ioctl is implemented).

And after all this is done, microcode_ctl is the natural place to call the 
ioctl (as a separate command line option).

Btw, I have just noticed what may be a bug wrt not being aware of kernel
preemption, i.e. we cache the CPU id in a local variable and later use it,
but then there seems to be no protection against kernel preemption (i.e.
we hold no spinlocks, only a semaphore) at that point, so the original CPU
id may not be quite the same as the CPU id for which the data was
collected. I should fix this if it is a problem. The question to
linux-kernel guys is to confirm that this is indeed a bug, i.e. to clarify
under which condition the kernel preemption can and cannot occur.

In particular can such preemption occur while executing a function called 
via IPI mechanism?

Kind regards
Tigran

> ---------- Forwarded message ----------
> Date: Wed, 5 May 2004 20:17:06 +0100 (BST)
> From: Simon Trimmer <simon@urbanmyth.org>
> To: "JENSEN,KIM (HP-FtCollins,ex1)" <kim.jensen2@hp.com>
> Subject: Re: microcode_ctl question
> 
> Hi Kim,
> Not off the top of my head; Tigran?
> 
> The driver used to print it out as it seeks to load the new microcode, I
> guess you could attempt to reload it (it'll cope with the revisions being the
> same and it'll print out the version in the detail).
> 
> -Simon
> 
> On Wed, 5 May 2004, JENSEN,KIM (HP-FtCollins,ex1) wrote:
> > Simon,
> >
> > Do you know of any linux tools that allow one to query the version of ia32
> > intel microcode that has been loaded?
> >
> > Thanks!
> > Kim Jensen
> >
> > Linux Workstations R&D
> > Hewlett Packard


