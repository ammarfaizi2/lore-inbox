Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269645AbUJGN7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269645AbUJGN7o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269660AbUJGN7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 09:59:43 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:32146 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S269645AbUJGN7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 09:59:14 -0400
Subject: Re: 2.6.9-rc2-mm4-VP-S7 - ksoftirq and selinux oddity
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc: lkml <linux-kernel@vger.kernel.org>, SELinux@tycho.nsa.gov,
       Ingo Molnar <mingo@redhat.com>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
In-Reply-To: <200410070542.i975gkHV031259@turing-police.cc.vt.edu>
References: <200410070542.i975gkHV031259@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1097157367.13339.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Oct 2004 09:56:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 01:42, Valdis.Kletnieks@vt.edu wrote:
> audit(1097111349.727:0): avc:  denied  { tcp_recv } for  pid=2 comm=ksoftirqd/0 saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=59639 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:netif_lo_t tclass=netif
> audit(1097111349.754:0): avc:  denied  { tcp_recv } for  pid=2 comm=ksoftirqd/0 saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=59639 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:node_lo_t tclass=node
> audit(1097111349.782:0): avc:  denied  { recv_msg } for  pid=2 comm=ksoftirqd/0 saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=59639 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:smtp_port_t tclass=tcp_socket
> 
> At least for the recv_msg error, I *think* the message is generated because
> when we get into net/socket.c, we call security_socket_recvmsg() in
> __recv_msg() - and (possibly only when we have the VP patch applied?) at that
> point we're in a softirqd context rather than the context of the process that
> will finally receive the packet, so the SELinux code ends up checking the wrong
> credentials.  I've not waded through the code enough to figure out exactly
> where the two tcp_recv messages are generated, but I suspect the root cause is
> the same for all three messages.

Valdis,

These permission checks are based on the receiving socket security
context, not any process security context, and are performed by the
sock_rcv_skb hook when mediating packet receipt on a socket.  The
auxiliary pid and comm or exe information is meaningless for such
checks.  avc_audit could possibly be modified to check whether we are in
softirq and omit them in those cases from the audit messages.  This has
been discussed previously on the selinux mailing list, please see the
archives.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

