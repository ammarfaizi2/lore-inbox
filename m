Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268179AbUJHJVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268179AbUJHJVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 05:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268185AbUJHJVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 05:21:06 -0400
Received: from open.hands.com ([195.224.53.39]:24515 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268179AbUJHJUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 05:20:50 -0400
Date: Fri, 8 Oct 2004 10:31:54 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
       lkml <linux-kernel@vger.kernel.org>, SELinux@tycho.nsa.gov,
       Ingo Molnar <mingo@redhat.com>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4-VP-S7 - ksoftirq and selinux oddity
Message-ID: <20041008093154.GA5089@lkcl.net>
Mail-Followup-To: Stephen Smalley <sds@epoch.ncsc.mil>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	lkml <linux-kernel@vger.kernel.org>, SELinux@tycho.nsa.gov,
	Ingo Molnar <mingo@redhat.com>, netdev@oss.sgi.com,
	linux-net@vger.kernel.org
References: <200410070542.i975gkHV031259@turing-police.cc.vt.edu> <1097157367.13339.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097157367.13339.38.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 09:56:07AM -0400, Stephen Smalley wrote:

> On Thu, 2004-10-07 at 01:42, Valdis.Kletnieks@vt.edu wrote:

> > audit(1097111349.727:0): avc:  denied  { tcp_recv } for  pid=2 comm=ksoftirqd/0 saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=59639 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:netif_lo_t tclass=netif
> > audit(1097111349.754:0): avc:  denied  { tcp_recv } for  pid=2 comm=ksoftirqd/0 saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=59639 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:node_lo_t tclass=node
> > audit(1097111349.782:0): avc:  denied  { recv_msg } for  pid=2 comm=ksoftirqd/0 saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=59639 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:smtp_port_t tclass=tcp_socket
> > 
> > At least for the recv_msg error, I *think* the message is generated because
> > when we get into net/socket.c, we call security_socket_recvmsg() in
> > __recv_msg() - and (possibly only when we have the VP patch applied?) at that
> > point we're in a softirqd context rather than the context of the process that
> > will finally receive the packet, so the SELinux code ends up checking the wrong

> Valdis,
> 
> These permission checks are based on the receiving socket security
> context, not any process security context, and are performed by the
> sock_rcv_skb hook when mediating packet receipt on a socket.  The
> auxiliary pid and comm or exe information is meaningless for such
> checks.  avc_audit could possibly be modified to check whether we are in
> softirq and omit them in those cases from the audit messages.  

> This has
> been discussed previously on the selinux mailing list, please see the
> archives.

 an alternative possible solution is to get the packet _out_ from
 the interrupt context and have the aux pid comm exe information added.

 as i understand it "a" possible way to do that would be to have a
 userspace ip_queue which simply marks the packet as "seen it" and then
 does "now please reprocess it".

 by the time that packets get to ip_queue in userspace, they will have
 had their aix pid comm exe info added (and the file sock stuff).

 alternatively, someone could spend a lot of their time doing exactly
 the same thing in kernel-space.

 l.

