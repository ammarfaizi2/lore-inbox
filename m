Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVCUPb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVCUPb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVCUPb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:31:56 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:53509 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261820AbVCUPan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:30:43 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andi Kleen <ak@muc.de>, Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher order
Date: Mon, 21 Mar 2005 17:30:29 +0200
User-Agent: KMail/1.5.4
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0503180652350.15022@schroedinger.engr.sgi.com> <20050318192808.GB38053@muc.de>
In-Reply-To: <20050318192808.GB38053@muc.de>
MIME-Version: 1.0
Message-Id: <200503200220.57430.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ViuPCWK3mckm+uW"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ViuPCWK3mckm+uW
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 18 March 2005 21:28, Andi Kleen wrote:
> On Fri, Mar 18, 2005 at 07:00:06AM -0800, Christoph Lameter wrote:
> > On Fri, 18 Mar 2005, Denis Vlasenko wrote:
> > 
> > > NT stores are not about 5% increase. 200%-300%. Provided you are ok with
> > > the fact that zeroed page ends up evicted from cache. Luckily, this is exactly
> > > what you want with prezeroing.
> > 
> > These are pretty significant results. Maybe its best to use non-temporal
> 
> The differences are actually less. I do not know what Denis benchmarked,
> but in my tests the difference was never more than ~10%.  He got a zero
> too much? 

No. See attached.

# gcc -O2 0main.c
# ./a.out
Page clear/copy benchmark program.
buffer size: 1 Mb
Each test tried 64 times, max and min CPU cycles per page are reported.
Please disregard max values. They are due to system interference only.
clear_page() tests:
               normal_clear_page - took 44214 max,12615 min cycles per page
               normal_clear_page - took 18969 max,12649 min cycles per page
             repstosl_clear_page - took 19897 max,12655 min cycles per page
                 movq_clear_page - took 39391 max,10782 min cycles per page
               movntq_clear_page - took 21612 max, 4779 min cycles per page

copy_page() tests:
....

I'm basically saying that 'microbenchmark-visible'
performance of NT stores is 200-300% higher than 'normal' stores.

BTW: cache eviction is not an intrisic property of non-temporal
stores. It's merely how they're implemented in current CPUs:
if NT stores hit cached line, invalidate it and
push stores to bus. Else just push stores to bus
without reading cacheline from RAM first.

It is possible that some future CPU won't evict cacheline
if NT stores happened to hit it: "if NT stores hit cached line,
MODIFY it and push stores to bus".
--
vda

--Boundary-00=_ViuPCWK3mckm+uW
Content-Type: application/x-tbz;
  name="page_asm.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="page_asm.tar.bz2"

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
OFCQ4WtORg==

--Boundary-00=_ViuPCWK3mckm+uW--

