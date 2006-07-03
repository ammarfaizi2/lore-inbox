Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWGCRsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWGCRsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 13:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWGCRsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 13:48:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:19428 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751227AbWGCRsJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 13:48:09 -0400
Date: Mon, 3 Jul 2006 18:48:04 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       serue@us.ibm.com
Subject: Re: [PATCH 20/20] honor r/w changes at do_remount() time
Message-ID: <20060703174804.GD29920@ftp.linux.org.uk>
References: <20060627221436.77CCB048@localhost.localdomain> <20060627221457.04ADBF71@localhost.localdomain> <20060628051935.GA29920@ftp.linux.org.uk> <1151947814.11159.147.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151947814.11159.147.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 10:30:14AM -0700, Dave Hansen wrote:
> On Wed, 2006-06-28 at 06:19 +0100, Al Viro wrote:
> >         * make the moments when i_nlink hits 0 bump the superblock writers
> > count; drop it when such sucker gets freed on final iput. 
> 
> Could you elaborate on this one a bit?  
> 
> I assume that there are rules that once i_nlink hits 0, it never goes
> back up again.  It seems that a whole bunch (if not all) of the
> individual filesystems do things to it.  Is it really necessary to go
> into all of those looking for the places that i_nlink hits 0?  Seems
> like it would be an awful lot of patching.

Not that much...  That happens in three methods (->unlink(), ->rename(),
->rmdir()) and yes, we really want to track those.  Think for a minute
and you'll see why - we don't want to allow remount ro when there is
a pending truncate/freeing inode.
