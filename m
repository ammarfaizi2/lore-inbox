Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276675AbRJPVbx>; Tue, 16 Oct 2001 17:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276736AbRJPVbm>; Tue, 16 Oct 2001 17:31:42 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:2825 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S276675AbRJPVbh>; Tue, 16 Oct 2001 17:31:37 -0400
Date: Tue, 16 Oct 2001 15:36:40 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: SCSI tape load problem with Exabyte Drive
Message-ID: <20011016153623.A21324@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.4.6 with st and AICXXXX driver, issuance of an MTLOAD command
via st ioctl() calls results in a unit attention and failure of 
the drive while loading a tape from an EXB-480 robotics tape
library.

Code which generates this error is attached.  The error will not 
clear unless the code first closes the open handle to the device,
then reopens the handle and retries the load command.  The failure
scenario is always the same.  The first MTLOAD command triggers 
the tape drive to load the tape, then all subsequent commands
fail until the handle is closed and the device is reopened and
a second MTLOAD command gets issued, then the drive starts 
working.

I have written a tape robotics library for the Exabyte EXB-80
robotic tape library on Linux for a customer of Canopy.  The
offending code is from this library.
 
Code attached.  This error is persistent and 100% reproducable on 
this hardware.  The error does not involve the robot in the 
library, as the robot has a unique SCSI id, and commands being
sent to the robot via the SCSI generic interface work flawlessly.
The tape drives in the robotics library appear to Linux as 
tape devices on the SCSI bus, and the problems are apparent
on the SCSI tape drives via st.o.  

There are no other problems at present with any of the remaining
tape code, and it is working perfectly, with the exception of 
this load command. 

Jeff

//
// function used to call the st ioctl() interface.  handles are opened
// in kernel space via filp_open()
//

int trx_tape_command(int tape_id, int cmd, int count, int count_bits)
{
    struct file *filp;
    register int ccode;
    struct mtop mt_com;

    if (tape_id >= MAX_TAPES)
       return -EINVAL;

    if ((!SystemTape[tape_id]) || (!SystemTape[tape_id]->filp))
       return -EINVAL;

    filp = SystemTape[tape_id]->filp;

    mt_com.mt_op = cmd;
    mt_com.mt_count = count;
    mt_com.mt_count |= count_bits;

    if (mt_com.mt_count < 0)
    {
       TRXDRVPrint("mt: negative repeat count\n");
       return -EIO;
    }

    ccode = tape_ioctl(filp, MTIOCTOP, (char *)&mt_com);
    if (ccode)
       return ccode;

    return 0;
}

//
//
//   This code segment is what I am doing to get around this problem
//   however, we still see a unit attention error periodically, and
//   it does not reliably work every time.
//
//

reload:;
       err = trx_tape_open(device);   // this is a filp_open() call
       if (err)
          goto done;

       err = trx_tape_status(device);  
       if (err)                       
          goto done;

       // load command
       err = trx_tape_command(device, MTLOAD, 0, 0);
       TRXDRVPrint("loading tape %d ret-%d\n", (int)device, (int)err);
       if (err)
          goto done;

       err = trx_tape_command(device, MTSETBLK, 4096, 0);
       TRXDRVPrint("set tape blksize %d ret-%d\n", (int)device, (int)err);
       if (err)
       {
          if (rcount++ < 3)
          {
             trx_tape_close(device);
             goto reload;
          }
          else
             goto done;
       }

       err = trx_tape_command(device, MTREW, 0, 0);
       TRXDRVPrint("rewinding tape %d ret-%d\n", (int)device, (int)err);
       if (err)
          goto done;

       //
       //  redacted code.
       //

done:;

