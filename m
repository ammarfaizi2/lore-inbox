Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWJHTb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWJHTb3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 15:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWJHTb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 15:31:29 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:37608 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1751357AbWJHTb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 15:31:27 -0400
Date: Sun, 8 Oct 2006 12:31:24 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Karim Yaghmour <karim@opersys.com>, Pavel Machek <pavel@suse.cz>,
       Joe Perches <joe@perches.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: Performance analysis of Linux Kernel Markers 0.20 for 2.6.17
In-Reply-To: <20060930180157.GA25761@Krystal>
Message-ID: <Pine.LNX.4.64.0610081223150.28503@twinlark.arctic.org>
References: <20060930180157.GA25761@Krystal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006, Mathieu Desnoyers wrote:

> - Optimized
> 
> static int my_open(struct inode *inode, struct file *file)
> {
>    0:   55                      push   %ebp
>    1:   89 e5                   mov    %esp,%ebp
>    3:   83 ec 0c                sub    $0xc,%esp
>         MARK(subsys_mark1, "%d %p", 1, NULL);
>    6:   b0 00                   mov    $0x0,%al <-- immediate load 0 in al
>    8:   84 c0                   test   %al,%al
>    a:   75 07                   jne    13 <my_open+0x13>

why not replace the mov+test with "xor %eax,%eax" and then change the 0x75 
to a 0x74 to change from jne to je when you want to enable the marker?

i.e. disabled:

	31 c0	xor %eax,%eax
	75 07	jne 13

enabled:

	31 c0	xor %eax,%eax
	74 07	je 13

it would save 2 bytes, 1 instruction and avoid partial register writes... 
and still has the nice property that a single byte store into the code is 
required for enable/disable (which sounds like a great property -- i 
assume you were deliberately going for that).

i assume there's probably no reason to tie the sequence to eax either -- 
you could let gcc choose it (or maybe you already do).

-dean
