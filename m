Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbSLGOen>; Sat, 7 Dec 2002 09:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbSLGOen>; Sat, 7 Dec 2002 09:34:43 -0500
Received: from h-64-105-35-2.SNVACAID.covad.net ([64.105.35.2]:47327 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262667AbSLGOem>; Sat, 7 Dec 2002 09:34:42 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 7 Dec 2002 06:37:00 -0800
Message-Id: <200212071437.GAA07864@adam.yggdrasil.com>
To: rmk@arm.linux.org.uk
Subject: Re: [RFC] generic device DMA implementation
Cc: david@gibson.dropbear.id.au, James.Bottomley@steeleye.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org, miles@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Dec 2002 11 Russell King wrote:
>On Sat, Dec 07, 2002 at 08:45:30PM +1100, David Gibson wrote:
>> Actually, no, since my idea was to remove the "consistent_alloc()"
>> path from the driver entirely - leaving only the map/sync approach.
>> That gives a result which is correct everywhere (afaict) but (as
>> you've since pointed out) will perform poorly on platforms where the
>> map/sync operations are expensive.

>As I've also pointed out in the past couple of days, doing this will
>mean that you then need to teach the drivers to align structures to
>cache line boundaries.  Otherwise, you _will_ get into a situation
>where you _will_ loose data.

	Drivers for such hardware would allocate their memory with
dma_alloc(...,DMA_CONSISTENT), which is what 99.9% of all current
drivers would do, indicating that the allocation should
fail if consistent memory is unavailable.

	David Gibson was describing a hypothetical platform which
would have both consistent and inconsistent meory but on which the
cache operations were so cheap that he thought it might be more
optimal to give inconsistent memory to those drivers that claimed
to be able to handle it.  (Ignore the question of whether that
really is optimal; let's assume David is right for the sake
of example.)  On such a platform, drivers that did not
claim to be able to handle inconsistent memory would still get
consistent memory (or get NULL).  The optimization that David has
in mind would only be done for drivers that claim to be able to
handle inconsistent memory.

>I would rather keep the consistent_alloc() approach for allocating
>consistent memory, and align structures as they see fit, rather than
>having to teach the drivers to align appropriately.  And you can be
>damned sure that driver writers are _not_ going to get the alignment
>right.

	Nobody is talking about eliminating the mechanism for a
driver to say "fail if you cannot give me consistent memory."
That would be the normal usage.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
