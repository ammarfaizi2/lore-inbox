Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTLPWOo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 17:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTLPWOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 17:14:44 -0500
Received: from fmr02.intel.com ([192.55.52.25]:37848 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262882AbTLPWOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 17:14:40 -0500
Message-ID: <3FDF83CA.10000@intel.com>
Date: Wed, 17 Dec 2003 00:14:34 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es> <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com> <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com> <20031216174505.GC2716@kroah.com>
In-Reply-To: <20031216174505.GC2716@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>Minor code comments below:
>
>On Tue, Dec 16, 2003 at 12:20:39PM +0200, Vladimir Kondratiev wrote:
>  
>
>>+
>>+#ifdef CONFIG_PCI_EXPRESS
>>+#define PCI_PROBE_EXP		0x0008
>>+#endif
>>+
>>    
>>
>
>If you change this to:
>#ifdef CONFIG_PCI_EXPRESS
>#define PCI_PROBE_EXP		0x0008
>#else
>#define PCI_PROBE_EXP		0x0000
>#endif
>
>You can get rid of a number of "#ifdef CONFIG_PCI_EXPRESS" statements
>later on in the .c files by just always using the PCI_PROBE_EXP value.
>That cleans up the patch a bit.
>  
>
Good point. Agree.

>>+/**
>>+ * RRBAR (memory base for PCI-E config space) resides here.
>>+ * Initialized to default address. Actually, it is platform specific, and
>>+ * value may vary.
>>+ * I don't know how to detect it properly, it is chipset specific.
>>+ */
>>+static u32 rrbar_phys = CONFIG_PCI_EXPRESS_BASE * 0x10000000UL;
>>    
>>
>
><snip>
>
>  
>
>>+/**
>>+ * I don't know how to detect it properly.
>>+ * assume it is PCI-E, sanity_check will
>>+ * stop me if it is not.
>>+ * 
>>+ * Also, this function supposed to set rrbar_phys
>>+ */
>>+static int is_pcie_platform(void)
>>+{ return 1; }
>>    
>>
>
>Shouldn't your comments at least match your code for the rrbar_phys
>statement for your first release?  :)
>  
>
Default moved to CONFIG_PCI_EXPRESS_BASE.
Idea is some time later we fill replace is_pcie_platform with real auto 
detection...

>>+static int pci_express_init(void)
>>+{
>>+	rrbar_window_virt = (void*)fix_to_virt(FIX_PCIE_CONFIG);
>>+	if (!is_pcie_platform())
>>+		return 0;
>>    
>>
>
>Call fix_to_virt() after you do the check and not before?
>
>  
>
... and I assume virtual address may be used by auto detection code.

>  
>
>>+/**
>>+ * Shuts down PCI-E resources.
>>+ */
>>+static inline void pci_express_fini(void)
>>+{}
>>    
>>
>
>If this isn't needed, why have it anymore?
>  
>
Placeholder, to not forget. It is called in case auto detection says it 
is not PCI-E.

>  
>
>>+static struct pci_ops pci_express_conf = {
>>+	pci_exp_read_config_byte,
>>+	pci_exp_read_config_word,
>>+	pci_exp_read_config_dword,
>>+	pci_exp_write_config_byte,
>>+	pci_exp_write_config_word,
>>+	pci_exp_write_config_dword
>>+};
>>    
>>
>
>C99 initializers here?
>  
>
cut'n'paste from other methods, to keep style. If change, let's change all.

>  
>
>>+			printk(KERN_INFO "PCI-Express config at 0x%08x\n", rrbar_phys);
>>    
>>
>
>"%p" to show the address might be nicer.
>
>  
>
I print phys. address, it is u32. Do you mean (void*)rrbar_phys? Don't 
see why not to change,
I have no strong opinion for which format is better.

