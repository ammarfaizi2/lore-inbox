Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129700AbQKVBdd>; Tue, 21 Nov 2000 20:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbQKVBdY>; Tue, 21 Nov 2000 20:33:24 -0500
Received: from hera.cwi.nl ([192.16.191.1]:15531 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129700AbQKVBdJ>;
	Tue, 21 Nov 2000 20:33:09 -0500
Date: Wed, 22 Nov 2000 02:02:40 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011220102.CAA141029.aeb@aak.cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] isofs/rock.c
Cc: wkj@eecs.harvard.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William K. Josephson <wkj@eecs.harvard.edu>
wrote on Sun, 8 Oct 2000:

> While writing some user-space code recently, I ran across two bugs
> in the Rock Ridge support code.  First, a bogus return value and
> second links on the cd of the form foo->/bar are returned
> as foo->//bar.  This should fix it.

I think he was mistaken on both counts.
The present 2.4.0test11 only contains the first of his patches.
The 1-line patch below undoes that (and reintroduces some ugliness).

--- rock.c~     Tue Nov 21 21:44:14 2000
+++ rock.c      Wed Nov 22 00:55:33 2000
@@ -215,7 +215,7 @@
        printk("RR: RE (%x)\n", inode->i_ino);
 #endif
        if (buffer) kfree(buffer);
-       return 0;
+       return -1;
       default:
        break;
       }

[pasted from another window].

Concerning the case above: a RE entry denotes a relocated
directory, something we do not want to see here, so we
should return a "nothing" value.
The ugly code we used to have made get_rock_ridge_filename()
as called in dir.c return -1, and the code
		map = 1;
		if (we_have_rockridge) {
                        len = get_rock_ridge_filename(de, tmpname, inode);
                        if (len != 0) {
                                p = tmpname;
                                map = 0;
                        }
                }
                if (map) {
			...
		}
		if (len > 0) {
			...
		}
		filp->f_pos += de_len;
		continue;
	}
would make sure that nothing was done with this filename
and f_pos incremented, entirely as desired.
What 2.4.0test11 does is return 0, but now map is still 1,
and the code invents a real filename there, and then
comes with annoying console messages
	Attempt to read inode for relocated directory

So, the old situation was ugly but correct, the new situation wrong.

(I describe this in so much detail because I can readily imagine
that you would like to polish things a bit more.
This get_rock_ridge_filename is also called in namei.c, and
the -1 return value leads to obscure nonsense,
that happens to work today.)

Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
