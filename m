Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267383AbUIASFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267383AbUIASFa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 14:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267359AbUIASFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 14:05:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26807 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266892AbUIASDx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 14:03:53 -0400
Date: Wed, 1 Sep 2004 19:03:52 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch final : i386 tested, x86_64 support added
Message-ID: <20040901180352.GH642@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com> <20040827172337.638275c3.davem@davemloft.net> <20040827173641.5cfb79f6.akpm@osdl.org> <20040828010253.GA50329@muc.de> <20040827183940.33b38bc2.akpm@osdl.org> <16687.59671.869708.795999@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0408272021070.16607@schroedinger.engr.sgi.com> <20040827204241.25da512b.akpm@osdl.org> <Pine.LNX.4.58.0408272121300.16949@schroedinger.engr.sgi.com> <20040827223954.7d021aac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827223954.7d021aac.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 10:39:54PM -0700, Andrew Morton wrote:
> And we need larger atomic types _anyway_ for page->_count.  An unprivileged
> app can mmap the same page 4G times and can then munmap it once.  Do it on
> purpose and it's a security hole.  Due it by accident and it's a crash.

Sure, but the same kind of app can also do this on 32-bit architectures.
Assuming there's only 2.5GB of address space available per process,
you'd need 1638 cooperating processes to do it.  OK, that's a lot but
the lowest limit I can spy on a quick poll of multiuser boxes I have a
login on is 3064.  Most are above 10,000 (poll sample includes Debian,
RHAS and Fedora).

I think it would be better to check for overflow of the atomic_t (atomic_t
is signed) in the mmap routines.  Then kill the process that caused the
overflow.  OK, this is a local denial-of-service if someone does it to
glibc, but at least the admin should be able to reboot the box.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
