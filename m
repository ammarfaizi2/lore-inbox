Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTEIOOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 10:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbTEIOOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 10:14:20 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:11991 "EHLO
	mwinf0603.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262116AbTEIOOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 10:14:18 -0400
Message-ID: <3EBBD861.5070404@wanadoo.fr>
Date: Fri, 09 May 2003 16:33:37 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: paubert <paubert@iram.es>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andi Kleen <ak@suse.de>, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] Mask mxcsr according to cpu features.
References: <20030509004200.A22795@mrt-lx16.iram.es> <3EBB4B60.4080905@wanadoo.fr> <20030509104843.A16311@mrt-lx16.iram.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

paubert wrote:
> On Fri, May 09, 2003 at 06:32:00AM +0000, Philippe Elie wrote:
> 


>>>+/* mxcsr bits 31-16 must be zero for security reasons,
>>>+ * bit 6 depends on cpu features.
>>>+ */
>>>+#define MXCSR_MASK (cpu_has_sse2 ? 0xffff : 0xffbf)
>>>+
>>>+
>>
>>I don't think daz bit depend on sse2, it's a separate features
> 
> 
> The doc I have state in several places:
> "The denormals-are-zeros mode was introduced in the Pentium 4 processor 
> with the SSE2 extensions."
> 
> Maybe I should download a newer doc from Intel. The one I have states
> that DAZ is associated with sse2, and does not speak at _all_ of the 
> MXCSR_MASK field (I have seen it in my x86_64 doc though).

the doc is not very clear, I see this in 11.6.3

"The denormal-are-zeo flag in MXCSR was introduced in later Pentium
4 processor and in the Intel Xeon processor"


> So the question is, are there processors in the wild which have DAZ but
> still clear the MXCSR_MASK field?


Not for intel at least since they advocate to use the mask as
a "is this feature present" and use mask 0xFFBF if mask == 0
and since this bits was required to be zero I think it's safe.
The only problem we can get is an old processor which write non
zero but random bits in the 16 upper bits.


> It's simply a matter of rewriting the MXCSR_MASK macro, but to avoid
> a conditional, I'd rather have a global mxcsr_mask variable somewhere
> with the cpu feature flags. 


my documentation says to fxsave and get the features mask from
the mxcsr mask but to fall back to 0xffbf if mask == 0, quoting
docs 11.6.6:

1 setup a fxsave area
2 clear this area
3 fxsave in this area
4 if mxcsr == 0 use mask 0xffbf else use mxcsr mask

"All bits set to 0 in this mask indicate reserved bits in
the mxcsr register. Thus, if this mask value is AND'd with
a value to be written in the MXCSR register, the resulting
value will be assured of having all its reserved bits set
to 0, preventing the possibility of a general protection
exception being generated when the value is written to the
MXCSR register"

then the documentation show an example using this mechanism
for daz flag and add the following note:

"Note than all bits in the MXCSR_MASK value are set to 1 indicate
features supported byt the MXCSR register; so the bits in the
MXCSR_MASK can also treated as a features flags for identifying
processor capabilities"

regards,
Phil


