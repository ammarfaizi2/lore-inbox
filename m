Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWIVL27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWIVL27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 07:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWIVL27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 07:28:59 -0400
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:17068 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1751106AbWIVL26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 07:28:58 -0400
Message-ID: <4513C8F7.2020608@grupopie.com>
Date: Fri, 22 Sep 2006 12:28:55 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Om Narasimhan <om.turyx@gmail.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [KJ] kmalloc to kzalloc patches for drivers/block [sane version]
References: <6b4e42d10609202311t47038692x5627f51d69f28209@mail.gmail.com>	 <20060921072017.GA27798@us.ibm.com> <6b4e42d10609212240i3d02241djbdaa0176ab9bfb2b@mail.gmail.com> <4513A098.4060505@gmail.com>
In-Reply-To: <4513A098.4060505@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Om Narasimhan wrote:
>> Thanks for the comments.
>>> >
>>> > Signed off by Om Narasimhan <om.turyx@gmail.com>
>>>
>>> This is not the canonical format, per SubmittingPatches. It should be:
>>>
>>> Signed-off-by: Random J Developer <random@developer.example.org>
>> OK. I would take care of it.
>>>
>>> >  drivers/block/cciss.c    |    4 +--
>>> >  drivers/block/cpqarray.c |   72 
>>> +++++++++++++++-------------------------------
>>> >  drivers/block/loop.c     |    4 +--
>>> >  3 files changed, 25 insertions(+), 55 deletions(-)
>>>
>>> Your diffstat should have indicated to you that this should be split up
>>> better. Please (re-)read SubmittingPatches. *One* logical change per
>>> patch, most importantly.
>> OK. I would resubmit.
>>> >
>>> > diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
>>> > index 2cd3391..a800a69 100644
>>> > --- a/drivers/block/cciss.c
>>> > +++ b/drivers/block/cciss.c
>>> > @@ -900,7 +900,7 @@ #if 0                             /* 'buf_size' 
>>> member is 16-bits
>>> >                               return -EINVAL;
>>> >  #endif
>>> >                       if (iocommand.buf_size > 0) {
>>> > -                             buff = kmalloc(iocommand.buf_size, 
>>> GFP_KERNEL);
>>> > +                             buff = kzalloc(iocommand.buf_size, 
>>> GFP_KERNEL);
>>> >                               if (buff == NULL)
>>> >                                       return -EFAULT;
>>> >                       }
>>> > @@ -911,8 +911,6 @@ #endif
>>> >                                       kfree(buff);
>>> >                                       return -EFAULT;
>>> >                               }
>>> > -                     } else {
>>> > -                             memset(buff, 0, iocommand.buf_size);
>>> >                       }
>>> >                       if ((c = cmd_alloc(host, 0)) == NULL) {
>>> >                               kfree(buff);
>>>
>>> This changes performance potentially, no? The memset before was
>>> conditional upon (iocommand.Request.Type.Direction == XFER_WRITE) and
>>> now the memory will always be zero'd.
>> Yes, but not the functionality.
>> if (iocommand.buf_size > 0), code allocates using kmalloc. if
>> direction is XFER_WRITE, it does a copy_from_user(), and free()s the
>> allocated buffer, not really caring what data came in from userspace.

You really misread that code. It frees the buffer and returns -EFAULT if 
the copy_from_user _failed_. This is standard procedure and that code 
doesn't need to be changed to kzalloc.

Please only do kmalloc to k[zc]alloc changes that are really trivial. 
There is no point in risking inserting new bugs (or performance 
regressions) for some micro-space-optimization such as this.

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
