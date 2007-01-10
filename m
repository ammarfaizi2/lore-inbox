Return-Path: <linux-kernel-owner+w=401wt.eu-S965098AbXAJVwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbXAJVwH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbXAJVwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:52:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35765 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965098AbXAJVwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:52:04 -0500
Message-ID: <45A55FE5.80907@redhat.com>
Date: Wed, 10 Jan 2007 15:51:33 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       esandeen@redhat.com, aviro@redhat.com
Subject: Re: [PATCH 2/3] change libfs sb creation routines to avoid collisions
 with their root inodes
References: <200701082047.l08KlDCa001921@dantu.rdu.redhat.com> <20070110212215.GB4425@infradead.org>
In-Reply-To: <20070110212215.GB4425@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> 
>>  		return -ENOMEM;
>> +	/* set to high value to try and avoid collisions with loop below */
>> +	inode->i_ino = 0xffffffff;
>> +	insert_inode_hash(inode);
> 
> This is odd.  Can't we just add some constant base to the loop below?
>
I thought the same thing, but Jeff pointed out that
nfsctl_transaction_write does ops based on inode numbers, and they maybe
can't move around?

        rv =  write_op[ino](file, data, size);

However, nfsd's call to simple_fill_super already sends in a set of
files starting at inode 2:

enum {
        NFSD_Root = 1,
        NFSD_Svc,
...

        static struct tree_descr nfsd_files[] = {
                [NFSD_Svc] = {".svc", &transaction_ops, S_IWUSR},
...
        return simple_fill_super(sb, 0x6e667364, nfsd_files);

which does...

      for (i = 0; !files->name || files->name[0]; i++, files++) {
                if (!files->name)
                        continue;
...
                inode->i_ino = i;

So I think it's already expecting the root inode at one, and the other
files starting at 2?

-Eric
