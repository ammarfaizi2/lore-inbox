Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbTBTMKL>; Thu, 20 Feb 2003 07:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbTBTMKL>; Thu, 20 Feb 2003 07:10:11 -0500
Received: from holomorphy.com ([66.224.33.161]:28318 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265230AbTBTMKK>;
	Thu, 20 Feb 2003 07:10:10 -0500
Date: Thu, 20 Feb 2003 04:19:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix kirq code for clustered mode
Message-ID: <20030220121917.GZ29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
References: <3E5272A0.80803@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5272A0.80803@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 09:51:28AM -0800, Dave Hansen wrote:
> The new kirq code breaks clustered apic mode.  This 2-liner fixes it.
> It should compile down to the same thing, unless you're using a
> clustered apic sub-arch.

This isn't quite enough:


static int irq_affinity_write_proc (struct file *file, const char *buffer,
					unsigned long count, void *data)
{
	int irq = (long) data, full_count = count, err;
	unsigned long new_value;

	if (!irq_desc[irq].handler->set_affinity)
		return -EIO;

	err = parse_hex_value(buffer, count, &new_value);

	/*
	 * Do not allow disabling IRQs completely - it's a too easy
	 * way to make the system unusable accidentally :-) At least
	 * one online CPU still has to be targeted.
	 */
	if (!(new_value & cpu_online_map))
		return -EINVAL;

	irq_affinity[irq] = new_value;
	irq_desc[irq].handler->set_affinity(irq, new_value);

	return full_count;
}

This is a bitmask and it's being handed directly to set_ioapic_affinity().
Or, at least, it's inconsistent, being &'d with cpu_online_map.


-- wli
