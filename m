Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWDRF5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWDRF5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 01:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWDRF5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 01:57:49 -0400
Received: from uproxy.gmail.com ([66.249.92.170]:3493 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751397AbWDRF5s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 01:57:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dG1ifadY5fWde5g5IY3aKVipOtHmC7KrMXimDOELgDR0rF/Z+UPEA28J0e2ZaYFfm42yWj77xU+NcBn7vDVzRZN4jYbyDgUssKvLhrbDGBi7GJ37GgR2I6n/9B4ALdx4uqPRHSMmoOjvlKtykPKi8swNze+XoR9mvZZViEwh3sk=
Message-ID: <344eb09a0604172257g6936c24g48a6a78b3e245bc6@mail.gmail.com>
Date: Tue, 18 Apr 2006 11:27:47 +0530
From: "Bharata B Rao" <bharata.rao@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: shrink_dcache_sb scalability problem.
Cc: dgc@sgi.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       dipankar@in.ibm.com
In-Reply-To: <20060414225302.42270afe.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060413082210.GM1484909@melbourne.sgi.com>
	 <20060413015257.5b9d0972.akpm@osdl.org>
	 <20060414034332.GN1484909@melbourne.sgi.com>
	 <20060413222325.77f9ec9b.akpm@osdl.org>
	 <344eb09a0604142225t6e2d26eep94e1ffa64cf21803@mail.gmail.com>
	 <20060414225302.42270afe.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/06, Andrew Morton <akpm@osdl.org> wrote:
> "Bharata B Rao" <bharata.rao@gmail.com> wrote:
> >
> > > OT, I'm a bit curious about this:
> >  >
> >  >                 list_del_init(tmp);
> >  >                 spin_lock(&dentry->d_lock);
> >  >                 if (atomic_read(&dentry->d_count)) {
> >  >                         spin_unlock(&dentry->d_lock);
> >  >                         continue;
> >  >                 }
> >  >
> >  > So we rip the dentry off dcache_unused and just leave it floating about?
> >  > Dipankar, do you remember why that change was made, and why it's not a bug?
> >
> >  Due to lazy updating of the LRU list, there can be some dentries with non-zero
> >  ref counts on LRU list. This is one of the places where such dentries are
> >  removed from the LRU list. (Basically such dentries will be both on
> >  hash list and LRU
> >  list and here they get removed from the LRU list)
>
> OK.  But what guarantees that these live-but-detached dentries are
> appropriately destroyed before the unmount completes?

These are live dentries but not really detached, they are still attached to
the hash list. And yes I don't see shrink_dcache_sb holding the umount
because of these dentries. I assume dput of such dentries will happen
from different paths. But I am not sure if we could even end up in this
situation where we have landed up in shrink_dcache_sb from unmount path
and there are still some inuse dentries present. Need some clarification here.
>
> Or...  if these dentries will be freed by RCU callbacks potentially after
> the unmount, are we sure that they will always be in a state which will
> permit them to be freed?

When a dentry is queued for RCU freeing, there will be no references to
it from anywhere. It wouldn't be on hash list or on lru list. So I would think
only those dentries which are really freeable are queued for RCU freeing.

I see that shrink_dcache_sb is being called from the remount path
(do_remount_sb).
I couldn't understand why we do this. AFAICS we anyway don't modify the
mountpoint or the mount root during remount. Woudn't it be advantageous to
leave those dentries on LRU ?

Regards,
Bharata.
