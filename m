Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWFJG17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWFJG17 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 02:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWFJG17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 02:27:59 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:19376 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030316AbWFJG17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 02:27:59 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <448A65AB.3090509@s5r6.in-berlin.de>
Date: Sat, 10 Jun 2006 08:24:43 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [RFC]  Slimming down struct inode
References: <E1Foqjw-00010e-Ln@candygram.thunk.org> <20060610012757.GC27946@ftp.linux.org.uk> <20060610015631.GA29805@thunk.org>
In-Reply-To: <20060610015631.GA29805@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.875) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote at lkml:
[saving space in the numerously instantiated struct inode]
> On Sat, Jun 10, 2006 at 02:27:57AM +0100, Al Viro wrote:
>>>5) Nuke i_cindex.  This is only used by ieee1394's
>>>   ieee_file_to_instance.  There must be another place where we can
>>>   store this --- say, in a ieee1394-specific field in struct file?  Or
>>>   maybe it can be derived some other way, but to chew up 4 bytes in
>>>   i_cindex for all inodes just for ieee1394's benefit seems like the
>>>   Wrong Thing(tm).
>>
>>No, it's actually the right thing for _all_ char devices.  And it's used
>>before we get a struct file.  If anything, ->i_rdev should go long-term...
> 
> i_cindex is set by fs/char_dev.h, and the only user of that field (I
> grepped the entire sources) is ./drivers/ieee1394/ieee1394_core.h:
> 
>    /* return the index (within a minor number block) of a file */
>    static inline unsigned char ieee1394_file_to_instance(struct file *file)
>    {
> 	return file->f_dentry->d_inode->i_cindex;
>    }
...

Also, the places where ieee1394_file_to_instance() is used appear not to 
be fast paths. (It's the struct file_operations.open() hook of two 
protocol drivers.) I.e. there is no harm in replacing it by whatever 
more expensive lookup method.

Dv1394 calls ieee1394_file_to_instance() from within spin_lock_irqsave() 
/unlock_irqrestore(), but it can easily moved out of it if need be.
-- 
Stefan Richter
-=====-=-==- -==- -=-=-
http://arcgraph.de/sr/
