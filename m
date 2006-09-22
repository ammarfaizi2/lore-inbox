Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWIVIgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWIVIgp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 04:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWIVIgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 04:36:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:5865 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750891AbWIVIgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 04:36:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ozIcR4V0lYRv99M7Gz7SanMH6k20N0Y/4AtcYUx1lum5e6xQg8a9hkKHxsIKp5zq7j4Chcglqgc21D2jxwiJNmPraeiOv2vSeO5Ek0FoR1QwRoF6eQsygtWfw/7N2tq7wvp1+fKWIsCDr3b4gdnBBkh5SDvKJ9zARariN4/5Jhg=
Message-ID: <4513A098.4060505@gmail.com>
Date: Fri, 22 Sep 2006 10:36:40 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Om Narasimhan <om.turyx@gmail.com>
CC: Nishanth Aravamudan <nacc@us.ibm.com>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
Subject: Re: [KJ] kmalloc to kzalloc patches for drivers/block [sane version]
References: <6b4e42d10609202311t47038692x5627f51d69f28209@mail.gmail.com>	 <20060921072017.GA27798@us.ibm.com> <6b4e42d10609212240i3d02241djbdaa0176ab9bfb2b@mail.gmail.com>
In-Reply-To: <6b4e42d10609212240i3d02241djbdaa0176ab9bfb2b@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Om Narasimhan wrote:
> Thanks for the comments.
>> >
>> > Signed off by Om Narasimhan <om.turyx@gmail.com>
>>
>> This is not the canonical format, per SubmittingPatches. It should be:
>>
>> Signed-off-by: Random J Developer <random@developer.example.org>
> OK. I would take care of it.
>>
>> >  drivers/block/cciss.c    |    4 +--
>> >  drivers/block/cpqarray.c |   72 
>> +++++++++++++++-------------------------------
>> >  drivers/block/loop.c     |    4 +--
>> >  3 files changed, 25 insertions(+), 55 deletions(-)
>>
>> Your diffstat should have indicated to you that this should be split up
>> better. Please (re-)read SubmittingPatches. *One* logical change per
>> patch, most importantly.
> OK. I would resubmit.
>> >
>> > diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
>> > index 2cd3391..a800a69 100644
>> > --- a/drivers/block/cciss.c
>> > +++ b/drivers/block/cciss.c
>> > @@ -900,7 +900,7 @@ #if 0                             /* 'buf_size' 
>> member is 16-bits
>> >                               return -EINVAL;
>> >  #endif
>> >                       if (iocommand.buf_size > 0) {
>> > -                             buff = kmalloc(iocommand.buf_size, 
>> GFP_KERNEL);
>> > +                             buff = kzalloc(iocommand.buf_size, 
>> GFP_KERNEL);
>> >                               if (buff == NULL)
>> >                                       return -EFAULT;
>> >                       }
>> > @@ -911,8 +911,6 @@ #endif
>> >                                       kfree(buff);
>> >                                       return -EFAULT;
>> >                               }
>> > -                     } else {
>> > -                             memset(buff, 0, iocommand.buf_size);
>> >                       }
>> >                       if ((c = cmd_alloc(host, 0)) == NULL) {
>> >                               kfree(buff);
>>
>> This changes performance potentially, no? The memset before was
>> conditional upon (iocommand.Request.Type.Direction == XFER_WRITE) and
>> now the memory will always be zero'd.
> Yes, but not the functionality.
> if (iocommand.buf_size > 0), code allocates using kmalloc. if
> direction is XFER_WRITE, it does a copy_from_user(), and free()s the
> allocated buffer, not really caring what data came in from userspace.
> Else, it does memset(). So I could safely replace the kmalloc() with
> kzalloc() without compromising functionality.

Ok, this is something like I need 10 bytes of memory, so I request two memory 
pages for reserved use. It works, but it kills performance.

Why you zero memory that is not needed to be zeroed?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
