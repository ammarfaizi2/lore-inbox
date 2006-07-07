Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWGGPIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWGGPIm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 11:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWGGPIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 11:08:42 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:17021 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932190AbWGGPIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 11:08:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=y8dHVFdnEMc5zZILZ+McJbtebryYy4Z19yMB/Ly97vnuqc71ZXNnxyz99e/DJl9i7paX8PcnD+YK1B7cD0aEwWaBnGAtw+3327mfY/Ck56801FlttNF1W6Lll0bRZE1BazjOfF6LacnvH/f95qkRyEGPi3Op9VuultATgf/3CX8=  ;
Message-ID: <44AE1690.5070509@yahoo.com.au>
Date: Fri, 07 Jul 2006 18:08:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
In-Reply-To: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haavard Skinnemoen wrote:
> Hi everyone,
> 
> I've put up an updated set of patches for AVR32 support at
> http://avr32linux.org/twiki/bin/view/Main/LinuxPatches
> 
> The most interesting patch probably is
> http://avr32linux.org/twiki/pub/Main/LinuxPatches/avr32-arch-2.patch
> 
> which, at 544K, is too large to attach here. Please let me know if you
> want me to do it anyway.
> 
> Anyone want to have a look at this? I understand that a full review is
> a huge job, but I'd appreciate a pointer or two in the general
> direction that I need to take this in order to get it acceptable for
> mainline.
> 

Hi,

+void cpu_idle(void)
+{
+	/* endless idle loop with no priority at all */
+	while (1) {
+		/* TODO: Enter sleep mode */
+		if (need_resched())
+			schedule();
+	}
+}

AFAIKS, this is buggy.

need_resched() translates to a test_bit, which doesn't have any barriers,
so it could be optimised away completely. And if you're intending to use
preempt, you need to have preemption disabled in the idle loop.

Documentation/sched-arch.txt attempts to explain, and  something like
arm26's cpu_idle() is a nice, simple example to follow.

Actually, I'm wrong about the test_bit. It casts to volatile there, which
is probably why you don't end up with infinite loops. Still, it would be
nicer to have an explicit barrier (eg. cpu_relax()).

Why do we cast to volatile in places like this? Linus? I don't see why
test_bit() should be any more "special" than the & operator. What's more,
some architectures do cast and others don't, which is just insane.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
