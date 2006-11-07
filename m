Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbWKGQKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbWKGQKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbWKGQKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:10:08 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:18587 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S965186AbWKGQKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:10:05 -0500
Date: Tue, 7 Nov 2006 09:10:05 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Layton <jlayton@redhat.com>
Cc: Eric Sandeen <sandeen@redhat.com>, J?rn Engel <joern@wohnheim.fh-wedel.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels that offer x86 compatability
Message-ID: <20061107161004.GS27140@parisc-linux.org>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com> <20061106182222.GO27140@parisc-linux.org> <1162838843.12129.8.camel@dantu.rdu.redhat.com> <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com> <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com> <1162914966.28425.24.camel@dantu.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162914966.28425.24.camel@dantu.rdu.redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 10:56:06AM -0500, Jeff Layton wrote:
>  retry:
> -	if (counter > max_reserved) {
> -		head = inode_hashtable + hash(sb,counter);
> -		res = counter++;
> +	if (sb->s_lastino >= max_reserved) {
> +		head = inode_hashtable + hash(sb,++sb->s_lastino);
> +		res = sb->s_lastino;

I think it'd be clearer to write this as:

		res = ++sb->s_lastino;
		head = inode_hashtable + hash(sb, res);

My eye skipped over the preincrement entirely the way it's currently
written.

>  		inode = find_inode_fast(sb, head, res);
>  		if (!inode) {
>  			spin_unlock(&inode_lock);
>  			return res;
>  		}
>  	} else {
> -		counter = max_reserved + 1;
> +		 sb->s_lastino = max_reserved;
>  	}
>  	goto retry;
>  	
