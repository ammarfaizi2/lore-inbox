Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTFGUib (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 16:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTFGUib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 16:38:31 -0400
Received: from holomorphy.com ([66.224.33.161]:41416 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263637AbTFGUia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 16:38:30 -0400
Date: Sat, 7 Jun 2003 13:50:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, colin@colina.demon.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Maximum swap space?
Message-ID: <20030607205046.GL20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
	colin@colina.demon.co.uk, linux-kernel@vger.kernel.org
References: <ltptlqb72n.fsf@colina.demon.co.uk> <33435.4.64.196.31.1055008200.squirrel@www.osdl.org> <20030607132432.26846b8a.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607132432.26846b8a.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 01:24:32PM -0700, Andrew Morton wrote:
> The limit is now 16 swapfiles/devices, because one pte bit got
> stolen for nonlinear VMA pte's.
> I'm not sure where the 2G limit comes from?

i386 has:
#define __swp_type(x)                   (((x).val >> 1) & 0x1f)
#define __swp_offset(x)                 ((x).val >> 8)
#define __swp_entry(type, offset)       ((swp_entry_t) { ((type) << 1) | ((offse
t) << 8) })
#define __pte_to_swp_entry(pte)         ((swp_entry_t) { (pte).pte_low })
#define __swp_entry_to_pte(x)           ((pte_t) { (x).val })

These limits could be slightly relaxed by the kernel with some slightly
more complex bit twiddlings to recover up to 6 bits of the lower byte
of a non-present PTE for 64 swapfiles. The limitation on size seems to
be in userspace.  It appears the kernel has 24 bits for offsets in 4KB
units, for up to something approaching 64GB swapfiles. Andi Kleen tells
me newer distributions have fixed the mkswap(8) userspace limitation.
So non-PAE x86 should be able to do 4TB of aggregate swapspace modulo
vmallocspace and/or ZONE_NORMAL exhaustion from swap maps. Also, PAE
should be able to do 64TB of aggregate swapspace (modulo vmallocespace)
since it has an additional 4 bits usage for page offsets. But I didn't
audit intensively, so some silly limits may be lurking in dark corners.

-- wli
