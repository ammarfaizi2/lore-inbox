Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266796AbUHZAMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266796AbUHZAMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266854AbUHZAMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 20:12:36 -0400
Received: from mail.shareable.org ([81.29.64.88]:35269 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266796AbUHZAMC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:12:02 -0400
Date: Thu, 26 Aug 2004 01:11:52 +0100
From: Jamie Lokier <jamie@shareable.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826001152.GB23423@mail.shareable.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message suggests a way to extend the VFS safe locking rules to
include files-as-directories.

viro@parcelfarce.linux.theplanet.co.uk wrote:
> Note that currently it's OK - we get "all non-directories are always locked
> after all directories".  With filesystem that provides hybrid objects with
> non-NULL ->link() it's not true and we are in deadlock country.  Before
> we get anywhere near fs code.

Is this a problem if we treat entering a file-as-directory as crossing
a mount point (i.e. like auto-mounting)?

Simply doing a path walk would lock the file and then cross the mount
point to a directory.

A way to ensure that preserves the lock order is to require that the
metadata is in a different filesystem to its file (i.e. not crossing a
bind mount to the same filesystem).

That has the side effect of preventing hard links between metadata
files and non-metadata, which in my opinion is fine.

Path walking will lock the file, and then lock the directory on a
different filesystem.  Lock order is still safe, provided a strict
order is maintained between the two filesystems.

The strict order is ensured by preventing bind mounts which create a
path cycle containing a file->metadata edge.  One way to ensure that
is to prevent mounts on the metadata filesystems, but the rule doesn't
have to be that strict.  This condition only needs to be checked in
the mount() syscall.

-- Jamie
