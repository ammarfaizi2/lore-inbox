Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUE0LgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUE0LgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 07:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUE0LgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 07:36:00 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:65259 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261937AbUE0Lf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 07:35:56 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux@horizon.com
Date: Thu, 27 May 2004 21:35:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16565.53893.357718.79@cse.unsw.edu.au>
Cc: Olaf Kirch <okir@suse.de>, akpm@osdl.org, kerndev@sc-software.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 is crashing repeatedly
In-Reply-To: message from linux@horizon.com on  May 27
References: <20040520060805.1620.qmail@science.horizon.com>
	<20040527112508.24292.qmail@science.horizon.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  May 27, linux@horizon.com wrote:
> Even with neilb's patch, I just got an nfs oops:

As Olaf Kirch just said on nfs@lists.sourceforge.net:

> Hi Neil,
> 
> you recently posted a patch that should fix readdir encoding in
> nfsd. You say there
> 
> 	Note that as the offset and whole response is known to be
> 	4byte-aligned, the offset pointer will never be split over
> 	two pages.
> 
> This is not true. The dirent offset is a 64bit quantity, so it's quite
> possible it will be split across the page boundary. I'm working on a
> patch...

And that is exactly the problem you have hit:

> Unable to handle kernel paging request at virtual address f2590000
>  printing eip:
> c01a99a1
> *pde = 004b1067
> *pte = 32590000
> Oops: 0002 [#1]
> DEBUG_PAGEALLOC
> CPU:    0
> EIP:    0060:[<c01a99a1>]    Not tainted
> EFLAGS: 00010246   (2.6.6) 
> EIP is at encode_entry+0x51/0x530
> eax: cc010000   ebx: 00000000   ecx: 000001cc   edx: f32dcdf8
> esi: f258fffc   edi: d4ec21cc   ebp: 000001e0   esp: ebfd9b98

Note that "esi" is pointing to 4 bytes from the end of a page, and you
are getting a bad reference at the start of the next page.
The code is storing a 64bit value here, and it doesn't fit.

Stay tuned....

NeilBrown
