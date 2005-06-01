Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVFAGXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVFAGXX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 02:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVFAGXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 02:23:23 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:2756 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261291AbVFAGXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 02:23:16 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@muc.de>
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
Date: Wed, 1 Jun 2005 09:22:48 +0300
User-Agent: KMail/1.5.4
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20050530181626.GA10212@kvack.org> <20050531092358.GA9372@muc.de> <20050531135959.GA16081@kvack.org>
In-Reply-To: <20050531135959.GA16081@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506010922.48521.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 May 2005 16:59, Benjamin LaHaise wrote:
> On Tue, May 31, 2005 at 11:23:58AM +0200, Andi Kleen wrote:
> > fork is only a corner case. The main case is a process allocating
> > memory using brk/mmap and then using it.

I did the tests. I confirm Andi's conclusion that
if you are going to use cleared/copied page immediately,
nt stores are a loss.

However...
 
> At least for kernel compiles, using non-temporal stores is a slight 
> win (a 2-5s improvement on 4m30s).  Granted, there seems to be a 
> lot of variation in kernel compile times.
> 
> A bit more experimentation shows that non-temporal stores plus a 
> prefetch of the resulting data is still better than the existing 
> routines and only slightly slower than the pure non-temporal version.  
> That said, it seems to result in kernel compiles that are on the high 
> side of the variations I normally see (4m40s, 4m38s) compared to the 
> ~4m30s for an unpatched kernel and ~4m25s-4m30s for the non-temporal 
> store version.

My kernel compiles took ~5000000 page clears and ~300000 page copies.

slow (rep stosd/rep movsd), three runs:
real    12m47.530s
user    11m24.523s
sys     1m17.868s

real    12m45.362s
user    11m24.708s
sys     1m18.286s

real    12m45.152s
user    11m25.030s
sys     1m17.985s

mmx_APn/APN (mmx page clear, mmx page copy with nt stores):
real    12m41.737s
user    11m26.104s
sys     1m12.126s

real    12m40.753s
user    11m26.512s
sys     1m11.185s

mmx_APN  (mmx page clear with nt stores, mmx page copy with nt stores):
real    12m37.913s
user    11m30.376s
sys     1m4.622s

My kernel compiles on Athlon 2000 MHz were faster too.
--
vda

