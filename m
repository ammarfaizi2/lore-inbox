Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVAUVgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVAUVgu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbVAUVgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:36:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17566 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262511AbVAUVgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:36:31 -0500
Subject: Re: Fix ea-in-inode default ACL creation
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Tridgell <tridge@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1106245344.15959.13.camel@winden.suse.de>
References: <1106245344.15959.13.camel@winden.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106343376.1989.437.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 21 Jan 2005 21:36:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2005-01-20 at 18:22, Andreas Gruenbacher wrote:

> When a new inode is created, ext3_new_inode sets the EXT3_STATE_NEW
> flag, which tells ext3_do_update_inode to zero out the inode before
> filling in the inode's data. When a file is created in a directory with
> a default acl, the new inode inherits the directory's default acl; this
> generates attributes. The attributes are created before
> ext3_do_update_inode is called to write out the inode. In case of
> in-inode attributes, the new inode's attributes are written, and then
> zeroed out again by ext3_do_update_inode. Bad thing.
> 
> Fix this by recognizing the EXT3_STATE_NEW case in
> ext3_xattr_set_handle, and zeroing out the inode there already when
> necessary.

Ugh.  It feels horrible to have to do this, but we _do_ want to clear
the raw inode, and we only want to do it once, and we have to do it on
first access to the on-disk structures.  I can't see an easy way round
it that doesn't add more overhead.

Looks reasonable to me.

--Stephen

