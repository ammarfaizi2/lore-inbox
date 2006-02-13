Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWBMFrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWBMFrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 00:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWBMFrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 00:47:36 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:20116 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750709AbWBMFrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 00:47:35 -0500
Message-ID: <43F01D70.70600@namesys.com>
Date: Sun, 12 Feb 2006 21:47:28 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>, Jeff Mahoney <jeffm@suse.com>
CC: Bernd Schubert <bernd-schubert@gmx.de>, Chris Wright <chrisw@sous-sol.org>,
       John M Flinchbaugh <john@hjsoft.com>, reiserfs-list@namesys.com,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 Bug? New security model?
References: <200602080212.27896.bernd-schubert@gmx.de>	<200602081314.59639.bernd-schubert@gmx.de>	<20060208205033.GB22771@shell0.pdx.osdl.net>	<200602082246.15613.bernd-schubert@gmx.de>	<20060208221124.GN30803@sorel.sous-sol.org> <20060212005541.107f7011.vsu@altlinux.ru>
In-Reply-To: <20060212005541.107f7011.vsu@altlinux.ru>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an xattr bug, and I'll let jeff answer it.

Hans

Sergey Vlasov wrote:

>On Wed, 8 Feb 2006 14:11:24 -0800 Chris Wright wrote:
>
>  
>
>>* Bernd Schubert (bernd-schubert@gmx.de) wrote:
>>    
>>
>>>Er, you mean /proc/fs/reiserfs/{partition}/on-disk-super?
>>>      
>>>
>>Yup.
>>
>>    
>>
>>>bernd@bathl ~>grep attrs_cleared /proc/fs/reiserfs/hda6/on-disk-super
>>>flags:  1[attrs_cleared]
>>>      
>>>
>>>>2) does mount -o attrs ... make a difference?
>>>>        
>>>>
>>>Yes, 2.6.13 now makes the same trouble. No difference with 2.6.15.3. 
>>>I played with mount -o noattrs, this makes no difference with 2.6.13, but has 
>>>some effects to 2.6.15.3. Creating files in /var/run is possible again, 
>>>lsattr gives "lsattr: Inappropriate ioctl for device While reading flags 
>>>on /var/run", but deleting files in /var/run is still impossible (still 
>>>rather bad for the init-scripts).
>>>      
>>>
>
>Is the filesystem in question old - could it be created initially in the
>reiserfs v3.5 format (used with 2.2.x kernels) and later converted to
>v3.6 (by mounting with the "conv" option)?
>
>  
>
>>Yes, that's what I thought.  There's still some backward logic in there.
>>noattrs vs. attrs triggers whether the code path that's patched in
>>2.6.15.3 is taken.  I'll dig a bit more, but hopefully the reiserfs folks 
>>can fix this for us.
>>    
>>
>
>Here is a simple test case which reproduces the problem with a
>filesystem converted from v3.5:
>
># dd if=/dev/zero of=tmp.img bs=1M count=100
># mkreiserfs --format 3.5 -f tmp.img
># mount -t reiserfs -o loop,conv tmp.img /mnt/disk/
># umount /mnt/disk/
># reiserfsck --clean-attributes tmp.img
># mount -t reiserfs -o loop tmp.img /mnt/disk/
>
>At this point, I get obviously wrong attributes on /mnt/disk:
>
># lsattr -d /mnt/disk/
>-----a--c---- /mnt/disk/
>
>BTW, this breaks even with kernels earlier than 2.6.15.2, if you also
>add the "attrs" options to the last mount command.
>
>Apparently the reiserfs attrs code has been broken for such converted
>filesystems for some time, but it could be enabled only with the "attrs"
>option, so people were not hitting this.  However, the following patch:
>
>http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2949ccf9379678df66ecf2ca70ed4656159eacdd
>
>changed the logic to enable the "attrs" option on all filesystems which
>have the reiserfs_attrs_cleared flag.  But that patch was broken - it
>did not really set the option properly, so the attrs-related breakage
>did not became visible until yet another patch:
>
>http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d35c602870ece3166cff3d25fbc687a7f707acf3
>
>which later made into 2.6.15.2, and caused problems for some people.
>
>I have noticed that fs/reiserfs/inode.c:init_inode() does not initialize
>REISERFS_I(inode)->i_attrs and inode->i_flags (as done by
>sd_attrs_to_i_attrs()) in the branch for v1 stat data; maybe this causes
>the problem?
>  
>

