Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWDOFxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWDOFxo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 01:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWDOFxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 01:53:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:236 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030259AbWDOFxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 01:53:43 -0400
Date: Fri, 14 Apr 2006 22:53:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Bharata B Rao" <bharata.rao@gmail.com>
Cc: dgc@sgi.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       dipankar@in.ibm.com
Subject: Re: shrink_dcache_sb scalability problem.
Message-Id: <20060414225302.42270afe.akpm@osdl.org>
In-Reply-To: <344eb09a0604142225t6e2d26eep94e1ffa64cf21803@mail.gmail.com>
References: <20060413082210.GM1484909@melbourne.sgi.com>
	<20060413015257.5b9d0972.akpm@osdl.org>
	<20060414034332.GN1484909@melbourne.sgi.com>
	<20060413222325.77f9ec9b.akpm@osdl.org>
	<344eb09a0604142225t6e2d26eep94e1ffa64cf21803@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bharata B Rao" <bharata.rao@gmail.com> wrote:
>
> > OT, I'm a bit curious about this:
>  >
>  >                 list_del_init(tmp);
>  >                 spin_lock(&dentry->d_lock);
>  >                 if (atomic_read(&dentry->d_count)) {
>  >                         spin_unlock(&dentry->d_lock);
>  >                         continue;
>  >                 }
>  >
>  > So we rip the dentry off dcache_unused and just leave it floating about?
>  > Dipankar, do you remember why that change was made, and why it's not a bug?
> 
>  Due to lazy updating of the LRU list, there can be some dentries with non-zero
>  ref counts on LRU list. This is one of the places where such dentries are
>  removed from the LRU list. (Basically such dentries will be both on
>  hash list and LRU
>  list and here they get removed from the LRU list)

OK.  But what guarantees that these live-but-detached dentries are
appropriately destroyed before the unmount completes?

Or...  if these dentries will be freed by RCU callbacks potentially after
the unmount, are we sure that they will always be in a state which will
permit them to be freed?
