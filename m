Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUH3G27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUH3G27 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 02:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267438AbUH3G27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 02:28:59 -0400
Received: from codepoet.org ([166.70.99.138]:17572 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S267330AbUH3G25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 02:28:57 -0400
Date: Mon, 30 Aug 2004 00:28:56 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.8.1
Message-ID: <20040830062856.GA10475@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org
References: <200408292232.14446.mmazur@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408292232.14446.mmazur@kernel.pl>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Aug 29, 2004 at 10:32:13PM +0200, Mariusz Mazur wrote:
> Nothing special, really. One bigger change - on archs that have >1 possible
> page sizes (PAGE_SIZE definition in asm/page.h) we're now using a call to
> libc's getpagesize(), so don't count on it being static on archs like ia64.

I really do not like this change.  Since PAGE_SIZE has always
been a constant, the change you have made is likely to break a
fair amount of code, basically any code doing stuff like:

	static int* foo[PAGE_SIZE];

Your change will result in cryptic errors such as

    "error: variable-size type declared outside of any function"
    "error: storage size of `foo' isn't constant"

depending on whether the declaration is outside a function or in one.
I think it would be much better to either

    a) remove PAGE_SIZE or make using it an error somehow,

    b) make PAGE_SIZE an install time config option

    c) declare that on architectures such as mips that support
       variable PAGE_SIZE values, the libc kernel headers shall
       always provide the largest fixed size value of PAGE_SIZE
       supported for that architecture and everyone just agrees
       that using PAGE_SIZE rather than getpagesize(2) or
       sysconf(_SC_PAGESIZE) is generally a bad idea.  It should
       be the largest value supported on that architecture, since
       the the only cost of always using the largest possible
       value is wasted ram, whereas the cost of always using the
       smallest value is segfaults.

With any of the above 3 suggestions, things will either just
work, or the user will get a descriptive error message.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
