Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbTEHUbg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 16:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTEHUbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 16:31:35 -0400
Received: from [128.2.206.88] ([128.2.206.88]:31463 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262113AbTEHUbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 16:31:16 -0400
Date: Thu, 8 May 2003 16:43:34 -0400
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - Don't remove inode from hash until filesystem has deleted it.
Message-ID: <20030508204334.GA8577@delft.aura.cs.cmu.edu>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <16057.46720.778667.845306@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16057.46720.778667.845306@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 11:44:32AM +1000, Neil Brown wrote:
> ------------------------------------------------------
> Don't remove inode from hash until filesystem has deleted it.
>
> With this patch, the inode being deleted is left on the hash table,
> and if a lookup find an inode being freed in the hashtable, it waits
> in the inode waitqueue for the inode to be fully deleted.

I could be wrong, but won't that break the following sequence of
operations,

    mkdir("foo", 0755);
    fd = creat("foo/bar", 0644);
    unlink("foo/bar");
    rmdir("foo"); /* this should succeed, but if the file is hashed
		     we get EBUSY here */
    close(fd);

Or have potential deadlock effects when rmdir is replaced with some
operation that tries to perform a lookup for the inode, f.i. a
stat("foo/bar", &statbuf);

Jan

