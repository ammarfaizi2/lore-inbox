Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264916AbUEVI1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUEVI1J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 04:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUEVI1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 04:27:09 -0400
Received: from holomorphy.com ([207.189.100.168]:13960 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264917AbUEVI0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 04:26:07 -0400
Date: Sat, 22 May 2004 01:26:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: slab redzoning
Message-ID: <20040522082602.GJ2161@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>, mpm@selenic.com,
	linux-kernel@vger.kernel.org
References: <20040522034902.GB2161@holomorphy.com> <40AF0911.6020000@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AF0911.6020000@colorfullife.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>>-if ((size < 4096 || fls(size-1) == fls(size-1+3*BYTES_PER_WORD)))
>>+if (size + 3*BYTES_PER_WORD <= PAGE_SIZE ||

On Sat, May 22, 2004 at 10:02:25AM +0200, Manfred Spraul wrote:
> I understand this change: objects between 4082 and 4095 bytes are 
> redzoned and cause order==1 allocations, that's wrong.

William Lee Irwin III wrote:
> >+			((size & (size - 1)) &&
> >+			(1 << fls(size)) - size > 3*BYTES_PER_WORD))

On Sat, May 22, 2004 at 10:02:25AM +0200, Manfred Spraul wrote:
> Why this change? I've tested my fls(size-1)==fls(size-1-3*4) approach 
> and it always returned the right result: No redzoning between 8181 and 
> 8192 bytes, between 16373 and 16384, etc.

It returns a false positive when size + 3*BYTES_PER_WORD == 2**n, e.g.
size == 16373. Here, fls(size - 1) == 13, but fls(size - 1 + 12) == 13
while size - 1 + 12 == 16384, where we'd want the check to fail. Or so
my analysis of it goes.

-- wli
