Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263937AbUD2Ioi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUD2Ioi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 04:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbUD2Ioh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 04:44:37 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:47745 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S263770AbUD2IZa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 04:25:30 -0400
Message-ID: <4090BBF1.6080801@watson.ibm.com>
Date: Thu, 29 Apr 2004 04:25:21 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: [RFC] Revised CKRM release 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Class-based Resource Management project is happy to release the
first bits of a working prototype following a major revision of its
interface and internal organization.

The basic concepts and motivation of CKRM remain the same as described
in the overview at http://ckrm.sf.net. Privileged users can define
classes consisting of groups of kernel objects (currently tasks and
sockets) and specify shares for these classes. Resource controllers,
which are independent of each other, can regulate and monitor the
resources consumed by classes e.g the CPU controller will control the
CPU time received by a class etc. Optional classification engines,
implemented as kernel modules, can assist in the automatic
classification of the kernel objects (tasks/sockets currently) into
classes.

New in this release are the following:

1) A filesystem-based user interface, proposed by Rik van Riel, to
replace the system call interface in the previous prototype.

2) A hierarchy of classes can now be created so that a class (created
per user, say) can subdivide its share allocation among its children
classes (created one per application type), independent of its peer
classes (other users).

3) A newly introduced notion of a classtype which defines what kind of
kernel objects are being grouped into a class for regulation and
monitoring. Grouping tasks, into the taskclass classtype, is the most
commonly expected use. The prototype also implements the socketclass
classtype, useful for controlling groups of sockets.

4) Resource controllers are now explicitly associated with a
classtype. The CPU memory and I/O controllers (not yet implemented)
will operate on taskclasses while the multiple accept queue controller
operates on socketclasses.

5) A functional socketaq network controller which regulates the number
of accepted TCP connections for groups of listening sockets.

The newly implemented features have been described at some length in a
document posted on lkml a while back and available at

        http://ckrm.sourceforge.net/CKRMmergedAPI-d6.txt

A revised description and update of the project webpages is in
progress.  The patches will be posted individually and are described
below. They are also available on http://ckrm.sf.net.

Comments/feedback welcome. If this looks interesting, please consider
joining the ckrm-tech@lists.sf.net mailing list.


-- Hubertus Franke, Shailabh Nagar, Chandra Seetharaman, Vivek Kashyap



CKRM Patches overview
---------------------

All patches against 2.6.5.

00-core.ckrm-E12.patch:

Core code of ckrm which glues the interface (rcfs), resource
controllers (rc's) and classification engines (ce's) into the
framework.

01-rcfs.ckrm-E7.patch:

Resource control filesystem (rcfs) forming the user interface to CKRM.

02-taskclass.ckrm-E12.patch:

Creates the taskclass classtype for use by resource controllers which
operate on groups of tasks. The CPU, memory and I/O resource
controllers will operate on taskclasses when their rewrite/port to the
new API is complete. The patch includes the rcfs interface to
taskclasses.

03-numtasks.ckrm-E12.patch:

A simple resource controller that limits the number of tasks that can
be forked within a taskclass. Implemented mainly to serve as a
prototype for resource controller writers. Modifications to
kernel/exit.c and kernel/fork.c which should strictly be part of this
patch are included in the 00-core.ckrm-E12.patch.


04-socketclass.ckrm-E12.patch:

Creates the socketclass classtype, alongwith its rcfs interface, for
use by resource controllers which operate on groups of sockets.

05-socketaq.ckrm-E12.patch:

A resource controller that controls the number of accepted TCP
connections. It is CKRM's first real controller. Changes include
modifications to the TCP stack to implement multiple accept queues.


rbce.ckrm-E12:

Two classification engines (CE) to assist in automatic classification
of tasks and sockets. The first one, rbce, implements a rule-based
classification engine which is generic enough for most users. The
second, called crbce, is a variant of rbce which additionally provides
information on significant kernel events (where a task/socket could
get reclassified) to userspace as well as reports per-process wait
times for cpu, memory, io etc. Such information can be used by user
level tools to reclassify tasks to new classes, change class shares
etc.
