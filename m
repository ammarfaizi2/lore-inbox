Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265210AbUGGQOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUGGQOJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 12:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUGGQOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 12:14:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28333 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265210AbUGGQOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 12:14:06 -0400
Date: Wed, 7 Jul 2004 12:13:29 -0400
From: Alan Cox <alan@redhat.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: solar@openwall.dot.com, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: question about /proc/<PID>/mem in 2.4
Message-ID: <20040707161329.GI31674@devserv.devel.redhat.com>
References: <20040706163141.GI11736@devserv.devel.redhat.com> <Pine.LNX.4.44.0407071444300.26475-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407071444300.26475-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 02:53:44PM +0100, Tigran Aivazian wrote:
>         if (!MAY_PTRACE(task) || !may_ptrace_attach(task))
>                 return -ESRCH;
> 
> Btw, the second check looks like an obvious race to me. I.e. if this
> condition can change between the check in the beginning of mem_read() and
> return from access_process_vm() then what is to stop it from changing just
> after this second check and return from mem_read()?

The boundary in question is exec(). We don't allow ptrace attach during
an exec in process and that may well make the specific mm untraceable.
So the lifetime is something like

	exec
		no attach
		create mm
		load stuff
		destroy old mm
		if suid
			no ptrace
		can attach (maybe)

So an open by self before an exec always refers to the old dead mm and
the one after always hits the other checks. A user can ptrace their own
app but ptrace itself doesn't set ptraced exec's setuid.



