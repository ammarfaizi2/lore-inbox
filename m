Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270559AbRHITY1>; Thu, 9 Aug 2001 15:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270561AbRHITYS>; Thu, 9 Aug 2001 15:24:18 -0400
Received: from netsonic.fi ([194.29.192.20]:62737 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id <S270559AbRHITYJ>;
	Thu, 9 Aug 2001 15:24:09 -0400
Date: Thu, 9 Aug 2001 22:24:00 +0300 (EEST)
From: Sampsa Ranta <sampsa@netsonic.fi>
To: Alan Cox <laughing@shared-source.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.7-ac9 (breaks ATM connect)
In-Reply-To: <20010807235302.A16178@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0108092210260.31580-100000@nalle.netsonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Alan Cox wrote:

> o	Fix bug in atm_do_connect_dev (bogus EINVALs)	(Germán González)


--- linux.vanilla/net/atm/common.c      Wed Jul  4 12:21:53 2001
+++ linux.ac/net/atm/common.c   Wed Jul 25 16:28:24 2001
@@ -210,7 +210,7 @@

        if ((vpi != ATM_VPI_UNSPEC && vpi != ATM_VPI_ANY &&
            vpi >> dev->ci_range.vpi_bits) || (vci != ATM_VCI_UNSPEC &&
-           vci != ATM_VCI_ANY && vci >> dev->ci_range.vci_bits))
+           vci != ATM_VCI_ANY && vci > dev->ci_range.vci_bits))
                return -EINVAL;
        if (vci > 0 && vci < ATM_NOT_RSV_VCI &&
!capable(CAP_NET_BIND_SERVICE))
                return -EPERM;

The patch is not correct, this test compares number of allowed bits
to an integer. And due to this, breaks most of ATM. Even signalling
daemons cannot connect.

But yes, the original seems broken, too. I included code bits doing this
check elsewhere in ATM implementation code. I think the correct patch
would be

-           vci != ATM_VCI_ANY && vci >> dev->ci_range.vci_bits))
+           vci != ATM_VCI_ANY && vci > 1 << dev->ci_range.vci_bits))


Code bits taken from elsewhere:

net/atm/atm/atm_misc.c:
                    if (c >= 1 << vcc->dev->ci_range.vci_bits)

drivers/atm/eni.c:
	 dev->ci_range.vci_bits = NR_VCI_LD;

drivers/atm/midway.h:
#define NR_VCI_LD      10              /* log2(NR_VCI) */


Thanks,
   Sampsa Ranta
   sampsa@netsonic.fi


