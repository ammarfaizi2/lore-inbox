Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWEKVOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWEKVOR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 17:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWEKVOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 17:14:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:65461 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750790AbWEKVOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 17:14:16 -0400
Date: Thu, 11 May 2006 22:14:02 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net, dwalker@mvista.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Message-ID: <20060511211401.GN27946@ftp.linux.org.uk>
References: <20060510162106.GC27946@ftp.linux.org.uk> <20060510150321.11262b24.akpm@osdl.org> <20060510221024.GH27946@ftp.linux.org.uk> <20060510.153129.122741274.davem@davemloft.net> <20060510224549.GI27946@ftp.linux.org.uk> <20060510160548.36e92daf.akpm@osdl.org> <20060510232042.GJ27946@ftp.linux.org.uk> <20060510164554.27a13ca9.akpm@osdl.org> <20060511204033.GB3570@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060511204033.GB3570@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 10:40:33PM +0200, Adrian Bunk wrote:
> We could turn of this kind of warnings that generate these kind of false 
> positives globally with -Wno-uninitialized until a future gcc version 
> might be better at avoiding false positives.
> 
> But there's one problem, this turns off two kinds of warnings:
> - 'foo' may be used uninitialized in this function
> - 'foo' is used uninitialized in this function
> 
> The first kind of warnings is the one generating the false positives 
> while the second kind are warnings we do not want to lose, but AFAIK 
> there's no way to only turn off the first kind.
> 
> Perhaps asking the gcc developers for separate options for these two 
> kinds of warnings in gcc 4.2 and then turning off the first kind is 
> the way to go?

Folks, let's look at it that way:
	* warnings are tools to locate broken places in the tree.
	* we have two signals ("is unused" and "may be unused"), say
A(location, verision) and B(location, version).
	* A has fairly high S/N ratio.
	* B has very large noise component, but it's only weakly dependent
on the verision.

The question is how to get useful information out of those.
	* solution 1: introduce C(location, version) and filter A and B
with it, to kill noise in B.
	* solution 2: ignore B, either by gcc modification or simply filtering
it with grep.
	* solution 3: subtract the signals for consequent versions.

IMO it's obvious that combining outputs of (2) and (3) gives the best S/N.
The reason why (1) is bad is that it kills high-S/N channel in the areas
with high noise on low-S/N channel *and* that filtered-out areas will
remain filtered out in the next versions.  IOW, it's a clear loss.
