Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266454AbUGBELl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266454AbUGBELl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 00:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266456AbUGBELl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 00:11:41 -0400
Received: from janus.foobazco.org ([198.144.194.226]:36736 "EHLO
	mail.foobazco.org") by vger.kernel.org with ESMTP id S266454AbUGBELh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 00:11:37 -0400
Date: Thu, 1 Jul 2004 21:11:36 -0700
From: "Keith M. Wesolowski" <wesolows@foobazco.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: A question about PROT_NONE on Sun4c 32-bit Sparc
Message-ID: <20040702041136.GA21360@foobazco.org>
References: <20040630030503.GA25149@mail.shareable.org> <20040702010349.GF8950@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702010349.GF8950@mail.shareable.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 02:03:49AM +0100, Jamie Lokier wrote:

> I would like to know if the Sun4 and Sun4c ports have the same bug.
> I'm guessing not, but it's not clear to me from the code.

No, this code is ok.

> #define _SUN4C_PAGE_VALID        0x80000000
> #define _SUN4C_PAGE_SILENT_READ  0x80000000   /* synonym */
> ...
> #define _SUN4C_PAGE_READ         0x00800000   /* implemented in software */
> ...
> #define SUN4C_PAGE_NONE		__pgprot(_SUN4C_PAGE_PRESENT)

> SUN4C_PAGE_NONE corresponds to PROT_NONE mmap memory protection.
> The question is whether PROT_NONE pages are readable by the _kernel_.
> I.e. whether write() would successfully read from those pages.

No, they are not.  The _SUN4C_PAGE_SILENT_READ is the bit that allows
reading the page without trapping.  If it's not set, you trap, and
do_sun4c_fault tests _SUN4C_PAGE_READ with no special case for
user/kernel.  Since PROT_NONE doesn't include that bit, it's an oops.

> (By the way, as the sun4 files don't contain a definition of
> _SUN4_PAGE_FILE or pgoff_to_pte, but the sun4c one do, I guess the
> sun4 sub-architecture doesn't build in 2.6 but sun4c does?)

Correct, although I recently fixed this in my tree.  It now builds but
nobody has tested it in ages and I believe it doesn't work.

-- 
Keith M Wesolowski
