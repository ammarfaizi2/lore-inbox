Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261943AbTCMC07>; Wed, 12 Mar 2003 21:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261967AbTCMC07>; Wed, 12 Mar 2003 21:26:59 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:4810 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S261943AbTCMC05>;
	Wed, 12 Mar 2003 21:26:57 -0500
Date: Thu, 13 Mar 2003 02:37:36 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Olien <dmo@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmregress test on linux 2.5.62
In-Reply-To: <20030311191419.GA18449@osdl.org>
Message-ID: <Pine.LNX.4.53.0303130219070.3511@skynet>
References: <20030311191419.GA18449@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Mar 2003, Dave Olien wrote:

> I've modified your vmregress test form linux 2.4 so it works on
> linux 2.5.63.  I fixed up some of the core routines to understand
> new modifications to kernel vm structures, so it all compiles and
> runs.
>

Excellent stuff, thanks. This prompted me to dust off my old test box, get
2.5.64 on it, new modutils etc etc and get working back on VM Regress. I'm
releasing 0.8a for you to take a look at it, it is available from
http://www.csn.ul.ie/~mel/projects/vmregress/ and directly downloadable
from http://www.csn.ul.ie/~mel/projects/vmregress/vmregress-0.8a.tar.gz .

I'm not going to be working on this for another few days (hence the rushed
release) so I wanted you to see what I did with your stuff so far. Rather
than merging your stuff blindly, I took a few extra steps

1. The changes you made broke VM Regress from working with 2.4.anything so
I sat down and made the configure script understand both 2.4 and 2.5 build
systems. The way it is now, a

./configure --with-linux=/usr/src/linux-2.x.x
make

will compile the modules and be loadable against 2.4.20 and 2.5.64 . It
generates different makefiles depending on the kernel release and I'm
fairly sure I got it right. My "extensive" testing involved loading the
vmregress_core, sizes.o and zones.o modules and printing the reports. They
worked fine for that, but note the "a" part of 0.8a, I didn't test
anything else.

2. vmr_mmzone.h is going to be my mapping between the different names of
structs and fields between 2.4 and 2.5 . this (you'll love this) involves
having #defines which map some VM Regress type to the actual kernel
structure. So for example, on 2.4 it's

#define C_ZONE struct zone_t

and 2.5 it's

#define C_ZONE struct zone

This looks (and is) horrible but there is very few name discrepancies so
it doesn't confuse things too much and I reckon it is better than having a
2.4 and 2.5 version of VM Regress for such minor differences.

3. I kept my old indenting style, but I think I incorporated all your bug
fixes. I need to double check this though, I have a few other bugs on the
ToDo list I want to clean up anyway

4. I blindly included the OSDL scripts into an osdl/ directory. I haven't
looked at them in detail yet, I presume they are doing magic OSDL stuff
for the moment until I get back onto it. If I don't though, I would still
like to get the OSDL tests integrated into the tool rather than having
them separate. Is this ok with you?

> There are still some issues with the perl scripts that collect data
> and pipe it to gnuplot.  Some of the plots of vmstat output don't
> work.
>

I haven't looked at the new procps tools yet and won't get the chance for
a few days. Hence, the plots are still presumably broken.

> 	http://www.osdl.org/archive/dmo/VMREGRESS/
>
> There's a VMR_README file that describes the files there.
>

I think I have 99% if not 100% of your work integrated in nicely so that
VM Regress still works on both sets of trees. The rudimentary ChangeLog so
far is below

Version 0.8a
-----------
  o Minor bug fixes in the core
  o OSDL based merging
    - Fixed the extract_structs.pl script to ensure its a struct been extracted
    - Move the creation of internal.h from Makefiles to the configure script
    - Use configure script to apply kernel patch if requested
  o Read kernel release version directly from Kernel makefile
  o Automatically generate makefiles depending on kernel version from configure
  o Teach extract_structs.pl to identify a struct that is typedef'd
  o vmr_mmzone.h has been expanded to map between different struct and field
    names between kernel versions. Not many differences thankfully

Enjoy...

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel
