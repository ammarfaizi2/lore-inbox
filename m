Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUF3HOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUF3HOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 03:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266573AbUF3HOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 03:14:12 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:43440 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S265697AbUF3HOK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 03:14:10 -0400
Date: Wed, 30 Jun 2004 00:14:04 -0700
Message-Id: <200406300714.i5U7E48O027579@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: zombie with CLONE_THREAD
In-Reply-To: Andrew Morton's message of  Tuesday, 29 June 2004 23:08:04 -0700 <20040629230804.3e9ed144.akpm@osdl.org>
Emacs: if it payed rent for disk space, you'd be rich.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That change sure looks incorrect and unnecessary to me.  It wasn't clear to
me from Andrea's description whether there is really any kernel bug here or
not.  If some process is ptrace'ing a CLONE_THREAD thread, then the thread
should not disappear as this patch makes it do.  It becomes a zombie and
reports its death status to the ptracer.  When the ptracer waits for it, it
reverts to its original parent and then the logic in wait_task_zombie
should call release_task for the CLONE_THREAD case.

Are you saying that if the ptracer dies, it can leave some threads in limbo?
I think that case is supposed to work because forget_original_parent will
move all the threads ptrace'd by the dying tracer process to be ptrace'd by
init, which will then clean up their zombies as previously described.


Thanks,
Roland
