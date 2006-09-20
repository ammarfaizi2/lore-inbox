Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWITTm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWITTm2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWITTm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:42:28 -0400
Received: from smtp-out.google.com ([216.239.45.12]:56803 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932317AbWITTm0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:42:26 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=TBGJ8CLng3DmG8T8I+HRoIlYxqrjl8MXEkvqS08aXbSCL2pj5mLtnmfR3RokanP2l
	vTXTFtp0NbJZs0W9QDWag==
Message-ID: <45119934.8080001@google.com>
Date: Wed, 20 Sep 2006 12:40:36 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karim@opersys.com
CC: "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Michael Davidson <md@google.com>
Subject: Re: [PATCH] Linux Kernel Markers
References: <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919070516.GD23836@in.ibm.com> <451030A6.6040801@google.com> <45105B5E.9080107@opersys.com> <451141B1.40803@hitachi.com> <451178B0.9030205@opersys.com> <20060920180808.GI18646@redhat.com> <451186F2.3060702@google.com> <45118D63.8070604@opersys.com> <451194DA.40300@google.com> <451199F4.3000006@opersys.com>
In-Reply-To: <451199F4.3000006@opersys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Martin Bligh wrote:
> 
>>Do we even need the filler padding? I thought we could insert kprobes
>>at the beginning of any function without that ... it was only a
>>requirement for mid-function (sometimes). If we copy the whole function,
>>we don't even need that any more ...
>>
>>if kprobes can do it, I don't see why djprobes can't ... after all, it
>>just seems to use kprobes to insert a jump, AFAICS.
> 
> 
> I guess I must not be explaining myself properly.
> 
> The padding is for one purpose and one purpose only: having
> a know-to-be-good location at the beginning of the
> uninstrumented function for later using djprobes on. Once
> you've got that, then you can indeed copy the entire
> function and do whatever you want *without* using djprobes
> or kprobes, but using direct calls.
> 
> If you don't have the padding, then you might yourself in
> a case where you're replacing bytes from multiple instructions
> where something somewhere may have an IP within the replaced
> range. And to get around that you have to pull a few magic
> tricks *and* make a few assumptions. But if you replace a
> 5 bytes instruction (or the equivalent as in Hiramatsu-san's
> proposla) with another 5 bytes instruction, none of that is
> needed and djprobes can be used *today* to do that.
> 
> Using this, you've got an arguably non-existent penalty
> for the function with the filler and a very fast jump to
> the instrumented function. The best of both worlds
> actually.
> 
> Let me know if I'm still not being clear.

You mean using the jump-over thing that was posted earlier?
I thought the CPU erratas prevented doing that atomically
properly. From my understanding of the last 24 hours discussion,
it seemed like the ONLY thing we could do safely atomically was
insert an int3. Which sucks, frankly, but still.

Or are we talking about locking everyone in an NMI? Having
proposed that, I now think it doesn't work ... we still return
from it when it's done, and might be in the middle of the
instruction stream we just crapped on.

So, maybe I missed a bit of the conversation, or didn't understand
it, but I was trying to follow it pretty closely. Even with the
padding, I don't see how overwriting it is atomic ... they could
be off processing an interrupt / NMI or whatever when you were
in the midst of it.

One thing Michael (cc'ed) pointed out was the possibility of using
"jump to self" as a small marker instruction, where we set the
function in busy wait at the start as we overwrite the next few,
then overwrite the jump to selfs with a nop to liberate it again.
But I'm unconvinced that gets around the CPU errata Alan was
pointing to.

M.
