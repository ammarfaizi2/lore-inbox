Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261358AbREPVhs>; Wed, 16 May 2001 17:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262097AbREPVhi>; Wed, 16 May 2001 17:37:38 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33504 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261358AbREPVhW>;
	Wed, 16 May 2001 17:37:22 -0400
Message-ID: <3B02F30F.5D05C77E@mandrakesoft.com>
Date: Wed, 16 May 2001 17:37:19 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
Cc: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ((struct pci_dev*)dev)->resource[...].start
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678ED4@mail-in.comverse-in.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Khachaturov, Vassilii" wrote:
> Can someone please confirm if my assumptions below are correct:
> 1) Unless someone specifically tampered with my driver's device since the OS
> bootup, the mapping of the PCI base address registers to virtual memory will
> remain the same (just as seen in /proc/pci, and as reflected in <subj>)? If
> not, is there a way to freeze it for the time I want to access it?

This is not a safe assumption, because the OS may reprogram the PCI BARs
at certain times.  The rule is:  ALWAYS read from dev->resource[] unless
you are a bus driver (PCI bridges, for example, need to assign
resources).

Further, access to PCI BARs -and- dev->resource[] in a driver is wrong
until you have called pci_enable_device.  Resource and IRQ assignment
potentially occurs at pci_enable_device time, so BAR is [potentially]
undefined before then.

Finally, make sure to use pci_resource_{start,end,len,flags} macros to
make your core more portable and future-proof.

> 2) (Basically, the question is "Do I understand Documentation/IO-mapping.txt
> right?")
> PCI memory, whenever IO type or memory type, can not be dereferenced but
> should be accessed with readb() etc. On i386, PCI mem (memory type) can be
> accessed by direct pointer access, but this is not portable.

We will yell at you mightily if you directly access PCI mem with a
pointer.  As you say it only works on i386 -- but IIRC since ioremap is
required, we are perfectly free to change or modify that assumption. 
For example ioremap might [have to] care about whether or not a pci mem
region is prefetchable.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
