Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVLPHq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVLPHq6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 02:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVLPHq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 02:46:58 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59864 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932171AbVLPHq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 02:46:58 -0500
Date: Thu, 15 Dec 2005 23:46:26 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: Keith Owens <kaos@sgi.com>
Cc: paulmck@us.ibm.com, Andi Kleen <ak@suse.de>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
Message-ID: <20051216074626.GB201289@sgi.com>
References: <20051213162027.GA14158@us.ibm.com> <17158.1134512861@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17158.1134512861@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier got this right.  The purpose of the mmiowb is
to ensure that writes to I/O devices while holding a spinlock
are ordered with respect to writes issued after the original
processor releases and a second processor acquires said
spinlock.

A MMIO read would be sufficient, but is much heavier weight.

On the SGI MIPS-based systems, the "sync" instruction was used.
On the Altix systems, a register on the hub chip is read.

>From comments by jejb, we're looking at modifying the mmiowb
API by adding an argument which would be a register to read
from if the architecture in question needs ordering in this
way but does not have a lighter weight mechanism like the Altix
mmiowb.  Since there will now need to be a width indication,
mmiowb will be replaced with mmiowb[bwlq].

jeremy
