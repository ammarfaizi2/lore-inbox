Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265102AbUFGWku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUFGWku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265103AbUFGWku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:40:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64679 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265102AbUFGWkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:40:46 -0400
Date: Mon, 7 Jun 2004 23:40:45 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       perex@suse.cz
Subject: Re: [RFC] ASLA design, depth of code review and lack thereof
Message-ID: <20040607224045.GJ12308@parcelfarce.linux.theplanet.co.uk>
References: <20040604230819.GR12308@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0406041622480.7010@ppc970.osdl.org> <20040605000410.GT12308@parcelfarce.linux.theplanet.co.uk> <s5hfz974ijl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hfz974ijl.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 03:14:06PM +0200, Takashi Iwai wrote:
> > and return a pointer to a (8-element) row in array of patterns.  Because
> > callers end up truncating the result and then filling a large area with
> > repeated copies.  All we get from use of u_int64_t is extra PITA with
> > endianness - memcpy from 1/2/4/8 element array is no less efficient than
> > assignment from u8/u16/u32/u64.
> 
> Is it true?  If gcc really optmizes well like this, yes, surely we can
> use memcpy for simplicity.

__builtin_memcpy() is definitely smart enough for that: e.g. on x86 (and you
don't get much more register-starved than that)
void b(char *);
void a(char *x, int count)
{
        char buf[8];
        int i;
        b(buf);
        for (i = 0; i < count; i++) {
                __builtin_memcpy(x, buf, 8);
                x += 8;
        }
}
will result (with -O2, which is normal for kernel) in
.L6:
        movl    %ecx, (%ebx)
        movl    %edx, 4(%ebx)
        addl    $8, %ebx
        decl    %eax
        jne     .L6
as the main loop, which gives you what you would get from use of u64.
And yes, constant-sized memcpy() in the kernel will be expanded to
__builtin_memcpy().

