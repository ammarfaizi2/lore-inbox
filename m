Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbUC2Va6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbUC2Va6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:30:58 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:62367 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S263141AbUC2Va2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:30:28 -0500
Message-ID: <000501c415d1$8d300860$fc82c23f@pc21>
From: "Ivan Godard" <igodard@pacbell.net>
To: "Davide Libenzi" <davidel@xmailserver.org>
Cc: "Paul Mackerras" <paulus@samba.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0403291019290.2275-100000@bigblue.dev.mdolabs.com>
Subject: Re: Kernel support for peer-to-peer protection models...
Date: Mon, 29 Mar 2004 12:53:19 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Davide Libenzi" <davidel@xmailserver.org>
To: "Ivan Godard" <igodard@pacbell.net>
Cc: "Paul Mackerras" <paulus@samba.org>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>
Sent: Monday, March 29, 2004 10:45 AM
Subject: Re: Kernel support for peer-to-peer protection models...


> On Sun, 28 Mar 2004, Ivan Godard wrote:
>
> > Ah! you wanted to know about exec, not fork. A true fork() is pretty
rare
> > these days anyway. Still, the answer is pretty much the same: the fork()
> > gets you a new data space, retaining the old code space, and the exec()
> > finds (or creates) the code space that cmd's code is in and switches the
> > active code space to that space. Heritable data, such as file
descriptors,
> > won't have been in the old data space anyway, so the child references
them
> > through syscalls just as in a conventional.
> >
> > Perhaps I'm missing your question here, but in general we see no problem
> > with fork/exec in our model - it's one of the least changed things. You
> > always get a new address space on a conventional, and you also do with a
> > Mill; the only difference is that you don't have to shoot down the cache
or
> > TLB, so a fork/exec should be quite a bit faster.
>
> No, sorry. Lossy email compression (sometimes being concise is a virtue
> but I usually fall way too far). Reading thru previous messages seems
> confusing to me. On one side you say that fork() uses a std COW, on the
> other side you say that the unified virtual address space combined with
> virtually tagged cache let you avoid cache flushes. As soon as you COW,
> you have one virtual address that refer to two different physical
addresses.
> Does the virtual address have extra tag bits to identify the task?

No, but it has a mechanism (unfortunately I can't explain yet  how it works)
which amount to the same thing. In fact, the hardware can distinguish
between the case where a particular address in the child is supposed to
refer to the child, and the case where it's supposed to refer back into the
parent. This is a novel feature that is not supportd by the conventional
model. We expect to expose it through an API. For example a server can spawn
worker processes such that each worker has its own space (and is protected
from other workers) but can communicate with the server via data structures
in the server, where the new worker COW comes up with the back-references
already created. This gives the convenience of thread-workers with the
protection of process-workers using a mmap communication region, but without
the overhead of creating the region.

Ivan


