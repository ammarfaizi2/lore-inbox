Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUITShz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUITShz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 14:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUITShw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 14:37:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:52126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266905AbUITShc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 14:37:32 -0400
Date: Mon, 20 Sep 2004 11:35:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Unaligned kernel access in crypto/sha1.c
Message-Id: <20040920113527.76b23801.akpm@osdl.org>
In-Reply-To: <20040920181645.GA32526@lucon.org>
References: <20040916231638.GA32514@lucon.org>
	<20040917221108.32545506.akpm@osdl.org>
	<20040920181645.GA32526@lucon.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. J. Lu" <hjl@lucon.org> wrote:
>
> On Fri, Sep 17, 2004 at 10:11:08PM -0700, Andrew Morton wrote:
> > "H. J. Lu" <hjl@lucon.org> wrote:
> > >
> > > I got
> > > 
> > > Sep 16 15:45:32 gnu-2 kernel: kernel unaligned access to
> > > 0xa0000002001c008e, ip=0xa0000001002135e0
> > > Sep 16 15:45:37 gnu-2 kernel: kernel unaligned access to
> > > 0xa0000002002d005e, ip=0xa0000001002135e0
> > > Sep 16 15:45:37 gnu-2 kernel: kernel unaligned access to
> > > 0xa0000002002d006e, ip=0xa0000001002135e0
> > > Sep 16 15:45:37 gnu-2 kernel: kernel unaligned access to
> > > 0xa0000002002d007e, ip=0xa0000001002135e0
> > > Sep 16 15:45:37 gnu-2 kernel: kernel unaligned access to
> > > 0xa0000002002d008e, ip=0xa0000001002135e0
> > > 
> > > on ia64 from sha1_transform in crypto/sha1.c:
> > > 
> > > /* Hash a single 512-bit block. This is the core of the algorithm. */
> > > static void sha1_transform(u32 *state, const u8 *in)
> > > {
> > >         u32 a, b, c, d, e;
> > >         u32 block32[16];
> > >                                                                                 
> > >         /* convert/copy data to workspace */
> > >         for (a = 0; a < sizeof(block32)/sizeof(u32); a++)
> > >           block32[a] = be32_to_cpu (((const u32 *)in)[a]);
> > > 				     ^^^^^^^^^^^^^^^^
> > > 				 This may not be aligned for u32 on ia64.
> > > 
> > > 
> > 
> > We really need to know the call trace here.
> > 
> 
> This is from a kernel with signed module support.
> 
> kernel unaligned access to 0xa0000002002e47ee, ip=0xa000000100211960
>  
> Call Trace:
>  [<a000000100017490>] show_stack+0x90/0xc0
>                                 sp=e00000017b8cf610
> bsp=e00000017b8c9330
>  [<a0000001000174f0>] dump_stack+0x30/0x60
>                                 sp=e00000017b8cf7e0
> bsp=e00000017b8c9318
>  [<a000000100043100>] ia64_handle_unaligned+0x540/0x2600
>                                 sp=e00000017b8cf7e0
> bsp=e00000017b8c9290
>  [<a0000001000101b0>] ia64_prepare_handle_unaligned+0x30/0x60
>                                 sp=e00000017b8cf990
> bsp=e00000017b8c9290
>  [<a00000010000fbe0>] ia64_leave_kernel+0x0/0x260
>                                 sp=e00000017b8cfba0
> bsp=e00000017b8c9290
>  [<a000000100211960>] sha1_transform+0x60/0x3160
>                                 sp=e00000017b8cfd70
> bsp=e00000017b8c9128
>  [<a000000100214c60>] sha1_update+0x120/0x1a0
>                                 sp=e00000017b8cfda0
> bsp=e00000017b8c90e0
>  [<a00000010020fd40>] update_kernel+0x60/0x100
>                                 sp=e00000017b8cfda0
> bsp=e00000017b8c90b0
>  [<a0000001000b3340>] module_verify_sig+0x660/0x740
>                                 sp=e00000017b8cfda0

The bug is in either module_verify_sig() or in update_kernel().

Neither of these functions are present in kernel.org kernels, so there's
some sort of lesson there.
