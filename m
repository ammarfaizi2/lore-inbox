Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424318AbWLHERb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424318AbWLHERb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 23:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424315AbWLHERb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 23:17:31 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:42726 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424309AbWLHERa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 23:17:30 -0500
Date: Thu, 7 Dec 2006 23:16:59 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 15/35] Unionfs: Common file operations
Message-ID: <20061208041656.GB14363@filer.fsl.cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu> <11652354702903-git-send-email-jsipek@cs.sunysb.edu> <Pine.LNX.4.61.0612052155150.18570@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0612052155150.18570@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 10:02:10PM +0100, Jan Engelhardt wrote:
> On Dec 4 2006 07:30, Josef 'Jeff' Sipek wrote:
> >+long unionfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >+{
> >+	long err;
> >+
> >+	if ((err = unionfs_file_revalidate(file, 1)))
> >+		goto out;
> >+
> >+	/* check if asked for local commands */
> >+	switch (cmd) {
> >+		case UNIONFS_IOCTL_INCGEN:
> >+			/* Increment the superblock generation count */
> >+			err = -EACCES;
> >+			if (!capable(CAP_SYS_ADMIN))
> >+				goto out;
> >+			err = unionfs_ioctl_incgen(file, cmd, arg);
> >+			break;
> >+
> >+		case UNIONFS_IOCTL_QUERYFILE:
> >+			/* Return list of branches containing the given file */
> >+			err = unionfs_ioctl_queryfile(file, cmd, arg);
> >+			break;
> >+
> >+		default:
> >+			/* pass the ioctl down */
> >+			err = do_ioctl(file, cmd, arg);
> >+			break;
> >+	}
> >+
> >+out:
> >+	return err;
> >+}
> 
> 
> I think there was an ioctl for files to find out where a particular
> file lives on disk.

That's the UNIONFS_IOCTL_QUERYFILE case.

> Do you think unionfs should handle it and return
> something more or less meaningful?

It is a very useful functionality for any stackable filesystem which may
store files on one of several branches. Do I think that it should be
factored out of Unionfs into fsstack or similar? Not at the moment. If there
seems to be a need for it, then I'd gladly move it out of Unionfs, but until
then I don't see a reason to do anything special.

Josef "Jeff" Sipek.

-- 
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are, by
definition, not smart enough to debug it.
		- Brian W. Kernighan 
