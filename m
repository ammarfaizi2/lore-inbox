Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266076AbUFPCsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266076AbUFPCsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 22:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266078AbUFPCsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 22:48:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2730 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266076AbUFPCsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:48:23 -0400
Date: Tue, 15 Jun 2004 22:48:09 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: "David S. Miller" <davem@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Chris Wright <chrisw@osdl.org>, <linux-kernel@vger.kernel.org>,
       <selinux@tycho.nsa.gov>
Subject: [SELINUX][PATCH 0/4] Fine-grained Netlink support
Message-ID: <Xine.LNX.4.44.0406152216030.30562-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch set implements fine-grained Netlink support for
SELinux.  It adds a set of extended Netlink socket classes, inherhited
from the socket class.  This allows socket controls to be applied on a per
Netlink family basis.

Additionally, two new permissions have been added:

nlmsg_read
nlmsg_write

These permissions control whether a domain can send messages which cause
kernel data to be read or written respectively (e.g. route table updates
vs. listings). They are only applied to extended Netlink socket classes
which carry user-generated messages.

This is important for locking down applications which need to do things
like read network configuration data, but not write any (e.g. Apache).  
(Currently, this is not possible, as SELinux cannot distinguish bewteen
different types of Netlink messages, or even different types of Netlink 
sockets).

Here are some example AVC messages with the patches applied:

Routing table listing:

avc:  granted  { nlmsg_read } for  pid=2760 exe=/sbin/ip
scontext=root:staff_r:staff_t tcontext=root:staff_r:staff_t
tclass=netlink_route_socket

Routing table update:

avc:  granted  { nlmsg_write } for  pid=2763 exe=/sbin/ip 
scontext=root:staff_r:staff_t tcontext=root:staff_r:staff_t 
tclass=netlink_route_socket

Reading socket status via 'ss':

avc: denied  { nlmsg_read } for  pid=1798 exe=/usr/sbin/ss 
scontext=root:staff_r:staff_t tcontext=root:staff_r:staff_t 
tclass=netlink_tcpdiag_socket

Note the new Netlink message permissions and extended Netlink socket
classes.

Patches for userspace components are available at:
http://people.redhat.com/jmorris/selinux/netlink/


- James
-- 
James Morris
<jmorris@redhat.com>




