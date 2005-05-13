Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVEMJAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVEMJAd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 05:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVEMJAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 05:00:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40399 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262310AbVEMJAO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 05:00:14 -0400
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, ericvh@gmail.com, 7eggert@gmx.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-Reply-To: <1115969123.6248.336.camel@localhost>
References: <20050511170700.GC2141@mail.shareable.org>
	 <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
	 <1115840139.6248.181.camel@localhost>
	 <20050511212810.GD5093@mail.shareable.org>
	 <1115851333.6248.225.camel@localhost>
	 <a4e6962a0505111558337dd903@mail.gmail.com>
	 <20050512010215.GB8457@mail.shareable.org>
	 <a4e6962a05051119181e53634e@mail.gmail.com>
	 <20050512064514.GA12315@mail.shareable.org>
	 <a4e6962a0505120623645c0947@mail.gmail.com>
	 <20050512151631.GA16310@mail.shareable.org>
	 <E1DWIms-0005nC-00@dorka.pomaz.szeredi.hu>
	 <1115946620.6248.299.camel@localhost> <1115969123.6248.336.camel@localhost>
Content-Type: multipart/mixed; boundary="=-J2+LKwenxBl8zOOtuuhO"
Organization: IBM 
Message-Id: <1115974780.6248.346.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 May 2005 01:59:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-J2+LKwenxBl8zOOtuuhO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-05-13 at 00:25, Ram wrote:
> On Thu, 2005-05-12 at 18:10, Ram wrote:
> > On Thu, 2005-05-12 at 11:51, Miklos Szeredi wrote:
> > > > > I'm not sure passing directory file descriptors is the right semantic
> > > > > we want - but at least it provides a point of explicit control (in
> > > > > much the same way as a bind).  Are you sure the clone + open("/") +
> > > > > pass-to-parent scenario you allows the parent to traverse the child's
> > > > > private name space through that fd?
> > > > 
> > > > Pretty sure.
> > > 
> > > Yup.  Attached a little program that can be used to try this out.  It
> > > creates a new namespace in the child, does a bind mount (so the
> > > namespaces can be differentiated), then sends the file descriptor of
> > > "/" to the parent.  The parent does fchdir(fd), then starts a shell.
> > 
> > 
> > > So the result is that CWD is under the child namespace, while root is
> > > under the initial namespace.
> > > 
> > 
> > r u sure, this program works? Sorry if I am saying something dumb here.
> > Correct me.  When a file descriptor is sent from one process to other,
> > arn't they referring to different files in each of the processes.
> > fd=5 may be pointing to file 'xyz' in parent process, 
> > where as fd=5 will be pointing to 'abc' in the child process.  
> > 
> > This program did not work for me, and I was wondering if adding
> > CLONE_FILES in clone() would help. Because that would make sure
> >  that both
> > the processes share the same file descriptor. It did not work too.
> > 
> > What am I understanding wrong?
> 
> Sorry it works. I was misinterpreting the results. 
> 
> > 
> > In any case my opinion is if this program works than the hole should
> > be closed instead of exploting it to access different namespace. I 
> > know Jamie is going to pounce at me. ;)
> 
> a patch is due to fix the problem :)


attached a patch that can fix the problem, if everybody agrees that its
a problem. 

> RP
> 

--=-J2+LKwenxBl8zOOtuuhO
Content-Disposition: attachment; filename=fix.patch
Content-Type: text/x-patch; name=fix.patch
Content-Transfer-Encoding: 7bit

--- /home/linux/views/linux-2.6.12-rc4/fs/open.c	2005-03-02 03:00:01.000000000 -0800
+++ linux-2.6.12-rc4/fs/open.c	2005-05-13 01:30:44.000000000 -0700
@@ -552,6 +552,8 @@
 	dentry = file->f_dentry;
 	mnt = file->f_vfsmnt;
 	inode = dentry->d_inode;
+	if(mnt->mnt_namespace != current->namespace)
+		goto out_putf;
 
 	error = -ENOTDIR;
 	if (!S_ISDIR(inode->i_mode))

--=-J2+LKwenxBl8zOOtuuhO--

