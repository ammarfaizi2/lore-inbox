Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUJ1Ogj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUJ1Ogj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUJ1OfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:35:15 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:15089 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S261317AbUJ1OcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:32:13 -0400
Message-ID: <4181025D.1020600@ttnet.net.tr>
Date: Thu, 28 Oct 2004 17:29:49 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20041003
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org, malware@t-online.de
Subject: Re: Linux 2.4.28-rc1
References: <417E5904.9030107@ttnet.net.tr> <20041026203334.GB29688@logos.cnet> <417F9731.5040101@ttnet.net.tr> <20041028095429.GH4815@logos.cnet>
	 <4180F415.8030409@ttnet.net.tr>
In-Reply-To: <4180F415.8030409@ttnet.net.tr>
Content-Type: multipart/mixed;
	boundary="------------050605090204020001080107"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050605090204020001080107
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

O.Sezer wrote:
> Marcelo Tosatti wrote:
> 
>> On Wed, Oct 27, 2004 at 03:40:17PM +0300, O.Sezer wrote:
>>
>>> Marcelo Tosatti wrote:
>>>
>>>> Hi,
>>>>
>>>> If you have been suddenly CC'ed to this message please search
>>>> your name below - there is something which concerns you.
>>>>
>>>> Replying only to the list, myself and O.Sezer is appreciated.
>>>>
>>>> On Tue, Oct 26, 2004 at 05:02:44PM +0300, O.Sezer wrote:
>>>>
>>>>
>>>>> There are many lost/forgotten patches posted here on lkml. Since 
>>>>> 2.4.28
>>>>> is near and 2.4 is going into "deep maintainance" mode soon, I 
>>>>> gathered
>>>>> a short list of some of them. 
>>>>
>>>>
>>>>
>>>> Oh it is hard to bookkeep all of this. I hope people check and 
>>>> resend, but
>>>> they dont do that always.
>>>>
>>>>
>>>>
>>>>> There, sure, are many more of them,  but here it goes.
>>>>
>>>>
>>>>
>>>> Please send'em all. I really appreciate your efforts.
>>>
>>>
>>> [...]
>>>
>>>>> - Michael Mueller: opti-viper pci-chipset support
>>>>> (have an updated-for-2.4.23+ patch for this)
>>>>> http://marc.theaimsgroup.com/?t=106698970100002&r=1&w=2
>>>>> http://marc.theaimsgroup.com/?l=linux-kernel&m=106698965700864&w=2
>>>>
>>>>
>>>>
>>>> Should be applied - v2.6 also lacks it AFAICS.
>>>
>>>
>>> Attached is a one that's supposed to apply cleanly to and work
>>> with 2.4.23+ kernels.
>>
>>
>>
>> Ozkan,
>>
>> Someone needs to check v2.6.
>>
>> Can you or Michael do that please?
>>
>> I'll save it to 2.4.29pre.
> 
> 
> 2.6 doesn't have it but I don't know if it needs it (it should, but...)
> I don't have the hardware anymore, so Michael can look after it, I'm
> sure.
> 

OK, out of curiosity, I did a quick re-diff of the patch, applied onto
the correct file, and did a real quick compile test (and nothing more).
Nothing went bad. Can't say anything about functionality (Michael?).
It is attached. Whom to send it? Linus, akpm?

--------------050605090204020001080107
Content-Type: text/plain;
	name="optiviper_26_test.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="optiviper_26_test.diff"

--- linux-2.6.9/arch/i386/pci/irq.c~
+++ linux-2.6.9/arch/i386/pci/irq.c
@@ -250,6 +250,44 @@
 }
 
 /*
+ * OPTI Viper-M/N+: Bit field with 3 bits per entry.
+ * Due to the lack of a specification the information about this chipset
+ * was taken from the NetBSD source code.
+ */
+static int pirq_viper_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+{
+	static const int viper_irq_decode[] = { 0, 5, 9, 10, 11, 12, 14, 15 };
+	u32 irq;
+
+	pci_read_config_dword(router, 0x40, &irq);
+	irq >>= (pirq-1)*3;
+	irq &= 7;
+
+	return viper_irq_decode[irq];
+}
+
+static int pirq_viper_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
+{
+	static const int viper_irq_map[] = { -1, -1, -1, -1, -1, 1, -1, -1, -1, 2, 3, 4, 5, -1, 6, 7 };
+	int newval = viper_irq_map[irq];
+	u32 val;
+	u32 mask = 7 << (3*(pirq-1));
+#if 0
+	mask |= 0x10000UL << (pirq-1);	/* edge triggered */
+#endif
+
+	if ( newval == -1 )
+		return 0;
+	
+	pci_read_config_dword(router, 0x40, &val);
+	val &= ~mask;
+	val |= newval << (3*(pirq-1));
+	pci_write_config_dword(router, 0x40, val);
+
+	return 1;
+}
+
+/*
  * Cyrix: nibble offset 0x5C
  * 0x5C bits 7:4 is INTB bits 3:0 is INTA 
  * 0x5D bits 7:4 is INTD bits 3:0 is INTC
@@ -567,9 +605,16 @@
 			r->name = "OPTI";
 			r->get = pirq_opti_get;
 			r->set = pirq_opti_set;
-			return 1;
+			break;
+		case PCI_DEVICE_ID_OPTI_82C558:
+			r->name = "OPTI VIPER";
+			r->get = pirq_viper_get;
+			r->set = pirq_viper_set;
+			break;
+		default:
+			return 0;
 	}
-	return 0;
+	return 1;
 }
 
 static __init int ite_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)

--------------050605090204020001080107--
