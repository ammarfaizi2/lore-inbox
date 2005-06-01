Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVFAUJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVFAUJA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVFAUI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:08:59 -0400
Received: from smtp110.mail.sc5.yahoo.com ([66.163.170.8]:22668 "HELO
	smtp110.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261157AbVFAUIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:08:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type:Content-Transfer-Encoding;
  b=YysUBOn594gs5O4BcPLsHttcezoKrnk/JM6xwg1MRj64u0gBA+3c+AppGo2edraUzK25r+OpnyXpkgDm15W4LjHMEX+14/EtEC+8z4c7p/9WYyUj2YCVU+FUnK8N0osYDkrtCR2gV5y+U5/zyS52whmxdPywZnipZhXqRhPus0g=  ;
Message-ID: <429E15CD.2090202@yahoo.com>
Date: Wed, 01 Jun 2005 13:08:45 -0700
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@lst.de>
Subject: [ANNOUNCE 0/7] Open-iSCSI/Linux-iSCSI-5 High-Performance Initiator
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is open-iscsi/linux-iscsi-5 Initiator. This submission is ready for
inclusion into mainline kernel.

It contains:

- iscsi data path (iscsi_tcp)
- iscsi transport class (scsi_transport_iscsi).

This Initiator depends on this transport class, but not vice versa: the
transport class is common, generic, and isolated from this concrete iscsi
implementation by scsi_transport_iscsi.h interface (see the header file
and/or diagrams on the open-iscsi website). Initiator's control plane (supplied
separately at http://www.open-iscsi.org/index.html#download) also does
not depend on iscsi_tcp data path implementation - it's multi-transport
capability is ensured by the the transport class itself.

Changes since 05/05/05 submission
(http://marc.theaimsgroup.com/?l=linux-kernel&m=111526765118450&w=2)
========================
* Stability: fixed a number of races between eh_abort(), conn_destroy(), abort
timeout, etc.

* Performance improvements.

* Internally reviewed and cleaned up all the code, to the best of our ability.

* Exported transport and session/connection information via sysfs.

* Removed not-greater-than-page-size restriction; should be able to support
applications using sg (tested) and presumably, st as well.


Tarball
====
The entire Initiator source including user space tools is available at
http://www.open-iscsi.org/index.html#download and/or svn
(svn.berlios.de/open-iscsi, r363).

The same tarball can be downloaded from the linux-iscsi project page on
sourceforge at http://sourceforge.net/project/shownotes.php?release_id=331731


Thanks
======
Many people contributed to testing. In particular, special thanks to:

Pascal Renauld, Harald Kubota, Olivier Galibert, Arne Redlich.


Changelog
========
* misleading printout in top-level Makefile fixed
* new ITT encoding implemented, should protect us from not well behaved targets
* ctask->in_progress state machine depricated. using direct PDU header processing
* using eh_host_reset_handler() to unjam iscsi session in case of interface fluks
* more verificiation done before r2t response processing
* recovery: ctask->SCp.Status deprecated, using ctask->sc (NULL/not NULL) instead
* Mike: scsi_transport_iscsi.h copyright cleanup
* Mike: minor coding style cleanup
* Mike: fixed the error path when session class was not being unregistered
* conn_stop() vs. eh_abort(): ctask->sc serialization via xmitsema
* Mike: iscsi_tcp: remove extra tabs
* fixed race between conn_destroy() and eh_abort()
* properly flushing r2tqueue and stopping ctask from being xmited after TMF Abort
* Mike: data_recv tabs cleanup
* Mike: dockbook style comments
* Mike: rm underscore in labels to match rest of driver
* fixed limitation on number of scattered PDUs across SKBs. Discovered by Harald.
* Mike: fixed some weird braces where locks would never get dropped if run and
tabing
* session->state is no longer volatile, since we always access it under lock
* session->generation is not longer volatile; renamed as session->age
* Mike: add kernel printk values
* Mike: rm extra module get/put call
* regression.sh: each test-case now tested with fdisk+mkfs+bonnie
* Mike: do copyright per line
* Mike: merge iscsi_ifev.h and iscsi_if.h
* Mike: rm iscsi_iftrans.h and move include of scsi_transport_iscsi.h
* fixed iscsi_ctask_copy() buffer length bug (observed when using bonnie++ as a
part of regression.sh)
* Mike: rm extra braces and add a space between var declarations and code
* enabling data digest causes lock-up (Arne Redlich)
* Mike: whitespaces cleanup
* Mike: coding style cleanup
* Mike: rm extra brace and mv invalid param test
* "un-volatile" tmabort_state (volatile is not needed)
* remved session->conn_lock
* "un-volatile" conn->c_stage
* "un-volatile" conn->stop_stage
* Wang Zhenyu: [io]fmarket typo fix
* regression introduced in r341: fixed now
* send_pdu(): use xmit semaphore, now serialized vs. data_xmit()
* removed: conn->cpu and the (dead) code
* data_xmit_more(): cleaned up and moved to the data_xmit()
* comments in the iscsi_tcp.h in particular: conn->xmitsema, session->lock
* Mike: remove the ISCSI_TRANSPORT_MAX limitation from the kernel using sysfs
* updated to the recent transport class changes backward-compile-2.6.11.patch
* fixed gcc4 compilation warnings
* Mike: don't hold session->lock when deleting timer with del_timer_sync()
* Mike: don't hold xmitsema while waiting for host_busy to decrement
* Mike: deadlock fix: cannot call del_timer sync with session_lock held
* propagating transport->caps up to the daemon, fixes DATA_DIGEST nego bug
* adding max_conn, max_cmd_len and max_lun attributes for iscsi_transport
* force eh_abort to unblock while in conn_destroy() waiting
* fail host_reset() in case of session terminated
* iscsiadm crash fix when transport capability does not match
* connection struct: re-aligned Tx members with Tx, Rx with Rx
* connection suspend: split Tx and Rx suspend, cleanup
* fixed eh_abort/conn_stop() race: clear/set conn->sock under lock
* removed restriction: sg element <= PAGE_SIZE
* removed restriction: non scatter/gather request <= PAGE_SIZE

Patches
=====

1. iscsi-tcp.c.patch - drivers/scsi/iscsi_tcp.c, iscsi data path. This is ~3000
lines 84K file, if it does not make it through, I'll split and resend. In
addition, this file is available at http://www.open-iscsi.org/src/iscsi_tcp.c

2. iscsi-tcp.h.patch - drivers/scsi/iscsi_tcp.h, header file.

3. common-iscsi-headers.patch - common header files:
	- iscsi_if.h (user/kernel #defines and user/kernel events);
	- iscsi_proto.h (RFC3720 #defines and types);
	- scsi_transport_iscsi.h (transport API, transport #defines and types).


4. iscsi-netlink.patch - include/linux/netlink.h changes (added new protocol
NETLINK_ISCSI).

5. iscsi-Makefile.patch - drivers/scsi/Makefile changes.

6. iscsi-transport.patch - new iscsi transport class
(drivers/scsi/scsi_transport_iscsi.c)

7. iscsi-Kconfig.patch - drivers/scsi/Kconfig changes.

Thanks,

Linux-iscsi Team

