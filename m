Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264752AbSKEKOW>; Tue, 5 Nov 2002 05:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbSKEKOW>; Tue, 5 Nov 2002 05:14:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54022 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264752AbSKEKOV>; Tue, 5 Nov 2002 05:14:21 -0500
Date: Tue, 5 Nov 2002 10:20:55 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 odd deref in serial_in
Message-ID: <20021105102055.B20224@flint.arm.linux.org.uk>
Mail-Followup-To: Zwane Mwaikambo <zwane@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211042323410.27141-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211042323410.27141-100000@montezuma.mastecende.com>; from zwane@holomorphy.com on Mon, Nov 04, 2002 at 11:27:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 11:27:28PM -0500, Zwane Mwaikambo wrote:
> 0xc023b428 <serial_in+24>:      je     0xc023b461 <serial_in+81>
> 0xc023b42a <serial_in+26>:      cmp    $0x2,%eax
> 0xc023b42d <serial_in+29>:      je     0xc023b440 <serial_in+48>
> 0xc023b42f <serial_in+31>:      mov    0x8(%ebx),%eax
> 0xc023b432 <serial_in+34>:      add    %eax,%edx
> 0xc023b434 <serial_in+36>:      in     (%dx),%al
> 
> eax: 00000000   ebx: 81acc5f0   ecx: 00000000   edx: 00000005
> 
> ...
> 	default:
> 		return inb(up->port.iobase + offset); <--
> 	}

Ok, if I'm reading this correctly:

offset = %edx
up->port.iobase = 0x8(%ebx)
up = %ebx

To get to this return statement, we would have had to execute:

static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int offset)
{
        offset <<= up->port.regshift;

        switch (up->port.iotype) {

which also dereferences "up".  So something may have corrupted %ebx
between executing that switch statement and executing the inb().

Could the NMI handler be corrupting %ebx ?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

