Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbSLFQHp>; Fri, 6 Dec 2002 11:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSLFQHp>; Fri, 6 Dec 2002 11:07:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47884 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263280AbSLFQHn>;
	Fri, 6 Dec 2002 11:07:43 -0500
Date: Fri, 6 Dec 2002 16:15:19 +0000
From: Matthew Wilcox <willy@debian.org>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 2.5.50: unused code in link_path_walk()
Message-ID: <20021206161519.A16341@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


@@ -700,7 +700,6 @@
                                 if (this.name[1] != '.')
                                         break;
                                 follow_dotdot(&nd->mnt, &nd->dentry);
-				inode = nd->dentry->d_inode;
                                 /* fallthrough */
                         case 1:
                                 goto return_base;

seems broken to me.  if follow_dotdot() changes nd->dentry (can happen!),
inode needs to be changed.  look:

        inode = nd->dentry->d_inode;
        for(;;) {
                err = exec_permission_lite(inode);
                if (this.name[0] == '.') switch (this.len) {
                        case 2: 
                                if (this.name[1] != '.')
                                        break;
                                follow_dotdot(&nd->mnt, &nd->dentry);
                                inode = nd->dentry->d_inode;
                                /* fallthrough */
                        case 1:
                                continue;
                }
        }

btw, you should cc linux-fsdevel for patches to the VFS.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
