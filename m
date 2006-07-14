Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422675AbWGNRhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWGNRhi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422676AbWGNRhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:37:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22480 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422675AbWGNRhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:37:37 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	<1152815391.7650.58.camel@localhost.localdomain>
	<m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	<1152821011.24925.7.camel@localhost.localdomain>
	<m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>
	<1152887287.24925.22.camel@localhost.localdomain>
	<m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
	<20060714162935.GA25303@sergelap.austin.ibm.com>
	<m18xmwuo5r.fsf@ebiederm.dsl.xmission.com>
	<1152896138.24925.74.camel@localhost.localdomain>
	<20060714170814.GE25303@sergelap.austin.ibm.com>
	<1152897579.24925.80.camel@localhost.localdomain>
Date: Fri, 14 Jul 2006 11:36:27 -0600
In-Reply-To: <1152897579.24925.80.camel@localhost.localdomain> (Dave Hansen's
	message of "Fri, 14 Jul 2006 10:19:39 -0700")
Message-ID: <m17j2gt7fo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Fri, 2006-07-14 at 12:08 -0500, Serge E. Hallyn wrote:
>> yes, of course, vfsmount, which I assume is what Eric meant?
>> 
>> Which means we'd have to do this at permission() using the nameidata, or
>> pass nd to generic_permission. 
>
> Yeah, I think so.  But, this is well into Al territory, and there might
> be a better way.

Well until we get that sorted out I will keep picking on i_sb.

The one thing that just occurred to me is that the generic permission
should end up structured as below.  I don't know if it is cheaper
but it is certainly more obvious.

Eric


  int generic_permission(struct inode *inode, int mask,
  		int (*check_acl)(struct inode *inode, int mask))
  {
  	umode_t			mode = inode->i_mode;
  
+       if (unlikely(current->nsproxy->user_ns != inode->i_sb->user_ns))
+          	goto unknown_user;

  	if (current->fsuid == inode->i_uid)
  		mode >>= 6;
  	else {
  		if (IS_POSIXACL(inode) && (mode & S_IRWXG) && check_acl) {
  			int error = check_acl(inode, mask);
  			if (error == -EACCES)
  				goto check_capabilities;
  			else if (error != -EAGAIN)
  				return error;
  		}
  
  		if (in_group_p(inode->i_gid))
  			mode >>= 3;
  	}
+ unknown_user:
  
  	/*
  	 * If the DACs are ok we don't need any capability check.
  	 */
  	if (((mode & mask & (MAY_READ|MAY_WRITE|MAY_EXEC)) == mask))
  		return 0;
  
   check_capabilities:
  	/*
  	 * Read/write DACs are always overridable.
  	 * Executable DACs are overridable if at least one exec bit is set.
  	 */
  	if (!(mask & MAY_EXEC) ||
  	    (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode))
  		if (capable(CAP_DAC_OVERRIDE))
  			return 0;
  
  	/*
  	 * Searching includes executable on directories, else just read.
  	 */
  	if (mask == MAY_READ || (S_ISDIR(inode->i_mode) && !(mask & MAY_WRITE)))
  		if (capable(CAP_DAC_READ_SEARCH))
  			return 0;
  
  	return -EACCES;
  }

