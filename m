Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUL0Bkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUL0Bkq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 20:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUL0Bkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 20:40:46 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:43493 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261668AbUL0Bkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 20:40:42 -0500
Date: Mon, 27 Dec 2004 02:40:41 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-VServer <vserver@list.linux-vserver.org>
Subject: The Future of Linux Capabilities ...
Message-ID: <20041227014041.GA30550@mail.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-VServer <vserver@list.linux-vserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus!
Hi Folks!

as linux-vserver is heavily using (and depending) on
the linux capability system, and we are always trying
to improve things for users and developers I wonder
how the future of this capability system looks like ...

I would not spend too much time on that, if we would
not need to improve that system by splitting up (or
working around) some capabilities which are too coarse
(or too general) to be useful ...

good examples for such capabilities are:

	#define CAP_NET_ADMIN        12

	/* Allow locking of shared memory segments */
	/* Allow mlock and mlockall (which doesn't really
		have anything to do with IPC) */

	#define CAP_IPC_LOCK         14

	#define CAP_SYS_ADMIN        21
	#define CAP_SYS_RESOURCE     24

especially CAP_NET_ADMIN and CAP_SYS_ADMIN contain
more than 20 different aspects ...

we are currently aware of three different solutions
to refine the capability system, and I would like to
hear some opinions and get a statement from mainline
(good, impossible, crap, don't care, or whatever ;) 

   I)	extend the capability type kernel_cap_t to
	64 (or more) bit, add new syscalls cap*64()	 
	and let the 'old' interface just see the lower
	32 bit

  II)	add 32 (or more) sub-capabilities which depend
	on the parent capability to be usable, and add
	appropriate syscalls for them.

	example: CAP_IPC_LOCK gets two subcapabilities
	(e.g. SCAP_SHM_LOCK and SCAP_MEM_LOCK) which

 III)	(linux-vserver specific solution)
	add a (compile time) CAP_MASK to declare which
	caps have subcaps, then use per context subcaps
	for known subfeatures and an additional cap_t
	to cover 'all other' aspects of the capability

	example: CAP_IPC_LOCK in CAP_MASK, plus the
	SCAP_MEM_LOCK subcapability, now having IPC_LOCK
	in the tasks caps doesn't do anything without
	the corresponding IPC_LOCK in the context or
	the SCAP_MEM_LOCK capability where appropriate

I think that all three solutions are usable for our
project, so I can live pretty well with III, but I think
refining the capability system might be something which
is useful for mainline ...

TIA,
Herbert





