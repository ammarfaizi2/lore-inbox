Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbUKBNIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUKBNIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 08:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbUKBNFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:05:14 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:5565 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262958AbUKBM7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:59:36 -0500
Date: Tue, 2 Nov 2004 18:33:16 +0530
From: Suresh Kodati <kodatisu@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: andrea@novell.com
Subject: 2.6 kernel - Oops in parport_wait_peripheral
Message-ID: <20041102130316.GA10103@2fdyhf0.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While running some tests we observed a kernel oops in parport driver with the
following trace

f91f9234
*pde = 359d4001
Oops: 0000 [#1]
SMP
CPU:    1
EIP:    0060:[<f91f9234>]    Not tainted
EFLAGS: 00010286   (2.6.5-7.111-bigsmp)
EIP is at parport_wait_event+0x14/0xc0 [parport]
eax: 00000000   ebx: f6278400   ecx: 0000000a   edx: 00000001
esi: f6278400   edi: f58fc000   ebp: 000356ab   esp: f58fde84
ds: 007b   es: 007b   ss: 0068
Process test (pid: 2837, threadinfo=f58fc000 task=f61c2c80)
Stack: 00100100 00200200 0003568d 00000001 4b87ad6e c0130470 f61c2c80 00000000
       f6278400 00000000 f91f93ad 000001f4 88884350 f58fdf40 f6278400 0000000a
       00037d93 f58fc000 f91fa921 f602cf80 f6363001 00000001 00000000 00000044
Call Trace:
 [<c0130470>] process_timeout+0x0/0x10
 [<f91f93ad>] parport_wait_peripheral+0xcd/0x120 [parport]
 [<f91fa921>] parport_ieee1284_write_compat+0xa1/0x200 [parport]
 [<f91fa880>] parport_ieee1284_write_compat+0x0/0x200 [parport]
 [<f91f9a8f>] parport_write+0x9f/0x126 [parport]
 [<f91e7c5f>] lp_write+0x18f/0x3f0 [lp]
 [<c016bd52>] vfs_write+0xc2/0x140
 [<c0130cc7>] del_singleshot_timer_sync+0x17/0x30
 [<c016bfe1>] sys_write+0x91/0xf0
 [<c0130470>] process_timeout+0x0/0x10
 [<c0109199>] sysenter_past_esp+0x52/0x71

I have observed the same problem with linux-2.6.10-rc1 also.

Debugging the problem we found that lp driver calls parport_release, 
while parport_write is still in progress. 

lp_write does:

	a. down_interruptible
	b. lp_claim_parport_or_block (sets LP_PARPORT_CLAIMED and calls 
	   parport_claim_or_block to claim parport)
	c. parport_write


and LPGETSTATUS ioctl does
	d. lp_claim_parport_or_block (sets already set LP_PARPORT_CLAIMED bit)
	e. gets status
	f. lp_release_parport (clears LP_PARPORT_CLAIMED bit _and_ calls 
	   parport_release to release parport).


Because of parport_release in step f, port->cad was set to NULL. As 
a result, the write issued in step c trapped accessing the NULL pointer. 
It happens because ioctl LPGETSTATUS do not check if there is any 
pending write before releasing the port.

There appears to be other places where similar problem exists (lp_reset, 
lp_release ?).

The following fix has resolved the problem. Can somebody comment on this


Signed-off-by :Suresh Kodati (kodatisu@in.ibm.com)

--- linux-2.6.10-rc1-orig/drivers/char/lp.c     2004-11-02 16:53:22.573053168 +0530
+++ linux-2.6.10-rc1/drivers/char/lp.c  2004-11-02 15:53:59.000000000 +0530
@@ -609,9 +609,12 @@
                                return -EFAULT;
                        break;
                case LPGETSTATUS:
+                       if (down_interruptible (&lp_table[minor].port_mutex))
+                               return -EINTR;
                        lp_claim_parport_or_block (&lp_table[minor]);
                        status = r_str(minor);
                        lp_release_parport (&lp_table[minor]);
+                       up (&lp_table[minor].port_mutex);

                        if (copy_to_user(argp, &status, sizeof(int)))
                                return -EFAULT;



-- 
Thanks and regards,
   Suresh Kodati
Linux Technology center,
IBM Software Labs, Bangalore.
