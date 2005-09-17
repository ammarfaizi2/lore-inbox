Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVIQBPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVIQBPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 21:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVIQBPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 21:15:39 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:31626 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750803AbVIQBPj (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 21:15:39 -0400
Date: Sat, 17 Sep 2005 03:15:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
In-Reply-To: <4328D39C.2040500@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0509170300030.3743@scrub.home>
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au>
 <Pine.LNX.4.61.0509141814220.3743@scrub.home> <43285374.3020806@yahoo.com.au>
 <Pine.LNX.4.61.0509141906040.3728@scrub.home> <20050914230049.F30746@flint.arm.linux.org.uk>
 <Pine.LNX.4.61.0509150010100.3728@scrub.home> <20050914232106.H30746@flint.arm.linux.org.uk>
 <4328D39C.2040500@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Sep 2005, Nick Piggin wrote:

> Roman: any ideas about what you would prefer? You'll notice
> atomic_inc_not_zero replaces rcuref_inc_lf, which is used several times
> in the VFS.

In the larger picture I'm not completely happy with these scalibilty 
patches, as they add extra overhead at the lower end. On a UP system in 
general nothing beats:

	spin_lock();
	if (*ptr)
		ptr += 1;
	spin_unlock();

The main problem is here that the atomic functions are used in two basic 
situation:

1) interrupt synchronization
2) multiprocessor synchronization

The atomic functions have to assume both, but on UP systems it often is 
a lot cheaper if they don't have to synchronize with interrupts. So 
replacing a spinlock with a few atomic operations can hurt UP performance.

bye, Roman
