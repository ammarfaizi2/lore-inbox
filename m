Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUEQTGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUEQTGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUEQTGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:06:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33942 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262190AbUEQTGZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:06:25 -0400
Date: Mon, 17 May 2004 20:06:23 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Steven Cole <scole@lanl.gov>
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, support@bitmover.com,
       Linus Torvalds <torvalds@osdl.org>, Wayne Scott <wscott@bitmover.com>,
       adi@bitmover.com, Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       lm@bitmover.com, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: 1352 NUL bytes at the end of a page?
Message-ID: <20040517190623.GV17014@parcelfarce.linux.theplanet.co.uk>
References: <200405162136.24441.elenstev@mesatop.com> <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040516231120.405a0d14.akpm@osdl.org> <20040517.085640.30175416.wscott@bitmover.com> <20040517151738.GA4730@thunk.org> <Pine.LNX.4.58.0405170820560.25502@ppc970.osdl.org> <20040517153736.GT17014@parcelfarce.linux.theplanet.co.uk> <E88DCF88-A827-11D8-A7EA-000A95CC3A8A@lanl.gov> <20040517174004.GU17014@parcelfarce.linux.theplanet.co.uk> <1084815598.26340.6.camel@spc0.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084815598.26340.6.camel@spc0.esa.lanl.gov>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 11:39:58AM -0600, Steven Cole wrote:
> Yes, seven of the 52 references to mmap in the strace output met
> the above criteria: 
> 
>   old_mmap(0x4015f000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x142000) = 0x4015f000
>   old_mmap(0x40170000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x9000) = 0x40170000
>   old_mmap(0x40180000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x9000) = 0x40180000
>   old_mmap(0x40191000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x10000) = 0x40191000
>   old_mmap(0x4019c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x7000) = 0x4019c000
>   old_mmap(0x401a0000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x3000) = 0x401a0000
>   old_mmap(0x401af000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0xe000) = 0x401af000

Shared libraries.  And no, those will never lead to any writes, no matter how
you modify them (MAP_PRIVATE).  Which is the point, since that's where we
are doing relocations and we definitely do not want that to hit the disk ;-)

IOW, we can remove writes of dirtied mmap'ed pages from consideration.
