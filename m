Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129265AbQKQU6E>; Fri, 17 Nov 2000 15:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129806AbQKQU5y>; Fri, 17 Nov 2000 15:57:54 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:45486 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129265AbQKQU5j>;
	Fri, 17 Nov 2000 15:57:39 -0500
Date: Fri, 17 Nov 2000 15:27:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Guest section DW <dwguest@win.tue.nl>
cc: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, Eric Paire <paire@ri.silicomp.fr>
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <20001117185638.A8452@win.tue.nl>
Message-ID: <Pine.GSO.4.21.0011171514210.18150-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Nov 2000, Guest section DW wrote:

> I see that an entire discussion has taken place. Let me just remark this,
> quoting the Austin draft:
> 
> If the path argument refers to a path whose final component is either
> dot or dot-dot, rmdir( ) shall fail.
> 
> EINVAL	The path argument contains a last component that is dot.
[snip]

> So, it seems that -EINVAL would be a better return value in case LAST_DOT.

No problems with that... Linus, could you apply the following (cut-and-paste
alert)?
--- fs/namei.c     Fri Nov 17 18:43:20 2000
+++ fs/namei.c.new Fri Nov 17 18:48:00 2000
@@ -1381,8 +1381,11 @@
                case LAST_DOTDOT:
                        error = -ENOTEMPTY;
                        goto exit1;
-               case LAST_ROOT: case LAST_DOT:
+               case LAST_ROOT:
                        error = -EBUSY;
+                       goto exit1;
+               case LAST_DOT:
+                       error = -EINVAL;
                        goto exit1;
        }
        down(&nd.dentry->d_inode->i_sem);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
