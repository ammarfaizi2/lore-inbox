Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUITSQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUITSQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 14:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUITSQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 14:16:57 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:58814 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266912AbUITSQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 14:16:48 -0400
Date: Mon, 20 Sep 2004 11:16:45 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Unaligned kernel access in crypto/sha1.c
Message-ID: <20040920181645.GA32526@lucon.org>
References: <20040916231638.GA32514@lucon.org> <20040917221108.32545506.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917221108.32545506.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 10:11:08PM -0700, Andrew Morton wrote:
> "H. J. Lu" <hjl@lucon.org> wrote:
> >
> > I got
> > 
> > Sep 16 15:45:32 gnu-2 kernel: kernel unaligned access to
> > 0xa0000002001c008e, ip=0xa0000001002135e0
> > Sep 16 15:45:37 gnu-2 kernel: kernel unaligned access to
> > 0xa0000002002d005e, ip=0xa0000001002135e0
> > Sep 16 15:45:37 gnu-2 kernel: kernel unaligned access to
> > 0xa0000002002d006e, ip=0xa0000001002135e0
> > Sep 16 15:45:37 gnu-2 kernel: kernel unaligned access to
> > 0xa0000002002d007e, ip=0xa0000001002135e0
> > Sep 16 15:45:37 gnu-2 kernel: kernel unaligned access to
> > 0xa0000002002d008e, ip=0xa0000001002135e0
> > 
> > on ia64 from sha1_transform in crypto/sha1.c:
> > 
> > /* Hash a single 512-bit block. This is the core of the algorithm. */
> > static void sha1_transform(u32 *state, const u8 *in)
> > {
> >         u32 a, b, c, d, e;
> >         u32 block32[16];
> >                                                                                 
> >         /* convert/copy data to workspace */
> >         for (a = 0; a < sizeof(block32)/sizeof(u32); a++)
> >           block32[a] = be32_to_cpu (((const u32 *)in)[a]);
> > 				     ^^^^^^^^^^^^^^^^
> > 				 This may not be aligned for u32 on ia64.
> > 
> > 
> 
> We really need to know the call trace here.
> 

This is from a kernel with signed module support.

kernel unaligned access to 0xa0000002002e47ee, ip=0xa000000100211960
 
Call Trace:
 [<a000000100017490>] show_stack+0x90/0xc0
                                sp=e00000017b8cf610
bsp=e00000017b8c9330
 [<a0000001000174f0>] dump_stack+0x30/0x60
                                sp=e00000017b8cf7e0
bsp=e00000017b8c9318
 [<a000000100043100>] ia64_handle_unaligned+0x540/0x2600
                                sp=e00000017b8cf7e0
bsp=e00000017b8c9290
 [<a0000001000101b0>] ia64_prepare_handle_unaligned+0x30/0x60
                                sp=e00000017b8cf990
bsp=e00000017b8c9290
 [<a00000010000fbe0>] ia64_leave_kernel+0x0/0x260
                                sp=e00000017b8cfba0
bsp=e00000017b8c9290
 [<a000000100211960>] sha1_transform+0x60/0x3160
                                sp=e00000017b8cfd70
bsp=e00000017b8c9128
 [<a000000100214c60>] sha1_update+0x120/0x1a0
                                sp=e00000017b8cfda0
bsp=e00000017b8c90e0
 [<a00000010020fd40>] update_kernel+0x60/0x100
                                sp=e00000017b8cfda0
bsp=e00000017b8c90b0
 [<a0000001000b3340>] module_verify_sig+0x660/0x740
                                sp=e00000017b8cfda0
bsp=e00000017b8c8ff0
 [<a0000001000aed80>] load_module+0x7e0/0x2ba0
                                sp=e00000017b8cfda0
bsp=e00000017b8c8ec0
 [<a0000001000b1220>] sys_init_module+0xe0/0x640
                                sp=e00000017b8cfe30
bsp=e00000017b8c8e50
 [<a00000010000fa80>] ia64_ret_from_syscall+0x0/0x20
                                sp=e00000017b8cfe30
bsp=e00000017b8c8e50
 [<a000000000010620>] 0xa000000000010620
                                sp=e00000017b8d0000
bsp=e00000017b8c8e50

