Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWDBSBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWDBSBc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 14:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWDBSBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 14:01:31 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:60879 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932404AbWDBSBb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 14:01:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S1WWgFHbNZ3PUOEs2neNu7hdB6D2GXWInjlPa87JBgwRd6Ls+tA0aW/5G0vNWkeE+9/RV+JJ7h+UI2WwyVsTkOhexIKAIkquVL+0xY7XtfhDrk3MARuZ2xsGaoyQKMQivApJwKspE0aOIkiFIUHXpZxkVHdETqtKLfdEKIapgsA=
Message-ID: <bda6d13a0604021101h6cd362efn6d832bfb1275080c@mail.gmail.com>
Date: Sun, 2 Apr 2006 11:01:30 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC replace some locking of i_sem wiht atomic_t
In-Reply-To: <bda6d13a0603311608p5b74df13i259c2b9efa539330@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a0603311608p5b74df13i259c2b9efa539330@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/06, Joshua Hudson <joshudson@gmail.com> wrote:
> This might be a way to decrease complexity of locking in vfs.
>
> Basic idea: for local filesystems, i_sem gets taken on several objects
> only to protect i_nlink.
> These can be removed if i_nlink is atomic.
>
That doesn't work. Some code in affs I don't understand and the code in ext2
that checks for maximum hard links basically makes this not work. The
ext2 problem is solvable in assembly (adding a new atomic_* operation),
but the affs problem is not.

Scratch that idea.

Herein lies the problem with the current locking scheme:
1. rename locks target if it exists, but target may be created by
link() immediately
after the check&lock procedure.
2. The target of link() is completely unprotected.

Against ext2, this can result in a corrupted filesystem (two directory
entries with
the same name) by a three-way race between two instances of link() and one
unlink().

1. Both instances of link are started with target being the same name
in the same directory.
2. unlink() is started on a different name in the same directory.
3. link() 1 doesn't find a free slot in the first page, moves to the second.
    *rescheduled before locking second page*
4. unlink() finds target in first page, removes it.
5. link() 2 finds free slot in first page, creates entry, finishes
6. link() 1 continues, finds space in second page, creates entry
