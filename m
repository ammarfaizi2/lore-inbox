Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVJMTyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVJMTyo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbVJMTyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:54:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49830 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932169AbVJMTym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:54:42 -0400
Date: Thu, 13 Oct 2005 12:54:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Licquia <licquia@progeny.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.13: POSIX violation in pipes on ia64 for kernels >
 2.6.10
In-Reply-To: <1129232675.4573.18.camel@laptop1>
Message-ID: <Pine.LNX.4.64.0510131250070.23590@g5.osdl.org>
References: <1129232675.4573.18.camel@laptop1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Oct 2005, Jeff Licquia wrote:
>
> On architectures where PAGE_SIZE > PIPE_BUF, a read of PIPE_BUF bytes
> from a full pipe does not change the pipe's write state.  This behavior
> is different from kernels 2.6.9 and earlier, and it triggers failures of
> the LSB tests.  

Sounds like the tests are broken.

It also sounds like your patch is broken: allowing partial short writes is 
in explicit violation of the POSIX specs, and breaks the only thing that 
PIPE_BUF _really_ guarantees, namely that writes smaller than that size 
must be atomic.

The _only_ guarantees wrt PIPE_BUF is literally that a write smaller than 
or equal to the PIPE_BUF will always either complete fully or not at all, 
and that a reader will see the write as an atomic packet (ie two writers 
will never have their write buffers interleaved within such a single 
"write()" system call).

How empty the pipe has to be for a write to be able to do so is outside 
the spec, and any code (including LSB tests) that depends on it is broken.

			Linus
