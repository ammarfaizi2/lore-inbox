Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272855AbSISULY>; Thu, 19 Sep 2002 16:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272851AbSISULW>; Thu, 19 Sep 2002 16:11:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4364 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S272843AbSISULV>;
	Thu, 19 Sep 2002 16:11:21 -0400
Date: Thu, 19 Sep 2002 21:16:23 +0100
From: Matthew Wilcox <willy@debian.org>
To: Burton Windle <bwindle@fint.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [2.5.36] oops when reading /proc/locks
Message-ID: <20020919211623.B10583@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[note: please cc me or linux-fsdevel when reporting file locking bugs;
i only read linux-kernel on the web and as time permits]

It looks to me like your dereference comes from this line:

        if (fl->fl_file != NULL)
                inode = fl->fl_file->f_dentry->d_inode;

and, if my terribly weak x86 assembler isn't deceiving me, f_dentry
is NULL.  Since you can reproduce this at will, could you insert some
debugging for me?

	if (fl->fl_file != NULL) {
		if (fl->fl_file->f_dentry) {
			inode = fl->fl_file->f_dentry->d_inode;
		} else {
			printk(KERN_EMERG "null dentry at %d\n", id);
		}
	}

That will avoid the oops, and tell us who managed to set a file lock on
a file without a dentry.

-- 
Revolutions do not require corporate support.
