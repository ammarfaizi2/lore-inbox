Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265931AbUGOD5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbUGOD5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 23:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265958AbUGOD5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 23:57:42 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:18633 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265931AbUGOD5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 23:57:22 -0400
Date: Wed, 14 Jul 2004 20:15:14 +0530
From: R Sharada <sharada@in.ibm.com>
To: fastboot@lists.osdl.org, linuxppc64-dev@lists.linuxppc.org,
       ltc-interlock@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: kexec on ppc64 
Message-ID: <20040714144514.GA2041@in.ibm.com>
Reply-To: sharada@in.ibm.com
Mail-Followup-To: fastboot@lists.osdl.org,
	linuxppc64-dev@lists.linuxppc.org, ltc-interlock@linux.ibm.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
        Sometime back, I started looking into ppc and working towards getting a
port of kexec to ppc64. As a recap (this is because I am cross-posting this mailto ppc64 and other lists as well), the idea behind kexec was to bypass the
kernel - firmware (bios/OF) interaction during bootup.
More kexec information can be obtained from Randy Dunlap's site on osdl:
http://developer.osdl.org/rddunlap/kexec
                                                                                
Some Background:
                                                                                
        Towards this, I looked at the ppc kernel boot code (primarily the prom
code that interacts with the openfirmware) and also asked a lot of questions to
Benh and Paulus regarding some of the ppc boot stuff. Ben and Paulus provided
lots of very useful information and suggestions for a clean implementation.
        One major requirement that came up for a clean implementation was to
re-order the prom_init code in ppc64. The prom_init (prom.c) code interacts withthe openfirmware to perform a lot of kernel initializations.
Since a lot of initializations were being done using firmware interaction, it
meant that for a kexec case, we would need to be able to save all of that from
the previous boot cleanly.
        Talking to Ben and Paulus, I found out that all that initialization
was not necessary at that point in boot.
        Hence, we got the idea to work on the re-order of the prom_init code.
The motivation to do this for kexec would be that it would facilitate branching
into a point after prom_init in a more cleaner setup and do away with having to
maintain a lot of kernel initialization information from the earlier boot.
                                                                                
To Dos:
                                                                                
To start with, I put together the following preliminary list for the cleanup:
        - only basic minimal initialization to be done in prom_init code. This
would include, instantiating the rtas, initializing client services, tce_table
initialization, cpu initializations, etc.
        - some other initializations, like initalization of the naca structure,
systemcfg data structures, to be moved to a early_init call, after prom_init,
but before memory management was setup, since some of the fields in systemcfg
and naca are required prior to htab/stab initializations.
        - still other initializations to be moved to a later call, maybe called
from setup_system() after kernel was relocated and memory management setup. Thiscould include setting up kernel globals like cpumask data structures (they are
currently setup in prom_init)
        - also identify relevant data (that might be required for the kexec
kernel) that could be pushed into the device_tree so that it can be passed to
the new kexec kernel
                                                                                
My current focus:
                                                                                
I am currently working on moving some of the cpumask data structures out into
setup_system and debugging some problems related to getting it working.
                                                                                
Other issues:
                                                                                
With respect to kexec, a few points came up in the discussions with Ben:
Memory accessibility in real mode in HV environment (only 256mb is accessible),
which has to be taken into account when we want to copy the new kernel. Ben
suggested that we could setup a mmu mapping making use of the HV calls, or we
have a real mode routine to copy pages.
Another point that came up was the unregistration and re-registration of the
vpa_areas in HV environment after a kexec reboot.
All this still needs to be thought through a lot more.
There are most likely to be more issues, points that have to be discussed,
sorted out and resolved to get kexec on ppc64 working.
                                                                                
Request for comments
                                                                                
I would like to solicit inputs, feedback, opinions, changes on this preliminary
idea and planned list of 'things to do'. I would also like to know the interest
to participate in this effort or anything else related to 'kexec on ppc64'.
                                                                                
Thanks and Regards,
Sharada
