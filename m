Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272565AbRHaAWl>; Thu, 30 Aug 2001 20:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272564AbRHaAWc>; Thu, 30 Aug 2001 20:22:32 -0400
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:41665 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S272561AbRHaAWW>; Thu, 30 Aug 2001 20:22:22 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880B4C@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: panic : problem in retrying the scsi command in case of CHECK_CON
	DITION with UNIT_ATTENTION and device reset
Date: Thu, 30 Aug 2001 18:22:38 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I believe that this is a bug in the scsi layer (scsi_io_completion() in
scsi_lib.c).

If you look at the routine scsi_io_completion(), if the device returned
check condition with bus reset and no data is transferred, then good_sectors
will
be 0.  scsi_io_completion tries to do retry by calling
scsi_queue_next_request().
But before that, it sets the request_buffer and buffer pointers to NULL. 
so, when the ll-driver gets the Scsi_Cmnd, this pointers are NULL which are
used to either access the buffer itself or the scatter-gather list and
if the low-level driver tries to access the scatter-gather list
it panics the system.

The following is the code that I am talking about :

	/*
	 * Zero these out.  They now point to freed memory, and it is
	 * dangerous to hang onto the pointers.
	 */
	SCpnt->buffer  = NULL;
	SCpnt->bufflen = 0;
	SCpnt->request_buffer = NULL;    ----> here it zeroes out the
request_buffer.
	SCpnt->request_bufflen = 0;

      ............



      	if ((SCpnt->sense_buffer[0] & 0x7f) == 0x70
		    && (SCpnt->sense_buffer[2] & 0xf) == UNIT_ATTENTION) {
			if (SCpnt->device->removable) {
				/* detected disc change.  set a bit and
quietly refuse
				 * further access.
				 */
				SCpnt->device->changed = 1;
				SCpnt = scsi_end_request(SCpnt, 0,
this_count);
				return;
			} else {
				/*
				 * Must have been a power glitch, or a
				 * bus reset.  Could not have been a
				 * media change, so we just retry the
				 * request and see what happens.  
				 */
				scsi_queue_next_request(q, SCpnt);  --> here
we try to do retry.
				return;
			}
		}

Has this been fixed  in later versions of the kernel ? 
any comment on the above code ?

Thanks and regards,
-hiren
