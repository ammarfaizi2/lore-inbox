Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267302AbUH0TMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267302AbUH0TMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267346AbUH0TJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:09:48 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:57914 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267285AbUH0TIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:08:17 -0400
Date: Fri, 27 Aug 2004 20:08:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ram Pai <linuxram@us.ibm.com>
cc: Gergely Tamas <dice@mfa.kfki.hu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: data loss in 2.6.9-rc1-mm1
In-Reply-To: <1093631420.11648.14.camel@dyn319181.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0408271950460.8349-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Aug 2004, Ram Pai wrote:
> On Fri, 2004-08-27 at 06:56, Hugh Dickins wrote:
> > 
> > Hmm, 2.6.9-rc1-mm1 looks like not a release to trust your (page
> > size multiple) data to!  You should find the patch below fixes it
> > (and, I hope, the issue the erroneous patches were trying to fix).
> 
> Hmm.. now I fail to understand how this code works.
> 
> assuming page size is 4096, if the size of the file is 4096, is the
> end_index 0 or is it 1?

Before your change and after mine, 1; with your change, 0.

> I had this assumption:  
> 
> 	file size in bytes			end_index
> 	-----------------			---------
> 		1 to 4096			0
> 		4097 to 2*4096			1
> 		2*4096+1 to 3*4096		2
> 		...				..

Well, that's what you changed it to, when you patched from the original
		end_index = isize >> PAGE_CACHE_SHIFT;
to		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;

But the "nr <= offset" check(s) relies on the original convention:
		0 to 4095			0
		4096 to 8191			1
		...				..

> or is the isize value reported by i_size_read(inode) one less than the
> size of the real file?

No!

> What am I missing?

You're expecting end_index to be the index of the last (possibly
incomplete) page of the file.  And that might be a reasonable way
of working it (though the special case of an empty file hints not).
But the nr,offset checks (I say checks because I added another like
the one further down, hopefully to fix the extra readahead issue)
require the original convention.  Just try it out with numbers.

Hugh

