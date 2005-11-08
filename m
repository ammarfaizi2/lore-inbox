Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbVKHPZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbVKHPZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 10:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVKHPZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 10:25:38 -0500
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:2389 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S964897AbVKHPZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 10:25:37 -0500
X-SBRSScore: None
X-IronPort-AV: i="3.97,304,1125871200"; 
   d="scan'208"; a="19308458:sNHT23862332"
Message-ID: <4370C36E.2040205@fujitsu-siemens.com>
Date: Tue, 08 Nov 2005 16:25:34 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
CC: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org, Allan Graves <allan.graves@oracle.com>
Subject: Re: [uml-devel] [PATCH 8/10] UML - Maintain own LDT entries
References: <200510310439.j9V4dfbw000872@ccure.user-mode-linux.org> <200511022051.24335.blaisorblade@yahoo.it> <436F469B.3080607@fujitsu-siemens.com> <200511072028.23111.blaisorblade@yahoo.it>
In-Reply-To: <200511072028.23111.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade wrote:
> On Monday 07 November 2005 13:20, Bodo Stroesser wrote:
> 
>>Blaisorblade wrote:
>>
>>>On Monday 31 October 2005 05:39, Jeff Dike wrote:
>>>
>>>>From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
> 
> 
>>>Or at least so I think (I must still give a proper look afterwards, and
>>>I'll post patches). Actually it seems that this is done on purpose, but I
>>>don't agree too much on this. I will see.
> 
> 
>> From the beginning my new code for SKAS included the checks/buffering you
>>later inserted for TT and SKAS. So this patch is a second version adapted
>>to your changes. It shifts your improvements into TT path only (where I
>>didn't do any changes in my old patch), while it uses my own stuff for
>>SKAS. Thus the patch doesn't really revert your improvements, but restricts
>>it to TT. As in SKAS0 UML now holds its own LDT data, there is no need for
>>buffering in this case. So I think it makes sense to have separate code for
>>SKAS.
> 
> Yep, ok - I'm undecided about the new code for SKAS3, but it may make sense 
> (i.e. no opinion).
> 
> Instead, I have another question: is there a proper reason for using the 
> processor format for storing the info and translating it back to (struct 
> user_desc)? I am planning to avoid this double translation because I don't 
> like it. Any opinion?

In my opinion there is no reason to change the current implementation for SAKS3/0.
Note: if someone reads LDT via [sys_]modify_ldt(), he will receive the requested
data in "processor format", that is LDT-descriptors. He will receive a list of
descriptors starting at the first descriptor of the LDT, thus no entry number is
needed in the enties.
The only case that uses user_desc is when writing one desriptor via modify_ldt().
modify_ldt(WRITE) exactly writes one LDT-descriptor, so user_desc must contain
the number of the entry to write. Thus user_desc is bigger than LDT descriptor.
It also uses an other data layout resulting in double the size of LDT-descriptor.
So I think it doesn't make sense to store user_desc. We save memory storing the
resulting LDT-descriptors, which then are copied transparently on modify_ldt(READ).
Conversion between user_desc and LDT-entry is done on modify_ldt(WRITE) in SKAS0
only. No other conversions are done in UML.

	Bodo
