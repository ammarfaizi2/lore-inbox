Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUGFLSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUGFLSF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 07:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUGFLSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 07:18:04 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:1489 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263772AbUGFLSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 07:18:01 -0400
Date: Tue, 6 Jul 2004 12:35:24 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@localhost.localdomain
To: Arjan van de Ven <arjanv@redhat.com>
cc: FabF <fabian.frederick@skynet.be>, <linux-kernel@vger.kernel.org>
Subject: Re: question about /proc/<PID>/mem in 2.4
In-Reply-To: <1089110989.2703.9.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.44.0407061228350.20027-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004, Arjan van de Ven wrote:
> may I ask what the point is ?

Yes, sure. I asked about the point of this check in the function 
fs/proc/base.c:mem_read() (in 2.4 but 2.6 is similar):

           if (!MAY_PTRACE(task) || !may_ptrace_attach(task))
                return -ESRCH;

If you check the definition of MAY_PTRACE() macro and may_ptrace_attach() 
function then you will notice that if a typical root process (uid=euid=0)
tries to read /proc/<PID>/mem file for a process other than itself or one 
of its children then MAY_TRACE() will return 0 and therefore the above 
check will be if (1 || !may_ptrace_attach(task)) and thus evaluate to 1 
and return -ESRCH.

Therefore, even a privileged process (with CAP_SYS_PTRACE capability) is 
not allowed to read arbitrary process' /proc/<PID>/mem file.

This can be worked around by writing a (GPL of course) module but I didn't
want to spend time writing it (although actually I went ahead and started
writing it yesterday evening anyway :) if the above check is erroneous and
can simply be relaxed to allow root to read it. This will save me time and
effort, that's all.

But if the above check is there for a good reason, then I would like to 
know what that reason is, exactly.

Kind regards
Tigran


