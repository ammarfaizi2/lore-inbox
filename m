Return-Path: <linux-kernel-owner+w=401wt.eu-S932969AbWL1KN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbWL1KN5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932979AbWL1KN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:13:57 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3076 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932963AbWL1KNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:13:55 -0500
Date: Thu, 28 Dec 2006 10:13:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Gordon Farquharson <gordonfarquharson@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>,
       ranma@tdiedrich.de, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Message-ID: <20061228101311.GA9672@flint.arm.linux.org.uk>
Mail-Followup-To: Gordon Farquharson <gordonfarquharson@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
	tbm@cyrius.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	andrei.popa@i-neo.ro, Andrew Morton <akpm@osdl.org>,
	hugh@veritas.com, nickpiggin@yahoo.com.au, arjan@infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20061226.205518.63739038.davem@davemloft.net> <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org> <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> <20061227.165246.112622837.davem@davemloft.net> <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org> <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com> <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org> <97a0a9ac0612272120g144d2364n932d6f66728f162e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a0a9ac0612272120g144d2364n932d6f66728f162e@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 10:20:20PM -0700, Gordon Farquharson wrote:
> I have run the program a few times, and the output is pretty
> consistent. However, when I increase the target size, the difference
> between the expected and actual values is larger.
> 
> Written as (749)935(738)
> Chunk 1113 corrupted (1-1455)  (2965-323)
> Expected 89, got 93

This is not the corruption Linus is after.  Note that the corruption starts
at offset '1'.  Also note that:

89 = 1113 & 255
93 = 1113 & 255 | (1113 >> 8)

and if you look at glibc's memset() function, you'll notice that's exactly
what you expect if you pass a non-8bit value to it.  Ergo, what you're
seeing is utterly expected given glibc's memset() implementation on ARM.

Fixing Linus' test program to pass nr & 255 to memset results in clean
passes on 2.6.9 on TheCus N2100 (IOP8032x) and 2.6.16.9 StrongARM
machines (as would be expected.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
