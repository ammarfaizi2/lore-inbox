Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAKJw2>; Thu, 11 Jan 2001 04:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRAKJwS>; Thu, 11 Jan 2001 04:52:18 -0500
Received: from mons.uio.no ([129.240.130.14]:29930 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S129324AbRAKJwD>;
	Thu, 11 Jan 2001 04:52:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14941.33321.654339.640474@charged.uio.no>
Date: Thu, 11 Jan 2001 10:51:37 +0100 (CET)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ak@suse.de (Andi Kleen), phillips@innominate.de (Daniel Phillips),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <E14GRE7-0000p5-00@the-village.bc.nu>
In-Reply-To: <20010110204308.A5303@gruyere.muc.suse.de>
	<E14GRE7-0000p5-00@the-village.bc.nu>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

    >> As the thread started it's not only only needed for pthreads,
    >> but also for NFS and setuid (actually NFS already implements it
    >> privately), and probably other network file systems too.  So
    >> it's far from being only a "bad standard corner case".

     > I wonder how Linux 2.2 worked, that doesnt have them. Now if
     > its a clean way of sorting out a pile of other things and it
     > does pthreads as a side effect I've no problem, but arguing for
     > it because of a tiny pthreads corner case is coming from the
     > wrong end


How about this then:

Sure NFS can work without ucreds, but there are limitations.  For
instance the MVFS folks recently complained. They're trying to keep
mmap consistency between their own filesystem layer and the underlying
storage filesystem using i_mapping (a la CODAfs). The problem then is
that the vma will be using the wrong 'struct file' to call the
underlying storage.

This sort of problem would indeed disappear if we have a generic
credential stored in the struct file as we could make the VFS pass the
credential directly to readpage (and writepage?) rather than passing
the whole struct file.

If you use the same credentials in the task structure, then there are
other advantages even to NFS itself.
You may for example want to attach an ACL cache at some point in time
(to avoid the messiness of calling NFSv3/v4 permissions routines at
each and every file lookup). Ditto for strong RPC authentication
schemes that require an upcall to some userspace daemon.

That said, we'd first have to find a way to reconcile fsuid/fsgid with
the BSD model in some way: I'd rather not have 2 'ucred's per task (1
for threads + 1 for filesystems).

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
