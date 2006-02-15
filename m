Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945958AbWBOO76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945958AbWBOO76 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 09:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945948AbWBOO76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 09:59:58 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:19611 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1945958AbWBOO75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 09:59:57 -0500
Date: Wed, 15 Feb 2006 08:59:42 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: (pspace,pid) vs true pid virtualization
Message-ID: <20060215145942.GA9274@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the lkml discussion on pid virtualization has been covering many of the
issues both relating directly to pid virtualization, and relating to
optimizations in the two specific implementations.

However, if we're going to get anywhere, the first decision which we
need to make is whether to go with a (container,pid), (pspace,pid) or
equivalent pair like approach, or a virtualized pid approach.  Linus had
previously said that he prefers the former.  Since there has been much
discussion since then, I thought I'd try to recap the pros and cons of
each approach, with the hope that the head Penguins will chime in one
more time, after which we can hopefully focus our efforts.

Issues with the (pspace,pid) pair like approach:
	1. how do we reap zombies when the "real" init process
		is not visible from within a container?
	2. global process view
		userspace tools may need to be taught about containers
		in order to provide any container with a "global pid view".
		i.e. all tasks could be listed as (pspace,pid), or as
		pid1/pid2/pid3 where pid1 is creator of pid2's pspace
		which is creator of pid3's pspace...
	3. no half-isolation mode?
		containers are always fully isolated.  This doesn't
		need to be the case if userspace tools are taught
		to deal with containerids.  On the other hand, it
		can also be considered one of it's strenghts.

Issues with pid virtualization;
	1. maintenance/correctness
		pids and vpids are now different and must not be mixed.
		Enforcing this simply in the kernel is a concern.  Sparse
		may be useful here, or simply using different opaque types.
	2. slowdown after migration
		before checkpt, pid==vpid.  After restore or migration,
		vpid = hash(pid) or vice versa.

Please add any issues I've not listed, or correct anything you feel I've
misrepresented.

thanks,
-serge
