Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWAUBPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWAUBPZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWAUBPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:15:25 -0500
Received: from pat.uio.no ([129.240.130.16]:42154 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932362AbWAUBPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:15:25 -0500
Subject: Re: set_bit() is broken on i386?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200601201955_MC3-1-B649-DCF5@compuserve.com>
References: <200601201955_MC3-1-B649-DCF5@compuserve.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 20:15:07 -0500
Message-Id: <1137806107.8691.25.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.421, required 12,
	autolearn=disabled, AWL 1.39, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 19:53 -0500, Chuck Ebbert wrote:

> #define ADDR (*(volatile long *) addr)
> static inline void set_bit(int nr, volatile unsigned long * addr)
> {
> 	__asm__ __volatile__( "lock ; "
> 		"btsl %1,%0"
> 		:"=m" (ADDR)
> 		:"Ir" (nr));
> }

The asm needs a memory clobber in order to avoid reordering with the
assignment to b[1]:

static inline void set_bit(int nr, volatile unsigned long * addr)
{
	__asm__ __volatile__( "lock ; "
		"btsl %1,%0"
		:"=m" (ADDR)
		:"Ir" (nr)
		: "memory");
}

This works consistently correctly for me.

Cheers,
  Trond

