Return-Path: <linux-kernel-owner+w=401wt.eu-S964885AbWL2JoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWL2JoZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 04:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbWL2JoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 04:44:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:24205 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964885AbWL2JoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 04:44:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PuBgvwULgb9zr+8szsdiHADIAzqFF/fxVjnr4LVx6D9B+dLGkrJc6eLZoJVja70Wxy3Upj74yNQ0lYzoqZ/v5RY1/wtRKbbyuUr5H5S1sxqLhJc6Y88UHaVF7hftwP+01jKiJqgOwChc2CV4da9lqJWbEzcG5OpSVWsYc7fFbn8=
Message-ID: <a44ae5cd0612290144x4cbc25daif5f88982ef301879@mail.gmail.com>
Date: Fri, 29 Dec 2006 01:44:23 -0800
From: "Miles Lane" <miles.lane@gmail.com>
To: "Jiri Slaby" <jirislaby@gmail.com>
Subject: 2.6.20-rc2-mm1 -- BUG: at arch/i386/mm/highmem.c:50 kmap_atomic()
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/06, Jiri Slaby <jirislaby@gmail.com> wrote:
> Miles Lane wrote:
> > On 12/18/06, Jiri Slaby <jirislaby@gmail.com> wrote:
> >> Miles Lane wrote:
> >> > Sorry, I am not finding who maintains highmem.  Please forward.
> >> >
> >> > WARNING (1) at arch/i386/mm/highmem.c:41 kmap_atomic()
> >> > [<c0103c25>] dump_trace+0x68/0x1d2
> >> > [<c0103da7>] show_trace_log_lvl+0x18/0x2c
> >> > [<c0104410>] show_trace+0xf/0x11
> >> > [<c010449b>] dump_stack+0x12/0x14
> >> > [<c01144d9>] kmap_atomic+0x6f/0x1ca
> >> > [<f930e25d>] ntfs_end_buffer_async_read+0x25d/0x2ca [ntfs]
> >> > [<c017c294>] end_bio_bh_io_sync+0x2c/0x37
> >> > [<c017dc29>] bio_endio+0x5a/0x62
> >> > [<c01c8412>] __end_that_request_first+0x145/0x3ab
> >> > [<c0237695>] ide_end_request+0x80/0xd8
> >> > [<c023e3f0>] ide_dma_intr+0x55/0x9a
> >> > [<c02388dc>] ide_intr+0x182/0x1f2
> >> > [<c0140775>] handle_IRQ_event+0x1a/0x3f
> >> > [<c0141baa>] handle_edge_irq+0xc6/0x11c
> >> > [<c0105416>] do_IRQ+0x57/0x71
> >> > [<c010366b>] common_interrupt+0x23/0x28
> >> > [<f8826ee4>] acpi_processor_idle+0x1cc/0x36c [processor]
> >> > [<c010132b>] cpu_idle+0x3e/0x6c
> >> > [<c03f06d9>] start_kernel+0x2fa/0x2fe
> >> > =======================
> >>
> >> Reported yet, you might see it here:
> >> http://lkml.org/lkml/2006/12/15/222
> >
> > It is certainly very similar, and probably has the same root cause.
> > Though, the trace isn't an exact match.   So, who should look into
> > this?
>
> The trace needn't be the same. The problem was, that kmap_atomic didn't know
> KM_BIO_SRC_IRQ which is called (twice) from ntfs_end_buffer_async_read. It
> doesn't matter who called this ntfs function and why.

With 2.6.20-rc2-mm1 I am seeing:

BUG: at arch/i386/mm/highmem.c:50 kmap_atomic()
 [<c0114368>] kmap_atomic+0x8e/0x18b
 [<f938525d>] ntfs_end_buffer_async_read+0x25d/0x2ca [ntfs]
 [<c017a205>] end_bio_bh_io_sync+0x0/0x37
 [<c017a231>] end_bio_bh_io_sync+0x2c/0x37
 [<c017bb95>] bio_endio+0x5a/0x62
 [<c0237da2>] scsi_delete_timer+0xb/0x1b
 [<c01c641c>] __end_that_request_first+0x145/0x3ab
 [<c01cb657>] as_put_io_context+0x43/0x4e
 [<c0238ec7>] scsi_end_request+0x1d/0xb6
 [<c0239092>] scsi_io_completion+0xf5/0x2ba
 [<c011ff63>] do_timer+0x4fc/0x70c
 [<f90024b6>] sd_rw_intr+0x15d/0x186 [sd_mod]
 [<c023970f>] scsi_softirq_done+0x20/0xce
 [<c02358cd>] scsi_finish_command+0x3f/0x43
 [<c01c7f4c>] blk_done_softirq+0x4a/0x55
 [<c011c1d1>] __do_softirq+0x35/0x75
 [<c011c233>] do_softirq+0x22/0x26
 [<c011c3fa>] irq_exit+0x29/0x62
 [<c0106232>] do_IRQ+0x67/0x81
 [<c01046e3>] common_interrupt+0x23/0x28
 [<f8823ee4>] acpi_processor_idle+0x1cc/0x36c [processor]
 [<f8823d18>] acpi_processor_idle+0x0/0x36c [processor]
 [<c0102389>] cpu_idle+0x44/0x77
 [<c0380a93>] start_kernel+0x2f9/0x2fd
 [<c038042b>] unknown_bootoption+0x0/0x202
