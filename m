Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTKJQQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263959AbTKJQQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:16:26 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:28151 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263937AbTKJQQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:16:25 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Date: Mon, 10 Nov 2003 10:15:34 -0600
X-Mailer: KMail [version 1.2]
Cc: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Davide Rossetti <davide.rossetti@roma1.infn.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <QiyV.1k3.15@gated-at.bofh.it> <03111007291500.08768@tabby> <1068477550.5743.50.camel@hades.cambridge.redhat.com>
In-Reply-To: <1068477550.5743.50.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Message-Id: <03111010153401.08768@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 November 2003 09:19, David Woodhouse wrote:
> On Mon, 2003-11-10 at 07:29 -0600, Jesse Pollard wrote:
> > > > sys_fscopy(...)
> >
> > It is too simple to implement in user mode.
>
> Is it? Please explain the simple steps which cp(1) should take in order
> to observe that it is being asked to duplicate a file on a file system
> such as CIFS (or NFSv4?) which allows the client to issue a 'copy file'
> command over the network without actually transferring the data twice,
> and to invoke such a command.

Ah. That is an optimization question, not a question of kernel/user mode.

Since the error checking for source and destination both include doing
a stat and statfs, the device information (and FS info) can both be retrieved.

And mmap doesn't require data transfer "twice" (local copy). Since that copy 
only pagefaults (though read/write may be faster for some files - I thought
that was true for small files that fit in cache, and large files faster via
mmap and depends on the page size; and the tradeoff would be system
dependant).

And since both source and destination may be remote you do get to decide
based on source and destination devices: if they are the same, and one on
a remote node, then BOTH will be on the remote, then you get to use the
CIFS/NFS file copy. (check the doc on "stat/statfs" for additional info).

I don't believe it works when source and destination are on DIFFERENT remote
nodes, though.

Strictly up to the implementation of cp/mv.

Though you will loose portability of cp/mv. (Of course, you also loose
it with a syscall for file copy too; as well as the MUCH more complicated
implementation/security checks).
