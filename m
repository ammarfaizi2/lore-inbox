Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVBTIWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVBTIWy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 03:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVBTIWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 03:22:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20240 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261704AbVBTIWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 03:22:41 -0500
Date: Sun, 20 Feb 2005 08:22:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI interrupts. Fish. Please report.]
Message-ID: <20050220082226.A7093@flint.arm.linux.org.uk>
Mail-Followup-To: Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
References: <1108858971.8413.147.camel@localhost.localdomain> <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org> <1108863372.8413.158.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1108863372.8413.158.camel@localhost.localdomain>; from rostedt@goodmis.org on Sat, Feb 19, 2005 at 08:36:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 08:36:12PM -0500, Steven Rostedt wrote:
> Linux version 2.6.10 (root@bilbo) (gcc version 3.3.5 (Debian 1:3.3.5-8)) #13 SMP Sat Feb 19 20:12:19 EST 2005
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
>  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
>  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000f6f0000 (usable)
>  BIOS-e820: 000000000f6f0000 - 000000000f700000 (reserved)
>  BIOS-e820: 000000000f700000 - 000000003fef0000 (usable)
>  BIOS-e820: 000000003fef0000 - 000000003fef8000 (ACPI data)
>  BIOS-e820: 000000003fef8000 - 000000003fefa000 (ACPI NVS)
>  BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)

Your BIOS is broken.  You probably have 1GB of RAM which extends from
0x00000000 to 0x40000000.  However, there's a hole in the ACPI map
between 0x3fefa000 and 0x3ff00000.  This is where your Cardbus devices
are ending up:

> 3fefa000-3fefa3ff : 0000:00:1f.1
> 3fefb000-3fefbfff : 0000:02:01.0
>   3fefb000-3fefbfff : yenta_socket
> 3fefc000-3fefcfff : 0000:02:01.1
>   3fefc000-3fefcfff : yenta_socket

Changing the bridge type to non-transparent just means that we find
we can't allocate the bridge resources in this small window, so they
get moved elsewhere.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
