Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUA3P3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 10:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUA3P3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 10:29:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49898 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261735AbUA3P3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 10:29:06 -0500
Date: Fri, 30 Jan 2004 10:28:35 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Dave Paris <dparis@w3works.com>
Cc: linux-kernel@vger.kernel.org, rspchan@starhub.net.sg
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch pentium3,4
Message-ID: <20040130152835.GN31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Xine.LNX.4.44.0401300939070.15830-100000@thoron.boston.redhat.com> <PLEIIGNDLGEDDKABPLHBAECPCHAA.dparis@w3works.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PLEIIGNDLGEDDKABPLHBAECPCHAA.dparis@w3works.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 10:04:00AM -0500, Dave Paris wrote:
> Has this been demonstrated on *any* system/arch using GCC 3.2.3 (or other
> 3.2 series) or is it limited in scope to the description below?  Does it
> seem to do this with other implementations (other than sha256.c) or other
> kernels?  Just trying to get an idea if this is a complier optimization bug
> or something much more limited in scope.
> 
> My personal lab is currently being unboxed and I won't be able to run my own
> tests for another week or so.  (apologies in advance)
> 
> In any case, this is *extremely* serious from a number of angles.

GCC handling of automatic const variables with initializers is very fragile.
There have been numerous bugs in it in the past and last one has been fixed
just yesterday (on GCC trunk only for the time being).  It will be
eventually backported once it gets some more testing on GCC mainline.

The problematic line in sha256.c is:
static void sha256_final(void* ctx, u8 *out)
{
...
	const u8 padding[64] = { 0x80, };

where if you are unlucky, scheduler will with various different GCC versions
on various architectures reorder instructions so that store of 0x80 into the
struct is before clearing of the 64 bytes.

On the other side, doing this in sha256.c seems quite inefficient, IMHO much
better would be to have there static u8 padding[64] = { 0x80 };
because that will not mean clearing 64 bytes and writing another one on top
of it every time the routine is executed.

	Jakub
