Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753215AbWKCOby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbWKCOby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 09:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753183AbWKCOby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 09:31:54 -0500
Received: from usea-naimss2.unisys.com ([192.61.61.104]:44562 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S1753215AbWKCObx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 09:31:53 -0500
Subject: Re: [Fastboot] [RFC] [PATCH 2.6.19-rc4] kdump panics early in boot
	when reserving	MP Tables located in high memory
From: Amul Shah <amul.shah@unisys.com>
To: vgoyal@in.ibm.com
Cc: LKML <linux-kernel@vger.kernel.org>, fastboot <fastboot@lists.osdl.org>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <20061102233629.GB18286@in.ibm.com>
References: <1162506272.19677.33.camel@ustr-linux-shaha1.unisys.com>
	 <20061102233629.GB18286@in.ibm.com>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:30:37 -0500
Message-Id: <1162564238.19677.51.camel@ustr-linux-shaha1.unisys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2006 14:31:36.0093 (UTC) FILETIME=[C43744D0:01C6FF54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 18:36 -0500, Vivek Goyal wrote:
> On Thu, Nov 02, 2006 at 05:24:32PM -0500, Amul Shah wrote:
> > The kdump crash kernel panics when it tries to reserve the MP Config
> > tables on an ES7000.
> > 
> > The MP Config table is located above 1MB of physical memory in a
> > reserved memory area.  It is located outside the first 1MB area because
> > the tables are too large, 240k.
> > 
> 
> Hi Amul,
> 
> Can you tell where it is placed in your system? At the end of physical
> RAM?

The MP tables are located at 896MB of RAM.  I believe that we ended up
there because i386 Linux would choke if the tables were located higher
than 896MB (the low memory boundary).

> > The crash kernel is given a user defined memory map with E820 reserved
> > and ACPI areas passed in by kexec tools and a usable area from 16MB
> > physical to 80MB physical.  This user defined map causes the top of
> > memory to be set as 80MB.
> > 
> > The ACPI tables and MP Tables reside higher in memory.  When reserving
> > memory with reserve_bootmem_generic, the function has a BUG panic if the
> > memory location to reserve is above the top of memory.  The MP table is
> > above the top of memory in a user defined memory map.
> > 
> > This patch will ignore reserving the MP tables if the MP table resides
> > in an area already reserved in the E820.
> > 
> > I have two alternate patches that accomplish the same effect if this
> > patch is not acceptable.
> > 1. avoid reserving the MP tables if a user defined memory map or if a
> > user defined memory limit ("mem=") is used.
> > 2. avoid reserving the MP tables if a kernel parameter is passed in to
> > ignore MP table reservation.
> > 
> > 
> 
> I think both the methods are not the right way to solve the problem. It
> will just fix the symtom you are facing. Currently this solution works
> for you as you are using MADT tables from ACPI. But it will fail if you try
> to boot second kernel on your system with acpi=off as MP tables are not
> accessible.

You are correct, this patch most certainly only fixes the Unisys problem
(does that make me a corporate shill? ;).  Since we can't boot the
ES7000 without ACPI, the crash kernel must have access to the ACPI Data
area.

> I think the right way to fix this problem would be to let kexec-tools know
> where the MP table is in RAM and kexec-tools can create another memmap=
> entry for that area so that MP tables are accessible in second kernel.

The MP Tables already reside in a reserved area which the kexec-tools
handles.  Unfortunately because end of ram in the user defined map is
physical 80MB, trying to reserve memory above that point breaks the
ES7000.

> I think you need to export the MP table location and size to user space,
> say through /sys/kernel/. And also modify kexec-tools to parse it.
> 
> Thanks
> Vivek

Andi's suggestion will work with a modification.  I'll post it once I've
tested it.

thanks,
Amul

