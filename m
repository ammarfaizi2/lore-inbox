Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263386AbTJQLDZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 07:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTJQLDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 07:03:25 -0400
Received: from mail.jambit.de ([212.18.21.206]:13323 "EHLO mail.jambit.de")
	by vger.kernel.org with ESMTP id S263386AbTJQLDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 07:03:20 -0400
Message-ID: <008b01c3949e$36cf3a40$c100a8c0@wakatipu>
From: "Michael Kerrisk" <mtk-lists@jambit.com>
To: "Andreas Gruenbacher" <agruen@suse.de>, <linux-kernel@vger.kernel.org>
References: <1066316719.15192.3.camel@E136.suse.de>
Subject: Re: permission() bug?
Date: Fri, 17 Oct 2003 13:02:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher wrote:

> I think there is a bug in fs/namei.c:vfs_permission(). The function
> contains:
> 
> 
>     int vfs_permission(struct inode * inode, int mask)
>     {
> [...]
>         /*
>          * Read/write DACs are always overridable.
>          * Executable DACs are overridable if at least one exec
>          * bit is set.
>          */
>         if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
>                 if (capable(CAP_DAC_OVERRIDE))
>                         return 0;
> [...]
> return -EACCES;
>     }
> 
> 
> The comment makes sense; the code doesn't quite implement what the
> comment says. Consider the case of an inode with  "--" permissions. We
> get the following results:
> 
> permission(inode, MAY_READ) = 0
> permission(inode, MAY_EXEC) = -EACCESS
> permission(inode, MAY_READ|MAY_EXEC = 0
> 
> The last result seems wrong; I would expect -EACCESS instead. 

Some pieces from SUSv3 that look relevant to me:

[[
<unistd.h>

    The constants F_OK, R_OK, W_OK, and X_OK and the expressions 
    R_OK|W_OK, R_OK|X_OK, and R_OK|W_OK|X_OK shall all have 
    distinct values.

access()
    If any access permissions are checked, each shall be checked 
    individually, as described in the Base Definitions volume of 
    IEEE Std 1003.1-2001, Chapter 3, Definitions. If the process 
    has appropriate privileges, an implementation may indicate 
    success for X_OK even if none of the execute file permission 
    bits are set.

    ERRORS
    [EACCES] Permission bits of the file mode do not 
    permit the requested access, or search permission is 
    denied on a component of the path prefix. 
]]

The implication of all this is that it is bits/masks that are
relevant for the check.  In this interpretation it is nonsensical 
that access() on a file with no perms should return:

0 if mask is R_OK | X_OK

but

-1/EACCES if mask is just X_OK.

I'd say that in this case, both of these calls should fail 
(-1/EACCES), though in my reading of the following,
SUSv3 allows (but discourages) the possibility that both 
would succeed.  (What is bizarre is the current scenario 
where one of the above calls succeeds and the other fails...)

[[
SUSv3 rationale to access():
    In early proposals, some inadequacies in the access() 
    function led to the creation of an eaccess() function 
    because:

    1. Historical implementations of access() do not test 
    file access correctly when the process' real user 
    ID is superuser. In particular, they always return
    zero when testing execute permissions without regard 
    to whether the file is executable.

    2. The superuser has complete access to all files on a 
    system. As a consequence, programs started by the 
    superuser and switched to the effective user ID with 
    lesser privileges cannot use access() to test their 
    file access permissions.

    However, the historical model of eaccess() does not 
    resolve problem (1), so this volume of IEEE Std 
    1003.1-2001 now allows access() to behave in the desired 
    way because several implementations have corrected the 
    problem. It was also argued that problem (2) is more 
    easily solved by using open(), chdir(), or one of the
    exec functions as appropriate and responding to the 
    error, rather than creating a new function that would 
    not be as reliable. Therefore, eaccess() is not included 
    in this volume of IEEE Std 1003.1-2001.

    The sentence concerning appropriate privileges and 
    execute permission bits reflects the two possibilities 
    implemented by historical implementations when checking
    superuser access for X_OK.

    New implementations are discouraged from returning X_OK 
    unless at least one execution permission bit is set.
]]

> So IMHO
> the code in permission (and in the file system specific copies) should
> read:
> 
>         if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
>                 if (capable(CAP_DAC_OVERRIDE))
>                         return 0;

The above is consistent with how I interpret SUSv3.

Cheers,

Michael
