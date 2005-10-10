Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVJJV6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVJJV6x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 17:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVJJV6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 17:58:53 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:48603 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751280AbVJJV6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 17:58:52 -0400
Date: Mon, 10 Oct 2005 23:58:51 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       hirofumi@mail.parknet.co.jp, linux-ntfs-dev@lists.sourceforge.net,
       aia21@cantab.net, hch@infradead.org, viro@zeniv.linux.org.uk,
       akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
In-Reply-To: <20051010214605.GA11427@br.ibm.com>
Message-ID: <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
References: <20051010204517.GA30867@br.ibm.com>
 <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
 <20051010214605.GA11427@br.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Oct 2005, Glauber de Oliveira Costa wrote:

> On Mon, Oct 10, 2005 at 10:20:07PM +0100, Anton Altaparmakov wrote:
>> Hi,
>>
>> On Mon, 10 Oct 2005, Glauber de Oliveira Costa wrote:
>>> I've just noticed that the use of sb_getblk differs between locations
>>> inside the kernel. To be precise, in some locations there are tests
>>> against its return value, and in some places there are not.
>>>
>>> According to the comments in __getblk definition, the tests are not
>>> necessary, as the function always return a buffer_head (maybe a wrong
>>> one),
>>
>> If you had read the source code rather than just the comments you would
>> have seen that this is not true.  It can return NULL (see
>> fs/buffer.c::__getblk_slow()).  Certainly I would prefer to keep the
>> checks in NTFS, please.  They may only be good for catching bugs but I
>> like catching bugs rather than segfaulting due to a NULL dereference.

The check should be rather a BUG() than dump_stack() and return NULL --- I 
think it's not right to write code to recover from programming errors. 
Filesystem drivers are supposed to pass correct blocksize to getblk(). --- 
even for users it's better to crash, because user whose machine has locked 
up on BUG() will report bug more likely than user whose machine has 
written stack dump into log and corrupted filesystem --- by the time he 
discovers the corruption and mesage he might not even remember what 
triggered it.

As comment in buffer.c says, getblk will deadlock if the machine is out of 
memory. It is questionable whether to deadlock or return NULL and corrupt 
filesystem in this case --- deadlock is probably better.

Mikulas

>
> I did. But I did not see this specifically, for sure. What takes us to
> the opposite problem: A lot of places do not check for the return value
> of getblk (Almost half of them, I'd say), and may thus lead to a
> dereferencing  of a NULL pointer.
>
> Does anyone else have any comments on that?
>
>> Best regards,
> Thanks,
>> 	Anton
> Glauber
>
>> --
>> Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
>> Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
>> Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
>> WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
>>
>
> -- 
> =====================================
> Glauber de Oliveira Costa
> IBM Linux Technology Center - Brazil
> glommer@br.ibm.com
> =====================================
>
