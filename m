Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWCPE6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWCPE6a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 23:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWCPE6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 23:58:30 -0500
Received: from mx.pathscale.com ([64.160.42.68]:23438 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932367AbWCPE63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 23:58:29 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh@veritas.com, rdreier@cisco.com, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060315192813.71a5d31a.akpm@osdl.org>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
	 <1142477579.6994.124.camel@localhost.localdomain>
	 <20060315192813.71a5d31a.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 20:58:23 -0800
Message-Id: <1142485103.25297.13.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 19:28 -0800, Andrew Morton wrote:

> It still has PG_reserved set.  I'd suggest you simply not set PG_reserved
> on these pages.

I made that change; thanks to you and Linus for suggesting it.

It caused progress of a sort to occur.  This time, we made it through
mmput (the earlier crash site) and tripped over our shoelaces a bit
later during process exit:

        Bad page state at __free_pages_ok (in process 'mpi_hello', page ffff8100020e2f88)
        flags:0x0100000000000804 mapping:0000000000000000 mapcount:0 count:0 (Not tainted)
        Backtrace:
        
        Call Trace:<ffffffff80169577>{bad_page+135} <ffffffff8016b1ae>{__free_pages_ok+128}
               <ffffffff880f1c88>{:ipath_core:ipath_free_pddata+292}
               <ffffffff880f7039>{:ipath_core:ipath_close+1616} <ffffffff8018afeb>{__fput+183}
               <ffffffff80188612>{filp_close+91} <ffffffff8013e2a3>{put_files_struct+117}
               <ffffffff8013f312>{do_exit+646} <ffffffff8013fdd1>{sys_exit_group+0}
               <ffffffff80149fd9>{get_signal_to_deliver+1594} <ffffffff8010f23a>{do_signal+116}
               <ffffffff80148529>{force_sig_info+158} <ffffffff8011017e>{retint_signal+61}

Here, I think we're calling dma_free_coherent, on a hunk of memory that
userspace mmapped earlier.  Perhaps that got cleaned up during mmput,
and that's why dma_free_coherent is choking here.

> hm.  Are these pages supposed to be owned by the userspace process?  To have their
> lifetime controlled by that process?

We have two different sets of pages.  Some we want to keep around for as
long as a device is plugged in, so the driver should continue to own
them after a user process exits.

Other pages should only live as long as the process that has them
mmapped, but at the moment our driver is (perhaps mistakenly?)
explicitly freeing them as part of fops->close.

I am quite unclear in my head on what mechanism to use to manage the
lifetimes of these pages. Should I use get_page on the pages that span
multiple process lifetimes, and let whatever cleans up the process's
mappings handle the pages that should go away with the process?  Is it
even safe to do that, if I allocated them with dma_alloc_coherent
instead of kmalloc?

Thanks for your patience and help,

	<b

