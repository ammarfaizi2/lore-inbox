Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWDUVMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWDUVMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWDUVMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:12:35 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:65448 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932481AbWDUVMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:12:34 -0400
Date: Sat, 22 Apr 2006 01:12:05 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: Mathieu Chouquet-Stringer <mchouque@free.fr>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, rth@twiddle.net
Subject: Re: strncpy (maybe others) broken on Alpha
Message-ID: <20060422011205.A1270@jurassic.park.msu.ru>
References: <20060421182223.C19738@jurassic.park.msu.ru> <20060421193759.55D55DBA1@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060421193759.55D55DBA1@gherkin.frus.com>; from rct@gherkin.frus.com on Fri, Apr 21, 2006 at 02:37:59PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 02:37:59PM -0500, Bob Tracy wrote:
> WITHOUT the patch, and everything else the same, gcc-4.0 and gcc-4.1
> appear to work, but the gcc-3.3 build produces the bad behavior we've
> been seeing.

Actually the bug doesn't show up with gcc-4 *only* because it tends
to pack the data more tightly, so that both src[] and dest[] have different
alignment vs. gcc-3 compiled foo.c:
src 0x11ffff8f4, dest 0x11ffff926 - gcc-4
src 0x11ffff8c0, dest 0x11ffff900 - gcc-3

If you add __attribute__((aligned(8))) to both src and dest declarations
in Mathieu's foo.c, you'll see the bug is still here.

> Pending a knowledgable peer review of Ivan's patch (no insult intended:
> I'm not qualified), I'd say we're close to putting this to rest.  If it
> turns out the patch is the correct fix, I'm genuinely concerned about
> how long this bug went undetected :-(.  The modification date of
> arch/alpha/lib/strncpy.S is 28 Jul 2003 in my tree.  The stxncpy.S file
> is not quite a year newer: 10 May 2004.

Well, these things happen. I think it's not quite surprising.
First, the kernel is not overloaded with strncpy calls. ;-)
Second, strncpy was mostly used in drivers that are rarely (if at all)
used on alpha.
Third, to discover this bug you need some special combination of source
and destination alignment, source string length and byte count.

Ivan.
