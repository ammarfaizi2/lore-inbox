Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbTILRnR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTILRnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:43:17 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:23723 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S261164AbTILRnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:43:15 -0400
Message-Id: <200309121743.h8CHhB114413@brk-mail1.uk.sun.com>
Date: Fri, 12 Sep 2003 18:43:10 +0100 (BST)
From: Marco Bertoncin - Sun Microsystems UK - Platform OS
	 Development Engineer <Marco.Bertoncin@Sun.COM>
Reply-To: Marco Bertoncin - Sun Microsystems UK - Platform
	   OS Development Engineer <Marco.Bertoncin@Sun.COM>
Subject: Re: NFS/MOUNT/sunrpc problem?
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: 4Gf427wD7xROCyZfv6+Gxg==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.4.6_06 SunOS 5.8 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


An update on this.
After numerous experiments, I now suspect some code in userland. I managed to 
find the traceback involved in the storm and every packet generated in the storm 
repeats the whole of the patern:

...
tg3_start_xmit
qdisc_restart
dev_queue_xmit
ip_finish_output2
ip_build_xmit
udp_sendmsg
inet_sendmsg
sock_sendmsg
sys_sendto
sys_socketcall
...

This is a MOUNT req, not NFS, so we are using userland rpc?

Now, just as a conformation, if I put a delay in sys_socketcall after each group 
of 40 packets sent, my storm recovers after 40 packets!

I was sidetracked by my ignorance of the fact that the MOUNT call does not go 
through the kernel module nfs/sunrpc, which made me go off instrumenting, 
debugging and tracing those modules that do not even get used :-((((((((!


Marco

