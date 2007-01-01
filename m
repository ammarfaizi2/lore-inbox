Return-Path: <linux-kernel-owner+w=401wt.eu-S1754750AbXAAXXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbXAAXXe (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754727AbXAAXXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:23:34 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:35330 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754750AbXAAXXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:23:33 -0500
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
	that again
From: James Bottomley <James.Bottomley@SteelEye.com>
To: David Miller <davem@davemloft.net>
Cc: torvalds@osdl.org, miklos@szeredi.hu, rmk+lkml@arm.linux.org.uk,
       arjan@infradead.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20070101.150401.93385110.davem@davemloft.net>
References: <Pine.LNX.4.64.0612311249240.4473@woody.osdl.org>
	 <20061231.131216.105428418.davem@davemloft.net>
	 <1167669876.5302.60.camel@mulgrave.il.steeleye.com>
	 <20070101.150401.93385110.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 01 Jan 2007 17:23:08 -0600
Message-Id: <1167693789.2825.6.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-01 at 15:04 -0800, David Miller wrote:
> I thought this was accepted and Ralf is using it on MIPS?

It partially is ... we're using it on parisc as well, but only as a
supplement to the current linux flushing APIs.  There's still no
guarantee in the standard linux API that 

kmap();  do something; kunmap();

leaves everything correctly coherent.

I have some code for parisc that implements the strong coherency around
kmap/kunmap.  What we do is actually use the page access flags to tell
us if the page was altered by the "do something" code and thus flush
only where necessary (i.e. our prototype was hint free).  If everyone's
happy with this, we can kill off flush_kernel_dcache_page() and a few
other flush_dcache_pages() around kmaps and just let the kmap API handle
it all.  Unfortunately, this still won't solve the anonymous page
problem.

James


