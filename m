Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318028AbSHHWSZ>; Thu, 8 Aug 2002 18:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318034AbSHHWSZ>; Thu, 8 Aug 2002 18:18:25 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:30452 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318028AbSHHWSX>; Thu, 8 Aug 2002 18:18:23 -0400
Subject: Re: [patch] PCI configuration fix for NUMA-Q
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: colpatch@us.ibm.com
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
In-Reply-To: <3D52EBB2.1070202@us.ibm.com>
References: <3D52EBB2.1070202@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 Aug 2002 00:41:59 +0100
Message-Id: <1028850119.30103.117.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-08 at 23:07, Matthew Dobson wrote:
> Linus,
> 	The PCI code for NUMA-Q machines has been broken for a while...  The kernel 
> currently can't find PCI busses on quad's other than the first.  This patch 
> fixes that problem.  Please apply.

Its a tiny bit more code to implement a set of pci ops instead of
hacking CONFIG_MULTIQUAD into the core code and it gets rid of the
ifdefs for BUS2QUAD and the like if you instead of ideffing it all 
split the pci_conf1_ ops so you have your own copy with BUS2QUAD bits
called pci_conf1_mq_.... and put the originals back cleanly without
multiquad.

All you then have to do is

static struct pci_ops pci_direct_mq_conf1 = {
	pci_conf1_read_mq_config_byte,
        pci_conf1_read_mq_config_word,
	pci_conf1_read_mq_config_dword,
        pci_conf1_write_mq_config_byte,
	pci_conf1_write_mq_config_word,
	pci_conf1_write_mq_config_dword
};

and in the probe path a single clean

#ifdef CONFIG_MULTIQUAD
                        /* Multi-Quad has an extended PCI Conf1 */
			if(clustered_apic_mode)
                                return &pci_direct_mq_conf1;
#endif
      			return &pci_direct_conf1;
		}

which even takes the bus2quad maths out of line for non numa boxes
running the summit kernel code

Less ifdefs, less magic macros, minutely better performance and it
scales for future stuff when Intel/Dell/whoever releases their NUMA
chipset

(See 2.4.20pre-ac although the effect is less obvious there as its all
in one file anyway in 2.4)

