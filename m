Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262074AbTCVJZw>; Sat, 22 Mar 2003 04:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262078AbTCVJZw>; Sat, 22 Mar 2003 04:25:52 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:25536 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S262074AbTCVJZv>;
	Sat, 22 Mar 2003 04:25:51 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303220936.h2M9aqG05305@csl.stanford.edu>
Subject: [CHECKER] deadlock in 2.5.62 drivers/usb/host/uhci-hcd.c?
To: linux-kernel@vger.kernel.org
Date: Sat, 22 Mar 2003 01:36:52 -0800 (PST)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

there appears to be a potential locking cycle in 2.5.62's
	drivers/usb/host/uhci-hcd.c
Though it looks like its in debugging code.

Confirmation/destruction appreciated.

   <struct urb.lock (<local>:0)>-><struct uhci_hcd.complete_list_lock (<local>:0)> occurred 1 times
   <struct uhci_hcd.complete_list_lock (<local>:0)>-><struct urb.lock (<local>:0)> occurred 1 times
   Lock <struct urb.lock> is involved in <1> errors and <struct uhci_hcd.complete_list_lock> in 1

Callchain for
  <struct urb.lock (<local>:0)>-><struct uhci_hcd.complete_list_lock (<local>:0)> =

    depth = 2:
        drivers/usb/host/uhci-hcd.c:uhci_transfer_result:1507
        	spin_lock_irqsave(&urb->lock, flags);

           ->drivers/usb/host/uhci-hcd.c:uhci_transfer_result:1507
           	->uhci_transfer_result:1568
           	->end=uhci_add_complete:138:spin_lock_irq
                
                     spin_lock_irqsave(&uhci->complete_list_lock, flags);

   
Callchain for
  <struct uhci_hcd.complete_list_lock (<local>:0)>-><struct urb.lock (<local>:0)> =
    depth = 2:
        drivers/usb/host/uhci-debug.c:uhci_show_lists:395
           ->drivers/usb/host/uhci-debug.c:uhci_show_lists:395
           ->uhci_show_lists:407

        spin_lock_irqsave(&uhci->complete_list_lock, flags);

           ->end=uhci_show_urbp:328:spin_lock
           ->drivers/usb/host/uhci-debug.c:uhci_show_urbp:328

        		spin_lock(&urbp->urb->lock);


