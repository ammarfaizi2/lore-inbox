Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUIXCKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUIXCKB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUIWUit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:38:49 -0400
Received: from fmr12.intel.com ([134.134.136.15]:20924 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S266835AbUIWUZb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:31 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [arjanv@redhat.com: Re: [PATCH] shrink per_cpu_pages to fit 32byte cacheline]
Date: Thu, 23 Sep 2004 13:24:49 -0700
Message-ID: <7F740D512C7C1046AB53446D372001730249590A@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [arjanv@redhat.com: Re: [PATCH] shrink per_cpu_pages to fit 32byte cacheline]
Thread-Index: AcShhDWkzZZ25zopQ420HXJs2+AA4wAI5/Rw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Cc: <akpm@osdl.org>, <arjanv@redhat.com>, <ak@suse.de>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 23 Sep 2004 20:24:54.0584 (UTC) FILETIME=[63030B80:01C4A1AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com]
>Sent: Thursday, September 23, 2004 7:12 AM
>To: linux-kernel@vger.kernel.org
>Cc: Nakajima, Jun; akpm@osdl.org; arjanv@redhat.com; ak@suse.de
>Subject: [arjanv@redhat.com: Re: [PATCH] shrink per_cpu_pages to fit
32byte
>cacheline]
>
>
>Forgot to CC linux-kernel, just in case someone else
>can have useful information on this matter.
>
>Andi says any additional overhead will be in the noise
>compared to cacheline saving benefit.
>
>***********
>
>Jun,
>
>We need some assistance here - you can probably help us.
>
>Within the Linux kernel we can benefit from changing some fields
>of commonly accessed data structures to 16 bit instead of 32 bits,
>given that the values for these fields never reach 2 ^ 16.
>
>Arjan warned me, however, that the prefix (in this case "data16") will
>cause an additional extra cycle in instruction decoding, per message
above.

On the Pentium4 core, this is not a big deal because it runs out of the
trace cache (i.e. decoded in advance). However, on the Pentium III/M
(aka P6) core (i.e. Penitum III, Banias, Dothan, Yonah, etc.),
especially when an operand size prefix (0x66) changes the # of bytes in
an instruction (usually by impacting the size of an immediate in the
instruction), the P6 core pays unnegligible penalty, slowing down
decoding.

Jun

>
>Can you confirm that please? We can't seem to be able to find
>it in Intel's documentation.
>
>By shrinking two fields of "per_cpu_pages" structure we can fit it
>in one 32-byte cacheline (<= Pentium III and probably several other
>embedded/whatnot architectures will benefit from such a change).
>
>And we just shrank two fields of "struct pagevec" in a similar way
>in Andrew's -mm tree.
>
>I'm adding linux-kernel just in case someone else can have
>useful comments.
>
>Thanks.
>
>----- Forwarded message from Arjan van de Ven <arjanv@redhat.com> -----
>
>From: Arjan van de Ven <arjanv@redhat.com>
>Date: Tue, 14 Sep 2004 13:13:29 +0200
>To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
>Cc: akpm@osdl.org, "Martin J. Bligh" <mbligh@aracnet.com>,
>	linux-mm@kvack.org
>In-Reply-To: <20040914093407.GA23935@logos.cnet>
>Subject: Re: [PATCH] shrink per_cpu_pages to fit 32byte cacheline
>Original-Recipient: rfc822;linux-mm@kvack.org
>X-Loop: owner-majordomo@kvack.org
>X-MIMETrack: Itemize by SMTP Server on USMail/Cyclades(Release
>6.5.1|January 21, 2004) at
> 09/14/2004 03:13:02
>
>On Tue, Sep 14, 2004 at 06:34:07AM -0300, Marcelo Tosatti wrote:
>> How come short access can cost 1 extra cycle? Because you need two
"read
>bytes" ?
>
>on an x86, a word (2byte) access will cause a prefix byte to the
>instruction, that particular prefix byte will take an extra cycle
during
>execution
>of the instruction and potentially reduces the parallal decodability of
>instructions....
>
>
>
>----- End forwarded message -----
>
>----- End forwarded message -----
