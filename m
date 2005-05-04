Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVEDNIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVEDNIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 09:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVEDNIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 09:08:11 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:16076 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261692AbVEDNID convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 09:08:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p2RxBEgjyA/HgX5Im7jugrJwVZVqTEcNgynvMPXiVks/qc/88ag1gbq2Z/E/GrUQcxdIXAfrvkCKU0TCkW5DPgQPabNCooR4kNOAp91gGEc/NF5ihqO9BIHGWcRGF1mDQyN+anlJv6+2qNaaEmK6/xnuMgnUaMNgR/jroELJZT8=
Message-ID: <a4e6962a05050406086e3ab83b@mail.gmail.com>
Date: Wed, 4 May 2005 08:08:00 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-Reply-To: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> This (lightly tested) patch against 2.6.12-rc* adds some
> infrastructure and basic functionality for unprivileged mount/umount
> system calls.
> 
> Details:
> 
>   - new mnt_owner field in struct vfsmount
>   - if mnt_owner is NULL, it's a privileged mount
>   - global limit on unprivileged mounts in  /proc/sys/fs/mount-max
>   - per user limit of mounts in rlimit

I was starting down this track in my tree, but I'm glad you beat me to it ;). 
Your initial limit (10) seems low if you consider binds as mounts.  I
can easily see a user using more than 10 binds in an environment.  As
Ram mentioned earlier - we are going to run into problems with the
shared-subtree stuff if propagations into private namespaces count as
a new mount.  We need to think through how we are going to deal with
this.

>   - allow umount for the owner (except force flag)
>   - allow unprivileged bind mount to files/directories writable by owner
>   - add nosuid,nodev flags to unprivileged mounts
> 
> Next step would be to add some policy for new mounts.  I'm thinking of
> either something static: e.g. FS_SAFE flag for "safe" filesystems, or
> a more configurable approach through sysfs or something.
> 

I think the FS_SAFE stuff needs to be part of this patch.  Folks made
a pretty good argument that mounting corrupted images with certain
file systems could be a really bad thing.  I'm not sure on the whole
sysfs configurable approach -- it seems like more advanced policies
would be best handled in user-space.

My  major complaint is that I really think having user mounts without
requiring them to be in a user's private namespace creates quite a
mess.  It potentially pollutes the system's namespace and opens up the
possibility of all sorts of synthetic file system "traps".  I'd rather
see the private namespace stuff enforced before enabling user-mounts.

       -eric
