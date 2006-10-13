Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWJMLia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWJMLia (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 07:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWJMLi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 07:38:29 -0400
Received: from mail-gw3.adaptec.com ([216.52.22.36]:13727 "EHLO
	mail-gw3.adaptec.com") by vger.kernel.org with ESMTP
	id S1751402AbWJMLi1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 07:38:27 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: 2.6.18 bug in gdth.c [solved]
Date: Fri, 13 Oct 2006 13:38:26 +0200
Message-ID: <EF6AF37986D67948AD48624A3E5D93AFE72291@mtce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.18 bug in gdth.c [solved]
thread-index: Acbut1lvP69RYi3LQFWGyD8+cjwpHgAA2KJgAABQbQA=
From: "Leubner, Achim" <Achim_Leubner@adaptec.com>
To: "Jerome Borsboom" <j.borsboom@erasmusmc.nl>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for fixing the problem. If pci_map_page() can handle a call with 
scp->request_bufflen=0 as a parameter then reverting this line should be ok. Otherwise we should not remove the line but add the initialization of 
cmdp->u.raw64.sg_ranz respective cmdp->u.raw.sg_ranz to 0 before (where the initialization of all other elements like "reserved", "mdisc_time" etc. take place).

Thanks,
Achim Leubner

=======================
Achim Leubner
Software Engineer / RAID drivers
ICP vortex GmbH / Adaptec Inc.
Phone: +49-351-8718291
 
________________________________________
From: Jerome Borsboom [mailto:j.borsboom@erasmusmc.nl] 
Sent: Freitag, 13. Oktober 2006 13:04
To: linux-kernel@vger.kernel.org
Cc: Leubner, Achim
Subject: 2.6.18 bug in gdth.c [solved]

Recent changes in the gdth.c driver introduced an 'unable to handle kernel paging request' bug. The offending change seems to be following change in 'gdth_fill_raw_cmd':

@@ -3022,7 +3148,7 @@ #ifdef GDTH_STATISTICS
             }
#endif
-        } else {
+        } else if (scp->request_bufflen) {
             scp->SCp.Status = GDTH_MAP_SINGLE;
             scp->SCp.Message = PCI_DMA_BIDIRECTIONAL; 
             page = virt_to_page(scp->request_buffer);

Reverting this line, make the driver stable again. My hypothesis is that when scp->request_bufflen is 0, then cmdp->u.raw.sg_ranz will not be assigned which makes the subsequent ha->cmd_len calculation misbehave. When you compare gdth_fill_raw_cmd with gdth_fill_cache_cmd, then in the latter function cmdp- >u.cache.sg_canz IS assigned before the conditional 'if (scp- >use_sg)...'


Jerome Borsboom

