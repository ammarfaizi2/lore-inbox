Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131232AbRCHAWb>; Wed, 7 Mar 2001 19:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131234AbRCHAWV>; Wed, 7 Mar 2001 19:22:21 -0500
Received: from jalon.able.es ([212.97.163.2]:31737 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131232AbRCHAWM>;
	Wed, 7 Mar 2001 19:22:12 -0500
Date: Thu, 8 Mar 2001 01:21:49 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "Justin T . Gibbs" <gibbs@scsiguy.com>
Subject: aic7xxx funcs without return values
Message-ID: <20010308012149.A1158@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a note to make gcc 2.96 (and future) happy. The aic7xxx driver is full of
inline funcs that should return a value and do not do that:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.2-ac14/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o aic7xxx_linux.o aic7xxx_linux.c
In file included from aic7xxx_linux.c:131:
aic7xxx_osm.h: In function `ahc_pci_read_config':
aic7xxx_osm.h:839: warning: control reaches end of non-void function

That function, for example, is missing the returns and the breaks:

static __inline uint32_t
ahc_pci_read_config(ahc_dev_softc_t pci, int reg, int width)
{
    switch (width) {
    case 1:
    {
        uint8_t retval;
        pci_read_config_byte(pci, reg, &retval);
        return (retval);
    }

    case 2:
    {
        uint16_t retval;
        pci_read_config_word(pci, reg, &retval);
        return (retval);
    }
    case 4:
    {
        uint32_t retval;
        pci_read_config_dword(pci, reg, &retval);
        return (retval);
    }
    default:
        panic("ahc_pci_read_config: Read size too big");
        /* NOTREACHED */
    }
}

Or if you are so worried about early returns and fast paths:

static __inline uint32_t
ahc_pci_read_config(ahc_dev_softc_t pci, int reg, int width)
{
    uint8_t	b_val;
    uint16_t	s_val;
    uint32_t	l_val;

    switch (width) {
    case 1:
        pci_read_config_byte(pci, reg, &b_val);
	return b_bal;
	break;
    case 2:
        pci_read_config_word(pci, reg, &s_val);
	return s_bal;
	break;
    case 4:
        pci_read_config_dword(pci, reg, &l_val);
	return l_bal;
	break;
    }
    panic("ahc_pci_read_config: Read size too big");
    return 0;
}

Stack is changed only once, gcc is happy, and perhaps the explicit breaks
help gcc to optimize the code.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac13 #3 SMP Wed Mar 7 00:09:17 CET 2001 i686

