Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262666AbSI2PhV>; Sun, 29 Sep 2002 11:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262743AbSI2PhU>; Sun, 29 Sep 2002 11:37:20 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:11657 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S262666AbSI2PhT>; Sun, 29 Sep 2002 11:37:19 -0400
Date: Sun, 29 Sep 2002 18:42:21 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, wtarreau@yahoo.fr
Subject: linux-2.2.22, scsi-idle: oops with tmscsim driver
Message-ID: <20020929154221.GQ41965@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
	wtarreau@yahoo.fr
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Firstly: I've only seen this with scsi-idle, it perhaps might happen without
it.

[Willy, I'm cc'ing you because I asked you about scsi-idle and it seems the
bug might elsewhere.]

Whenever scsi-idle has spun down a disk, and the kernel wakes it up, the
disk does correctly spin up, but I get:

Adhoc c01aae80 <dc390_Disconnect+12c/138>
Adhoc c01a9f2a <do_DC390_Interrupt+112/1c8>
Adhoc c0108b7a <handle_IRQ_event+36/68>
Adhoc c010893f <do_8259A_IRQ+7f/a8>
Adhoc c0106000 <get_options+0/74>
Adhoc c0108c94 <do_IRQ+24/40>
Adhoc c0108980 <common_interrupt+18/20>
Adhoc c0106000 <get_options+0/74>
Adhoc c0106270 <cpu_idle+64/7c>
Adhoc c010629c <sys_idle+14/24>
Adhoc c01078e8 <system_call+34/38>
Adhoc c0106000 <get_options+0/74>
Adhoc c010609b <cpu_idle+7/18>
Adhoc c0106000 <get_options+0/74>
Adhoc c0100174 <L6+0/2>

Based on gdb dissambly, it actually dies in dc390_SRBdone, called by
dc390_Disconnect:


dc390_SRBdone( PACB pACB, PDCB pDCB, PSRB pSRB )
{
    UCHAR  bval, status, i, DCB_removed;
    PSCSICMD pcmd;
    PSCSI_INQDATA  ptr;
    PSGL   ptr2;
    ULONG  swlval;

    pcmd = pSRB->pcmd; DCB_removed = 0;
    status = pSRB->TargetStatus;
    ptr = (PSCSI_INQDATA) (pcmd->request_buffer);
    if( pcmd->use_sg )
        ptr = (PSCSI_INQDATA) (((PSGL) ptr)->address);
                                       ^^^^^^^^^^^^^^
                                       Here.

The ptr pointer is NULL.
  
I created the attached patch, and it works now, but I'm very uncertain if
that's even near the correct solution.

Also, I can't tell if that could happen without the scsi-idle patch.

It would be nice if a scsi-guru had a look...


-- v --

v@iki.fi

--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tmscsim.patch"

--- drivers/scsi/scsiiom.c	Sun Sep 29 18:39:15 2002
+++ ../linux-2.2.22/drivers/scsi/scsiiom.c	Sun Mar 25 19:37:36 2001
@@ -1367,7 +1367,7 @@
     pcmd = pSRB->pcmd; DCB_removed = 0;
     status = pSRB->TargetStatus;
     ptr = (PSCSI_INQDATA) (pcmd->request_buffer);
-    if( pcmd->use_sg && ptr )
+    if( pcmd->use_sg )
 	ptr = (PSCSI_INQDATA) (((PSGL) ptr)->address);
 	
     DEBUG0(printk (" SRBdone (%02x,%08x), SRB %p, pid %li\n", status, pcmd->result,\
@@ -1609,7 +1609,7 @@
     if( pcmd->cmnd[0] == INQUIRY && 
 	(pcmd->result == (DID_OK << 16) || status_byte(pcmd->result) & CHECK_CONDITION) )
      {
-	if (ptr && (ptr->DevType & SCSI_DEVTYPE) == TYPE_NODEV && !DCB_removed)
+	if ((ptr->DevType & SCSI_DEVTYPE) == TYPE_NODEV && !DCB_removed)
 	  {
 	     //printk ("DC390: Type = nodev! (%02i-%i)\n", pcmd->target, pcmd->lun);
 	     /* device not present: remove */

--LwW0XdcUbUexiWVK--
