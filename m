Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262828AbVD2Qr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbVD2Qr7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 12:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbVD2QqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 12:46:22 -0400
Received: from vanguard.topspin.com ([12.162.17.52]:39480 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S262834AbVD2Qpy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 12:45:54 -0400
To: Caitlin Bestler <caitlin.bestler@gmail.com>
Cc: Bill Jordan <woodennickel@gmail.com>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, Timur Tabi <timur.tabi@ammasso.com>
Subject: RDMA memory registration (was: [openib-general] Re:
 [PATCH][RFC][0/4] InfiniBand userspace verbs implementation)
X-Message-Flag: Warning: May contain useful information
References: <20050425135401.65376ce0.akpm@osdl.org>
	<20050425173757.1dbab90b.akpm@osdl.org> <52wtqpsgff.fsf@topspin.com>
	<20050426084234.A10366@topspin.com> <52mzrlsflu.fsf@topspin.com>
	<20050426122850.44d06fa6.akpm@osdl.org> <5264y9s3bs.fsf@topspin.com>
	<426EA220.6010007@ammasso.com> <20050426133752.37d74805.akpm@osdl.org>
	<5ebee0d105042907265ff58a73@mail.gmail.com>
	<469958e005042908566f177b50@mail.gmail.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 29 Apr 2005 09:45:50 -0700
In-Reply-To: <469958e005042908566f177b50@mail.gmail.com> (Caitlin Bestler's
 message of "Fri, 29 Apr 2005 08:56:20 -0700")
Message-ID: <52d5sdjzup.fsf_-_@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 29 Apr 2005 16:45:50.0402 (UTC) FILETIME=[E6858A20:01C54CDA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there anything wrong with the following plan?

1) For memory registration, use get_user_pages() in the kernel.  Use
   locked_vm and RLIMIT_MEMLOCK to limit the amount of memory pinned
   by a given process.  One disadvantage of this is that the
   accounting will overestimate the amount of pinned memory if a
   process pins the same page twice, but this doesn't seem that bad to
   me -- it errs on the side of safety.

2) For fork() support:

   a) Extend mprotect() with PROT_DONTCOPY so processes can avoid
      copy-on-write problems.

   b) (maybe someday?) Add a VM_ALWAYSCOPY flag and extend mprotect()
      with PROT_ALWAYSCOPY so processes can mark pages to be
      pre-copied into child processes, to handle the case where only
      half a page is registered.

I believe this puts the code that must be trusted into the kernel and
gives userspace primitives that let apps handle the rest.

 - R.
