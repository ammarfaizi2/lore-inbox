Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVCLQz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVCLQz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 11:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVCLQz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 11:55:56 -0500
Received: from mx2.netapp.com ([216.240.18.37]:61486 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S261462AbVCLQzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 11:55:16 -0500
X-IronPort-AV: i="3.90,158,1107763200"; 
   d="scan'208"; a="181568112:sNHT20041072"
Message-ID: <42331EF3.4000806@netapp.com>
Date: Sat, 12 Mar 2005 11:55:15 -0500
From: Dave Wysochanski <davidw@netapp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: open-iscsi@googlegroups.com
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [ANNOUNCE 0/6] Open-iSCSI High-Performance Initiator for Linux
References: <4229e34e.7e535078.5bc3.0b5eSMTPIN_ADDED@mx.googlegroups.com>
In-Reply-To: <4229e34e.7e535078.5bc3.0b5eSMTPIN_ADDED@mx.googlegroups.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Aizman wrote:

>
> This is to announce Open-iSCSI project: High-Performance iSCSI 
> Initiator for
> Linux.
>
> MOTIVATION
> ==========
>
> Our initial motivations for the project were: (1) implement the right
> user/kernel split, and (2) design iSCSI data path for performance. 
> Recently
> we added (3): get accepted into the mainline kernel.
>  
> As far as user/kernel, the existing iSCSI initiators bloat the kernel 
> with
> ever-growing control plane code, including but not limited to: iSCSI
> discovery, Login (Authentication and Operational), session and connection
> management, connection-level error processing, iSCSI Text, Nop-Out/In, 
> Async
> Message, iSNS, SLP, Radius... Open-iSCSI puts the entire control plane in
> the user space. This control plane talks to the data plane via well 
> defined
> interface over the netlink transport.
>  
> (Side note: prior to closing on the netlink we considered: sysfs, 
> ioctl, and
> syscall. Because the entire control plane logic resides in the user 
> space,
> we needed a real bi-directional transport that could support asynchronous
> API to transfer iSCSI control PDUs: Login, Logout, Nop-in, Nop-Out, Text,
> Async Message.
>
> Performance.
> This is the major goal and motivation for this project. As it happens, 
> iSCSI
> has to compete with Fibre Channel, which is a more entrenched 
> technology in
> the storage space. In addition, the "soft" iSCSI implementation have 
> to show
> good results in presence of specialized hardware offloads.
>
> Our today's performance numbers are:
>
> - 450MB/sec Read on a single connection (2-way 2.4Ghz Opteron, 64KB block
> size);
>
> - 320MB/sec Write on a single connection (2-way 2.4Ghz Opteron, 64KB 
> block
> size);
>
> - 50,000 Read IOPS on a single connection (2-way 2.4Ghz Opteron, 4KB 
> block
> size).
>
Has anyone on the list verified these #'s?  I'm trying to
get open-iscsi to work but it looks like it's got a problem
in the very initial stages of lun scanning that prevents
my target from working.  Open-iscsi guys I have a trace
if you want to look at it.  Looks like despite the fact that
report luns is returned successfully and only 1 lun is
returned (lun 0), the initiator is still sending inquiry
commands to luns > 0, and it looks like it gets confused
when it gets a 0x3f inquiry response from the target
(for an inquiry to lun 1), tries to issue a TMF abort
task on the previous inquiry which has already completed,
and the target responds with "task not in task set", which
is understandable since the command has already completed.
I used the latest .169 code.

I don't see this problem with the latest linux-iscsi.sfnet
code and have interoperated with many other initiators,
so I'm fairly confident there's a bug in open-iscsi somewhere.


> Prior to starting from-scratch the data path code we did evaluate the 
> sfnet
> Initiator. And eventually decided against patching it. Instead, we reused
> its Discovery, Login, etc. control plane code.
> Technically, it was the shortest way to achieve the (1) and (2) goals 
> stated
> above. We believe that it remains the easiest and the most practical 
> thing
> on the larger scale of: iSCSI for Linux.
>
>
> STATUS
> ======
>
> There's a 100% working code that interoperates with all (count=5) iSCSI
> targets we could get our hands on.
>
> The software was tested on AMD Opteron (TM) and Intel Xeon (TM).
>
> Code is available online via either Subversion source control database or
> the latest development release (i.e., the tarball containing Open-iSCSI
> sources, including user space, that will build and run on kernels 
> starting
> 2.6.10).
>
>         http://www.open-iscsi.org
>  
> Features:
>
>     - highly optimized and small-footprint data path;
>     - multiple outstanding R2Ts;
>     - thread-less receive;
>     - sendpage() based transmit;
>     - zero-copy header processing on receive;
>     - no data path memory allocations at runtime;
>     - persistent configuration database;
>     - SendTargets discovery;
>     - CHAP;
>     - DataSequenceInOrder=No;
>     - PDU header Digest;
>     - multiple sessions;
>     - MC/S (note: disabled in the patch);
>     - SCSI-level recovery via Abort Task and session re-open.
>
>
> TODO
> ====
>
> The near term plan is: test, test, and test. We need to stabilize the
> existing code, after 5 months of development this seems to be the right
> thing to do.
>
> Other short-term plans include:
>
> a) process community feedback, implement comments and apply patches;
> b) cleanup user side of the iSCSI open interface; use API calls 
> (instead of
> directly constructing events);
> c) eliminate runtime control path memory allocations (for Nop-In, 
> Nop-Out,
> etc.);
> d) implement Write path optimizations (delayed because of the 
> self-imposed
> submission deadline);
> e) oProfile the data path, use the reports for further optimization;
> f) complete the readme.
>
> Comments, code reviews, patches - are greatly appreciated!
>
>
> THANKS
> ======
>
> Special thanks to our first reviewers: Christoph Hellwig and Mike 
> Christie.
>
> Special thanks to Ming Zhang for help in testing and for insightful
> questions.
>
>
> Regards,
>
> Alex Aizman & Dmitry Yusupov
>
> =============================================
>
> The following 6 patches alltogether represent the Open-iSCSI Initiator:
>
> Patch 1:
>   SCSI LLDD consists of 3 files:
>   - iscsi_if.c (iSCSI open interface over netlink);
>   - iscsi_tcp.[ch] (iSCSI transport over TCP/IP).
>
> Patch 2:
>   Common header files:
>   - iscsi_if.h (iSCSI open interface over netlink);
>   - iscsi_proto.h (RFC3720 #defines and types);
>   - iscsi_ifev.h (user/kernel events).
>
> Patch 3:
>   drivers/scsi/Kconfig changes.
>
> Patch 4:
>   drivers/scsi/Makefile changes.
>
> Patch 5:
>   include/linux/netlink.h changes (added new protocol NETLINK_ISCSI)
>
> Patch 6:
>   Documentation/scsi/iscsi.txt
>
