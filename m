Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUFKFrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUFKFrv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 01:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUFKFru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 01:47:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:43934 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261862AbUFKFrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 01:47:48 -0400
Date: Thu, 10 Jun 2004 22:47:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm1
Message-Id: <20040610224700.71986a92.akpm@osdl.org>
In-Reply-To: <20040610213659.0fd93039.pj@sgi.com>
References: <20040609015001.31d249ca.akpm@osdl.org>
	<20040610213659.0fd93039.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Do you recall why your i386-uninline-bitops.patch moves i386
>  find_next_bit() and find_next_zero_bit() out of line, but not
>  find_first_zero_bit() nor find_first_bit()?

They're the two non-leaf functions - they expand other inlines and end up
quite big.

>  Perhaps someone else has further insight to the tradeoffs here, such as
>  a 'recommended size', above which most routines should be not inlined,
>  except in special cases.

Hard call.  Lots of hand-waving is involved.

Yes, an aggregate reduction in kernel text size is a good thing, but the
main reason for uninlining things is for performance: reduction of icache
footprint.

If an inline function is expanded several times in, say, fs/dcache.c then
it's a good candidate for uninlining, because it's probably the case that
all the expanded versions are in icache simultaneously.  But if a function
is expanded once in ext2 and once in ext3 then it's less useful to uninline
it, because it is rare that two different filesystem drivers are in use
simultaneously.
