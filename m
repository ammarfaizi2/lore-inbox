Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWCMTzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWCMTzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWCMTzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:55:12 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:48133 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932403AbWCMTzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:55:09 -0500
Message-ID: <4415CE1C.1060608@vmware.com>
Date: Mon, 13 Mar 2006 11:55:08 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VMI Interface Proposal Documentation for I386, Part 4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


3) Architectural Differences from Native Hardware.

     For the sake of performance, some requirements are imposed on kernel
     fault handlers which are not present on real hardware.  Most modern
     operating systems should have no trouble meeting these requirements.
     Failure to meet these requirements may prevent the kernel from
     working properly.

     1) The hardware flags on entry to a fault handler may not match
        the EFLAGS image on the fault handler stack.  The stack image
        is correct, and will have the correct state of the interrupt
        and arithmetic flags.

     2) The stack used for kernel traps must be flat - that is, zero base,
        segment limit determined by the hypervisor.

     3) On entry to any fault handler, the stack must have sufficient space
        to hold 32 bytes of data, or the guest may be terminated.

     4) When calling VMI functions, the kernel must be running on a
        flat 32-bit stack and code segment.

     5) Most VMI functions require flat data and extra segment (DS and ES)
        segments as well; notable exceptions are IRET and SYSEXIT.
        XXXPara - may need to add STI and CLI to this list.

     6) Interrupts must always be enabled when running code in userspace.

     7) IOPL semantics for userspace are changed; although userspace may be
        granted port access, it can not affect the interrupt flag.

     8) The EIPs at which faults may occur in VMI calls may not match the
        original native instruction EIP; this is a bug in the system
        today, as many guests do rely on lazy fault handling.

     9) On entry to V8086 mode, MSR_SYSENTER_CS is cleared to zero.

     10) Todo - we would like to support these features, but they are not
        fully tested and / or implemented:

        Userspace 16-bit stack support
        Proper handling of faulting IRETs

4) ROM Implementation

   Modularization

     Originally, we envisioned modularizing the ROM API into several
     subsections, but the close coupling between the initial layers
     and the requirement to support native PCI bus devices has made
     ROM components for network or block devices unnecessary to this
     point in time.

    VMI - the virtual machine interface.  This is the core CPU, I/O
          and MMU virtualization layer.  I/O is currently limited
              to port access to emulated devices.
    
   Detection

      The presence of hypervisor ROMs can be recognized by scanning the
      upper region of the first megabyte of physical memory.  Multiple
      ROMs may be provided to support older API versions for legacy guest
      OS support.  ROM detection is done in the traditional manner, by
      scanning the memory region from C8000h - DFFFFh in 2 kilobyte
      increments.  The romSignature bytes must be '0x55, 0xAA', and the
      checksum of the region indicated by the romLength field must be zero.
      The checksum is a simple 8-bit addition of all bytes in the ROM 
region.

   Data layout

      typedef struct HyperRomHeader {
         uint16_t        romSignature;
         int8_t          romLength;
         unsigned char   romEntry[4];
         uint8_t         romPad0;
         uint32_t        hyperSignature;
         uint8_t         APIVersionMinor;
         uint8_t         APIVersionMajor;
         uint8_t         reserved0;
         uint8_t         reserved1;
         uint32_t        reserved2;
         uint32_t        reserved3;
         uint16_t        pciHeaderOffset;
         uint16_t        pnpHeaderOffset;
         uint32_t        romPad3;
         char            reserved[32];
         char            elfHeader[64];
      } HyperRomHeader;

      The first set of fields is defined by the BIOS:

      romSignature - fixed 0xAA55, BIOS ROM signature
      romLength    - the length of the ROM, in 512 byte chunks.
                     Determines the area to be checksummed.
      romEntry     - 16-bit initialization code stub used by BIOS.
      romPad0      - reserved

      The next set of fields is defined by this API:

      hyperSignature  - a 4 byte signature providing recognition of the
                    device class represented by this ROM.  Each
                    device class defines its own unique signature.
      APIVersionMinor - the revision level of this device class' API.
                    This indicates incremental changes to the API.
      APIVersionMajor - the major version. Used to indicates large
                    revisions or additions to the API which break
                    compatibility with the previous version.
      reserved0,1,2,3 - for future expansion

      The next set of fields is defined by the PCI / PnP BIOS spec:

      pciHeaderOffset - relative offset to the PCI device header from
                  the start of this ROM.
      pnpHeaderOffset - relative offset to the PnP boot header from the
                    start of this ROM.
      romPad3         - reserved by PCI spec.

      Finally, there is space for future header fields, and an area
      reserved for an ELF header to point to symbol information.

