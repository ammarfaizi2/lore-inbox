Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317079AbSEXL4n>; Fri, 24 May 2002 07:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317125AbSEXL4m>; Fri, 24 May 2002 07:56:42 -0400
Received: from wiproecmx2.wipro.com ([164.164.31.6]:8609 "EHLO
	wiproecmx2.wipro.com") by vger.kernel.org with ESMTP
	id <S317079AbSEXL4l>; Fri, 24 May 2002 07:56:41 -0400
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: <dipankar@in.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, "Rusty Russell" <rusty@rustcorp.com.au>,
        "Paul McKenney" <paul.mckenney@us.ibm.com>,
        <lse-tech@lists.sourceforge.net>
Subject: RE: [Lse-tech] Re: [RFC] Dynamic percpu data allocator
Date: Fri, 24 May 2002 17:29:28 +0530
Message-ID: <AAEGIMDAKGCBHLBAACGBOELDCJAA.balbir.singh@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-e6e4ff64-5700-4144-bbab-6efecd8a8e9d"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <20020524144301.D11249@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-e6e4ff64-5700-4144-bbab-6efecd8a8e9d
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks, when I ment CPU local memory on SMP, I ment CPU cache.
Sorry for the confusion. I think your dynamic allocator makes
sense.

Balbir

|
|On Fri, May 24, 2002 at 02:08:50PM +0530, BALBIR SINGH wrote:
|> 
|> Sure, I understand what you are talking about now. That makes a lot
|> of sense, I will go through your document once more and read it.
|> I was thinking of the two combined (allocating CPU local memory
|> for certain data structs also includes allocating one copy per CPU).
|> Is there a reason to delay the implementation of CPU local memory,
|> or are we waiting for NUMA guys to do it? Is it not useful in an
|> SMP system to allocate CPU local memory?
|
|In an SMP system, the entire memory is equidistant from the CPUs.
|So, any memory that is exclusively accessed by once cpu only
|is CPU-local. On a NUMA machine however that isn't true, so
|you need special schemes.
|
|The thing about one-copy-per-cpu allocator that I describe is that
|it interleaves per-cpu data to save on space. That is if you
|allocate per-cpu ints i1, i2, it will be laid out in memory like this -
|
|   CPU #0          CPU#1
|
| ---------       ---------         Start of cache line
|   i1              i1
|   i2              i2 
|
|   .               .
|   .               .
|   .               .
|   .               .
|   .               .
|
| ---------       ----------        End of cache line
|
|The per-cpu copies of i1 and i2 for CPU #0 and CPU #1 are allocated from 
|different cache lines of memory, but copy of i1 and i2 for CPU #0 are
|in the same cache line. This interleaving saves space by avoiding
|the need to pad small data structures to cache line sizes.
|This essentially how the static per-cpu data area in 2.5 kernel
|is laid out in memory. Since copies for CPU #0 and CPU #1 for
|the same variable are on different cache lines, assuming that
|code that accesses "this" CPU's copy will not result in cache line
|bouncing. On an SMP machine, I can allocate the cache lines
|for different CPUs, where the interleaved data structures are
|laid out, using the slab allocator. On a NUMA machine however,
|I would want to make sure that cache line allocated for this
|purpose for CPU #N is closest possible to CPU #N.
|
|
|Thanks
|-- 
|Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
|Linux Technology Center, IBM Software Lab, Bangalore, India.
|-
|To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
|the body of a message to majordomo@vger.kernel.org
|More majordomo info at  http://vger.kernel.org/majordomo-info.html
|Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPartTM-000-e6e4ff64-5700-4144-bbab-6efecd8a8e9d
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer************************************

Information contained in this E-MAIL being proprietary to Wipro Limited is 
'privileged' and 'confidential' and intended for use only by the individual
 or entity to which it is addressed. You are notified that any use, copying 
or dissemination of the information contained in the E-MAIL in any manner 
whatsoever is strictly prohibited.

***************************************************************************

------=_NextPartTM-000-e6e4ff64-5700-4144-bbab-6efecd8a8e9d--
