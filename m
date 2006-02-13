Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWBMJt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWBMJt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWBMJt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:49:27 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:53885 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751686AbWBMJt0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:49:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d/07N4BnVxurrXQiXZmEQHZaLExCf0S31VnXcNKD5ooFKEORkHiABWdnkvrd6Nhvov+u0QMiHdctFY9+x4AFKZ2jc/qoNydkCKmiy33TM+6DlkkU2p4J6Hjd9uh8NXNTCx+5u+LfI1AZfZZ3J1nLyUC/Jsrt/qriAfMwlAilzls=
Message-ID: <84144f020602130149k72b8ebned89ff5719cdd0c2@mail.gmail.com>
Date: Mon, 13 Feb 2006 11:49:24 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Peter Osterlund <petero2@telia.com>
Subject: Re: [RFC][PATCH] UDF filesystem uid fix
Cc: linux-kernel@vger.kernel.org, Phillip Susi <psusi@cfl.rr.com>,
       bfennema@falcon.csc.calpoly.edu, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <m3lkwg4f25.fsf@telia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <m3lkwg4f25.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12 Feb 2006 19:17:38 +0100, Peter Osterlund <petero2@telia.com> wrote:
> The UDF filesystem refused to update the file's uid and gid on the
> disk if the in memory inode's id matched the values in the uid= and
> gid= mount options.  This was causing the owner to change from the
> desktop user to root when the volume was ejected and remounted.  I
> changed this so that if the inode's id matches the mount option, it
> writes a -1 to disk, because when the filesystem reads a -1 from disk,
> it uses the mount option for the in memory inode.  This allows you to
> use the uid/gid mount options in the way you would expect.

The UDF code really seems broken. It fails for new inodes and some
chown cases, when the mount options are being used. Phillip's patch
does not look like a complete fix, though, as it will store invalid
uid/gid (-1) for some cases where we probably should be storing the
real uid/gid. For example, doing chown <user> when the same user is
passed as mount option, we'll get -1 on disk, instead of user's uid.

I think the semantics you want is: "if uid/gid is invalid on disk,
leave it that way unless we explicitly change it via chown; otherwise
we can always overwrite it." Hmm?

                                  Pekka
