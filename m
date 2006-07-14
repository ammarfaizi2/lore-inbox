Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422645AbWGNQvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbWGNQvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbWGNQvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:51:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30694 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422643AbWGNQvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:51:02 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
	<44B684A5.2040008@fr.ibm.com>
	<20060713174721.GA21399@sergelap.austin.ibm.com>
	<m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	<1152815391.7650.58.camel@localhost.localdomain>
	<m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	<1152821011.24925.7.camel@localhost.localdomain>
	<m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>
	<1152887287.24925.22.camel@localhost.localdomain>
	<m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
	<20060714162935.GA25303@sergelap.austin.ibm.com>
Date: Fri, 14 Jul 2006 10:49:52 -0600
In-Reply-To: <20060714162935.GA25303@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Fri, 14 Jul 2006 11:29:35 -0500")
Message-ID: <m18xmwuo5r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> Dave Hansen <haveblue@us.ibm.com> writes:
>> 
>> > On Thu, 2006-07-13 at 21:45 -0600, Eric W. Biederman wrote:
>> >> I think for filesystems like /proc and /sys that there will normally
>> >> be problems.  However many of those problems can be rationalized away
>> >> as a reasonable optimization, or are not immediately apparent.
>> >
>> > Could you talk about some of these problems?
>> 
>> Already mentioned but.  rw permissions on sensitive files are for 
>> uid == 0.  No capability checks are performed.
>
> As Herbert (IIRC) pointed out that could/should be fixed.

Capabilities have always fitted badly in with the normal unix
permissions. So if we have a solution that works nicely with normal
unix permissions we will have a nice general solution, that is
easy for people to understand.

What I am talking about is making a small tweak to the permission
checking as below.  Why do you keep avoiding even considering it?

Eric

  int generic_permission(struct inode *inode, int mask,
  		int (*check_acl)(struct inode *inode, int mask))
  {
  	umode_t			mode = inode->i_mode;
  
- 	if (current->fsuid == inode->i_uid)
+ 	if ((current->fsuid == inode->i_uid) &&
+ 		(current->nsproxy->user_ns == inode->i_sb->user_ns))
  		mode >>= 6;
  	else {
  		if (IS_POSIXACL(inode) && (mode & S_IRWXG) && check_acl) {
  			int error = check_acl(inode, mask);
  			if (error == -EACCES)
  				goto check_capabilities;
  			else if (error != -EAGAIN)
  				return error;
  		}
  
- 		if (in_group_p(inode->i_gid))
+ 		if (in_group_p(inode->i_sb->user_ns, inode->i_gid))
  			mode >>= 3;
  	}
  
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

