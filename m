Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269325AbUINOaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269325AbUINOaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 10:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269330AbUINOaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:30:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25041 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269325AbUINOa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:30:28 -0400
Message-ID: <41470074.9010900@pobox.com>
Date: Tue, 14 Sep 2004 10:30:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add skeleton "generic IO mapping" infrastructure.
References: <200409132206.i8DM6dSC030620@hera.kernel.org> <1095152147.9144.254.camel@imladris.demon.co.uk>
In-Reply-To: <1095152147.9144.254.camel@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Mon, 2004-09-13 at 18:32 +0000, Linux Kernel Mailing List wrote:
> 
>>ChangeSet 1.1869, 2004/09/13 11:32:00-07:00, torvalds@ppc970.osdl.org
>>
>>	Add skeleton "generic IO mapping" infrastructure.
>>	
>>	Jeff wants to use this to clean up SATA and some network drivers.
> 
> 
> 
>>+ * Read/write from/to an (offsettable) iomem cookie. It might be a PIO
>>+ * access or a MMIO access, these functions don't care. The info is
>>+ * encoded in the hardware mapping set up by the mapping functions
>>+ * (or the cookie itself, depending on implementation and hw).
>>+ *
>>+ * The generic routines don't assume any hardware mappings, and just
>>+ * encode the PIO/MMIO as part of the cookie. They coldly assume that
>>+ * the MMIO IO mappings are not in the low address range.
>>+ *
>>+ * Architectures for which this is not true can't use this generic
>>+ * implementation and should do their own copy.
>>+ *
>>+ * We encode the physical PIO addresses (0-0xffff) into the
>>+ * pointer by offsetting them with a constant (0x10000) and
>>+ * assuming that all the low addresses are always PIO. That means
>>+ * we can do some sanity checks on the low bits, and don't
>>+ * need to just take things for granted.
>>+ */
>>+#define PIO_OFFSET	0x10000
>>+#define PIO_MASK	0x0ffff
>>+#define PIO_RESERVED	0x40000
> 
> 
>>+#define IO_COND(addr, is_pio, is_mmio) do {			\
>>+	unsigned long port = (unsigned long __force)addr;	\
>>+	if (port < PIO_RESERVED) {				\
>>+		VERIFY_PIO(port);				\
>>+		port &= PIO_MASK;				\
>>+		is_pio;						\
>>+	} else {						\
>>+		is_mmio;					\
>>+	}							\
>>+} while (0)
> 
> 
> Argh! Please no. You can't infer the IO space from the address. Provide
> a cookie containing {space, address} instead -- or indeed {bus,
> address}. Let some architectures optimise that by ignoring the bus and
> working it out from the address if you must, but don't put that in the
> generic version.

Override it in your arch if you don't like the generic version ;-)

	Jeff



