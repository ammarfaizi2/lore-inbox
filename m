Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274944AbTHRU35 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274969AbTHRU35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:29:57 -0400
Received: from fep19-0.kolumbus.fi ([193.229.0.45]:36233 "EHLO
	fep19-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S274944AbTHRU3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:29:53 -0400
Date: Mon, 18 Aug 2003 23:29:51 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [BUG] slab debug vs. L1 alignement
In-Reply-To: <1061141263.2139.33.camel@fuzzy>
Message-ID: <Pine.LNX.4.56.0308182306320.2361@kai.makisara.local>
References: <1061141263.2139.33.camel@fuzzy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003, James Bottomley wrote:

...
> As far as I/O from user land goes (especially to tape), the users
> usually can work out the alignment constraints and act accordingly.  I'm
> agnostic as to whether we should fail (with an error indicating
> alignment problems) or rebuffer causing inefficiency in throughput in
> the misaligned case.
>
I think we should rebuffer so that we don't fail writes and reads that
other systems can do.

However, I am not so optimistic about the users aligning the buffers.
According to the info, glibc aligns at 8 bytes or 16 bytes (64 bit
architectures). I made st fail writes if the test

#define ST_DIO_ALIGN_OK(x) \
  (((unsigned long)(x) & (L1_CACHE_BYTES - 1)) == 0)

fails on the buffer address. With a P4 kernel the result was that tar to
tape failed ;-(

A solution would be to define the address test for user buffers based on
the configuration, for example:

#if defined(CONFIG_XXX)
#define ST_DIO_ALIGN_OK(x) \
  (((unsigned long)(x) & (L1_CACHE_BYTES - 1)) == 0)
#elif defined(CONFIG_YYY)
#define ST_DIO_ALIGN_OK(x) \
  (((unsigned long)(x) & 7) == 0)
#else
#define ST_DIO_ALIGN_OK(x) (1)
#endif

Of course, it would be better if this would be defined in a more general
place than st.c (some scsi header, dma-mapping.h, ... ?).

-- 
Kai
