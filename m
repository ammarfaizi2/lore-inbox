Return-Path: <linux-kernel-owner+w=401wt.eu-S932555AbWLLW5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWLLW5j (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWLLW5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:57:39 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54156 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932555AbWLLW5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:57:38 -0500
Date: Tue, 12 Dec 2006 14:57:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Kyle Moffett <mrmacman_g4@mac.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Mach-O binary format support and Darwin syscall personality
 [Was: uts banner changes]
In-Reply-To: <1165963139.11914.93.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0612121451570.3535@woody.osdl.org>
References: <457D750C.9060807@shadowen.org>  <20061211163333.GA17947@aepfle.de>
  <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> 
 <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org>  <20061211180414.GA18833@aepfle.de>
 <20061211181813.GB18963@aepfle.de>  <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
  <320BD259-74D6-411F-82A4-4BF3CB15012F@mac.com>  <Pine.LNX.4.64.0612120815550.6452@woody.osdl.org>
  <D571C4CB-3D52-446C-802E-024C4C333562@mac.com>  <Pine.LNX.4.64.0612121008490.3535@woody.osdl.org>
  <0B8F288E-4FCD-409E-9BA2-C524CF31E9A3@mac.com> <1165963139.11914.93.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2006, Benjamin Herrenschmidt wrote:
> 
> > Secondly, is there a preferred existing field into which I should  
> > stick said flag or just stuff it somewhere?
> 
> Yes, thread_info->flags.

Well, it may actually make sense to actually stick the whole "syscall 
table pointer" in there, rather than a flag that says which pointer to 
choose.

We already load the thread_info pointer because we need the flags for 
syscall tracing, and since we have the thread_info pointer, it might be 
easier to load the syscall table pointer right off there, rather than 
loading it as a big constant with "lis + ori" (in fact, on ppc64, we 
currently load it off the TOC, which is really sad, since we already 
brought in the thread_info into the cache, and usign the TOC is not just a 
load, it's a load off a separate cacheline).

So on 64-bit ppc, it could actually speed things up to put the system call 
table pointer into thread_info, and make it more flexible at the same 
time, without any conditional flags.

		Linus
