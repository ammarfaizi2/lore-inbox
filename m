Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVBPPzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVBPPzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 10:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVBPPzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 10:55:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4521 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262052AbVBPPy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 10:54:59 -0500
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16915.27837.309170.73909@segfault.boston.redhat.com>
Date: Wed, 16 Feb 2005 10:54:37 -0500
To: raven@themaw.net
Cc: Jan Blunck <j.blunck@tu-harburg.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] dcache d_drop() bug fix / __d_drop() use fix
In-Reply-To: <Pine.LNX.4.61.0502162318240.8161@donald.themaw.net>
References: <421355A4.6000305@tu-harburg.de>
	<Pine.LNX.4.61.0502162318240.8161@donald.themaw.net>
X-Mailer: VM 7.19 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [PATCH] dcache d_drop() bug fix / __d_drop() use fix; raven@themaw.net adds:

raven> On Wed, 16 Feb 2005, Jan Blunck wrote:
>> This is a re-submission of the patch I sent about a month ago.
>> 
>> While working on my code I realized that d_drop() might race against 
>> __d_lookup(). __d_drop() (which is called by d_drop() after acquiring the 
>> dcache_lock) is accessing dentry->d_flags to set the DCACHE_UNHASHED flag. 
>> This shouldn't be done without holding dentry->d_lock, like stated in 
>> dcache.h:
>> 
>> struct dentry {
>> ...
>> unsigned int d_flags;		/* protected by d_lock */
>> ...
>> };
>> 
>> Therefore d_drop() must acquire the dentry->d_lock. Likewise every use of 
>> __d_drop() must acquire that lock.
>> 
>> This patch fixes d_drop() and every grep'able __d_drop() use. This patch is 
>> against today's http://linux.bkbits.net/linux-2.5.
>> 

raven> For my part, in autofs4, I would prefer:

> --- linux-2.6.9/fs/autofs4/root.c.d_lock	2005-02-16 23:15:18.000000000 +0800
> +++ linux-2.6.9/fs/autofs4/root.c	2005-02-16 23:15:35.000000000 +0800
> @@ -621,7 +621,7 @@
>   		spin_unlock(&dcache_lock);
>   		return -ENOTEMPTY;
>   	}
> -	__d_drop(dentry);
> +	d_drop(dentry);
>   	spin_unlock(&dcache_lock);

>   	dput(ino->dentry);

Ian, this would deadlock.  You already hold the dcache lock here, and
d_drop takes it:

static inline void d_drop(struct dentry *dentry)
{
        spin_lock(&dcache_lock);
        __d_drop(dentry);
        spin_unlock(&dcache_lock);
}

The proposed patch was to take the dentry->d_lock.

-Jeff
