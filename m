Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131894AbRCXXyB>; Sat, 24 Mar 2001 18:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131889AbRCXXxm>; Sat, 24 Mar 2001 18:53:42 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:36612 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131887AbRCXXxi>;
	Sat, 24 Mar 2001 18:53:38 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Pete Toscano <pete.lkml@toscano.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Constant Crash in scsi_eh_0 
In-Reply-To: Your message of "Sat, 24 Mar 2001 15:06:23 EST."
             <20010324150623.A27902@bubba.toscano.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 25 Mar 2001 09:52:52 +1000
Message-ID: <323.985477972@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2001 15:06:23 -0500, 
Pete Toscano <pete.lkml@toscano.org> wrote:
>[0]kdb> btp 862
>    EBP       EIP         Function(args)
>0xe2bdbf6c 0xc011526a schedule+0x41e (0xe2ce0960, 0xe2bda000)
>0xe2bdbf9c 0xc0107bb8 __down_interruptible+0x94
>0xe2bdbfac 0xc0107c96 __down_failed_interruptible+0xa (0x100, 0xe2c9dd14, 0xe2c9dd6c, 0xe2bdbfd8, 0x0)
>           0xeaf94d7f [scsi_mod].text.lock+0x1fb
>0xe2bdbfec 0xeaf90281 [scsi_mod]scsi_error_handler+0x101
>           0xc0107547 kernel_thread+0x23

scsi_error_handler has tried to get a lock and somebody else has
already got it and is not letting go.  It is not clear from the source
of scsi_error_handler which lock is the problem.

objdump -S --start-address=0xeaf90180 --end-address=0xeaf902f0 vmlinux

will disassemble the scsi_error_handler routine, the object code will
probably mean something to the scsi maintainers.

The trick is to find out which routine is holding the lock.  It could
be an active routine or it could be caused by code that failed to
release a lock when it should.  To check for active routines, in kdb

set BTSECT=0
bta

that will do a backtrace on every process, without the section lines.
Look for any other process with scsi code in its backtrace, it is
suspect.

kdb can help diagnose the problem but the fix will have to come from
the scsi maintainers.

