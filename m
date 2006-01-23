Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWAWP5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWAWP5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWAWP5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:57:32 -0500
Received: from mx1.suse.de ([195.135.220.2]:39094 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751481AbWAWP5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:57:31 -0500
Date: Mon, 23 Jan 2006 16:57:28 +0100
From: Jan Blunck <jblunck@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, olh@suse.de
Subject: Re: [PATCH] shrink_dcache_parent() races against shrink_dcache_memory()
Message-ID: <20060123155728.GC26653@hasse.suse.de>
References: <20060120203645.GF24401@hasse.suse.de> <43D48ED4.3010306@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43D48ED4.3010306@sw.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, Kirill Korotaev wrote:

> 
> 1. this patch doesn't fix the whole problem. iput() after sb free is 
> still possible. So busy inodes after umount too.
> 2. it has big problems with locking...
> 

Yes, you're right. I'll fix that and send an updated version.

> >+			goto repeat;
> <<<< I would prefer to have "goto repeat" as it was before...
> >+		/* out */
> >+	}

Fair.

> >+	if (atomic_add_unless(&dentry->d_count, -1, 1))
> >+		return;
> <<<< I would better introduce __dput_locked() w/o atomic_dec_and_test() 
> instead of using this atomic_add_unless()...
> <<<< For me it looks like an obfuscation of a code, which must be clean 
> and tidy.

Then it isn't dput_locked() anymore and you have to manually dereference
before you use __dput_locked(). Doesn't sound better. I'll give it a try ...

> >+
> >+	spin_lock(&dcache_lock);
> >+	dput_locked(dentry, &free_list);
> >+	spin_unlock(&dcache_lock);
> >+
> <<<< 1. locking here is totally broken... spin_unlock() in dentry_iput()

Yes, I totally missed the locking issue here. I'll rework that one.

> <<<< 2. it doesn't help the situation I wrote to you,
> <<<<    since iput() can be done on inode _after_ sb freeing...

Hmm, will think about that one again. shrink_dcache_parent() and
shrink_dcache_memory()/dput() are not racing against each other now since the
reference counting is done before giving up dcache_lock and the select_parent
could start.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
