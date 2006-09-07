Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422711AbWIGR4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbWIGR4w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 13:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422712AbWIGR4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 13:56:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48299 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422711AbWIGR4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 13:56:51 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] proc: Remove the hard coded inode numbers.
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com>
	<m1k64hx8rx.fsf@ebiederm.dsl.xmission.com>
	<m1fyf5x8ny.fsf_-_@ebiederm.dsl.xmission.com>
	<20060907102214.4be99fff.akpm@osdl.org>
Date: Thu, 07 Sep 2006 11:55:59 -0600
In-Reply-To: <20060907102214.4be99fff.akpm@osdl.org> (Andrew Morton's message
	of "Thu, 7 Sep 2006 10:22:14 -0700")
Message-ID: <m1lkovr26o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Wed, 06 Sep 2006 10:27:13 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> +static int proc_fill_cache(struct file *filp, void *dirent, filldir_t
> filldir,
>> +	char *name, int len,
>> +	instantiate_t instantiate, struct task_struct *task, void *ptr)
>> +{
>> +	struct dentry *child, *dir = filp->f_dentry;
>> +	struct inode *inode;
>> +	struct qstr qname;
>> +	ino_t ino = 0;
>> +	unsigned type = DT_UNKNOWN;
>> +
>> +	qname.name = name;
>> +	qname.len  = len;
>> +	qname.hash = full_name_hash(name, len);
>> +
>> +	child = d_lookup(dir, &qname);
>> +	if (!child) {
>> +		struct dentry *new;
>> +		new = d_alloc(dir, &qname);
>> +		if (new) {
>> +			child = instantiate(dir->d_inode, new, task, ptr);
>> +			if (child)
>> +				dput(new);
>> +			else
>> +				child = new;
>> +		}
>> +	}
>> +	if (!child || IS_ERR(child) || !child->d_inode)
>> +		goto end_instantiate;
>> +	inode = child->d_inode;
>> +	if (inode) {
>> +		ino = inode->i_ino;
>> +		type = inode->i_mode >> 12;
>> +	}
>> +	dput(child);
>> +end_instantiate:
>> +	if (!ino)
>> +		ino = find_inode_number(dir, &qname);
>> +	if (!ino)
>> +		ino = 1;
>> +	return filldir(dirent, name, len, filp->f_pos, ino, type);
>> +}
>
> The error handling in here looks rather absent.

Hey, thanks for the review.

I don't think so but a comment or two might be in order.

Calling filldir with the filename is the important part,
and the only real error is if filldir fails.

The rest of the logic is about populating and querying the
dcache so we can find our real inode number, if every reasonable
attempt to perform a dcache lookup fails I simply set the inode
number to 1 and use that in filldir.  It's wrong but at least
I report the file is there.

If I can find the dentry I lookup the inode and the inode
number and file type, and the dput the dentry.

If I can't lookup the dentry I attempt to create it.
instantiate will return a dentry or NULL if the dentry I preallocate
for it is good enough.

Is there something specific you are not seeing?

Eric










