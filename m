Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWISSDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWISSDH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWISSDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:03:07 -0400
Received: from smtp-out.google.com ([216.239.45.12]:13723 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750824AbWISSDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:03:05 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=Qz5vYul/T9ePum7W2mC+UK65IpYuGxNUEpo1EffSpnS3mI5Lueb1h33rxInSaKYjH
	cClnqRCfxoN1lbMEvgepA==
Message-ID: <4510308A.1070401@google.com>
Date: Tue, 19 Sep 2006 11:01:46 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: prasanna@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919175405.GC26339@Krystal>
In-Reply-To: <20060919175405.GC26339@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> * Martin Bligh (mbligh@google.com) wrote:
> 
>>How about we combine all three ideas together ...
>>
>>1. Load modified copy of the function in question.
>>2. overwrite the first instruction of the routine with an int3 that
>>does what you say (atomically)
>>3. Then overwrite the second instruction with a jump that's faster
>>4. Now atomically overwrite the int3 with a nop, and let the jump
>>take over.
>>
> 
> 
> Very good idea.. However, overwriting the second instruction with a jump could
> be dangerous on preemptible and SMP kernels, because we never know if a thread
> has an IP in any of its contexts that would return exactly at the middle of the
> jump. I think it would be doable to overwrite a 5+ bytes instruction with a NOP
> non-atomically in all cases, but as the instructions nin the prologue seems to
> be smaller :
> 
> prologue on x86
>    0:   55                      push   %ebp
>    1:   89 e5                   mov    %esp,%ebp
> epilogue on x86
>    3:   5d                      pop    %ebp
>    4:   c3                      ret
> 
> Then is can be a problem. Ideas are welcome.

Ugh, yes that's somewhat problematic. It does seem rather unlikely that
there's a function call in the function prologue when we're busy 
offloading stuff onto the stack, but still ...

For the cases where we're prepared to overwrite the call instruction in
the caller, rather than insert an extra jump in the callee, can we not
do that atomically by overwriting the address we're jumping to (the
call is obviously there already)? Doesn't fix function pointers, etc,
but might work well for the simple case at least.

M.
