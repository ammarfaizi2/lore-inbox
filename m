Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWGTVJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWGTVJF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 17:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWGTVJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 17:09:05 -0400
Received: from mail.gmx.net ([213.165.64.21]:41864 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030373AbWGTVJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 17:09:04 -0400
X-Authenticated: #5039886
Date: Thu, 20 Jul 2006 23:09:01 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Kari Hurtta <hurtta+gmane@siilo.fmi.fi>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC/PATCH] revoke/frevoke system calls
Message-ID: <20060720210901.GA29485@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Kari Hurtta <hurtta+gmane@siilo.fmi.fi>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <Pine.LNX.4.58.0607201504040.18901@sbz-30.cs.Helsinki.FI> <5dd5c0nixe.fsf@attruh.keh.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dd5c0nixe.fsf@attruh.keh.iki.fi>
User-Agent: Mutt/1.5.12-2006-07-14
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.07.20 23:02:53 +0300, Kari Hurtta wrote:
> Pekka J Enberg <penberg@cs.Helsinki.FI> writes in
> gmane.linux.file-systems,gmane.linux.kernel:
> 
> > From: Pekka Enberg <penberg@cs.helsinki.fi>
> > 
> > This patch implements the revoke(2) and frevoke(2) system calls for all
> > types of files. We revoke files in two passes: first we scan all open 
> > files that refer to the inode and substitute the struct file pointer in fd 
> > table with NULL causing all subsequent operations on that fd to fail. 
> > After we have done that to all file descriptors, we close the files and 
> > take down mmaps.
> > 
> > Note that now we need to unconditionally do fput/fget in sys_write and
> > sys_read because they race with do_revoke.
> > 
> > Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> What permissions is needed revoke access of other users open
> files ?
> 
> > +asmlinkage int sys_revoke(const char __user *filename)
> > +{
> > +	int err;
> > +	struct nameidata nd;
> > +
> > +	err = __user_walk(filename, 0, &nd);
> > +	if (!err) {
> > +		err = do_revoke(nd.dentry->d_inode, NULL);
> > +		path_release(&nd);
> > +	}
> > +	return err;
> > +}
> > +
> > +asmlinkage int sys_frevoke(unsigned int fd)
> > +{
> > +	struct file *file = fget(fd);
> > +	int err = -EBADF;
> > +
> > +	if (file) {
> > +		err = do_revoke(file->f_dentry->d_inode, file);
> > +		fput(file);
> > +	}
> > +	return err;
> > +}
> 
> Is that requiring only that user is able to refer file ?
> 
> 
> BSD manual page for revoke(2) seems say:
> 
>     Access to a file may be revoked only by its owner or the super user.

In do_revoke() there is:

+	if (current->fsuid != inode->i_uid && !capable(CAP_FOWNER)) {
+		ret = -EPERM;
+		goto out;

That pretty much matches what the BSD manpage says.

Björn
