Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWCLMuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWCLMuQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 07:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWCLMuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 07:50:16 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:38569 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932149AbWCLMuO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 07:50:14 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [discuss] Re: 2.6.16-rc5-mm3: spinlock bad magic on CPU#0 on AMD64
Date: Sun, 12 Mar 2006 13:49:31 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, ak@suse.de
References: <200603120024.04938.rjw@sisk.pl> <20060311153618.2e4b113d.akpm@osdl.org> <200603121127.28657.rjw@sisk.pl>
In-Reply-To: <200603121127.28657.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603121349.32374.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Dropped discuss@x86-64.org from the Cc list, it's probably OT there]

On Sunday 12 March 2006 11:27, Rafael J. Wysocki wrote:
> On Sunday 12 March 2006 00:36, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > With the 2.6.16-rc5-mm3 kernel w/ the patch
> > > 
> > > revert-x86_64-mm-i386-early-alignment.patch
> > > 
> > > applied I'm able to hang my box (Asus L5D, 1 CPU, x86-64 kernel) solid
> > > by running OpenOffice.org from under KDE (100% of the time but on one
> > > user account only).  Before it hangs I get something like this on the serial console:
> > > 
> > > BUG: spinlock bad magic on CPU#0, soffice.bin/5293
> > >  lock: ffff81005e174e28, .magic: 000001ff, .owner: .5).@4).06)./0, .owner_cpu: -2141827648
> > > BUG: spinlock lockup on CPU#0, soffice.bin/5293, ffff81005e174e28
> > > 
> > 
> > Is it a !CONFIG_SMP kernel?
> 
> Yes.
> 
> > There's no stack trace?
> 
> Well, probably there was one but it didn't appear on the serial console because
> the console loglevel was too low.  I'll try to increase console_loglevel in
> spin_bug() and see what happens.

Done, and now it looks like this:

BUG: spinlock bad magic on CPU#0, soffice.bin/5192
 lock: ffff81005f79ae28, .magic: 000001ff, .owner: 1..1..|1. |1.|1..|1.�1..|1..1. 1./-1,
.owner_cpu: -2141838208

Call Trace: <ffffffff80210383>{__alloc_pages+99} <ffffffff802156c3>{spin_bug+195}
       <ffffffff802077dc>{_raw_spin_lock+44} <ffffffff80270a4e>{_spin_lock+30}
       <ffffffff8033712d>{journal_extend+77} <ffffffff80327255>{ext3_get_block+165}
       <ffffffff8022c2f9>{do_mpage_readpage+425} <ffffffff80270cc4>{_write_unlock_irq+20}
       <ffffffff8020cce2>{add_to_page_cache+162} <ffffffff8023fdee>{mpage_readpages+254}
       <ffffffff803271b0>{ext3_get_block+0} <ffffffff803271b0>{ext3_get_block+0}
       <ffffffff803146df>{get_cnode+95} <ffffffff8020a3bb>{get_page_from_freelist+619}
       <ffffffff80210383>{__alloc_pages+99} <ffffffff80323c1a>{ext3_readpages+26}
       <ffffffff80214030>{__do_page_cache_readahead+416} <ffffffff80213c12>{poison_obj+66}
       <ffffffff80232058>{wake_up_bit+40} <ffffffff80243152>{unlock_buffer+18}
       <ffffffff80315bb8>{reiserfs_prepare_for_journal+104}
       <ffffffff802b6ab4>{do_page_cache_readahead+100} <ffffffff80215942>{filemap_nopage+322}
       <ffffffff80208b2c>{__handle_mm_fault+1004} <ffffffff80270e7d>{_spin_unlock_irqrestore+29}
       <ffffffff8020ae99>{do_page_fault+1257} <ffffffff8026af8d>{error_exit+0}
       <ffffffff802ffb40>{reiserfs_copy_from_user_to_file_region+80}
       <ffffffff80302446>{reiserfs_file_write+6102} <ffffffff802f8f4e>{reiserfs_add_entry+1054}
       <ffffffff8033c1ff>{journal_cancel_revoke+351} <ffffffff80213c12>{poison_obj+66}
       <ffffffff80236d27>{cache_free_debugcheck+711} <ffffffff80335734>{journal_stop+772}
       <ffffffff80270f30>{_spin_unlock+16} <ffffffff802193a2>{vfs_write+226}
       <ffffffff80219c80>{sys_write+80} <ffffffff8026d234>{cstar_do_call+27}
BUG: spinlock lockup on CPU#0, soffice.bin/5192, ffff81005f79ae28
