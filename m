Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbUB0JpV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 04:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbUB0JpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 04:45:21 -0500
Received: from fungus.teststation.com ([212.32.186.211]:63753 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S261751AbUB0JpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 04:45:15 -0500
Date: Fri, 27 Feb 2004 10:45:05 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Alain Fauconnet <alain@ait.ac.th>
cc: linux-kernel@vger.kernel.org
Subject: Re: smbfs broken in 2.4.25? (Too many open files in system)
In-Reply-To: <20040227022300.GA8072@ait.ac.th>
Message-ID: <Pine.LNX.4.44.0402271018090.15220-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Alain Fauconnet wrote:

> Looking   at   the   code   of   both   versions,   it   seems    that
> smb_proc_getattr_95()  (where  the  patch  you've  posted  lies)  uses
> smb_proc_getattr_trans2_std()  whereas  the   old   code   seemed   to
> completely avoid it in the W95 code path:
> 
> >From 2.4.24's ./fs/smbfs/proc.c:
> ========================================================================
>         /*
>          * Select whether to use core or trans2 getattr.
>          * Win 95 appears to break with the trans2 getattr.
>          */
>         if (server->opt.protocol < SMB_PROTOCOL_LANMAN2 ||
>             (server->mnt->flags & (SMB_MOUNT_OLDATTR|SMB_MOUNT_WIN95)) ) {  
>                 result = smb_proc_getattr_core(server, dir, fattr);
>         } else {
>                 if (server->mnt->flags & SMB_MOUNT_DIRATTR)
>                         result = smb_proc_getattr_ff(server, dir, fattr);
>                 else
>                         result = smb_proc_getattr_trans2(server, dir, fattr);
>         }
> ========================================================================

Yes, I know.

Unfortunately we want the trans2 version when reading directories, the
core version does not understand "long" filenames. The previous 2.4 code
does that, but uses the "core" version for getting file attributes.

The problem with using two different requests is that they have different
resolutions on file modification times. The core can only return odd- or
even-numbered seconds (I forget which). This makes programs like 'tar'
complain if the date they read from the dir does not always match the date
they read from getattr.


Now, when looking at the output of ethereal it re-reads attributes for the
/ inode a lot. It's not supposed to do a refresh if it thinks it has a
fairly recent copy, see smb_revalidate_inode and SMB_MAX_AGE. That could 
be making this problem worse.


> Am I completely off track here?

No, but you didn't know the background.

Btw, if you mount using the "oldattr" mount option you should get the
"core" behaviour back.

/Urban

