Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264071AbTDWO7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTDWO7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:59:50 -0400
Received: from mux2.uit.no ([129.242.5.252]:34570 "EHLO mux2.uit.no")
	by vger.kernel.org with ESMTP id S264071AbTDWO6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:58:38 -0400
Date: Wed, 23 Apr 2003 17:10:43 +0200
Message-Id: <200304231510.h3NFAh430564@lgserv3.stud.cs.uit.no>
From: Tobias Brox <tobias@stud.cs.uit.no>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: nfsroot.c + ipconfig.c (2.4.20)
Reply-To: tobias@stud.cs.uit.no
Organization: University of  =?ISO-8859-1?Q?=20Troms=F8?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to create a GRUB boot floppy that would download the kernel
from a server, mount the root partition over nfs and then mount other
nfs partitions later.

The very first problem: couldn't find the right options in the kernel
configuration (using "menuconfig").  The documentation in
Documentation/nfsroot.txt is obsoleted, I would suggest this text to
be added to the first section:

=== 
 On newer kernel releases, you will find "IP kernel level autoconfiguration"
 under the section "Networking Options"/"TCP/IP Networking".  You will have 
 to select this first, or the option "Root File System on NFS"
 will not appear under "File Systems"/"Network File Systems"/
 "NFS File System Support"/
===

Second problem: neither net/ipv4/ipconfig.c nor fs/nfs/nfsroot.c seemed to
care at all about the kernel parameters (though "root=/dev/nfs" seems
to be honored).  They should have been called from the
checksetup(char*) function in init/main.c.  According to debug output,
the checksetup function is run for each parameter at the command line,
but the corresponding setup functions in nfsroot and ipconfig is not
called.

The ipconfig logics is only started through the checksetup logics.
This is really weird, at this point of the execution, network drivers
haven't been loaded yet.

I hardcoded some values into the nfsroot.c, and forced ipconfig to be
started from nfsroot.c.  Problems didn't stop there.

At nfsroot.c, function root_nfs_get_handle the "status"
value is returned if it is below zero.  But what should the function
return if the status value is ok? I had to remove the if-test before
the mounting would work.

This is 2.4.20 with the gentoo-patches, compiled with gcc 3.2

After all my hacking and whacking, I finally got a kernel that managed
to find the IP address through DHCP, mount root through NFS using a
hard-coded server address and a hard coded path trailed with the last
digits of the IP address - but it did not want to mount other
NFS-partitions - the mount command would just freeze over.

(I'd appreciate CCs on any follow-ups)

-- 
Check our new Mobster game at http://hstudd.cs.uit.no/mobster/
(web game, updates every 4th hour, no payment, no commercials)
