Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752367AbWKBXh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbWKBXh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 18:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbWKBXh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 18:37:28 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:46477 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752367AbWKBXh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 18:37:27 -0500
Date: Thu, 2 Nov 2006 18:36:29 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Amul Shah <amul.shah@unisys.com>
Cc: LKML <linux-kernel@vger.kernel.org>, fastboot <fastboot@lists.osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [Fastboot] [RFC] [PATCH 2.6.19-rc4] kdump panics early in boot when reserving	MP Tables located in high memory
Message-ID: <20061102233629.GB18286@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1162506272.19677.33.camel@ustr-linux-shaha1.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162506272.19677.33.camel@ustr-linux-shaha1.unisys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 05:24:32PM -0500, Amul Shah wrote:
> The kdump crash kernel panics when it tries to reserve the MP Config
> tables on an ES7000.
> 
> The MP Config table is located above 1MB of physical memory in a
> reserved memory area.  It is located outside the first 1MB area because
> the tables are too large, 240k.
> 

Hi Amul,

Can you tell where it is placed in your system? At the end of physical
RAM?

> The crash kernel is given a user defined memory map with E820 reserved
> and ACPI areas passed in by kexec tools and a usable area from 16MB
> physical to 80MB physical.  This user defined map causes the top of
> memory to be set as 80MB.
> 
> The ACPI tables and MP Tables reside higher in memory.  When reserving
> memory with reserve_bootmem_generic, the function has a BUG panic if the
> memory location to reserve is above the top of memory.  The MP table is
> above the top of memory in a user defined memory map.
> 
> This patch will ignore reserving the MP tables if the MP table resides
> in an area already reserved in the E820.
> 
> I have two alternate patches that accomplish the same effect if this
> patch is not acceptable.
> 1. avoid reserving the MP tables if a user defined memory map or if a
> user defined memory limit ("mem=") is used.
> 2. avoid reserving the MP tables if a kernel parameter is passed in to
> ignore MP table reservation.
> 
> 

I think both the methods are not the right way to solve the problem. It
will just fix the symtom you are facing. Currently this solution works
for you as you are using MADT tables from ACPI. But it will fail if you try
to boot second kernel on your system with acpi=off as MP tables are not
accessible.

I think the right way to fix this problem would be to let kexec-tools know
where the MP table is in RAM and kexec-tools can create another memmap=
entry for that area so that MP tables are accessible in second kernel.

I think you need to export the MP table location and size to user space,
say through /sys/kernel/. And also modify kexec-tools to parse it.

Thanks
Vivek
