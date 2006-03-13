Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbWCMTu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbWCMTu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWCMTu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:50:58 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:3595 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751595AbWCMTu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:50:57 -0500
Message-ID: <4415CD1F.1010806@vmware.com>
Date: Mon, 13 Mar 2006 11:50:55 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VMI Interface Proposal Documentation for I386, Part 1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This still didn't seem to make it through vger, but gives a very good 
overview of what the interface is designed to do.


    Paravirtualization API Version 2.0

    Zachary Amsden, Daniel Arai, Daniel Hecht, Pratap Subrahmanyam
    Copyright (C) 2005, 2006, VMware, Inc.
    All rights reserved

Revision history:
         1.0: Initial version
         1.1: arai 2005-11-15
              Added SMP-related sections: AP startup and Local APIC support
         1.2: dhecht 2006-02-23
              Added Time Interface section and Time related VMI calls

Contents

1) Motivations
2) Overview
    Initialization
    Privilege model
    Memory management
    Segmentation
    Interrupt and I/O subsystem
    IDT management
    Transparent Paravirtualization
    3rd Party Extensions
    AP Startup
    State Synchronization in SMP systems
    Local APIC Support
    Time Interface
3) Architectural Differences from Native Hardware
4) ROM Implementation
    Detection
    Data layout
    Call convention
    PCI implementation

Appendix A - VMI ROM low level ABI
Appendix B - VMI C prototypes
Appendix C - Sensitive x86 instructions


1) Motivations

   There are several high level goals which must be balanced in designing
   an API for paravirtualization.  The most general concerns are:

   Portability      - it should be easy to port a guest OS to use the API
   High performance - the API must not obstruct a high performance
                  hypervisor implementation
   Maintainability  - it should be easy to maintain and upgrade the guest
                      OS
   Extensibility    - it should be possible for future expansion of the
                      API

   Portability.

     The general approach to paravirtualization rather than full
     virtualization is to modify the guest operating system.  This means
     there is implicitly some code cost to port a guest OS to run in a
     paravirtual environment.  The closer the API resembles a native
     platform which the OS supports, the lower the cost of porting.
     Rather than provide an alternative, high level interface for this
     API, the approach is to provide a low level interface which
     encapsulates the sensitive and performance critical parts of the
     system.  Thus, we have direct parallels to most privileged
     instructions, and the process of converting a guest OS to use these
     instructions is in many cases a simple replacement of one function
     for another. Although this is sufficient for CPU virtualization,
     performance concerns have forced us to add additional calls for
     memory management, and notifications about updates to certain CPU
     data structures. Support for this in the Linux operating system has
     proved to be very minimal in cost because of the already somewhat
     portable and modular design of the memory management layer.

  High Performance.

     Providing a low level API that closely resembles hardware does not
     provide any support for compound operations; indeed, typical
     compound operations on hardware can be updating of many page table
     entries, flushing system TLBs, or providing floating point safety.
     Since these operations may require several privileged or sensitive
     operations, it becomes important to defer some of these operations
     until explicit flushes are issued, or to provide higher level
     operations around some of these functions.  In order to keep with
     the goal of portability, this has been done only when deemed
     necessary for performance reasons, and we have tried to package
     these compound operations into methods that are typically used in
     guest operating systems.  In the future, we envision that additional
     higher level abstractions will be added as an adjunct to the
     low-level API.  These higher level abstractions will target large
     bulk operations such as creation, and destruction of address spaces,
     context switches, thread creation and control.

  Maintainability.

     In the course of development with a virtualized environment, it is
     not uncommon for support of new features or higher performance to
     require radical changes to the operation of the system.  If these
     changes are visible to the guest OS in a paravirtualized system,
     this will require updates to the guest kernel, which presents a
     maintenance problem.  In the Linux world, the rapid pace of
     development on the kernel means new kernel versions are produced
     every few months.  This rapid pace is not always appropriate for end
     users, so it is not uncommon to have dozens of different versions of
     the Linux kernel in use that must be actively supported.  To keep
     this many versions in sync with potentially radical changes in the
     paravirtualized system is not a scalable solution.  To reduce the
     maintenance burden as much as possible, while still allowing the
     implementation to accommodate changes, the design provides a stable
     ABI with semantic invariants.  The underlying implementation of the
     ABI and details of what data or how it communicates with the
     hypervisor are not visible to the guest OS.  As a result, in most
     cases, the guest OS need not even be recompiled to work with a newer
     hypervisor.  This allows performance optimizations, bug fixes,
     debugging, or statistical instrumentation to be added to the API
     implementation without any impact on the guest kernel.  This is
     achieved by publishing a block of code from the hypervisor in the
     form of a ROM.  The guest OS makes calls into this ROM to perform
     privileged or sensitive actions in the system.

  Extensibility.

     In order to provide a vehicle for new features, new device support,
     and general evolution, the API uses feature compartmentalization
     with controlled versioning.  The API is split into sections, with
     each section having independent versions.  Each section has a top
     level version which is incremented for each major revision, with a
     minor version indicating incremental level.  Version compatibility
     is based on matching the major version field, and changes of the
     major version are assumed to break compatibility.  This allows
     accurate matching of compatibility.  In the event of incompatible
     API changes, multiple APIs may be advertised by the hypervisor if it
     wishes to support older versions of guest kernels.  This provides
     the most general forward / backward compatibility possible.
     Currently, the API has a core section for CPU / MMU virtualization
     support, with additional sections provided for each supported device
     class.

