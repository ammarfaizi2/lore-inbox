Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751561AbWJFQLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWJFQLi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWJFQLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:11:38 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:34387 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751560AbWJFQLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:11:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=EUrNJwRFePIyD2KCO3sPKiGryo59hWLjV3gjNEhbqq5M/j1JI5XFVrYFb0mXJDqdRComSF+7Ohk80Ml7crBetEhJvZdmKYX90IAjRLyw2/qOYNBMdtLjNQjCPU4F2ZgQolFjZ5eftZOjCkJLMk/wnuv1cfkWKDt72CfmnsRDk68=
Reply-To: andrew.j.wade@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Date: Fri, 6 Oct 2006 12:11:27 -0400
User-Agent: KMail/1.9.1
Cc: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       tim.c.chen@linux.intel.com, "Jeremy Fitzhardinge" <jeremy@goop.org>,
       herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
References: <B41635854730A14CA71C92B36EC22AAC3F3FBA@mssmsx411> <20061005143748.2f6594a2.akpm@osdl.org>
In-Reply-To: <20061005143748.2f6594a2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610061211.30184.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 17:37, Andrew Morton wrote:
> 
> So how's this look?
> 
> I worry a bit that someone's hardware might go and prefetch that static
> variable even when we didn't ask it to.  Can that happen?

     Branch mispredictions might cause spurious fetches. But the
unlikely() should take care of that for the (presumably common)
!__warned case.

> ...
> 
> It would seem logical to mark the static variable as __read_mostly too. But  
> it would be wrong, because that would put it back into the vmlinux image, and
> the kernel will never read from this variable in normal operation anyway. 

And if that's the case they should probably be in amongst write-hot
variables so as to reduce cache-line ping-ponging. __read_mostly should
probably be called __read_hot_write_cold, see
http://lkml.org/lkml/2006/6/26/290 .

> Unless the compiler or hardware go and do some prefetching on us?

The compiler doesn't, at least not GCC 4. I wouldn't expect it to
hoist loads out of non-loop blocks.

> For some reason this patch shrinks softirq.o text by 40 bytes.

The compiler optimizes out __ret_warn_once; it didn't do that before.

The patch looks good to me, though I am still baffled as to why the
cache misses were occurring.

Andrew Wade
