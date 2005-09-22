Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965206AbVIVERm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965206AbVIVERm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 00:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbVIVERm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 00:17:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:9193 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965206AbVIVERm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 00:17:42 -0400
Date: Thu, 22 Sep 2005 05:17:33 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Roland Dreier <rolandd@cisco.com>, dipankar@in.ibm.com,
       Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen on 2.6.14-rc2
Message-ID: <20050922041733.GF7992@ftp.linux.org.uk>
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com> <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org> <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com> <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43322AE6.1080408@nortel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 09:54:14PM -0600, Christopher Friesen wrote:
> Al Viro wrote:
> 
> >>Hmm... could there be a race in shmem_rename()??
> 
> >Not likely - in that setup all calls of ->unlink() and ->rename()
> >are completely serialized by ->i_sem on parent.  One question:
> >is it dcache or icache that ends up leaking?
> 
> dcache.  Here's some information I sent to dipankar earlier, with his 
> debug patch applied.  This is within half a second of the oom killer 
> kicking in.

Umm...   How many RCU callbacks are pending?  Since past the OOM you get
the sucker back to normal...  Sounds like you've got a bunch of dentries
on their way to be freed, but the thing that should've been doing final
kmem_cache_free() is getting postponed too much.
