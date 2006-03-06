Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752006AbWCFU43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbWCFU43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbWCFU43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:56:29 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:9819 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752020AbWCFU42 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:56:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IQ6NSPHxvIpB3SyT2QaR/tIvyvSHx9UeiNopsPy4ZedqyWlRG3f6ht0YB8GPZEzjsFqzI6bX5ZfNsxeGTOzuREU92yZm0a8EOelF9W5grG+7diX9C0GG2VZjROVODnepYex7S1tYhmMCaJCGZUOSSi5GGgi7uYLakqPJ3c+4l3g=
Message-ID: <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com>
Date: Mon, 6 Mar 2006 21:56:26 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       "Andrea Arcangeli" <andrea@suse.de>,
       "Mike Christie" <michaelc@cs.wisc.edu>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       "Jens Axboe" <axboe@suse.de>
In-Reply-To: <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
	 <200603062136.17098.jesper.juhl@gmail.com>
	 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 3/6/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > On Monday 06 March 2006 21:06, Linus Torvalds wrote:
> > >
> <...snip...>
> > > and the scary thing is that "len=64".
> > >
> > > The thing is, SCSI uses "SCSI_SENSE_BUFFERSIZE" to determine the maximum
> > > sense size to copy, and what do we have, if not
> > >
> > >       include/scsi/scsi_cmnd.h:#define SCSI_SENSE_BUFFERSIZE  96
> > >
> > > ie a 64-byte buffer is simply TOO DAMN SMALL!
> > >
> > > Now, the thing is, the 64 comes from "sizeof(struct request_sense)", which
> > > is what "struct packet_command *" uses. We can change that sizeof() to
> > > just use SCSI_SENSE_BUFFERSIZE, but that still makes me worry about
> >
> > Building a kernel with that change on top of the other ones atm.
> >
> Changing the sizeof() to SCSI_SENSE_BUFFERSIZE doesn't fix it :
>
> Slab corruption: start=f79da5a8, len=64

Hmm, is it just me or should that len= have read len=96 ???

This is the change I made :

--- linux-2.6.16-rc5-mm2/block/scsi_ioctl.c~    2006-03-06
21:43:56.000000000 +0100
+++ linux-2.6.16-rc5-mm2/block/scsi_ioctl.c     2006-03-06
21:43:56.000000000 +0100
@@ -568,7 +568,7 @@ int scsi_cmd_ioctl(struct file *file, st
                        hdr.dxferp = cgc.buffer;
                        hdr.sbp = cgc.sense;
                        if (hdr.sbp)
-                               hdr.mx_sb_len = sizeof(struct request_sense);
+                               hdr.mx_sb_len = SCSI_SENSE_BUFFERSIZE;
                        hdr.timeout = cgc.timeout;
                        hdr.cmdp = ((struct cdrom_generic_command
__user*) arg)->cmd;
                        hdr.cmd_len = sizeof(cgc.cmd);

did I mess up?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
