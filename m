Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265165AbTIDQVo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbTIDQVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:21:43 -0400
Received: from mail1-106.ewetel.de ([212.6.122.106]:62140 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S265165AbTIDQTw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:19:52 -0400
Date: Thu, 4 Sep 2003 18:19:49 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [NFS] attempt to use V1 mount protocol on V3 server (fwd)
Message-ID: <Pine.LNX.4.44.0309041819190.1135-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, Trond Myklebust wrote:

> I assume that your server's RPC engine replying with a PROG_MISMATCH
> the way it should when it cannot support NFSv2?

Yes.

> Hmm.. Looking at the code, we appear not to be handling that case very
> well in the RPC client. PROG_UNAVAIL, PROG_MISMATCH, and PROC_UNAVAIL
> are all handled incorrectly as if the replies were garbage...

I see.

> Althought this is harmless, we should really be returning an EIO
> immediately, and report the error in the syslog...

It is harmless, it only sends retries to the server that can never
succeed.

> Does the following patch (against 2.4.22) help?

I've applied the patch to 2.4.23-pre3 (went okay with an offset) and 
caused the fallback to happen by always returning NFS3ERR_ACCES from
my GETATTR procedure.

Before patch:

nfs_get_root: getattr error = 13
call_verify: server accept status: 2
call_verify: server accept status: 2
call_verify: server accept status: 2
RPC: garbage, exit EIO
nfs_get_root: getattr error = 5
nfs_read_super: get root inode failed

After patch:

nfs_get_root: getattr error = 13
RPC:    3 call_verify: program 100003, version 2 unsupported by server 127.0.0.1
nfs_get_root: getattr error = 5
nfs_read_super: get root inode failed

So yes, it looks cleaner, and it does no longer send multiple NFSv2 
GETATTR attempts.

The problem with FSSTAT returning NOTSUPP hanging the kernel does not
happen on 2.4, neither before nor after the patch. It just says:

NFS: cannot retrieve file system info.
nfs_read_super: get root inode failed

Which is of course the right thing to do.

-- 
Ciao,
Pascal

