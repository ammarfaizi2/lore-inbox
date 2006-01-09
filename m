Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWAITjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWAITjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWAITjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:39:25 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:24227 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751254AbWAITjY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:39:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A6npJakCPVGkP84njP1zphWyXbpmLwLE+xtGTlEBxfjKH81NrZ9V7+QoMaq47aQK9QkhY81Xv0WPgs4TfDXktG+d7nQF5EGdDBarWcAmrMAMw4iEEZHKxLC+vn+s/pOvtlGFve7ffXFEZ3pdoVeKyDHu18QodMAe1N7xTKJwUIk=
Message-ID: <9a8748490601091139pf5fb6a0v3c8b3bcb41b85940@mail.gmail.com>
Date: Mon, 9 Jan 2006 20:39:21 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.15-mm2
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Doug Gilbert <dougg@torque.net>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601091857430.15219@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060107052221.61d0b600.akpm@osdl.org>
	 <9a8748490601070708p4353eb0ev9ea15edee132b13b@mail.gmail.com>
	 <9a8748490601090947i524d5f73uf5ccd06d8c693cae@mail.gmail.com>
	 <20060109175748.GD25102@redhat.com>
	 <9a8748490601091001y74fba5q2cd7e08a324701c3@mail.gmail.com>
	 <Pine.LNX.4.61.0601091819160.14800@goblin.wat.veritas.com>
	 <9a8748490601091048x46716e25u2fe2ebe9b5fbc9bb@mail.gmail.com>
	 <Pine.LNX.4.61.0601091857430.15219@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Hugh Dickins <hugh@veritas.com> wrote:
> On Mon, 9 Jan 2006, Jesper Juhl wrote:
> > Ok, with that patch the page, flags, mapping, mapcount & count
> > information prints again.
>
> Good, thanks.
>
> > I get the exact same backtrace as before though, but a slightly
> > different hexdump :
>
> (I find -mm's hexdump addition really irritating.  Perhaps it could
> be helpful if properly formatted, but not that dump of bytes.)
>
> > Bad page state in process 'kded'
> > page:c1e75400 flags:0x00000000 mapping:00000000 mapcount:1 count:0
> > Trying to fix it up, but a reboot is needed
> > Backtrace:
> > [<c0103e77>] dump_stack+0x17/0x20
> > [<c0148999>] bad_page+0x69/0x160
> > [<c0148e92>] __free_pages_ok+0xa2/0x120
> > [<c0149c7f>] __free_pages+0x2f/0x60
> > [<c02acb63>] sg_page_free+0x23/0x30
> > [<c02abdb3>] sg_remove_scat+0x63/0xe0
> ....
>
> Having sent you the patch to restore the KERN_EMERGs, I then took a
> look at drivers/scsi/sg.c, and it looks as if changes have gone into
> 2.6.15-git which might make more urgent a fix we knew would be needed
> in some cases.  Could you try the patch below and let us know if it
> fixes your problems?  Thanks...
>
>
> Remove sg_rb_correct4mmap() and its nasty __put_page()s, which are liable
> to do quite the wrong thing.  Instead allocate pages with __GFP_COMP, then
> high-orders should be safe for exposure to userspace by sg_vma_nopage(),
> without any further manipulations.  Based on original patch by Nick Piggin.
>

Unfortunately that patch doesn't change a thing (except some
addresses, but that's exected) :-(

Here's the crash I just got with that patch applied :

Bad page state in process 'kded'
page:c1e87d00 flags:0x00000000 mapping:00000000 macount:1 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
[<c0103e77>] dump_stack+0x17/0x20
[<c0148999>] bad_page+0x69/0x160
[<c0148e92>] __free_pages_ok+0xa2/0x120
[<c0149c7f>] __free_pages+0x2f/0x60
[<c02aca53>] sg_page_free+0x23/0x30
[<c02abcc3>] sg_remove_scat+0x63/0xe0
[<c02ac711>] __sg_remove_sfp+0x41/0xa0
[<c02ac927>] sg_remove_sfp+0xa7/0x120
[<c02a8b39>] sg_release+0x49/0xc0
[<c0166827>] __fput+0x167/0x1b0
[<c01666ab>] fput+0x3b/0x50
[<c0164efc>] filp_close+0x3c/0x80
[<c0164fa9>] sys_close+0x69/0x90
[<c0103009>] syscall_call+0x7/0xb
Hexdump:
000: ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00
010: d0 7c e8 c1 d0 7c e8 c1 ff ff ff ff 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
040: 00 00 00 00 ff ff ff ff 00 00 00 00 00 00 00 00
050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
