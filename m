Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWDBSnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWDBSnR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 14:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWDBSnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 14:43:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44958 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751395AbWDBSnQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 14:43:16 -0400
Date: Sun, 2 Apr 2006 19:43:15 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC replace some locking of i_sem wiht atomic_t
Message-ID: <20060402184315.GD27946@ftp.linux.org.uk>
References: <bda6d13a0603311608p5b74df13i259c2b9efa539330@mail.gmail.com> <bda6d13a0604021101h6cd362efn6d832bfb1275080c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda6d13a0604021101h6cd362efn6d832bfb1275080c@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 11:01:30AM -0700, Joshua Hudson wrote:
> Herein lies the problem with the current locking scheme:
> 1. rename locks target if it exists, but target may be created by
> link() immediately
> after the check&lock procedure.
> 2. The target of link() is completely unprotected.
 
3. You have failed to RTFS or RTFM.

> Against ext2, this can result in a corrupted filesystem (two directory
> entries with
> the same name) by a three-way race between two instances of link() and one
> unlink().

Not really.
 
> 1. Both instances of link are started with target being the same name
> in the same directory.
> 2. unlink() is started on a different name in the same directory.
> 3. link() 1 doesn't find a free slot in the first page, moves to the second.
>     *rescheduled before locking second page*
> 4. unlink() finds target in first page, removes it.
> 5. link() 2 finds free slot in first page, creates entry, finishes
> 6. link() 1 continues, finds space in second page, creates entry

And this is BS, since link() _does_ grab ->i_sem on directory it modifies.
So does unlink().
