Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUBBJmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 04:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbUBBJmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 04:42:46 -0500
Received: from albatross-ext.wise.edt.ericsson.se ([193.180.251.49]:8900 "EHLO
	albatross-ext.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id S265682AbUBBJmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 04:42:43 -0500
X-Sybari-Trust: e91dcd7f 6b512624 10d098d8 00000138
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Date: Mon, 2 Feb 2004 10:42:17 +0100 (MET)
Message-Id: <200402020942.i129gHf15172@duna48.eth.ericsson.se>
To: pavel@ucw.cz
CC: linux-kernel@vger.kernel.org
In-reply-to: <20040130170610.GB625@elf.ucw.cz> (message from Pavel Machek on
	Fri, 30 Jan 2004 18:06:10 +0100)
Subject: Re: Userspace filesystems (WAS: Encrypted Filesystem)
References: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com> <y2ar7xmkyqe.fsf@cartman.at.fivegeeks.net> <200401281350.i0SDo2I03247@duna48.eth.ericsson.se> <20040130170610.GB625@elf.ucw.cz>
X-OriginalArrivalTime: 02 Feb 2004 09:42:41.0794 (UTC) FILETIME=[E7046620:01C3E970]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Jean-Luc wrote:
> >    app wants to read data from a file ->
> >    userspace application requires memory allocation to provide this data ->
> >    VM tries to write out dirty data associated with the Coda mountpoint ==
> >    deadlock
> 
> How do you solve this one?

1) In FUSE normal writes go through the cache, so no dirty pages are
   created.  The only possibility to create dirty pages is with shared
   writable mapping, and this is rare

2) Userspace filesystem app can be multithreaded, so probably write
   can be satisfied even if read is pending.

3) The 2.6 kernel provides asynchronous page writeback, so even if a
   writeback is blocking forever the VM will continue to try to free
   up memory.

4) If no memory can be freed, then the allocation will fail, so the
   read will fail: no deadlock.

5) Even if the memory allocation was caused by a page fault, which
   cannot fail, the worst case is that the OOM killer is invoked, and
   memory is freed up: no deadlock.

So with the asynchronous page writeback mechanism the 2.6 kernel is
very immune to this kind of deadlock.  I have tested this with a
little program which behaves very nastily in this respect (I can send
you this if you're interested).  And I was able to invoke the OOM
killer if there was no swap, but there was never a deadlock.

Miklos

This communication is confidential and intended solely for the addressee(s). Any unauthorized review, use, disclosure or distribution is prohibited. If you believe this message has been sent to you in error, please notify the sender by replying to this transmission and delete the message without disclosing it. Thank you.

E-mail including attachments is susceptible to data corruption, interruption, unauthorized amendment, tampering and viruses, and we only send and receive e-mails on the basis that we are not liable for any such corruption, interception, amendment, tampering or viruses or any consequences thereof.

