Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWDDFCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWDDFCn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 01:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWDDFCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 01:02:43 -0400
Received: from nproxy.gmail.com ([64.233.182.184]:28711 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964918AbWDDFCm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 01:02:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ETUNYAoY9WEesgGTOPqcM5NDrSn9ZXmi3gFd93dWE2XWumTn512SyCnmCzYlfXqXdusRFrY53+WsNOgk1fYuBd3ZpOESSF1iWDUjxDIiu2HCFMwI2s9vNE6v6yyTzSEo3p/D2c70jKppRbySE3HR0nSOqUgijS1ymcLqszE3HTU=
Message-ID: <661de9470604032202k4dd3bf1cx6ba7a448d208087c@mail.gmail.com>
Date: Tue, 4 Apr 2006 10:32:41 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: "Neil Brown" <neilb@suse.de>
Subject: Re: [PATCH] Fix dcache race during umount
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Jan Blunck" <jblunck@suse.de>, "Kirill Korotaev" <dev@openvz.org>,
       olh@suse.de
In-Reply-To: <17457.50445.138103.748844@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060403133804.27986.patches@notabene>
	 <1060403034001.28030@suse.de>
	 <661de9470604031112j3bf81a21r7066c67f62f1de63@mail.gmail.com>
	 <17457.50445.138103.748844@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  * If the dentry is not DCACHED_REFERENCED, it is time to move it to LRU list,
> >  * provided the super block is NULL (which means we are trying to reclaim memory
> >  * or this dentry belongs to the same super block that we want to shrink.
> >  */
>
> Ok, thanks.  However it isn't time to "move it to the LRU list" but
> rather time to "move it from the LRU list, out of the cache all
> together, and through it away".

Oops, yes

>
> >
> > One side-effect of this check I see is
> >
> > Earlier, all prune_dcache() calls would prune the dentry cache. This
> > condition will cause dentries belonging only those super blocks being
> > shrink'ed to be freed up. shrink_dcache_memory() will have to do the
> > additional work of freeing dentries (especially for file systems like
> > sysfs, procfs, etc). But the good thing is it should make the per
> > super block operations faster (like unmount). IMO, this is the correct
> > behaviour, but I am not sure of the side-effects.
> >
>
> Hmm... yes, but there is a worse side-effect I think. If
> shrink_dcache_memory finds a dentry that it cannot free, it will move
> it to the head of the LRU, so unmount will not be able to find it so
> easily, and will end up moving it back down to the tail.  I don't
> think this can livelock, but it is unpleasant.
>
> Rather than move these entries to the head of the list, I'd like to
> leave them at the tail, and try to skip over entries that we might not
> be able to free.

Yes and you could use the first pass of dcache_shrink_sb() to do that for you.

Thanks,
Balbir
