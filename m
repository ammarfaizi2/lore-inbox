Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbUBXWp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbUBXWoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:44:54 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:22417 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S262512AbUBXWoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:44:19 -0500
Date: Tue, 24 Feb 2004 17:34:25 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Christophe Saout <christophe@saout.de>
Cc: James Morris <jmorris@intercode.com.au>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: cryptoapi highmem bug
Message-ID: <20040224223425.GA32286@certainkey.com>
References: <1077655754.14858.0.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077655754.14858.0.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe,

What is calling cbc_process directly?  I don't see how any other function
could possibly call this function directly.

cipher.c's cipher() function called cbc_process() with two different src and
dst buffers, *always*.

Have any more info?

JLC

On Tue, Feb 24, 2004 at 09:49:14PM +0100, Christophe Saout wrote:
> Hi,
> 
> someone noticed strange corruptions with dm-crypt and highmem. After I
> found out that I could force my machine to use highmem even though it
> only has 256MB, I finally found the problem after some debugging:
> 
> The problem is in cbc_process (well, partly):
> 
> >      const int need_stack = (src == dst);
> >      u8 stack[need_stack ? crypto_tfm_alg_blocksize(tfm) : 0];
> >      u8 *buf = need_stack ? stack : dst;
> 
> src == dst fails if the page was in highmem because crypto_kmap will
> assign two different virtual addresses for the same page.
> 
> The result is data corruption.
> 
> How could this be fixed?
> 
> scapperwalk_map could check if this page was already mapped (walk_in)
> and reuse the virtual address if so. So a single page is only mapped
> once and the check in cbc_process will work.
> 
> I can really use the src == dst case because I would need to allocate
> unnecessary buffers (at least 512 bytes at a time and per cpu).
> 
> (I just hacked dm-crypt to allocate 512 bytes on the stack and use it
> temporarily and kmap around myself to copy it back and the problem is
> gone. Ugly.)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
