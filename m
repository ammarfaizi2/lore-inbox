Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262262AbRERHGf>; Fri, 18 May 2001 03:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262263AbRERHGZ>; Fri, 18 May 2001 03:06:25 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:63935 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262262AbRERHGR>; Fri, 18 May 2001 03:06:17 -0400
From: Stefan.Bader@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: linux-kernel@vger.kernel.org
Message-ID: <C1256A50.0026C177.00@d12mta05.de.ibm.com>
Date: Fri, 18 May 2001 09:03:17 +0200
Subject: Re: Storage - redundant path failover / failback - quo vadis
	 linux?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi,

Please respond to Christoph Biardzki <cbi@cebis.net>
To:     linux-kernel@vger.kernel.org
cc:
Subject:        Storage - redundant path failover / failback - quo vadis
linux?



>I was investigating redundant path failover with FibreChannel disk
devices
>during the last weeks. The idea is to use a second, redundant path to a
>storage device when the first one fails. Ideally one could also implement
>load balancing with these paths.

I was looking at the same concepts lately. Not only from the view of the
failover
side but also for the aspects of using this paths (maybe even more than
one) for
the load balancing (which gets more important the more traffic goes to a
device).

<snip>

>- The "T3"-Patch for 2.2-Kernels which patches the sd-Driver und the
>Qlogic-FC-HBA-Driver. When you pull an FC-Cable on a host equiped with
two
>HBAs the failover is almost immediate and an automatic failback (after
>"repairing") is possible

The drawback would be here (beside whether the load balancing is done
there
or not) is that this limits the solution to a specific type of devices.
One would have to have the same things in every device driver that wants
to
support multiple paths.

>- The "multipath"-Personality-patch for the md-Driver by Ingo Molnar
>(intergrated in the redhat 2.4.2-Kernel) You set up an md-device on
>two devices (which are actually the same physical device seen twice on
the
>dual paths) and when the primary one fails, the system will access the
>other one. There seems to be no failback possibility, however, and the
>failover takes around 30s.

The same idea here. Maybe going one step further. Intstead of using md the
idea
was to enhance the lvm to support multipathing. Since for lvm a physical
device
can be any block device (supporting certain gendisk interfaces) the paths
to the
device do not need to use the same physical interface (e.g. one path is
fibre
channel, another one ethernet).
The overhead during normal operation (depending of course whether and how
load
balancing is done) should be not much worse than the normal lvm operation
(request
always have to be mapped from the logical volume to a physical volume - so
this
adds just one other step). And since lvm keeps unique id's on its physical
devices
even the detection could somehow be automatic... :)
The failover stuff won't be that easy. I don't know how one could detect
the failure
of a path at this level fast enough. For now lvm itself doesn't care about
an io
request as soon as it is dispatched to a physical device. First approach
could be
to check the results of io requests and disable a path if there are too
many failures.
Then from time to time try that path again an re-enable it as soon as
there is success.
However, I think it could take rather long to be sure a path has failed
(maybe that are
the 30s delay in md).

>My question is which way is the more probable solution for future linux
>kernels?
>The low-level-approach of the "T3"-patch requires changes to the
>scsi-drivers and the hardware-drivers but provides optimal communication
>between the driver and the hardware

Thinking about it: if there would be some sort of 'available' flag in the
gendisk
structure, that would be updated by the low-level drivers. This could the
used by
a high-level design to use or skip a failed device/path...
In the S/390 (or zSeries) environment the device drivers are even able to
detect
a failing connection even if there is no data going to a device. That way
the device
would be disabled even _before_ anybody tries to write...

>The high-level-approach of the "multipath"-personality is
>hardware-independant but works very slowly. On the other hand I see no
>clear way how to check for availability of the (previously failed)
primary
>channel to automate a fail-back.

Well, slower, but I think there will be many that take that performance
loss already
by using lvm or md (for the benefit of flexible/large filesystems) this
approach would
add failover while beeing IMHO only a little less performant.

<snip>

Stefan

Linux for eServer development, IBM Germany
Stefan.Bader@de.ibm.com
----------------------------------------------------------------------------------

  When all other means of communication fail, try words.


