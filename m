Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUA3QBc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 11:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUA3QBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 11:01:32 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:14984 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S261774AbUA3QBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 11:01:30 -0500
Date: Fri, 30 Jan 2004 17:01:25 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040130160125.GC25833@drinkel.cistron.nl>
References: <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040128222521.75a7d74f.akpm@osdl.org> (from akpm@osdl.org on Thu, Jan 29, 2004 at 07:25:21 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004 07:25:21, Andrew Morton wrote:
> "Miquel van Smoorenburg" <miquels@cistron.nl> wrote:
> >
> > I have a Linux 2.6.2-rc2 NFS file server and another similar
> > box as client. Kernel is compiled for SMP (hyperthreading).
> > 
> > In a few seconds, the server locks up. It spins in
> > generic_fillattr(), apparently in the i_size_read() inline function.
> > Server responds to pings and sysrq, but nothing else.
> > Here's the sysrq output:
> > 
> > Pid: 531, comm:                 nfsd
> > EIP: 0060:[<c01577c2>] CPU: 0
> > EIP is at generic_fillattr+0x82/0xa0
> >  EFLAGS: 00000246    Not tainted
> > EAX: 00000000 EBX: 07ae7200 ECX: f650a0a0 EDX: 000113eb
> > ESI: 00000000 EDI: f66cfed4 EBP: f66e5804 DS: 007b ES: 007b
> > CR0: 8005003b CR2: 40019000 CR3: 37245000 CR4: 000006d0
> > Call Trace:
> >  [<f8ab1f6b>] linvfs_getattr+0x2b/0x34 [xfs]
> >  [<c0157805>] vfs_getattr+0x25/0x84
> >  [<c01c19a3>] encode_post_op_attr+0x53/0x238
> >  [<c01c1e27>] encode_wcc_data+0x29f/0x2a8
> >  [<c01c4521>] nfs3svc_encode_commitres+0x19/0x5c
> >  [<c01b709d>] nfsd_dispatch+0x14d/0x1a3
> >  [<c02fb79b>] svc_process+0x3b3/0x640
> >  [<c01b6ddc>] nfsd+0x1e4/0x358
> >  [<c01b6bf8>] nfsd+0x0/0x358
> >  [<c0107251>] kernel_thread_helper+0x5/0xc
> > 
> 
> Is the EIP _always_ inside generic_fillattr()?
> 
> If so then yes, your analysis look right.  I'd say that the inode has been
> corrupted and the seqcount counter has assumed an non-even value.  That
> will cause i_size_read() to lock up.

Yes, but why does it lock up the whole machine? I'd say just that one
process should go into 'R', but other things should get scheduled right?
Or is some very common lock being held? The machine responds to pings,
so interrupts are working.

In fact as this is a hyperthreaded machine, why don't I see anything
running on the "other virtual cpu" ? I only see nfsd spinning on CPU#0

Could it be a CPU problem, the other CPU-thread is in i_size_write() but
that CPU-thread is simply never run ? To test this, I rebooted the exact
same 2.6.2-rc2 kernel with "maxcpus=1" .. and it doesn't lock up ..

(Still weird that -mm doesn't lock up)

Mike.
