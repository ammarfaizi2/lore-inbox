Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbREXWGd>; Thu, 24 May 2001 18:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262393AbREXWGX>; Thu, 24 May 2001 18:06:23 -0400
Received: from femail8.sdc1.sfba.home.com ([24.0.95.88]:42142 "EHLO
	femail8.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S262384AbREXWGK>; Thu, 24 May 2001 18:06:10 -0400
Message-ID: <3B0D85E6.7E509F3E@home.com>
Date: Thu, 24 May 2001 18:06:30 -0400
From: Willem Riede <wriede@home.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dawson Engler <engler@csl.Stanford.EDU>
CC: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] null bugs in 2.4.4 and 2.4.4-ac8
In-Reply-To: <200105242109.OAA29748@csl.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler wrote:
> 
> Hi All,
> 
> Enclosed are 103 potential errors where code gets a pointer from a
> possibly-failing routine (kmalloc, etc) and dereferences it without
>
> [BUG] osst_do_scsi will never return NULL if argument SRpnt isn't NULL. But they copy SRpnt back by *aSRpnt, implies it could be NULL

No. It implies SRpnt could have changed. The functions flagged
(osst_read_back_buffer_and_rewrite and osst_reposition_and_retry)
cannot be reached with SRpnt == NULL. So these are false alarms.

> /u2/engler/mc/oses/linux/2.4.4/drivers/scsi/osst.c:1163:osst_read_back_buffer_and_rewrite: ERROR:NULL:1111:1163: Using unknown ptr "SRpnt" illegally! set by 'osst_do_scsi':1163 [nbytes = 216]
> #if DEBUG
>                 if (debugging)
>                         printk(OSST_DEB_MSG "osst%d: About to attempt to write to frame %d\n", dev, new_block+i);
> #endif
>                 SRpnt = osst_do_scsi(SRpnt, STp, cmd, OS_FRAME_SIZE, SCSI_DATA_WRITE,
> Start --->
>                                             STp->timeout, MAX_WRITE_RETRIES, TRUE);
> 
>         ... DELETED 46 lines ...
> 
>                         }
>                 }
>                 if (flag) {
>                         if ((SRpnt->sr_sense_buffer[ 2] & 0x0f) == 13 &&
>                              SRpnt->sr_sense_buffer[12]         ==  0 &&
> Error --->
>                              SRpnt->sr_sense_buffer[13]         ==  2) {
>                                 printk(KERN_ERR "osst%d: Volume overflow in write error recovery\n", dev);
>                                 vfree((void *)buffer);
>                                 return (-EIO);                  /* hit end of tape = fail */
> 

Regards. Willem Riede.
