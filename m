Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264624AbTFLATD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 20:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbTFLATD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 20:19:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37647 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264624AbTFLATB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 20:19:01 -0400
Date: Wed, 11 Jun 2003 17:32:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] First casuality of hlist poisoning in 2.5.70
In-Reply-To: <16103.50069.802804.254270@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0306111727070.28014-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jun 2003, Trond Myklebust wrote:
>
> AFAICS one should not rehash the dentry until after the d_move(). Does
> that make sense?

Yeah, it does seem that rehashing before actually calling d_move() means 
that there is a small window where another process might now come in, and 
use the dcache (without getting the semaphore) to see the old value of the 
target dentry, even though the low-level filesystem has already move the 
new dentry value over the target. Ie the window would be between

		i_op->rename(...)
	d_rehash(new_dentry)
	... race here ...
	d_move(old_dentry, new_dentry)

That might confuse a filesystem that expected that the target was deleted 
an no longer reachable by anybody.

Al? What do you think?

		Linus

