Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <155478-17483>; Mon, 10 May 1999 18:30:29 -0400
Received: by vger.rutgers.edu id <154834-17480>; Mon, 10 May 1999 16:57:36 -0400
Received: from ppp-107-107.villette.club-internet.fr ([194.158.107.107]:1050 "EHLO localhost.localdomain" ident: "groudier") by vger.rutgers.edu with ESMTP id <155463-17480> convert rfc822-to-8bit; Mon, 10 May 1999 16:33:03 -0400
Date: Mon, 10 May 1999 23:25:46 +0200 (MET DST)
From: Gerard Roudier <groudier@club-internet.fr>
To: Rainer Clasen <bj@ncc.cicely.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.rutgers.edu, Shaw Carruthers <shaw@shawc.demon.co.uk>
Subject: Re: sym/ncr53c8xx phase error: Some progress
In-Reply-To: <Pine.LNX.3.95.990510213737.823A-100000@localhost>
Message-ID: <Pine.LNX.3.95.990510231114.725A-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-kernel@vger.rutgers.edu



Looking again in to the reported messages, I am not quite sure my 
previous idea was the right one.

It should be interesting to display the CDB at the place the driver 
try to handle the phase change and at the place it displays the error, 
as follow:


	/*
	**	Print out any error for debugging purpose.
	*/
	if (DEBUG_FLAGS & (DEBUG_RESULT|DEBUG_TINY)) {
		if (cp->host_status!=HS_COMPLETE || cp->scsi_status!=S_GOOD) {
+			int k;
			PRINT_ADDR(cmd);
			printk ("ERROR: cmd=%x host_status=%x scsi_status=%x\n",
				cmd->cmnd[0], cp->host_status, cp->scsi_status);
+			printk("CDB(%d):", cmd->cmd_len);
+			for (k = 0 ; k < 12 ; k++)
+				printk(" %02x", cmd->cmnd[k]);
+			printk("\n");
		}
	}

And add some equivalent code at the following place:

unexpected_phase:
	dsp -= 8;
	nxtdsp = 0;

	switch (cmd & 7) {
+	int k;
	case 2:	/* COMMAND phase */
		nxtdsp = NCB_SCRIPT_PHYS (np, dispatch);
+		if (cp) {
+			printk("CDB(%d):", cp->cmd->cmd_len);
+			for (k = 0 ; k < 12 ; k++)
+				printk(" %02x", cp->cmd->cmnd[k]);
+			printk("\n");
		break;
#if 0
	case 3:	/* STATUS  phase */
		nxtdsp = NCB_SCRIPT_PHYS (np, dispatch);


The above is quite untested.

By the way, I probably should add this kind of dump to the driver 
source.

On the other hand, could you check that your disks are configured
(probably via jumpers) for SCSI parity checking.

Let me know.

Regards,
   Gérard.

On Mon, 10 May 1999, Gerard Roudier wrote:

> 
> Hello,
> 
> I just mailed Shaw the following.
> Could you give it a try. It is untested and, by the way, applies to 
> the SCSI code.
> 
> : From groudier@club-internet.fr Mon May 10 21:36:20 1999
> : Date: Mon, 10 May 1999 20:57:27 +0200 (MET DST)
> : From: Gerard Roudier <groudier@club-internet.fr>
> : To: Shaw Carruthers <shaw@shawc.demon.co.uk>
> : Subject: Re: Phase change problem: error log
> : 
> : 
> : 
> : On Mon, 10 May 1999, Shaw Carruthers wrote:
> : 
> : Nice!!!!!!!!!!!!!!!!!
> : 
> : > sym53c860-0-<4,0>: phase change 2-3 6@0037ea45 resid=2. 
> : > sym53c860-0-<4,0>: ERROR: cmd=28 host_status=84 scsi_status=2 
> : 
> : Command is 28 which is a READ(10) but the CDB is reported as 6 bytes by
> : the driver. It should be 10 bytes. If the ERROR refers to the
> : phase change then something is really WRONG there and the device is 
> : right to complain and to destroy everything when it is unable to 
> : detect the problem. :-)
> : 
> : > sym53c860-0-<4,0>: sense data: 70 0 5 0 0 0 0 18 0 0 0 0 24 0. 
> : 
> : 5    : means ILLEGAL REQUEST
> : 24 0 : means INVALID FIELD IN CDB
> : 
> : > attempt to access beyond end of device 
> : > 08:06: rw=0, want=226304033, limit=704907 
> : 
> : This may well be a bug in the SCSI code.
> : The following Code seems suspicious to me (scsi_do_cmd()/scsi..c)
> : 
> :     if (SCpnt->cmd_len == 0)
> : 	SCpnt->cmd_len = COMMAND_SIZE(SCpnt->cmnd[0]);
> : 
> : If cmd_len is not zero for some reason, it will not be loaded with the 
> : right value of the CDB length.
> : 
> : You may want to try this untested patch and let me know how it make 
> : differences:) . IMO, if it boots it has chance to fix.
> : (against 2.2.7)
> : 
> : --- linux/drivers/scsi/sd.c.orig	Mon May 10 20:47:23 1999
> : +++ linux/drivers/scsi/sd.c	Mon May 10 20:49:45 1999
> : @@ -1037,6 +1037,7 @@
> :  
> :      SCpnt->transfersize = rscsi_disks[dev].sector_size;
> :      SCpnt->underflow = this_count << 9;
> : +    SCpnt->cmd_len = 0;
> :      scsi_do_cmd (SCpnt, (void *) cmd, buff,
> :  		 this_count * rscsi_disks[dev].sector_size,
> :  		 rw_intr,
> : 
> : Gérard.
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
