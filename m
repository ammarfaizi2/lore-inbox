Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262458AbREXWjZ>; Thu, 24 May 2001 18:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262461AbREXWjF>; Thu, 24 May 2001 18:39:05 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:2002 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S262458AbREXWi6>; Thu, 24 May 2001 18:38:58 -0400
Date: Thu, 24 May 2001 15:38:50 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Willem Riede <wriede@home.com>
cc: Dawson Engler <engler@csl.stanford.edu>, <linux-kernel@vger.kernel.org>,
        <mc@CS.Stanford.EDU>
Subject: Re: [CHECKER] null bugs in 2.4.4 and 2.4.4-ac8
In-Reply-To: <3B0D85E6.7E509F3E@home.com>
Message-ID: <Pine.GSO.4.31.0105241532450.11846-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2001, Willem Riede wrote:

> Dawson Engler wrote:
> >
> > Hi All,
> >
> > Enclosed are 103 potential errors where code gets a pointer from a
> > possibly-failing routine (kmalloc, etc) and dereferences it without
> >
> > [BUG] osst_do_scsi will never return NULL if argument SRpnt isn't NULL. But they copy SRpnt back by *aSRpnt, implies it could be NULL
>
> No. It implies SRpnt could have changed. The functions flagged
> (osst_read_back_buffer_and_rewrite and osst_reposition_and_retry)
> cannot be reached with SRpnt == NULL. So these are false alarms.

these are false positives if osst_read_back_buffer_and rewrite can't be
reached with SRpnt == NULL. It seems that osst_do_scsi will not change
SRpnt unless it is NULL though. In other words, SRpnt is changed by
osst_do_scsi <=> the initial argument SRpnt == NULL. Probabaly the pointer
aSRpnt is useless.

>
> > /u2/engler/mc/oses/linux/2.4.4/drivers/scsi/osst.c:1163:osst_read_back_buffer_and_rewrite: ERROR:NULL:1111:1163: Using unknown ptr "SRpnt" illegally! set by 'osst_do_scsi':1163 [nbytes = 216]
> > #if DEBUG
> >                 if (debugging)
> >                         printk(OSST_DEB_MSG "osst%d: About to attempt to write to frame %d\n", dev, new_block+i);
> > #endif
> >                 SRpnt = osst_do_scsi(SRpnt, STp, cmd, OS_FRAME_SIZE, SCSI_DATA_WRITE,
> > Start --->
> >                                             STp->timeout, MAX_WRITE_RETRIES, TRUE);
> >
> >         ... DELETED 46 lines ...
> >
> >                         }
> >                 }
> >                 if (flag) {
> >                         if ((SRpnt->sr_sense_buffer[ 2] & 0x0f) == 13 &&
> >                              SRpnt->sr_sense_buffer[12]         ==  0 &&
> > Error --->
> >                              SRpnt->sr_sense_buffer[13]         ==  2) {
> >                                 printk(KERN_ERR "osst%d: Volume overflow in write error recovery\n", dev);
> >                                 vfree((void *)buffer);
> >                                 return (-EIO);                  /* hit end of tape = fail */
> >
>
> Regards. Willem Riede.
>

