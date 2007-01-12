Return-Path: <linux-kernel-owner+w=401wt.eu-S1751535AbXALAoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbXALAoq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 19:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbXALAoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 19:44:46 -0500
Received: from md2.t-2.net ([84.255.209.81]:22896 "EHLO md2.t-2.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbXALAoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 19:44:46 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 19:44:45 EST
Subject: LTT for 2.6.19
From: Samo Pogacnik <samo_pogacnik@t-2.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 12 Jan 2007 01:48:15 +0100
Message-Id: <1168562896.3738.161.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-Junkmail-Status: score=10/150, host=md2.t-2.net
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090201.45A6D699.0009,ss=1,fgs=0,
	ip=192.168.1.2,
	so=2006-03-30 10:46:40,
	dmn=5.2.125/2006-10-10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to introduce oldstyle ltt patches and tools supporting kernel
2.6.19.

Beside support for newer kernel, there are other changes within these
patches and tools:
- storing descriptions of custom events in flight recording mode outside
subbuffers (not to be overwriten in circular buffers), 
- way of timestamping (no more time deltas), 
- removed procfs usage for control,
- initial implementation of static kernel markers (currently just for
LTT), which does not change original kernel sources at any time.

Links:
base    - http://84.255.254.67/linux-2.6.19-ltt-base.patch
markers - http://84.255.254.67/linux-2.6.19-ltt-markers.patch
tools   - http://84.255.254.67/ltt-0.9.6-pre8.tar.gz

Remark: 
New shell script files setmarker, createmarker and recreatemarkers
under scripts directory need to be set as executables manually after
patching the kernel with LTT base patch.

- about custom events:
There was a problem of overwritting descriptions of new custom events in
flight recording mode, since those descriptions were stored sequentialy
as any other ltt events in circular subbuffers. If descriptions were
overwritten, collected custom events coud not be recognised. By storing
descriptions outside subbuffers (in reley_reserved area if configured),
these descriptions are being dumped inside the first dummy subbuffer.
This dummy subbuffer has always been created at trace dump time in
flight recording mode anyway and is almost empty.

-about timestamping:
I wanted to simplify things by using any kind of monotonic time within
the system, which does not overflow in the reasonable lifetime of the
system (even for an embedded type of application, which could be
required to run for years without reboot). do_gettimeofday has already
been such clock and for less overhead timestamping the complete 64 bits
of TSC were used converted into nanoseconds. Luckily both clocks return
64 bit values, so a union of both types has been used for all ltt events
to store its timestamp. In TSC mode sched_clock() is called to convert
TSC values into nsecs and to be open for other architectures with TSC
compareable counters (e.g. TB in ppc) in their sched_clock() functions.

- about static kernel markers:
This is an idea which came out of long running debates (many thanks to
all involved:-) about problematic managing of static markers within
kernel code. Here is a possible way of getting around the need for a
subsystem maintainer to even know about them (meaning markers).
Since this tool uses direct calls to store events from fixed trace
points in kernel source, a way to define those direct calls without 
modifying original sources has been implemented. The solution is quite
primitive and involves a patch tool, a set of marker files (slightly
modified patch files), a few scripts and a minimal modification of the
kernel build subsystem.
How this works:
If markers are not to be used (kernel config option), everything is
being compiled as always. But if kernel config option requires ltt
markers to be used, each .c and .S file is being checked on the fly
during compilation for its marker file. When a marker file has been
found a new source file is created using a patch tool through the
setmarker script and this new file gets compiled. It is easy to create a
new marker file using createmarker script after manual preparation of
marked file or after the use of a partially correct marker from another
kernel version for example. All markers can be regenerated via
recreatemarkers script, when all marked files have been prepared. 
I find this solution very handy at moving ltt patch to new kernel mainly
because the patch includes real minimum of modified files and all the
rest are just new files. And than during the first compilation using
markers, patch tool is very helpfull resolving all nonconflicting
modifications of the original files in the newer kernel.
This implementation is just ltt oriented, but it could be done or used
as more general static kernel marker solution as well.

tracing new year, Samo


