Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTLJLO4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 06:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTLJLO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 06:14:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43017 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263528AbTLJLOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 06:14:55 -0500
Date: Wed, 10 Dec 2003 11:14:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Matthew Reppert <repp0017@tc.umn.edu>,
       Guennadi Liakhovetski <gl@dsa-ac.de>,
       LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
Subject: Re: [OOPS] 2.6.0-test11 sysfs
Message-ID: <20031210111451.G16651@flint.arm.linux.org.uk>
Mail-Followup-To: Maneesh Soni <maneesh@in.ibm.com>,
	Matthew Reppert <repp0017@tc.umn.edu>,
	Guennadi Liakhovetski <gl@dsa-ac.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
References: <Pine.LNX.4.33.0312091826090.1130-100000@pcgl.dsa-ac.de> <1070992648.27231.7.camel@minerva> <20031209211440.A16651@flint.arm.linux.org.uk> <20031210110632.GA1314@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031210110632.GA1314@in.ibm.com>; from maneesh@in.ibm.com on Wed, Dec 10, 2003 at 04:36:33PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 04:36:33PM +0530, Maneesh Soni wrote:
> How is the following patch? It moves the complete() call in the "pccardd" 
> thread after class_device_register(), so that in init_i82365() when
> pcmcia_register_socket() is done we are sure that class device is 
> registered before creating the attribute files.

You'll either deadlock if you have a Cardbus card in the slot at
initialisation, or break standard PCMCIA cards due to a race.

The PCMCIA card race is the exact reason why class_device_register
was moved out of pcmcia_register_socket() in the first place; we
tried adding locks, but that just caused deadlock.

Basically, the only way this can be properly solved is to find some
solution to sysfs's restriction that you can't add devices for a
particular bus type from the same bus type driver's probe method.

IOW, you can't add PCI devices from a PCI device drivers probe method,
and you can't remove PCI devices from a PCI device drivers remove
method.

Pat decided that it was too risky/too late to try to fix this for 2.6,
so our only option now is to disable the problematical bits of code.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
