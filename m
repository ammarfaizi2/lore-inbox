Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265690AbTFXFDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 01:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbTFXFDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 01:03:34 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:11905 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265690AbTFXFCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 01:02:05 -0400
Message-ID: <3EF81E59.F6F1C704@in.ibm.com>
Date: Tue, 24 Jun 2003 10:48:09 +0100
From: Prashanth T <prasht@in.ibm.com>
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Race conditions while accessing /proc/scsi/scsi
Content-Type: multipart/mixed;
 boundary="------------1DCFC778063561CD08D1C7D0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1DCFC778063561CD08D1C7D0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
In linux-2.4 kernels, I notice an empty Scsi_Device structure being
added at the end of Scsi_Host list while detecting the scsi devices
[scan_scsis( ) in scsi_scan.c].  This empty structure would get filled
later in scan_scsis_single( ), in which case, again an empty device is
appended.

This being the case, there is a race condition being noticed. Taking a
scenario, if we are adding a scsi driver as a module and at the same
time if we are running a script trying to write to a device (for this
controller), insmod results in seg faults (oops) while accessing invalid
fields of this structure.  The script trying to remove the scsi device
(on the same controller) is attached below (script.txt).  I have
attached the oops message for reference (this is on my RH7.3,  2.4.18-3
kernel):  oops.txt.

The patch for the same is to increment  'access_count' during scanning
of devices.  This patch for 2.4.18 vanilla kernel  is attached below
(2418v.patch)

There is also a race condition when we are trying to read
'/proc/scsi/scsi' continuously in a script and at the same time adding
the module for the controller.   Invalid fields are noticed till the
scanning is complete.  The attached file (proc_read.txt) shows it.  But,
the same logic of incrementing 'access_count' doesn't work here (as you
know) since this field is also
related to mounting of the devices.  This problem looks to be a
limitation.

Please let me know your comments.

--------------1DCFC778063561CD08D1C7D0
Content-Type: text/plain; charset=us-ascii;
 name="script.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="script.txt"

while [ TRUE ]
do 
	`echo "scsi remove-single-device 1 0 1 0 " > /proc/scsi/scsi`;
done

--------------1DCFC778063561CD08D1C7D0
Content-Type: text/plain; charset=us-ascii;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01aa73f
*pde = 00000000
Oops: 0002
aic7xxx autofs rtc
CPU:    0
EIP:    0010:[<c01aa73f>]    Not tainted
EFLAGS: 00010046

EIP is at scsi_queue_next_request [kernel] 0x4f (2.4.18-3custom)
eax: 00000000   ebx: c80bf618   ecx: 00000001   edx: 00000003
esi: 00000000   edi: 00000246   ebp: c80bf600   esp: c50f7c68
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 11227, stackpage=c50f7000)
Stack: c7a2da00 c80bf600 00000286 c80bf600 c01a301d c80bf618 00000000 c79ddd80
       c50f7cf4 00000000 c0242b42 c01a33e4 c7a2da00 00000000 00000001 c50f7cb4
       c50f7cb4 00000000 00000001 c50f7cb4 c50f7cb4 c80bf600 c79ddd80 c80bf600
Call Trace: [<c01a301d>] scsi_release_command [kernel] 0x11d
[<c01a33e4>] scsi_wait_req [kernel] 0xe4
[<c01ae37f>] scan_scsis_single [kernel] 0xff
[<c018bbf9>] vt_console_print [kernel] 0x69
[<c011a4e6>] __call_console_drivers [kernel] 0x46
[<c011a65b>] call_console_drivers [kernel] 0xeb
[<c01ae0d5>] scan_scsis [kernel] 0x3a5
[<c01a9280>] scsi_error_handler [kernel] 0x0
[<c0119675>] do_fork [kernel] 0x505
[<c01a9280>] scsi_error_handler [kernel] 0x0
[<c0119872>] do_fork [kernel] 0x702
[<c018bbf9>] vt_console_print [kernel] 0x69
[<c011a4e6>] __call_console_drivers [kernel] 0x46
[<c0116f19>] __wake_up [kernel] 0x39
[<d488b700>] driver_template [aic7xxx] 0x0
[<c01a49e3>] scsi_register_host [kernel] 0x1d3
[<d4872d67>] init_this_scsi_driver [aic7xxx] 0x17
[<d488b700>] driver_template [aic7xxx] 0x0
[<d488b700>] driver_template [aic7xxx] 0x0
[<c011b6e5>] sys_init_module [kernel] 0x555
[<d486f060>] ahc_print_path [aic7xxx] 0x0
[<c0108c6b>] system_call [kernel] 0x33


Code: f0 fe 08 0f 88 51 0c 00 00 53 ff 53 3c 5a 8b 53 74 b0 01 86



--------------1DCFC778063561CD08D1C7D0
Content-Type: text/plain; charset=us-ascii;
 name="proc_read.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc_read.txt"

		o/p before the device is added.


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02



		o/p while adding the device 
Each o/p below (which is pasted for particular ID) repeats few times

 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: ffffffff


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: ffffffff


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: ffffffff


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: ffffffff


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 04 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: ffffffff



Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: ffffffff



Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 08 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02



Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 09 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02



Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 10 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02



Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 11 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02




Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 12 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 12 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 12 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 12 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 12 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 12 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 12 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 12 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 12 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 12 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 12 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 12 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 12 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02


Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 13 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02




Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 14 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02



Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 15 Lun: 00
  Vendor:          Model:                  Rev:     
  Type:   <NULL>                ANSI SCSI revision: 02


		O/p after the scanning is complete.

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: CDRM00203     !K Rev: 1.00
  Type:   CD-ROM                           ANSI SCSI revision: 02



--------------1DCFC778063561CD08D1C7D0
Content-Type: text/plain; charset=us-ascii;
 name="2418v.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2418v.patch"

--- drivers/scsi/scsi_scan.c	Tue Jun  3 15:09:14 2003
+++ drivers/scsi/scsi_scan.c.mod	Tue Jun  3 15:05:14 2003
@@ -323,6 +323,7 @@
 	SDpnt->queue_depth = 1;
 	SDpnt->host = shpnt;
 	SDpnt->online = TRUE;
+	SDpnt->access_count = 1;
 
 	initialize_merge_fn(SDpnt);
 
@@ -757,6 +758,7 @@
 	SDpnt->host = shpnt;
 	SDpnt->online = TRUE;
 	SDpnt->scsi_level = scsi_level;
+	SDpnt->access_count = 1; 
 
 	/*
 	 * Register the queue for the device.  All I/O requests will come

--------------1DCFC778063561CD08D1C7D0--

