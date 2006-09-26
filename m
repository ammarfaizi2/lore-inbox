Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751826AbWIZAHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbWIZAHR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 20:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWIZAHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 20:07:16 -0400
Received: from gw.goop.org ([64.81.55.164]:41146 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751824AbWIZAHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 20:07:12 -0400
Message-ID: <45186F1F.8030408@goop.org>
Date: Mon, 25 Sep 2006 17:06:55 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Karim Yaghmour <karim@opersys.com>,
       Pavel Machek <pavel@suse.cz>, Joe Perches <joe@perches.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.13 for 2.6.17
References: <20060925233349.GA2352@Krystal>
In-Reply-To: <20060925233349.GA2352@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> +/* Note : max 256 bytes between over_label and near_jump */
> +#define MARK_JUMP(name, format, args...) \
> +	do { \
> +		asm volatile(	".section .markers, \"a\";\n\t" \
> +				".long 0f, 1f, 2f;\n\t" \
> +				".previous;\n\t" \
> +				".align 16;\n\t" \
> +				".byte 0xeb;\n\t" \
> +				"0:\n\t" \
> +				".byte 2f-1f;\n\t" \
> +				"1:\n\t" \
> +			: "+m" (__marker_sequencer) : ); \
> +		MARK_CALL(name, format, ## args); \
> +		asm volatile (	"2:\n\t" : "+m" (__marker_sequencer) : ); \
>   

Unfortunately this doesn't work either.  The two asms are ordered with 
respect to each other, but there's nothing to 1) stop the MARK_CALL from 
being moved out between them, 2) something else being moved in between 
them.  I don't really see a way out of this without implementing the 
whole call in assembler as well, which is a big pain.

    J
