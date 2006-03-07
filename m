Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbWCGDP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbWCGDP1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWCGDP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:15:27 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:33185 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S932640AbWCGDP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:15:26 -0500
Message-ID: <440CFABF.5040403@cs.wisc.edu>
Date: Mon, 06 Mar 2006 21:15:11 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, markhe@nextd.demon.co.uk, andrea@suse.de,
       James.Bottomley@steeleye.com, axboe@suse.de, penberg@cs.helsinki.fi
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
References: <200603060117.16484.jesper.juhl@gmail.com>	 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>	 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com>	 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>	 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>	 <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>	 <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>	 <Pine.LNX.4.64.0603061445350.13139@g5.osdl.org>	 <9a8748490603061501r387291f0ha10e9e9fe3c9e060@mail.gmail.com>	 <20060306150612.51f48efa.akpm@osdl.org> <9a8748490603061524j616bf6b3i1b6ab5354bcfe1a9@mail.gmail.com>
In-Reply-To: <9a8748490603061524j616bf6b3i1b6ab5354bcfe1a9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 3/7/06, Andrew Morton <akpm@osdl.org> wrote:
> 
>>"Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>>
>>>And since 2.6.16-rc5-git8 is not experiencing problems I'd suggest you
>>> perhaps instead take a look at what's in -mm... That's where we need
>>> to work (it seems) to find the bug...
>>
>>Yes, it's very probably something in git-scsi-misc.
>>
> 
> I would say that's correct. I just build 2.6.16-rc5-mm2 with just
> git-scsi-misc.patch reverted, and that makes the problem go away.
> 
> So now the big question is; what part(s) of git-scsi-misc is broken?
> 

Is it relate to this change?

diff --git a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
index 5d02ff4..03fbc4b 100644
--- a/drivers/scsi/sr_ioctl.c
+++ b/drivers/scsi/sr_ioctl.c
@@ -44,11 +44,10 @@ static int sr_read_tochdr(struct cdrom_d
         int result;
         unsigned char *buffer;

-       buffer = kmalloc(32, GFP_KERNEL | SR_GFP_DMA(cd));
+       buffer = kzalloc(32, GFP_KERNEL | SR_GFP_DMA(cd));
         if (!buffer)
                 return -ENOMEM;

-       memset(&cgc, 0, sizeof(struct packet_command));         cgc.timeout = IOCTL_TIMEOUT;
         cgc.cmd[0] = GPCMD_READ_TOC_PMA_ATIP;         cgc.cmd[8] = 12;                /* LSB of length */
@@ -74,11 +73,10 @@ static int sr_read_tocentry(struct cdrom
         int result;
         unsigned char *buffer;

-       buffer = kmalloc(32, GFP_KERNEL | SR_GFP_DMA(cd));
+       buffer = kzalloc(32, GFP_KERNEL | SR_GFP_DMA(cd));
         if (!buffer)
                 return -ENOMEM;

-       memset(&cgc, 0, sizeof(struct packet_command));




When someone converted the *buffer* allocation to kzalloc they
also removed the the memset for the *packet_cmmand* struct.

The

memset(&cgc, 0, sizeof(struct packet_command));

should be added back I think.
