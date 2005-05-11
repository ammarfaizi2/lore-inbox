Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVEKSUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVEKSUo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVEKSUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:20:43 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:31139 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262005AbVEKST3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:19:29 -0400
Message-ID: <42824CA7.9040201@austin.rr.com>
Date: Wed, 11 May 2005 13:19:19 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
References: <4272A275.4030801@austin.rr.com> <20050429213108.GA15262@infradead.org> <4272B335.5090207@austin.rr.com> <20050511085619.GA24841@infradead.org>
In-Reply-To: <20050511085619.GA24841@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>
>should export it in /proc/<pid>/mounts, which is
>an ASCII interface and any half-sane parser does not depend on the width
>of the field in the kernel.
>
>Can we please get rid of the broken ioctl now so it doesn't become part
>of the ABI and you'll add the trivial output to /proc/<pid>/mounts?
>
>
>  
>
OK - why don't we just add this (ie the ioctl removal) to the patch

[PATCH] unprivileged mount/umount

of Miklos et al, since that removes the need to modify showmounts (and 
avoids any name collision/confusion
with the existing meaning of the mount option "uid" ie as the default 
uid to use for files on the system when
mounting to servers which can not return inode owners as uids).

On another topic relating to ioctls, various people have suggested 
adding an ioctl to add a table to optionally map file owner (uid / gid 
mapping tables) on remote filesystems. Although this is easy enough to 
do for the case of CIFS, this seems like a function (loading the table) 
that could be done via /proc or perhaps even sysfs. Is there are 
precedent for doing this on Linux? Googling I see various examples where 
NFS client on other platforms (not Linux) have done something vaguely 
similar. NFSv4 uses an upcall for this (although they are mapping 
slightly differently since they now receive a fully qualified username 
and have to map this to a loca uid, rather than getting a remote uid to 
local uid as earlier nfs did). The general issue is that when mounting 
to multiple Unix/Linux servers (especially in different domains), unlike 
in Windows (or perhaps MacOS), similar users are defined with different 
uids, and there are cases where mapping uids/gids or ranges of uids/gids
from that returned from the server would be helpful. The mapping table 
would have to hang off the tree connection or the SMB session for the 
case of CIFS but I would rather not use an ioctl to load it, yet if the 
table ever got big, I would prefer not to use /proc either. Is there a 
recommended approach.
