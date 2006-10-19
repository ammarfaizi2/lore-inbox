Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946196AbWJSQXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946196AbWJSQXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946195AbWJSQXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:23:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:61585 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1946174AbWJSQXQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:23:16 -0400
Date: Thu, 19 Oct 2006 17:23:08 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061019162308.GT29920@ftp.linux.org.uk>
References: <20061017005025.GF29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk> <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org> <20061018160609.GO29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180926380.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610180926380.3962@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 09:32:08AM -0700, Linus Torvalds wrote:
> That said, I'd rather do any lock_super() cleanup totally _independently_ 
> of a include file cleanup. 
> 
> So since it's clearly not performance-critical, how about just making it 
> be out-of-line in fs/super.c, and turn the header file into just a 
> declaration?

Next fun question on strategy: we have a very good bunch of candidates on
killable includes in skbuff.h - highmem.h, mm.h and poll.h.  I've done
preliminary variants on amd64 and they give nice reductions of deps
counts with small patches.  The tricky part is a couple of helpers -
k{un,}map_skb_frag().  They require highmem.h; nothing else in skbuff.h
does.  Only two places are using them - net/core/skbuff.c and
net/appletalk/ddp.c (the latter in one function - dealing with Apple's
take on checksums[1]).

Possible variants:
	* turn into macros.  Works for a test run, not nice for final
variant.
	* new header just for those two in include/net
	* new header in net/core, with ddp.c including ../core/skb_kmap.h
	* inline in net/core/skbuff.h, extern in ddp.c; then normal paths
get it inlined and appletalk can live with uninlined version.

Preferences?

[1] appletalk: the proof that Vogon neuroanatomy was not entirely fictional.
