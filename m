Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUEWWvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUEWWvv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 18:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUEWWvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 18:51:51 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:13704 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263698AbUEWWv2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 18:51:28 -0400
Subject: Re: [FIX] kernel BUG at fs/locks.c:1723!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chris Mason <mason@suse.com>
In-Reply-To: <200405232350.16169.agruen@suse.de>
References: <200405232350.16169.agruen@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1085352682.579.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 23 May 2004 18:51:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 23/05/2004 klokka 17:50, skreiv Andreas Gruenbacher:

> Here's a proposed fix. As a side effect, steal_locks no longer walks the 
> global list of locks, but only the locks of all open inodes.
> 
> What are the reasons (other than historic ones) for not getting rid of 
> fl_owner and using fl_pid instead, by the way? I think that would clean up 
> the whole mess with file locks a bit.

If I understand correctly, the fl_owner was introduced in order to deal
with the problem of lockd which has no control over which pids it has to
use. You should probably check with Olaf though...

In the end, this made for a horrible "solution", and causes no end of
bugs. Look for instance at the code in locks_remove_posix() which breaks
POSIX 'cos it gets the whole idea wrong and thinks that it suffices to
test the fl_owner instead of doing fl_pid (at least posix_same_owner() &
friends get that right).
IMO it would be better to set fl_owner to NULL for ordinary processes
(instead of dealing with this mess inside current->files), and then let
lockd set current->files in whatever way it needs to in order to
distinguish the various "pid spaces" it deals with...

Cheers,
  Trond
