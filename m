Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbTJGJMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 05:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbTJGJMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 05:12:14 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:15685 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262016AbTJGJMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 05:12:06 -0400
Subject: Re: ext3 crash with 2.4.22: Assertion failure in
	journal_forget_R10d91946()
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andriy Rysin <arysin@bcsii.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0310061946290.2403-100000@logos.cnet>
References: <Pine.LNX.4.44.0310061946290.2403-100000@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1065517918.6579.1005.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Oct 2003 10:11:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2003-10-06 at 23:56, Marcelo Tosatti wrote:

> On Thu, 2 Oct 2003, Andriy Rysin wrote:
> > I am having crashes on ext3 with 2.4.22 kernel. System was up for 8 
> > days. I am not sure I can reproduce it real quick but we've seen it 
> > occasionly on 2.4.20 for about several months and after we updated to 
> > 2.4.22 it's here again.

> > the log looks like this:
> > 
> > Sep 29 20:15:08 dunne-demo kernel: EXT3-fs error (device ide0(3,2)): 
> > ext3_free_blocks: Freeing blocks not in datazone - bloc
> > k = 2907885836, count = 1
...
> > Oct  2 00:43:53 dunne-demo kernel: hda: dma_timer_expiry: dma status == 0x20
> > Oct  2 00:43:53 dunne-demo kernel: hda: timeout waiting for DMA
> > Oct  2 00:43:53 dunne-demo kernel: hda: timeout waiting for DMA
> > Oct  2 00:43:53 dunne-demo kernel: hda: (__ide_dma_test_irq) called 
> 
> You are getting DMA timeouts and such. Try turning off the DMA.

The ext3 errors are entirely consistent with disk corruption.  They can
occur in many ways: for example, if the drive is dropping writes due to
the IDE errors, you could easily end up with a corrupt indirect block
that would lead to the above errors if you tried to delete the file
again.

The

	journal_forget_R10d91946() at transaction.c:1259: "!jh->b_committed_data"

error occurs when we try to discard a buffer that has got "committed
data" versioning info attached.  That info is only ever used for bitmap
blocks: it is there to ensure that we don't reallocate freed data until
the transaction that deleted the data has committed (if we crash before
the commit, we need to be able to roll back the delete, so we can't
overwrite the data on disk until after the commit.)

So we're deleting a bitmap block.  No wonder jbd is getting worried.
:-)  But this indicates that it's yet another consequence of the
underlying corruption of an indirect block.

Current 2.4 ext3 includes a patch from Andreas Dilger which detects when
we're attempting to free metadata, and which avoids the free so that we
don't end up reallocating critical metadata as file contents.  I'll have
a look at using that detection to avoid the ext3_forget() on such
blocks.

It's definitely a case that you should never see except on a corrupt
filesystem, so I want to preserve the ability to panic() here for
testing: there's already an ext3 compile-time option you can set in
jbd.h to turn error-detection into assert-failures for errors which can
happen in real life on corrupt filesystems.

--Stephen

