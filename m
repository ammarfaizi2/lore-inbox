Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbUA1Bzt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 20:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265804AbUA1Bzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 20:55:46 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:22992 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265802AbUA1BzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 20:55:15 -0500
Date: Wed, 28 Jan 2004 10:54:46 +0900
From: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Subject: [RFC/PATCH, 4/4] readX_check() performance evaluation
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Message-id: <00a501c3e541$c214e4d0$2987110a@lsd.css.fujitsu.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain;	charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is our goal and plan.

Our goal:
    - We'd like to recover from PCI-X intermittent errors
      as possible as we can.
      We'd like to recvoer from following errors
         a) PIO read data parity errors
         b) PIO write data parity erros
         c) DMA read data parity errors
         d) DMA write data parity erros
      (PIO means that the initiator is the CPU,
      DMA means that the initiator is the device.)
    - If a fatal bus error like SERR occurs, we'd like to shutdown 
      the failed bus(, remove driver instances) and continue 
      system operation.
    - If there are readX_check() I/F, we can safely perform 
      PHP(PCI Hotplug) operation.
      Currently there is no reliable I/F to check the newly 
      installed card, so to speak, PHP is the same as the gambling.

Our Plan:
    - Recover from Data parity error
        Currently, we are focused on ia64 architecture.

        Device setup assumption:
          PCI command register/ Parity error response =1
          PCI-X command register/ Data parity error recovery=1

        a) PIO read data parity error recovery
          (Memory mapped I/O read error recovery)

          - readX_check() read the memory mapped hardware
            and consume the data by additional instruction.
          - If there were data parity error, machine check will
            occurs.  Local machine check handler check whether 
            the exception was caused by readX_check() 
            and increment a per-CPU MCA counter variable.
            Then handler returns.
          - readX_check check the per-CPU MCA counter variable.
            When the counter is incremented, return an error.
          - If readX_check() returns an error and if reading 
            the register has no side-effect, re-read the register
            a few times to recover from the error.
            If reading the register has a side-effect, driver may
            reset the HW and restart operation.

        b) PIO write data parity error recovery
          (Memory mapped I/O write error recovery)
          
          - The device will find a parity error.
            When the device find a parity error, 
            it reports the error in the PCI status 
            register as "Detected Parity Error == 1".
            After the driver did some PIO writes,
            the driver can notice the error by reading
            the PCI staus register.
          - If writing to the register has no side-effect,
            the driver can re-writeto the register.
            If writing the register has a side-effect,
            driver may reset the HW and restart operation.

        c) DMA read data parity errors
           (DMA from memory to device)

          - The device will find a parity error.
            When the device detected a data parity error,
            it set the "Detected Parity Error == 1".

            After a while, the driver check the PCI status
            register, and knows that there was a data parity error.
          - Because the driver can't decide which I/O failed
            precisely, the recovery method will be reseting the HW
            and restarting the I/O if possible.

        d) DMA write data parity erros
           (DMA from device to memory)

           - Host bridge detect the data parity error,
             and assert PERR signal on the bus.
             Then the device will notice the error and 
             report it in PCI status register as 
             "Master Data Parity error == 1".
          - Because the driver can't decide which I/O failed
            precisely, the recovery method will be reseting the HW
            and restarting the I/O if possible.

    - Shutdown a bus(, remove driver instances) and continue operation. 
        We have no good idea currently.
        Does someone have a idea?

Thanks,
Hironobu Ishii

