Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbUA3XI2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 18:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbUA3XI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 18:08:28 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:9538 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264363AbUA3XIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 18:08:23 -0500
Date: Sat, 31 Jan 2004 10:07:34 +1100
From: Nathan Scott <nathans@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040131100734.E3584036@wobbly.melbourne.sgi.com>
References: <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org> <20040130202155.GM25833@drinkel.cistron.nl> <20040130221353.GO25833@drinkel.cistron.nl> <20040130143459.5eed31f0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040130143459.5eed31f0.akpm@osdl.org>; from akpm@osdl.org on Fri, Jan 30, 2004 at 02:34:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 02:34:59PM -0800, Andrew Morton wrote:
> Miquel van Smoorenburg <miquels@cistron.nl> wrote:
> > What lock exactly is supposed to protect i_size_write, since it
> > appears that i_size_write is being called without proper locking ?
> > (Am I right?)
> 
> If two CPUs hit i_size_write() at the same time we have a bug.  That
> function requires that the caller provide external serialisation, via i_sem.

Hmm... I suspect we may not always be providing that in XFS -
I'll go audit our calls.

> Try adding this to the start of i_size_write():
> 
> 	if (down_trylock(&inode->i_sem) == 0) {
> 		printk("I am buggy\n");
> 		dump_stack();
> 		up(&inode->i_sem);
> 	}

Let me know what you hit Miquel :) - I'll run the XFS tests
next week with this too and see what I can find.

thanks.

-- 
Nathan
