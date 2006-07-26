Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWGZJzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWGZJzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 05:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWGZJzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 05:55:51 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:65477 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750743AbWGZJzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 05:55:50 -0400
Date: Wed, 26 Jul 2006 12:55:48 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <20060726084921.GB9592@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.58.0607261251530.17557@sbz-30.cs.Helsinki.FI>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
 <20060722162607.GA10550@osiris.ibm.com> <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com>
 <20060723073500.GA10556@osiris.ibm.com> <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com>
 <20060723162427.GA10553@osiris.ibm.com> <20060726084921.GB9592@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Wed, 26 Jul 2006, Heiko Carstens wrote:
> Since I didn't get an ACK or NACK, I split this patch into two very small
> ones and repost them. Hopefully with a better description than the first
> time.

I don't see ARCH_SLAB_MINALIGN defined for s390, what's up with that? I 
agree that we should always respect ARCH_SLAB_MINALIGN no matter what. 
Does the included patch fix that for you?

				Pekka

[PATCH] slab: respect mandated minimum architecture alignment

The slab debugging code for SLAB_RED_ZONE and SLAB_STORE_USER require 
BYTES_PER_WORD alignment for the caches. However, for some architectures, 
the mandated minimum alignment might be bigger than that, so disable 
debugging for those cases instead of crashing the machine.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

diff --git a/mm/slab.c b/mm/slab.c
index 0f20843..0346311 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2123,6 +2123,13 @@ #endif
 #if DEBUG
 	cachep->obj_size = size;
 
+	/*
+	 * Debugging requires BYTES_PER_WORD alignment but we must always
+	 * respect ARCH_SLAB_MINALIGN so disable debugging if necessary.
+	 */
+	if (ARCH_SLAB_MINALIGN > BYTES_PER_WORD)
+		flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
+
 	if (flags & SLAB_RED_ZONE) {
 		/* redzoning only works with word aligned caches */
 		align = BYTES_PER_WORD;
