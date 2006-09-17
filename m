Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWIRMJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWIRMJc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 08:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWIRMJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 08:09:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:1473 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965005AbWIRMJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 08:09:17 -0400
Date: Sun, 17 Sep 2006 09:07:05 -0700
From: Greg KH <gregkh@suse.de>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>
Subject: Re: [PATCH 1/11] LTTng-core 0.5.111 : Relay+DebugFS (DebugFS fix)
Message-ID: <20060917160705.GB6326@suse.de>
References: <20060916075103.GB29360@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060916075103.GB29360@Krystal>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2006 at 03:51:03AM -0400, Mathieu Desnoyers wrote:
> 1 - DebugFS stalled dentry patch
> DebugFS seems to keep a stalled dentry when a process is in a directory that is
> being removed. Force a differed deletion.
> patch-2.6.17-lttng-core-0.5.111-debugfs.diff
> 
> 
> OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
> Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -266,6 +266,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_dir);
>  void debugfs_remove(struct dentry *dentry)
>  {
>  	struct dentry *parent;
> +	int ret = 0;
>  	
>  	if (!dentry)
>  		return;
> @@ -278,9 +279,10 @@ void debugfs_remove(struct dentry *dentr
>  	if (debugfs_positive(dentry)) {
>  		if (dentry->d_inode) {
>  			if (S_ISDIR(dentry->d_inode->i_mode))
> -				simple_rmdir(parent->d_inode, dentry);
> +				ret = simple_rmdir(parent->d_inode, dentry);
>  			else
> -				simple_unlink(parent->d_inode, dentry);
> +				ret = simple_unlink(parent->d_inode, dentry);
> +			if(ret) d_delete(dentry);

Are you saying that perhaps all other users of simple_unlink() are also
broken like this?  If so, why not just fix simple_unlink()?

Also, wrong coding style used :(

thanks,

greg k-h
