Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269664AbTHOQOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269646AbTHOQNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:13:55 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269664AbTHOQKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:10:00 -0400
Subject: [BUG] slab debug vs. L1 alignement
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060956004.581.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Aug 2003 16:00:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when enabling slab debugging, we lose the property of
having the objects aligned on a cache line size.

This is, imho, an error, especially if GFP_DMA is passed. Such an
object _must_ be cache alined (and it's size rounded to a multiple
of the cache line size).

There is a simple performance reason on cache coherent archs, but
there's also the fact that it will just _not_ work properly on
non cache-coherent archs. Actually, I also have to deal with some
old machines who have a SCSI controller who has a problem accessing
buffers that aren't aligned on a cache line size boundary.

This is typically causing me trouble in various parts of SCSI which
abuses kmalloc(512, GFP_KERNEL | GFP_DMA) for buffers passed to some
SCSI commands, typically "utility" commands used to read a disk
capacity, read read/write protect flags, some sense buffers, etc...

While I know SCSI shall use the consistent alloc things, it has not
been fully fixed yet and kmalloc with GFP_DMA is still valid despite
not beeing efficient, so we should make sure in this case, the returned
buffer is really suitable for DMA, that is cache aligned.

Ben.

