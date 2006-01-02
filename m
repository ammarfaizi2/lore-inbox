Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWABWX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWABWX5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 17:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWABWX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 17:23:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11537 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751103AbWABWX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 17:23:56 -0500
Date: Mon, 2 Jan 2006 22:23:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Ingo Molnar <mingo@elte.hu>,
       Adrian Bunk <bunk@stusta.de>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060102222335.GB5412@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Krzysztof Halasa <khc@pm.waw.pl>, Ingo Molnar <mingo@elte.hu>,
	Adrian Bunk <bunk@stusta.de>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
	mpm@selenic.com
References: <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org> <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu> <m3ek3qcvwt.fsf@defiant.localdomain> <1136227893.2936.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136227893.2936.51.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 07:51:32PM +0100, Arjan van de Ven wrote:
> On Mon, 2006-01-02 at 19:44 +0100, Krzysztof Halasa wrote:
> > Ingo Molnar <mingo@elte.hu> writes:
> > 
> > > what is the 'deeper problem'? I believe it is a combination of two 
> > > (well-known) things:
> > >
> > >   1) people add 'inline' too easily
> > >   2) we default to 'always inline'
> > 
> > For example, I add "inline" for static functions which are only called
> > from one place.
> 
> you know what? gcc inlines those automatic even without you typing
> "inline". (esp if you have unit-at-a-time enabled)

Rubbish it will.

static void fn1(void *f)
{
}

void fn2(void *f)
{
        fn1(f);
}

on ARM produces:

        .text
        .align  2
        .type   fn1, %function
fn1:
        @ args = 0, pretend = 0, frame = 0
        @ frame_needed = 0, uses_anonymous_args = 0
        @ link register save eliminated.
        @ lr needed for prologue
        mov     pc, lr
        .size   fn1, .-fn1
        .align  2
        .global fn2
        .type   fn2, %function
fn2:
        @ args = 0, pretend = 0, frame = 0
        @ frame_needed = 0, uses_anonymous_args = 0
        @ link register save eliminated.
        @ lr needed for prologue
        b       fn1
        .size   fn2, .-fn2
        .ident  "GCC: (GNU) 3.3 20030728 (Red Hat Linux 3.3-16)"

You can't get a simpler function than fn1 to automatically inline.

GCC will only automatically inline using -O3.  We don't use -O3 with
the kernel - only -O2 and -Os.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
