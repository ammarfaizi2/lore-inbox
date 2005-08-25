Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbVHYHS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVHYHS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 03:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbVHYHS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 03:18:29 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:60136 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751556AbVHYHS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 03:18:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=JdumWo/w4mr6TZT2Xu7I+1zJEYTgO7z3LXhqday69NgG2H2400gR55TFSA7132ADCVEVALLHBxPNFC4kHS7kjYmtWDIASSWuqgoy+UkvPlEZ3BhN+KOHrHD5AFB4DDhY24D9vrq7RT3kuTisMc3TBkan0O5W3ujfvpZfCWQvX4A=
Date: Thu, 25 Aug 2005 11:27:32 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Paul Jackson <pj@sgi.com>, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13-rc7
Message-ID: <20050825072731.GA876@mipter.zuzino.mipt.ru>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org> <20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk> <20050824114351.4e9b49bb.pj@sgi.com> <20050824191544.GM9322@parcelfarce.linux.theplanet.co.uk> <20050824201301.GA23715@mipter.zuzino.mipt.ru> <20050824213859.GN9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824213859.GN9322@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 10:38:59PM +0100, Al Viro wrote:
> On Thu, Aug 25, 2005 at 12:13:02AM +0400, Alexey Dobriyan wrote:
> > On Wed, Aug 24, 2005 at 08:15:44PM +0100, Al Viro wrote:
> > > Most of the remaining stuff is for
> > > m68k (and applies both to Linus' tree and m68k CVS); I'll send that today
> > > and if Geert ACKs them, we will be _very_ close to having 2.6.13 build
> > > out of the box on the following set:
> > > alpha,
> > 
> > Do I understand correctly that alpha in "--><-- close" list?
> > 
> > 2.6.13-rc7, alpha, allmodconfig:
> > 
> >   LD      .tmp_vmlinux1
> > net/built-in.o: In function `kmalloc':
> > include/linux/slab.h:92: undefined reference to `__you_cannot_kmalloc_that_much'
> > include/linux/slab.h:92: undefined reference to `__you_cannot_kmalloc_that_much'
> > 
> > Guilty: net/ipv4/route.c
> > 
> > $ nm net/ipv4/route.o | grep kmalloc
> >                  U __you_cannot_kmalloc_that_much
> 
> Not here...
> 
>   CC      arch/alpha/lib/udelay.o
>   LD      .tmp_vmlinux1
	[snip]

> Allmodconfig on alpha, alpha-linux-gcc (GCC) 4.0.1 20050727 (Red Hat 4.0.1-5).

Mine is alpha-unknown-linux-gnu-gcc (GCC) 3.4.4 (Gentoo 3.4.4)

> Which place triggers it in your build?

net/ipv4/route.c:3152, call to rt_hash_lock_init().

>From preprocessed source (reformatted):
-----------------------------------------------------------------------
typedef struct {
	volatile unsigned int lock;

	int on_cpu;
	int line_no;
	void *previous;
	struct task_struct * task;
	const char *base_file;
} spinlock_t;

static inline void *kmalloc(size_t size, unsigned int flags)
{
	if (__builtin_constant_p(size)) {
		int i = 0;
		
		if (size <= 64) goto found; else i++;
		if (size <= 128) goto found; else i++;
		if (size <= 192) goto found; else i++;
		if (size <= 256) goto found; else i++;
		if (size <= 512) goto found; else i++;
		if (size <= 1024) goto found; else i++;
		if (size <= 2048) goto found; else i++;
		if (size <= 4096) goto found; else i++;
		if (size <= 8192) goto found; else i++;
		if (size <= 16384) goto found; else i++;
		if (size <= 32768) goto found; else i++;
		if (size <= 65536) goto found; else i++;
		if (size <= 131072) goto found; else i++;
		{
			extern void __you_cannot_kmalloc_that_much(void);
			__you_cannot_kmalloc_that_much();
		}
		[snip]
-----------------------------------------------------------------------
{
	int i;
	rt_hash_locks = kmalloc(sizeof(spinlock_t) * 4096, (0x10u | 0x40u | 0x80u));
	if (!rt_hash_locks)
		panic("IP: failed to allocate rt_hash_locks\n");
		for (i = 0; i < 4096; i++)
			do {
				*(&rt_hash_locks[i]) = (spinlock_t){ 0, -1, 0, ((void *)0), ((void *)0), ((void *)0) };
			} while(0);
};
-----------------------------------------------------------------------

