Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVBUMib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVBUMib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 07:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVBUMib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 07:38:31 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:17855 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261961AbVBUMiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 07:38:13 -0500
Date: Mon, 21 Feb 2005 13:38:11 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: checkstack.pl <large_number>
Message-ID: <20050221123811.GA13273@wohnheim.fh-wedel.de>
References: <42163E2D.8050106@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42163E2D.8050106@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 February 2005 11:12:45 -0800, Randy.Dunlap wrote:
> 
> In checkstack.pl, do you recall the reason for this code snippet:
> 
> 		if ($size > 0x80000000) {
> 			$size = - $size;
> 			$size += 0x80000000;
> 			$size += 0x80000000;
> 		}
> 
> There is one (unusual:) case where it fails.  Is it needed?

Something like this is needed, also for unusual cases.  gcc sometimes
decides to switch "sub 16" with "add -16".  Later, when the stack
frame is popped back, the exchange goes vice versa.

Without this code, you'd see a few cases of nearly 4GiB.

> For arch/i386/kernel/efi_stub.S, checkstack reports:
> 
> 0xc0116f5d efi_call_phys:				1073741824
> which is 0x4000_0000 (_ added for readability only), however the
> actual change in %esp there is __PAGE_OFFSET (0xc000_0000 on ia32),
> 
> so if I alter the "if" test above to check for > 0xf000_0000,
> checkstack reports the correct value:
> 0xc0116f5d efi_call_phys:				3221225472
> which is 0xc000_0000.
> 
> 
> from objdump of efi_stub.o:
>    5:	81 ea 00 00 00 c0    	sub    $0xc0000000,%edx
> 
> or I can just ignore it, like I've been doing for awhile...

Changing 0x8000_0000 to 0xf000_0000 would work for the add case as
well.  Sounds like a sane change.

Checkstack could also do the ignoring for you, maybe like this:
	if ($size > 0xf0000000) {
		$size = - $size;
		$size += 0x80000000;
		$size += 0x80000000;
	}
	if ($size > 0x10000000) {
		$size = 0;
	}

Jörn

-- 
Ninety percent of everything is crap.
-- Sturgeon's Law
