Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTJPPF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 11:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbTJPPF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 11:05:27 -0400
Received: from ns.suse.de ([195.135.220.2]:42982 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262960AbTJPPFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 11:05:20 -0400
Subject: permission() bug?
From: Andreas Gruenbacher <agruen@suse.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SuSE Labs, SuSE Linux AG
Message-Id: <1066316719.15192.3.camel@E136.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 16 Oct 2003 17:05:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I think there is a bug in fs/namei.c:vfs_permission(). The function
contains:


    int vfs_permission(struct inode * inode, int mask)
    {
	[...]
        /*
         * Read/write DACs are always overridable.
         * Executable DACs are overridable if at least one exec
         * bit is set.
         */
        if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
                if (capable(CAP_DAC_OVERRIDE))
                        return 0;
	[...]
	return -EACCES;
    }


The comment makes sense; the code doesn't quite implement what the
comment says. Consider the case of an inode with  "--" permissions. We
get the following results:

	permission(inode, MAY_READ)		= 0
	permission(inode, MAY_EXEC)		= -EACCESS
	permission(inode, MAY_READ|MAY_EXEC	= 0

The last result seems wrong; I would expect -EACCESS instead. So IMHO
the code in permission (and in the file system specific copies) should
read:

        if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
                if (capable(CAP_DAC_OVERRIDE))
                        return 0;


Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SuSE Labs, SuSE Linux AG <http://www.suse.de/>

