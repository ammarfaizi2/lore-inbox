Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWFFWaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWFFWaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWFFWaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:30:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2460 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751249AbWFFWaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:30:01 -0400
Date: Tue, 6 Jun 2006 15:29:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: laurent.riffard@free.fr, barryn@pobox.com, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org, jbeulich@novell.com,
       arjan@linux.intel.com
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060606152930.adc58fe4.akpm@osdl.org>
In-Reply-To: <20060606220507.GA19882@elte.hu>
References: <200606042101_MC3-1-C19B-1CF4@compuserve.com>
	<20060604181002.57ca89df.akpm@osdl.org>
	<44840838.7030802@free.fr>
	<4484584D.4070108@free.fr>
	<20060605110046.2a7db23f.akpm@osdl.org>
	<986ed62e0606051452x320cce2ap9598558b5343ae6b@mail.gmail.com>
	<20060606072628.GA28752@elte.hu>
	<4485E0D3.8080708@free.fr>
	<20060606205801.GC17787@elte.hu>
	<4485F5E2.5040708@free.fr>
	<20060606220507.GA19882@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 00:05:07 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Laurent Riffard <laurent.riffard@free.fr> wrote:
> 
> > >> Results:
> > >> - 2.6.17-rc4-mm3 with 4K stack works fine (this is the latest good 4K-kernel).
> > >> - 2.6.17-rc5-mm3 with 4K stack crashes, the stack seems to be corrupted.
> > > 
> > > that's vanilla mm3, or mm3 patched with extra lockdep patches? If it's 
> > > patched then you should try vanilla mm3 too.
> > 
> > It was vanilla mm3.
> 
> ok, i'll check the stack impact of the block_dev.c changes tomorrow.
> 

Note that Laurent is also passing through ide_cdrom_packet(), which has a
`struct request' on the stack.  The kernel does this in a lot of places,
and at 168 bytes on x86, it'd really be best if we were to dynamically
allocate these things.

However there are no locks in the request struct, so lockdep hasn't
worsened that part of the stack usage.

There could be lock-heavy automatically-allocated structs lurking all over
the place - the least path of resistance here is to require 8k stacks for
lockdep.

