Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267715AbSLGEJ4>; Fri, 6 Dec 2002 23:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267716AbSLGEJ4>; Fri, 6 Dec 2002 23:09:56 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:13739 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267715AbSLGEJy>; Fri, 6 Dec 2002 23:09:54 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 6 Dec 2002 20:12:57 -0800
Message-Id: <200212070412.UAA07362@adam.yggdrasil.com>
To: davem@redhat.com
Subject: Re: [RFC] generic device DMA implementation
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       willy@debian.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The question of flags versus an extra procedure name is not
actually that big of a deal to me.  I can live with either approach
for dma_alloc.  However, I'll explain what I see as advantages of
using a flags parameter for others to consider (or to tell me where
they think I'm wrong or haven't thought of something).

On Fri, 06 Dec 2002, David S. Miller wrote:
> I don't want a 'flags' thing, because that tends to be the action
> which opens the flood gates for putting random feature-of-the-day new
> bits.

	It is possible to overuse any extension mechanism.  I think
you've made a general argument against extension mechanisms that is
usually not true in practice, at least in Linux.  I think simple
extension mechanisms, like having a flag word in this case when we
need to express a choice between two options anyhow, tend to do more
good than harm on average, even when I think about most egregious
cases like filesystems.  Maybe if I could see an example or two
extension mechanisms that have a net negative impact in your opinion,
I'd better understand.


> If you have to actually get a real API change made, it will get review
> and won't "sneak on in"

	Or Linux just won't get that optimization because people give
up or leave their changes on the back burner indefinitely, something
that I think happens to most Linux improvements, especially if you
count those that don't make it to implementation because people
correctly forsee this kind of bureaucracy.  If anyone does decide to
propose another flag-like facility for dma_alloc, I expect people will
complain that changing the API may require hundreds of drivers to be
updated.

	I did think about the possibility of a flags parameter
inviting features that aren't worth their complexity or other costs
before I suggested a flags parameter.  My view was and is that if
people handling individual architectures want to add and remove flags
bits, even just to experiment with features, I think the existing
process of getting patches integrated would cause enough review.  I
also think our capacity to process changes is already exceeded by
voluntary submissions as evidenced by backlogs and dropped patches.


> I also don't want architectures adding arch
> specific flag bits that some drivers end up using, for example.

	Here I'm guessing at your intended meaning.  If you mean that
there will be numbering collisions, I would expect these flags to be
defined in include/asm-xxx/dma-mapping.h.  I was going to suggest that
we even do this for DMA_ALLOW_INCONSISENT.
include/asm-parisc/dma-mapping.h would contain:

#define DMA_ALLOW_INCONSISTENT 	0x1

linux/dma-mapping.h would contain:

#include <asm/dma-mapping.h>
#ifndef DMA_ALLOW_INCONSISTENT
# define DMA_ALLOW_INCONSISTENT		0
#endif

	By that convention, bits would not be used in architectures
that never set them, and it could conceivably simplify some compiler
optimizations like "flags |= DMA_SOME_FLAG;" and
"if (flags & DMA_SOME_FLAG) {....}" on architectures where this is never
true.  Bit assignment would be under the control of the platforms, at
least in the absense of a flag that is meaningful on every platform (if
there were one, it would just simplify the source code to define it only
in linux/dma-mapping.h).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
