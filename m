Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVKVAtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVKVAtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 19:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbVKVAtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 19:49:20 -0500
Received: from pat.uio.no ([129.240.130.16]:16599 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964808AbVKVAtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 19:49:19 -0500
Subject: Re: infinite loop? with mmap, nfs, pwrite, O_DIRECT
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: theonetruekenny@yahoo.com, cel@citi.umich.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051121162837.1a952543.akpm@osdl.org>
References: <20051121213913.61220.qmail@web34115.mail.mud.yahoo.com>
	 <1132612974.8011.12.camel@lade.trondhjem.org>
	 <20051121153454.1907d92a.akpm@osdl.org>
	 <1132617503.8011.35.camel@lade.trondhjem.org>
	 <20051121160913.6d59c9fa.akpm@osdl.org>
	 <1132618731.8011.46.camel@lade.trondhjem.org>
	 <20051121162837.1a952543.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 19:49:00 -0500
Message-Id: <1132620540.8011.58.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.899, required 12,
	autolearn=disabled, AWL 1.91, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 16:28 -0800, Andrew Morton wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >
> > On Mon, 2005-11-21 at 16:09 -0800, Andrew Morton wrote:
> > > Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > > >
> > > > The only difference I can see between the two paths is the call to
> > > >  unmap_mapping_range(). What effect would that have?
> > > 
> > > It shoots down any mapped pagecache over the affected file region.  Because
> > > the direct-io write is about to make that pagecache out-of-date.  If the
> > > application tries to use that data again it'll get a major fault and will
> > > re-read the file contents.
> > 
> > I assume then, that this couldn't be the cause of the
> > invalidate_inode_pages() failing to complete?
> 
> It sounds unlikely.  This hang is associated with crossing the 2G boundary
> isn't it?
> 
> I don't think we've seen a sysrq-T trace from the hang?

Kenny sent us this trace. The thing appears to be hanging in
unmap_mapping_range() as called by invalidate_inode_pages2()

Pid: 4271, comm:            writetest
EIP: 0060:[<c029cd2b>] CPU: 0
EIP is at prio_tree_first+0x26/0xb8
 EFLAGS: 00000292    Tainted: P       (2.6.15-rc1)
EAX: 00000000 EBX: f6765d94 ECX: f6765d94 EDX: 00000200
ESI: 00000000 EDI: f5da475c EBP: f6765db4 DS: 007b ES: 007b
CR0: 8005003b CR2: b7590000 CR3: 36b5d000 CR4: 000006d0
 [<c029ce5e>] prio_tree_next+0xa1/0xa3
 [<c014822a>] vma_prio_tree_next+0x27/0x51
 [<c014b1dc>] unmap_mapping_range+0x18b/0x210
 [<c0120d06>] __do_softirq+0x6a/0xd1
 [<c0103a24>] apic_timer_interrupt+0x1c/0x24
 [<c0146577>] invalidate_inode_pages2_range+0x215/0x24c
 [<c01465cd>] invalidate_inode_pages2+0x1f/0x26
 [<c01e4031>] nfs_file_direct_write+0x1e1/0x21a
 [<c0159ea4>] do_sync_write+0xc7/0x10d
 [<c012ff32>] autoremove_wake_function+0x0/0x57
 [<c0159f92>] vfs_write+0xa8/0x177
 [<c015a275>] sys_pwrite64+0x88/0x8c
 [<c0102f51>] syscall_call+0x7/0xb

> > Unless there is some
> > method to prevent applications from faulting in the page while we're
> > inside generic_file_direct_IO(), then the same race would be able to
> > occur there.
> 
> Yes, there are still windows.
> 
> Another thing the unmap_mapping_range() does is to push pte-dirty bits into
> the software-dirty flags, so the modified data does get written.  If we
> didn't do this, a page which was dirtied via mmap before the direct-io
> write would get written back _after_ the direct-io write, arguably causing
> corruption.

As far as we're concerned, anybody using direct-io is responsible for
enforcing their own ordering. The pagecache is one thing, but in NFS,
direct IO is mainly used in situations where several clients are writing
to the same file. There is no way to ensure fully safe mmap() semantics.

Cheers,
  Trond

