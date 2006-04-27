Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbWD0MaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbWD0MaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 08:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbWD0MaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 08:30:06 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:16348 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S965099AbWD0MaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 08:30:05 -0400
Date: Thu, 27 Apr 2006 15:30:03 +0300 (IDT)
From: Or Gerlitz <ogerlitz@voltaire.com>
X-X-Sender: ogerlitz@zuben
To: rdreier@cisco.com
cc: openib-general@openib.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] iSER (iSCSI Extensions for RDMA) initiator
Message-ID: <Pine.LNX.4.44.0604271528140.16463-100000@zuben>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 27 Apr 2006 12:30:03.0144 (UTC) FILETIME=[4ECB1080:01C669F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland,

The patch series that follows contains the iSER code which we want to submit 
upstream for 2.6.18. Below i have placed some general information on iser for 
LKML reviewers (please CC openib-general@openib.org on your responses).

Details are provided here on new some code which iser is dependent upon, and 
is expected in 2.6.18, (i have communicated them already to you but prefer
to repeat it again for clarity).

iSER is dependent on three new changesets/functionalities which are expected 
in 2.6.18, two in iscsi and one in infiniband.

+1 libiscsi - a kernel library (module) implementing lots of common code to
   iscsi_tcp and iscsi_iser

+2 iscsi transport ep callbacks - the first patch in this RFC, which enables
   an iscsi transport to establish/disconnect its connection from the kernel

+3 the rdma cm (CMA) - a module that implements RDMA transport neutral Address
   Translation and Communication Management (CM). iSER as most of the inwork 
   IB RC ULPs (eg SDP, NFSoRDMA, Lustre, etc) are coded to the CMA api.

The patch adding libiscsi is one of 5 iSCSI patches present already in the 
scsi-misc git tree, where the ep callbacks patch is expected to be pushed
by the end of this week. The CMA is present in the infiniband git tree. 

To compile the code you would need to patch 2.6.17-rcX with the 6 iscsi patches 
I have described above (iser is directly dependent only on two but the patches 
might apply only in the full order), the patches are also present under 
https://openib.org/svn/gen2/branches/backport/2.6.17

The code has been tested with 2.6.16 and 2.6.17-rc3 (drivers/infiniband and 
include/rdma being latest openib) and the user space part of latest open-iscsi. 
The only patches over this setting were the iscsi updates for 2.6.18. 

Over the 2.6.17 testing an issue with kmem_cache_destroy crash which seems
unrelated to iSER has popped up, i have sent a bug report on the matter today.

The iSER targets in this testing were from two types: Voltaire's IB/FC router 
and Voltaire's Native IB storage box, also recently an open source iSER target 
was kickedoff.

OK, here is some general information on iSER:

iSER (iSCSI Extensions for RDMA) is defined by the IETF IP Storage (IPS) working 
group, also an iSER annex was recently approved to appear in the IB spec.

This driver is an iSER transport implementation for the Open iSCSI initiator 
(www.open-iscsi.org) whose kernel portion and TCP transport provider are merged 
in as of 2.6.15 (iscsi_trasport_iscsi & iscsi_tcp and with 2.6.18 also libiscsi)

Hence iSER is both a provider of the Linux iSCSI transport api (scsi/
scsi_transport_iscsi.h) and a SCSI LLD (Low Level Driver) of the Linux SCSI 
midlayer api (scsi/scsi_host.h)

The Open iSCSI initiator discovery of targets and login into a target is carried 
out from user space, where once the login negotiation is done, the transport 
connection is bounded to an iSCSI connection. The diagram under http://www.
open-iscsi.org/docs/open-iscsi-1.jpg shows the connecting sequence for TCP.

Upto 2.6.18, the transport is expected to use a socket for the connection where 
Linux has the means to move a socket from user to kernel space. This restriction, 
the inability to move an IB QP (Queue-Pair) from user to kernel space, and looking
forward to integrate with more transports such as iSCSI offloads lead to a change 
in iscsi under which the transport is allowed to create/connect its native "end 
point" either from user space (eg TCP/socket) or from the kernel (iSER/QP), later
the transport connection is bounded to an iSCSI connection.

Basically, it goes like:
+1 target discovery over TCP/IP with the discovery server
+2.TCP  socket create/bind/setopt/connect to the target
+2.iSER CMA_ID/QP create/connect to the target
+3 iscsi session create
+4 iscsi connection create
+5 bind iscsi connection to the transport connection 
+6 login request/response negotiation
+7 iscsi connection start
+8 the SCSI midlayer starts its inquiry and so on

Or Gerlitz

