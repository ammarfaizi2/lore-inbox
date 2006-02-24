Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWBXJfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWBXJfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 04:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWBXJfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 04:35:34 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:28091 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932163AbWBXJfe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 04:35:34 -0500
Message-ID: <20060224043526.6t3wb8s10k08c888@imap.linux.ibm.com>
Date: Fri, 24 Feb 2006 04:35:26 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       zanussi@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sysfs: relay channel buffers as sysfs attributes
References: <20060219210733.GA3682@linux-sh.org>
	<20060219210757.GB3682@linux-sh.org> <20060223105934.GA6884@in.ibm.com>
	<20060224083426.GA3385@linux-sh.org>
In-Reply-To: <20060224083426.GA3385@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Mundt <lethal@linux-sh.org>:

> On Thu, Feb 23, 2006 at 04:29:35PM +0530, Maneesh Soni wrote:
>> On Sun, Feb 19, 2006 at 11:07:57PM +0200, Paul Mundt wrote:
>> > +	dentry = lookup_one_len(filename, parent, strlen(filename));
>>
>> lookup_one_len() needs parent's i_mutex.
>>
> Good catch, thanks.
>
>> > +	if (IS_ERR(dentry))
>> > +		sysfs_hash_and_remove(parent, filename);
>>
>> Also wondering if you have considered the case of -EEXIST?
>>
> How is that going to happen? The line before we do sysfs_add_file(), and
> if that errors out, then we never make it to lookup_one_len().
>

well, there is no check in sysfs_add_file() (probably it should have?) 
for -EEXIST. Till
now, the dentry/inode for sysfs files are allocated only when
the file is looked up at the first instance. Where here (for relay files)
dentry/inodes are being allocated at the time of creation.

IOW, the check for existing files is being done at the time of
assigning the inode (as in fs/sysfs/inode.c:sysfs_create()) when 
someone looks for the
file.
->sysfs_lookup()-->sysfs_attach_attr()-->sysfs_create()

> The IS_ERR() check is pretty superfluous anyways, perhaps it makes more
> sense just to remove it and the sysfs_hash_and_remove() reference
> entirely.
>
hmm.. probably not, looks like it is needed. The extra sysfs_dirent which
got added in sysfs_add_file() will be removed by sysfs_hash_and_remove() in
case of -EEXIST.

Thanks
Maneesh

PS: Sorry for previous message with incorrect reply-to address.
