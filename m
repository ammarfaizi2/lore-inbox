Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbUDAVBq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUDAVBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:01:46 -0500
Received: from faui10.informatik.uni-erlangen.de ([131.188.31.10]:48322 "EHLO
	faui10.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S263165AbUDAVBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:01:42 -0500
From: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
Message-Id: <200404012101.XAA23775@faui1d.informatik.uni-erlangen.de>
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
To: ak@suse.de (Andi Kleen)
Date: Thu, 1 Apr 2004 23:01:39 +0200 (CEST)
Cc: dan@debian.org (Daniel Jacobowitz), weigand@i1.informatik.uni-erlangen.de,
       gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
In-Reply-To: <20040401224604.5c3b45ff.ak@suse.de> from "Andi Kleen" at Apr 01, 2004 10:46:04 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Thu, 1 Apr 2004 15:39:23 -0500
> Daniel Jacobowitz <dan@debian.org> wrote:
> > > 
> > 
> > (I haven't tested anything but...) why should this fix it?  Ulrich's
> > problem happens when the .o file is flushed from the cache, and then
> > stat'd; it now appears to be older than the .c file.  With a change to
> > round up instead, if the .c file is flushed from the cache before the
> > .o, the .c will still suddenly appear to be newer than the .o.
> 
> That is what he wants I think. It's logically just like taking a bit longer. 

Not really.  I have two files generated in sequence:

  .c at 08:12:23.1
  .o at 08:12:23.2

As long as the .o stays more recent than the .c, everything is fine.
With the current code, this breaks if the .o file is flushed and
re-read, while the .c file stays in cache:

  .c at 08:12:23.1
  .o at 08:12:23.0  (oops, suddenly in need of rebuild)

With your suggested change, it will break if the .c file is flushed
while the .o file stays in cache (as Daniel pointed out):

  .c at 08:12:24.0
  .o at 08:12:23.1  (oops, suddenly in need of rebuild)

Both lead to the same type of problem.

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
