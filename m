Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTFTQXz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 12:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTFTQXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 12:23:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13472 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263295AbTFTQXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 12:23:54 -0400
Date: Fri, 20 Jun 2003 17:37:55 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VFS autmounter support v3
Message-ID: <20030620163755.GH6754@parcelfarce.linux.theplanet.co.uk>
References: <25482.1056125836@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25482.1056125836@warthog.warthog>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 05:17:16PM +0100, David Howells wrote:
 
>  (2) Automatic mount point expiry. This allows any mountpoint to be given a
>      timeout, such that when mntput() detects that the vfsmount is only used
>      by its parent, a work chitty will be enqueued to cause the containing
>      namespace to be vacuumed later for dead mounts.

Broken.
	a) it doesn't scale.  A single expirable mountpoint and we will be
walking potentially very long list.
	b) the logics is wrong - you are scheduling "let's go and expire
stuff" when ->mnt_count drops far enough; put something like /usr/share
on a separate fs and observe what happens to ->mnt_count.  It will touch
the trigger value very often.  Better yet, do that with /usr/include and
start a big build.  You will have your expiry code triggered all the time,
even though fs is in very active use.
