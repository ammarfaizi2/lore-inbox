Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVCXXUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVCXXUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 18:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVCXXUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 18:20:53 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:63387
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261238AbVCXXUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:20:37 -0500
Date: Thu, 24 Mar 2005 15:13:50 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: davidm@hpl.hp.com, ak@muc.de, clameter@sgi.com,
       vda@port.imtp.ilyichevsk.odessa.ua, haveblue@us.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, mel@csn.ul.ie, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher
 order
Message-Id: <20050324151350.5801ee10.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0503241449070.7119@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com>
	<200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
	<200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com>
	<20050318192808.GB38053@muc.de>
	<16963.2075.713737.485070@napali.hpl.hp.com>
	<Pine.LNX.4.58.0503241038040.5663@schroedinger.engr.sgi.com>
	<20050324110336.488241c4.davem@davemloft.net>
	<Pine.LNX.4.58.0503241449070.7119@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 14:49:55 -0800 (PST)
Christoph Lameter <clameter@engr.sgi.com> wrote:

> On Thu, 24 Mar 2005, David S. Miller wrote:
> 
> > > prep_zero_page would use a temporal clear for an order 0 page but a
> > > nontemporal clear for higher order pages.
> >
> > That sounds about right to me.
> >
> > Hmmm, I'm inspired to experiment with this on sparc64 a bit.
> 
> Could you help me fix up this patch replacing the old clear_pages patch?

Sure, I'll play with it.

Meanwhile, here are some numbers.  I changed just the clear_page()
implementation on sparc64 so that it used prefetching and normal
temporal stores.  The machine is a uniprocessor 1.5Ghz Ultra-IIIi,
64K write-through D-cache, 64K I-cache, 1MB L2 cache.  I did 4
timed 'vmlinux' builds after a fresh boot:

BEFORE:
real	9m8.720s
user	8m28.345s
sys	0m32.734s

real	9m2.034s
user	8m28.763s
sys	0m32.512s

real	9m1.848s
user	8m28.970s
sys	0m32.204s

real	9m1.701s
user	8m28.715s
sys	0m32.394s

AFTER:
real	9m2.241s
user	8m16.633s
sys	0m36.451s

real	8m53.739s
user	8m17.165s
sys	0m36.052s

real	8m54.089s
user	8m17.266s
sys	0m36.219s

real	8m54.071s
user	8m17.473s
sys	0m36.073s

So, at the very least, my results agree with D. Mosberger's on IA64.

At the cost of ~4 seconds of system time, we gain ~11 seconds of
user time.

I'm pretty much convinced this is a win.  I wonder if it matters to
do something similar for copy_page*() as well.
