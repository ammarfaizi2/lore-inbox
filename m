Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265743AbUHRLDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265743AbUHRLDo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 07:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUHRLDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 07:03:44 -0400
Received: from kerberos2.troja.mff.cuni.cz ([195.113.28.3]:13684 "HELO
	kerberos2.troja.mff.cuni.cz") by vger.kernel.org with SMTP
	id S265743AbUHRLD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 07:03:28 -0400
Received: from argo.troja.mff.cuni.cz (195.113.28.11)
  by vger.kernel.org with SMTP; 18 Aug 2004 11:03:26 -0000
Date: Wed, 18 Aug 2004 13:03:25 +0200 (MET DST)
From: Pavel Kankovsky <peak@argo.troja.mff.cuni.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux kernel file offset pointer races
In-Reply-To: <1092345143.22458.105.camel@localhost.localdomain>
Message-ID: <20040818103356.6974.0@argo.troja.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004, Alan Cox wrote:

> > In this scenario, the 1st and 3rd pages read by read() contain the old
> > data (before write()) but the 2nd page contains the new data (after
> > write()). This is absurd.
> 
> Why ?

Ok, it is not absurd. It is insane. :)

As far as I know, POSIX compliant read() and write() et al. are
supposed to be serializable.

> > BTW: What about writev() (esp. with O_APPEND)? It appears Linux
> > implementation makes it possible to interleave parts of writev() with
> > other writes.
> 
> If that can occur with O_APPEND it might be a bug. SuS does make some
> real guarantees about what O_APPEND means.

The following scenario appears to be possible when the default
implementation in do_readv_writev() is used:

1. process P1 calls writev(), writes the 1st chunk
   fs specific write operation grabs i_sem when it starts...
   and releases it when it finished
2. process P2 calls write() on the same file
   i_sem is free now, and P2 can grab it..and release it again
3. process P1 writes the 2nd chunk
   i_sem is free again, and P1 can grab it to write the 2nd chunk

The good news is some filesystems use generic_file_writev() (ext2, ext3)
or their own implementation (xfs) rather than the "supergeneric" code in
do_readv_writev(). The bad news is some other filesystems (reiser) use the
"supergeneric" code.

> > Moreover, there appears to be a race condition between locks_verify_area()
> > and the actual I/O operation(s).
> 
> Details ?

When I hold a mandatory lock on a file then no other process will be
allowed to read from/write to (depending on the type of the lock) that
file, right? The code (vfs_read(), vfs_write(), do_readv_writev()) in
Linux appears to work as follows:

1. locks_verify_area() is called
2. file i/o is performed

As far as I can tell, the process holds no locks covering both steps.
Another process might call fcntl(...F_SETLK...) between steps 1 and 2,
i.e. after locks_verify_area() said "ok" but before the actual i/o is
finished, and the result would be one process doing i/o on a file
while the other process holds a mandatory lock on the same file.

--Pavel Kankovsky aka Peak  [ Boycott Microsoft--http://www.vcnet.com/bms ]
"Resistance is futile. Open your source code and prepare for assimilation."


