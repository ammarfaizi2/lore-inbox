Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVJMA7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVJMA7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVJMA7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:59:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32906 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964839AbVJMA7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:59:32 -0400
Message-ID: <434DB140.7050404@redhat.com>
Date: Wed, 12 Oct 2005 19:58:40 -0500
From: Mike Christie <mchristi@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Andrew Morton <akpm@osdl.org>,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, glommer@br.ibm.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] Use of getblk differs between locations
References: <20051010204517.GA30867@br.ibm.com>	 <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>	 <20051010214605.GA11427@br.ibm.com>	 <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>	 <20051010223636.GB11427@br.ibm.com>	 <Pine.LNX.4.64.0510102328110.6247@hermes-1.csi.cam.ac.uk>	 <20051010163648.3e305b63.akpm@osdl.org>	 <Pine.LNX.4.62.0510110203430.27454@artax.karlin.mff.cuni.cz>	 <20051010180705.0b0e3920.akpm@osdl.org> <1129017679.12336.7.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1129017679.12336.7.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> On Mon, 2005-10-10 at 18:07 -0700, Andrew Morton wrote:
> 
>>Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:
>>
>>> On Mon, 10 Oct 2005, Andrew Morton wrote:
>>>
>>> > Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>>> >>
>>> >> > Maybe the best solution is neither one nor another. Testing and failing
>>> >> > gracefully seems better.
>>> >> >
>>> >> > What do you think?
>>> >>
>>> >>  I certainly agree with you there.  I neither want a deadlock nor
>>> >>  corruption.  (-:
>>> >
>>> > Yup.  In the present implementation __getblk_slow() "cannot fail".  It's
>>> > conceivable that at some future stage we'll change __getblk_slow() so that
>>> > it returns NULL on an out-of-memory condition.
>>>
>>> The question is if it is desired --- it will make bread return NULL on 
>>> out-of-memory condition, callers will treat it like an IO error, skipping 
>>> access to the affected block, causing damage on perfectly healthy 
>>> filesystem.
>>
>>Yes, that is a bit dumb.  A filesystem might indeed want to take different
>>action for ENOMEM versus EIO.
>>
>>
>>> I liked what linux-2.0 did in this case --- if the kernel was out of 
>>> memory, getblk just took another buffer, wrote it if it was dirty and used 
>>> it. Except for writeable loopback device (where writing one buffer 
>>> generates more dirty buffers), it couldn't deadlock.
>>
>>Wouldn't it be better if bread() were to return ERR_PTR(-EIO) or
>>ERR_PTR(-ENOMEM)?    Big change.
> 
> 
> It would indeed.  Much better.  And whilst at it, it would be even
> better if we had a lot more error codes like "ERR_PTR(-EDEVUNPLUGGED)"
> for example...  But that would be an even better change.  Anyone feeling
> like touching every block driver in the kernel?  (-;
> 

I have actually done this
http://marc.theaimsgroup.com/?l=linux-scsi&m=112487427230642&w=2
(this is just the bio users, the end_that_request_first/chunk users are 
in another patch).

I am just trying to figure out how to support some wierd scsi HW before 
reposting. If you have suggestions about how to implement the bitmap 
suggestion in that thread I am listening too (I implemented it like 
scsi's scsi_cmnd result field).
