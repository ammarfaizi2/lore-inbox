Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWITMVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWITMVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 08:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWITMVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 08:21:33 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:41123 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751188AbWITMVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 08:21:32 -0400
Date: Wed, 20 Sep 2006 08:21:30 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>
Subject: Re: [PATCH 1/11] LTTng-core 0.5.111 : Relay+DebugFS (DebugFS fix)
Message-ID: <20060920122130.GB25639@Krystal>
References: <20060916075103.GB29360@Krystal> <20060917160705.GB6326@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060917160705.GB6326@suse.de>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 08:18:34 up 28 days,  9:27,  2 users,  load average: 0.07, 0.55, 0.78
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (gregkh@suse.de) wrote:
> On Sat, Sep 16, 2006 at 03:51:03AM -0400, Mathieu Desnoyers wrote:
> > 1 - DebugFS stalled dentry patch
> > DebugFS seems to keep a stalled dentry when a process is in a directory that is
> > being removed. Force a differed deletion.
> > patch-2.6.17-lttng-core-0.5.111-debugfs.diff
> > 
> > 
> > OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
> > Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
> 
> > --- a/fs/debugfs/inode.c
> > +++ b/fs/debugfs/inode.c
> > @@ -266,6 +266,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_dir);
> >  void debugfs_remove(struct dentry *dentry)
> >  {
> >  	struct dentry *parent;
> > +	int ret = 0;
> >  	
> >  	if (!dentry)
> >  		return;
> > @@ -278,9 +279,10 @@ void debugfs_remove(struct dentry *dentr
> >  	if (debugfs_positive(dentry)) {
> >  		if (dentry->d_inode) {
> >  			if (S_ISDIR(dentry->d_inode->i_mode))
> > -				simple_rmdir(parent->d_inode, dentry);
> > +				ret = simple_rmdir(parent->d_inode, dentry);
> >  			else
> > -				simple_unlink(parent->d_inode, dentry);
> > +				ret = simple_unlink(parent->d_inode, dentry);
> > +			if(ret) d_delete(dentry);
> 
> Are you saying that perhaps all other users of simple_unlink() are also
> broken like this?  If so, why not just fix simple_unlink()?
> 

I don't think that libfs is fundamentally broken, as simple_unlink always
returns 0 but simple_rmdir may fail if !simple_empty(dentry). I think that the
decision of what to do in such situation is "simply" left to the caller.

But you probably know more than I do on that matter.

Mathieu



OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
