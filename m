Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267408AbUHWFBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUHWFBi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 01:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUHWFBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 01:01:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19113 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267408AbUHWFBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 01:01:34 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4
References: <20040822013402.5917b991.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Aug 2004 23:00:15 -0600
In-Reply-To: <20040822013402.5917b991.akpm@osdl.org>
Message-ID: <m14qmu4ffk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm4/
> 
> 
> - Added the kexec code.  Again.  This was in -mm a year or so ago but didn't
>   make it.

Hopefully it will this round :)

There is a null pointer dereference bug in ide_print_status,
the following patch allows me to boot.

The function still looks fishy as there is another access
to rq outside of ide_lock, a few lines earlier.

Eric

diff -uNrX linux-exclude-files linux-2.6.8.1-mm4-i8259-shutdown-x86_64/drivers/ide/ide.c linux-2.6.8.1-mm4-i8259-x86_64/drivers/ide/ide.c
--- linux-2.6.8.1-mm4-i8259-shutdown-x86_64/drivers/ide/ide.c	Sun Aug 22 21:15:25 2004
+++ linux-2.6.8.1-mm4-i8259-x86_64/drivers/ide/ide.c	Sun Aug 22 22:07:54 2004
@@ -442,7 +442,10 @@
 		int opcode = 0x100;
 
 		spin_lock(&ide_lock);
-		rq = HWGROUP(drive)->rq;
+		rq = 0;
+		if (HWGROUP(drive)) {
+			rq = HWGROUP(drive)->rq;
+		}
 		spin_unlock(&ide_lock);
 		if (!rq)
 			goto out;
