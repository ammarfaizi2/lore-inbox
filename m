Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283860AbRLEJIt>; Wed, 5 Dec 2001 04:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283864AbRLEJIl>; Wed, 5 Dec 2001 04:08:41 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:10135 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S283850AbRLEJIW>;
	Wed, 5 Dec 2001 04:08:22 -0500
Message-Id: <5.1.0.14.2.20011205090142.04ab5b20@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 05 Dec 2001 09:08:12 +0000
To: Nathan Scott <nathans@sgi.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] Revised extended attributes interface
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:32 05/12/01, Nathan Scott wrote:
>Here is the revised interface.  I believe it takes into account
>the issues raised so far - further suggestions are also welcome,
>of course.

Hi,

Looks good to me. Just one tiny point: you seem to like setting error=xyz; 
a lot which is completely unnecessary some times. Any particular reason? 
Here is an example of what I mean:

>+static long
>+setxattr(struct dentry *d, char *name, void *value, size_t size, int flags)
>+{
>+       int error;
>+       void *kvalue;
>+       char kname[XATTR_NAME_MAX + 1];
>+
>+       error = -EINVAL;
>+       if (flags & ~(XATTR_CREATE|XATTR_REPLACE))
>+               return error;

Why not:

+       if (flags & ~(XATTR_CREATE|XATTR_REPLACE))
+               return -EINVAL;

>+
>+       error = -EFAULT;
>+       if (copy_from_user(kname, name, XATTR_NAME_MAX))
>+               return error;

+       if (copy_from_user(kname, name, XATTR_NAME_MAX))
+               return -EFAULT;

>+       kname[XATTR_NAME_MAX] = '\0';
>+
>+       kvalue = xattr_alloc(size, XATTR_SIZE_MAX);
>+       if (IS_ERR(kvalue))
>+               return PTR_ERR(kvalue);
>+
>+       error = -EFAULT;
>+       if (size > 0 && copy_from_user(kvalue, value, size)) {
>+               xattr_free(kvalue, size);
>+               return error;
>+       }

+       if (size > 0 && copy_from_user(kvalue, value, size)) {
+               xattr_free(kvalue, size);
+               return -EFAULT;
+       }

Shorter, faster in the common non-error path, and looks nicer, although the 
latter is probably a matter of personal preference. (-;

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

