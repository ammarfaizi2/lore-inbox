Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWIMOCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWIMOCh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWIMOCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:02:36 -0400
Received: from gatekeeper.ncic.ac.cn ([159.226.41.188]:53710 "HELO ncic.ac.cn")
	by vger.kernel.org with SMTP id S1750799AbWIMOCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:02:36 -0400
Date: Wed, 13 Sep 2006 22:02:35 +0800
From: "Yingchao Zhou" <yc_zhou@ncic.ac.cn>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "akpm" <akpm@osdl.org>, "alan" <alan@redhat.com>, "zxc" <zxc@ncic.ac.cn>
Subject: [RFC] PAGE_RW Should be added to PAGE_COPY ?
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20060913140241.60C5FFB046@ncic.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


     The current kernel set PAGE_COPY without write bit. This will cause intermittent non-cosistent data for user-level network drivers such as Infiniband, Quadrics and Myrinet. Which has also be mentioned by Costin Iancu in the paper "HUNTing the Overlap " (PACT'05).
    An example of such phenomena is the following sequences: 
	register a memory space BUFF for receive message, 
	receive message,
	call mprotect(...PROT_NONE...) and mprotect(...PROT_READ|PROT_WRITE) one by one, 	
	write into BUFF, 
	then receive again.      
    The second time received data will perhaps not be the data sent by the peer machine but the data written by itself in the 4th step.

     The reson is that :
     1) User-level network driver locks phy pages when memory space is registered;
     2) 2 calls to mprotect change ptes in the space to PAGE_COPY, so write any page in the space will cause a page fault;
     3) In the page fault handler, it goes to do_wp_page, and in it if Page Is Locked, a new page is generated and filled into the pte. So the physical page seen by the host is not the same one by the NIC.

     Adding PAGE_RW to PAGE_COPY will resolve this problem.  
     In my option, the reason for absense of RW is to save memory by mapping all those only read pages into ZERO_PAGE. But is there really programs which make many read-ops in memory space without even initialize them?

___________________________________________________
_      Yingchao Zhou                              _
_      ICT, CAS                                   _
_      (86)010-62601009                           _
___________________________________________________


