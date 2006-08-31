Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWHaQdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWHaQdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWHaQdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:33:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:61087 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932363AbWHaQdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:33:37 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,195,1154934000"; 
   d="scan'208"; a="118675172:sNHT949635666"
From: Jesse Barnes <jesse.barnes@intel.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: When to use mmiowb()?
Date: Thu, 31 Aug 2006 09:31:37 -0700
User-Agent: KMail/1.9.4
Cc: LKML <linux-kernel@vger.kernel.org>
References: <44F699CE.8050803@drzeus.cx>
In-Reply-To: <44F699CE.8050803@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608310931.37617.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 31, 2006 1:11 am, Pierre Ossman wrote:
> I'm been trying to wrap my head around all this memory barrier
> business, and I'm slowly grasping the inter-CPU behaviours. Barriers
> with regard to devices still has me a bit confused though.
>
> The deviceiobook document and memory-barriers.txt both make it clear
> that memory operations to devices are strictly ordered from a single
> CPU. When more CPUs are involved, things get a bit fuzzier.
> memory-barriers.txt seems to suggest that mmiowb() is only needed
> before an unlock under special circumstances, but deviceiobook states
> that mmiowb() should be used before all unlocks where the writeX():s
> aren't followed by a readX() (which would flush the writes anyway).
>
> Grepping the tree indicates that mmiowb() isn't used that often, but
> according to deviceiobook, they should be plentiful. This leads me to
> believe that memory-barriers.txt is closer to the truth, but then the
> question is what those special cirumstances that require mmiowb() are.

AFAICT, they're both right.  Generally, mmiowb() should be used prior to 
unlock in a critical section whose last PIO operation is a writeX.

You're right though: for portability, many more drivers should use this 
type of barrier.  However, rather than doing an audit of the tree and 
inserting mmiowb() everywhere (w/o testing it), we chose to add it on an 
as-needed basis for drivers that run on platforms that have weak I/O 
ordering.  Feel free to add it in other places if you want though (esp. 
if you have the hardware to test your changes).

Jesse
