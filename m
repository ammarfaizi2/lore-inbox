Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154889AbPGNXN2>; Wed, 14 Jul 1999 19:13:28 -0400
Received: by vger.rutgers.edu id <S154876AbPGNXNJ>; Wed, 14 Jul 1999 19:13:09 -0400
Received: from [144.191.22.149] ([144.191.22.149]:4760 "EHLO sting.phx.mcd.mot.com") by vger.rutgers.edu with ESMTP id <S154807AbPGNXLS>; Wed, 14 Jul 1999 19:11:18 -0400
Message-ID: <378D2636.47F7807@phx.mcd.mot.com>
Date: Wed, 14 Jul 1999 17:07:18 -0700
From: Johnnie Peters <jpeters@phx.mcd.mot.com>
Organization: Motorola Computer Group
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-ha@muc.de" <linux-ha@muc.de>, "linux-kernel@vger.rutgers.edu" <linux-kernel@vger.rutgers.edu>, "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>, Linux Hot Swap <hotplug-list@redhat.com>
Subject: Motorola PCI services follow up.
Content-Type: multipart/mixed; boundary="------------3E5D695EF8FB80931D6FD853"
Sender: owner-linux-kernel@vger.rutgers.edu

This is a multi-part message in MIME format.
--------------3E5D695EF8FB80931D6FD853
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Everybody,

Here is a HOWTO on the PCI services changes I posted for Motorola
yesterday.

Johnnie
--------------3E5D695EF8FB80931D6FD853
Content-Type: text/plain; charset=us-ascii;
 name="HOWTO-PCI_SERVICES"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HOWTO-PCI_SERVICES"

  MCG Linux PCI Kernel Services (PKS) HOWTO
  v1.0.0, 14 July 1999
  Robert Robinson

  This document describes how to install and use the Motorola 
  Computer Group PKS package for Linux, and answers some 
  frequently asked questions.  
  ______________________________________________________________________




  Table of Contents


  1. General information and hardware requirements

     1.1 Introduction
     1.2 What systems are supported?

  2. Compilation and installation

     2.1 Prerequisites and kernel setup
     2.2 Installation
     2.3 Configuration
         2.3.1 PKS Options
         2.3.2 Configuring PKS for MCG platforms
     2.4 Compilation
     2.5 Notes about specific Linux distributions

  3. Usage and features

     3.1 PKS Interface
         3.1.1 Add Node
         3.1.1 Delete Node
     3.2 Errnos
     3.3 PCI utilities

  4. Debugging tips and problem reporting

     4.1 Submitting useful bug reports
     4.2 Interpreting kernel trap reports
     4.3 Low level PKS debugging aids


  ______________________________________________________________________



  1. General information and hardware requirements


  1.1 Introduction 

  The PCI Kernel Services patch package for Linux works in conjunction
  with the MCG HOTSWAP package to provide hot swap functionality for
  Linux on CompactPCI systems. It includes changes to the Linux PCI
  driver to all PCI nodes/devices to be added or removed from the PCI
  topology.

  The PCI Kernel Services provide minimal dynamic PCI device and
  resource management in Linux. Currently, Linux does not support this.
  Linux simply probes the PCI bus for devices and adds them to a
  static device list. Linux assumes that resources for each device in its
  device list has been allocated by the system's PCIBIOS. Hence, Linux
  simply reads the resource/configuration information for each device in
  the device list and saves it.

  To support hot swap functionality, PCI resource management needs to
  support the dynamic insertion and extraction of boards and the
  accompanying resource allocation and de-allocation requests. PCI
  resources fall into three categories:

  - PCI Bus Numbering
  - PCI I/O Space
  - PCI Memory Space

  PCI device management needs to support the addition or deletion
  of devices located on the boards. PCI devices fall into two
  categories:

  - Bus Node (PCI-To-PCI Bridges)
  - Device Node (non PCI-To-PCI Bridges)

  In addition to dynamic PCI device and resource management functions
  within the Linux kernel was the addition of a node interface to the
  Linux proc file system, i.e. /proc/bus/pci/node. This interface
  allows an application program, e.g. the Hot Swap Event Manager, to add
  or delete a node via the PCI device/resource management kernel
  functions.

  This document is provided "AS IS", with no express or implied
  warranties. Use the information in this document at your own risk.


  1.2 What systems are supported?

  The PCI Kernel Services patch package has been tested on CPV5000,
  CPV5300, and CPV5350 (Intel based) processor modules housed in a
  CPX2208 chassis and on CPV5350, and MCP750 (PowerPC based) processor
  modules housed in a CPX8216 chassis.


  2. Compilation and installation


  2.1 Prerequisites and kernel setup

  The following things should be installed on your system before you
  begin:
  
  - A 2.2.xx series kernel source tree that has been patched with
    the MCG PCI Kernel Services patch.    

  - Modutils 2.1.85 or above.

  You need to have a complete Linux source tree for your kernel, not
  just an up-to-date kernel image. The driver modules contain some
  references to kernel source files. 

  Current "stable" kernel sources and patches are available from
  <ftp://sunsite.unc.edu/pub/Linux/kernel/v2.2>, or from
  <ftp://tsx-11.mit.edu/pub/linux/sources/system/v2.2>. 
  Current module utilities can be found in the same locations.

  In the Linux kernel source tree, the Documentation/Changes file
  describes the versions of all sorts of other system components that
  are required for that kernel release. You may want to check through
  this and verify that your system is up to date, especially if you have
  updated your kernel. 


  2.2 Installation

  You install the PCI Kernel Services' releases by patching. Patches
  are distributed in the traditional gzip. To install by patching, get
  the PCI Kernel Services' patch file for the Linux kernel you are using.

  Then:

    cd /usr/src
    gzip -cd patch-2.2.xx-pci.gz | patch -p0

  or

    cd /usr/src
    gzip patch-2.2.xx-pci.gz
    patch -p0 < patch-2.2.xx-pci

  The default directory for the kernel source is /usr/src/linux.
  However, the patch file is applied against the source under
  the /usr/src/linux-2.2.xx directory.


  2.3 Configuration

  2.3.1 PKS Options

  The following configuration options have been added to support
  dynamic PCI device/resource management:

  - PCI services (CONFIG_PCI_SERVICES)

    If your platform supports PCI hot swap capability,
    you can add dynamic PCI device/resource management
    services here, e.g. dynamic PCI bus node management,
    as well as PCI memory and I/O space management. If
    unsure, say N.

  - PCI Bus Level 0 nodes (CONFIG_PCI_BUSLVL0_NODES)

    This PCI Services option sets the number of Bus Level
    0 nodes for your platform. The number of Bus Level 0
    nodes is the same as the number of PCI Host Bridges
    connected to the Host Bus.  Normally, each system has
    only one Host Bridge. 

  - PCI Bus Level 1 nodes (CONFIG_PCI_BUSLVL1_NODES)

    This PCI Services option sets the number of Bus Level
    1 nodes for your platform. The number of Bus Level 1
    nodes is the number of PCI-2-PCI bridges (excluding
    any AGP bridges) whose primary bus is the Host Bridges'
    secondary bus, e.g. PCI bus 0. Normally, each system
    has only one such bridge.

  - PCI Bus Level 2 nodes (CONFIG_PCI_BUSLVL2_NODES)

    This PCI Services option sets the number of Bus Level
    2 nodes for your platform. Typically, each PCI slot or
    card in a system is a Bus Level 2 node. Each card usually
    has one PCI-2-PCI bridge which is connected to a Bus
    Level 1 node. The maximum number of PCI cards (hence,
    Bus Level 2 nodes) is normally eight for a system.

  - PCI Bus Level 3 nodes (CONFIG_PCI_BUSLVL3_NODES)

    This PCI Services option sets the number of Bus
    Level 3 nodes for your platform. A Bus Level 3 node
    is an additional PCI-2-PCI bridge located on the PCI
    card. Normally, there is no more than one additional
    bridge (connected to a Bus Level 2 node) per card.

  - PCI I/O space starting address (CONFIG_PCI_IO_START)

    This PCI Services option sets the starting address of
    configurable PCI I/O space for your platform. If no
    configurable PCI I/O space is needed or available,
    then set this value to 00000000 and the
    CONFIG_PCI_IO_END PCI Services option to ffffffff.

  - PCI I/O space ending address (CONFIG_PCI_IO_END)

    This PCI Services option sets the ending address of
    configurable PCI I/O space for your platform. If no
    configurable PCI I/O space is needed or available,
    then set this value to ffffffff and the
    CONFIG_PCI_IO_START PCI Services option to 00000000.

  - PCI 20-bit memory space starting address (CONFIG_PCI_MEM20_START)

    This PCI Services option sets the starting address of
    configurable PCI 20-bit memory space (i.e. memory below
    1M byte) for your platform. Note that only Bus 0 devices
    can be configured to use 20-bit memory.

  - PCI 20-bit memory space ending address (CONFIG_PCI_MEM20_END)

    This PCI Services option sets the ending address of
    configurable PCI 20-bit memory space (i.e. memory below
    1M byte) for your platform. Note that only Bus 0 devices
    can be configured to use 20-bit memory.

  - PCI memory space starting address (CONFIG_PCI_MEM_START)

    This PCI Services option sets the starting address of normal
    configurable PCI memory space (i.e. either 32-bit memory or
    64-bit memory).

  - PCI memory space ending address (CONFIG_PCI_MEM_END)

    This PCI Services option sets the ending address of normal
    configurable PCI memory space (i.e. either 32-bit memory or
    64-bit memory).

  - PCI prefetch memory space starting address (CONFIG_PCI_MEMPF_START)

    This PCI Services option sets the starting address of
    configurable PCI prefetchable memory space, (i.e. either
    32-bit prefetchable memory or 64-bit prefetchable memory).
    If no configurable PCI prefetchable memory space is needed
    or available, then set this value to 00000000 and the
    CONFIG_PCI_MEMPF_END PCI Services option to ffffffff.

  - PCI prefetch memory space ending address (CONFIG_PCI_MEMPF_END)

    This PCI Services option sets the ending address of configurable
    PCI prefetchable memory space, (i.e. either 32-bit prefetchable
    memory or 64-bit prefetchable memory). If no configurable PCI
    prefetchable memory space is needed or available, then set this
    value to ffffffff and the CONFIG_PCI_MEMPF_START PCI Services
    option to 00000000.

  - PCI AGP bridge (CONFIG_PCI_AGP_BRIDGE)

    This PCI Services option enables support for an AGP
    PCI-2-PCI bridge device. If your platform doesn't have
    an AGP PCI-2-PCI bridge device, then you should say N
    here. If unsure, say N.

  - PCI AGP bridge I/O space size (CONFIG_PCI_AGP_IO_SIZE)

    If the AGP PCI-2-PCI bridge option is enabled, this PCI
    Services option sets the size of I/O space that will be
    allocated for the AGP PCI-2-PCI bridge device.

  - PCI AGP bridge memory space size (CONFIG_PCI_AGP_MEM_SIZE)

    If the AGP PCI-2-PCI bridge option is enabled, this PCI
    Services option sets the size of memory space that will be
    allocated for the AGP PCI-2-PCI bridge device.

  - PCI AGP prefetch memory space size (CONFIG_PCI_AGP_MEMPF_SIZE)

    If the AGP PCI-2-PCI bridge option is enabled, this PCI
    Services option sets the size of prefetchable memory space
    that will be allocated for the AGP PCI-2-PCI bridge device.

  - PCI local IRQ A (CONFIG_PCI_LOCAL_PIRQA)

    This PCI Services option sets the PCI Interrupt A (PIRQA)
    value for PCI for the local domain.

  - PCI local IRQ B (CONFIG_PCI_LOCAL_PIRQB)

    This PCI Services option sets the PCI Interrupt B (PIRQB)
    value for PCI for the local domain.

  - PCI local IRQ C (CONFIG_PCI_LOCAL_PIRQC)

    This PCI Services option sets the PCI Interrupt C (PIRQC)
    value for PCI for the local domain.

  - PCI local IRQ D (CONFIG_PCI_LOCAL_PIRQD)

    This PCI Services option sets the PCI Interrupt D (PIRQD)
    value for PCI for the local domain.

  - PCI multi-domain system (CONFIG_PCI_MULTI_DOMAIN)

    This PCI Services option enables support for systems with
    more than one PCI domain, i.e. a local domain and a remote
    domain. If you have a system with only one domain, like
    most personal computers, say N.

  - PCI remote IRQ A (CONFIG_PCI_REMOTE_PIRQA)

    If the multi-domain option is enabled, this PCI
    PCI Services option sets the PIRQA value for PCI
    Interrupt A in the remote domain.

  - PCI remote IRQ B (CONFIG_PCI_REMOTE_PIRQB)

    If the multi-domain option is enabled, this PCI
    PCI Services option sets the PIRQB value for PCI
    Interrupt A in the remote domain.

  - PCI remote IRQ C (CONFIG_PCI_REMOTE_PIRQC)

    If the multi-domain option is enabled, this PCI
    PCI Services option sets the PIRQC value for PCI
    Interrupt A in the remote domain.

  - PCI remote IRQ D (CONFIG_PCI_REMOTE_PIRQD)

    If the multi-domain option is enabled, this PCI
    PCI Services option sets the PIRQD value for PCI
    Interrupt A in the remote domain.

  - PCI remote domain bridge device/function (CONFIG_PCI_REMOTE_DEV)

    This PCI Services option sets the device/function value
    for the remote domain PCI-2-PCI bridge. This is used
    by the PCI Services to differentiate between local and
    remote devices in a multi-domain system.

  - PCI local domain bridge device/function (CONFIG_PCI_LOCAL_DEV)

    This PCI Services option sets the device/function value
    for the local domain PCI-2-PCI bridge. This is used
    by the PCI Services to differentiate between local and
    remote devices in a multi-domain system.

  - PCI PIRQ registers update (CONFIG_PCI_PIRQ_UPDATE)

    This PCI Services option will update the interrupt
    control device's PIRQ registers with the local PCI
    IRQ values if selected. If unsure, say Y.

  - PCI Bus 0 device configuration (CONFIG_PCI_BUS_0_DEVICES)

    This PCI Services option enables the dynamic configuration of
    Bus 0 PCI devices. If not enabled, then the PCIBIOS
    configuration of Bus 0 PCI devices, except for PCI-2-PCI
    bridges, will be retained and used.  If your platform is Intel
    based, then you should say N here. If unsure, say N.

  - PCI Command Reg. - Special Cycle Recognition (CONFIG_PCI_COMMAND_SPECIAL)

    This PCI Services option will set the Special Cycle Recognition
    bit in each device's command register. When set, the device will
    be enabled to monitor PCI special cycles (if it's designed to
    monitor special cycles). If not set, the device will ignore
    special cycles.  If unsure, say N.

  - PCI Command Reg. - Memory Write/Invalidate (CONFIG_PCI_COMMAND_INVALIDATE)

    This PCI Services option will set the Memory Write and
    Invalidate Enable bit in each device's command register.
    When set, the device will be enabled to generate the memory
    write and invalidate command.  If not set, the device will
    use memory write commands instead. If unsure, say N.

  - PCI Command Reg. - Parity Error Response (CONFIG_PCI_COMMAND_PARITY)

    This PCI Services option will set the Parity Error Response
    bit in each device's command register. When set, the device
    can report parity errors. If not set, the device ignores
    parity errors. If unsure, say N.

  - PCI Command Reg. - Wait Cycle (CONFIG_PCI_COMMAND_WAIT)

    This PCI Services option will set the Wait Cycle Enable bit
    in each device's command register. This bit controls whether
    the device does address/data stepping. If unsure, say N.

  - PCI Command Reg. - System Error (CONFIG_PCI_COMMAND_SERR)

    This PCI Services option will set the System Error Enable
    bit in each device's command register. When set, the device
    can drive the SERR# line. If unsure, say Y.

  - PCI Cache Line Size (CONFIG_PCI_CACHE_LINE_SIZE)

    This PCI Services option will set the Cache Line Size value
    for each device. For Intel-based platforms, this is normally
    4. For PowerPC-based platforms, this is normally 8.

  - PCI Latency Timer (CONFIG_PCI_LATENCY_TIMER)

    This PCI Services option will set the Latency Timer value for
    each device. For Intel-based platforms, this is normally 32.
    For PowerPC-based platforms, this is normally 128.

  - PCI Secondary Latency Timer (CONFIG_PCI_SEC_LATENCY_TIMER)

    This PCI Services option will set the Secondary Latency Timer
    value for each bridge device. For Intel-based platforms, this
    is normally 64. For PowerPC-based platforms, this is normally
    128.

  - PCI Bridge Ctl. - Parity Error Response (CONFIG_PCI_BRIDGE_CTL_PARITY)

    This PCI Services option will set the Parity Error Response
    bit in each bridge device's bridge control register. When set,
    the bridge takes the normal actions when a parity error is
    detected on the secondary side. If not set, parity errors are
    ignored, but the bridge must generate proper parity. If unsure,
    say N.

  - PCI Bridge Ctl. - System Error (CONFIG_PCI_BRIDGE_CTL_SERR)

    This PCI Services option will set the System Error Enable bit
    in each bridge device's bridge control register. When set,
    detection of SERR# asserted on the secondary side causes the
    bridge to assert SERR# on the primary side (but only if the
    SERR# enable bit in the command register is set). If not set,
    detection of SERR# on the secondary side is ignored. If unsure,
    say N.

  - PCI Bridge Ctl. - ISA Mode (CONFIG_PCI_BRIDGE_CTL_ISA_MODE)

    This PCI Services option will set the ISA Mode bit in each
    bridge device's bridge control register. When set, the bridge
    only recognizes I/O addresses within the usable ranges that
    do not alias to an ISA range. If unsure, say N.

  - PCI Bridge Ctl. - Master Abort Mode (CONFIG_PCI_BRIDGE_CTL_MASTER_ABORT)

    This PCI Services option will set the Master Abort Mode bit in
    each bridge device's bridge control register. When set, if the
    bridge experiences a master abort, it issues a target abort to
    the initiating master. If not set, any reads that experiences
    a master abort returns all ones; any writes complete normally
    and the data is thrown away. If unsure, say N.


  2.3.2 Configuring PKS for MCG platforms

  Change directory to the PCI driver directory:

    cd /usr/src/linux-2.2.xx/drivers/pci

  Then do a "soft link" of the correct configuration file
  for your platform to "Config.in". For example:

  If your platform is a CPV5000 based platform, then:

    ln -s Config.in.cpv5000 Config.in

  If your platform is a CPV5300 based platform, then:

    ln -s Config.in.cpv5300 Config.in

  If your platform is a CPV5350 based platform, then:

    ln -s Config.in.cpv5350 Config.in

  If your platform is a CPX8216 based platform, then:

    ln -s Config.in.cpx8216 Config.in

  Execute the desired configuration commands: 

	"make menuconfig"  Text based color menus, radiolists & dialogs.

  or

	"make xconfig"     X windows based configuration tool.
   
  Select the "General setup" option.

  Ensure the "PCI support" option is enabled, i.e. "Y".

  For "PCI access mode", select "Direct".

  Select and enable the "PCI services" option, i.e. "Y".

  For CPV5000 based platforms, do:

    - Ensure the "PCI Bus Level 0 nodes"
      value is set to "1".
 
    - Ensure the "PCI Bus Level 1 nodes"
      value is set to "1".
 
    - Ensure the "PCI Bus Level 2 nodes"
      value is set to "7".
 
    - Ensure the "PCI Bus Level 3 nodes"
      value is set to "1".
 
    - Ensure the "PCI I/O space starting address"
      value is set to "00007000".
 
    - Ensure the "PCI I/O space ending address"
      value is set to "0000dfff".
 
    - Ensure the "PCI 20-bit memory space starting address"
      value is set to "00000000".
 
    - Ensure the "PCI 20-bit memory space ending address"
      value is set to "000fffff".
 
    - Ensure the "PCI memory space starting address"
      value is set to "ff000000".
 
    - Ensure the "PCI memory space ending address"
      value is set to "ff8fffff".
 
    - Ensure the "PCI prefetch memory space starting address
      value is set to "fe000000".
 
    - Ensure the "PCI prefetch memory space ending address"
      value is set to "feffffff".

    - De-select and disable the "PCI AGP bridge"
      option, i.e. "N".
 
    - Ensure the "PCI local IRQ A"
      value is set to "5".
 
    - Ensure the "PCI local IRQ B"
      value is set to "9".
 
    - Ensure the "PCI local IRQ C"
      value is set to "5".
 
    - Ensure the "PCI local IRQ D"
      value is set to "10".

    - De-select and disable the "PCI multi-domain system"
      option, i.e. "N".
 
    - Select and enable the "PCI PIRQ registers update"
      option, i.e. "Y".

    - De-select and disable the "PCI Bus 0 device configuration"
      option, i.e. "N".

    - De-select and disable the "PCI Command Reg. - Special
      Cycle Recognition" option, i.e. "N".
 
    - Select and enable the "PCI Command Reg. - Memory
      Write/Invalidate" option, i.e. "Y".

    - De-select and disable the "PCI Command Reg. - Parity
      Error Response" option, i.e. "N".

    - De-select and disable the "PCI Command Reg. - Wait
      Cycle" option, i.e. "N".
 
    - Select and enable the "PCI Command Reg. - System
      Error" option, i.e. "Y".
 
    - Ensure the "PCI Cache Line Size"
      value is set to "4".
 
    - Ensure the "PCI Latency Timer"
      value is set to "32".
 
    - Ensure the "PCI Secondary Latency Timer"
      value is set to "64".
 
    - Select and enable the "PCI Bridge Ctl. - Parity
      Error Response" option, i.e. "Y".
 
    - Select and enable the "PCI Bridge Ctl. - System Error"
      option, i.e. "Y".

    - De-select and disable the "PCI Bridge Ctl. - ISA Mode"
      option, i.e. "N".

    - De-select and disable the "PCI Bridge Ctl. - Master
      Abort Mode" option, i.e. "N".

  For CPV5300 based platforms, do:

    - Ensure the "PCI Bus Level 0 nodes"
      value is set to "1".
 
    - If your system is single-domain, then
      ensure the "PCI Bus Level 1 nodes"
      value is set to "1".  If your system is
      multi-domain, then ensure the "PCI Bus
      Level 1 nodes" value is set to "2".
 
    - If your system is single-domain, then
      ensure the "PCI Bus Level 3 nodes"
      value is set to "7". If your system is
      multi-domain, then ensure the "PCI Bus
      Level 3 nodes" value is set to "6".
 
    - Ensure the "PCI Bus Level 3 nodes"
      value is set to "1".

    - Ensure the "PCI I/O space starting address"
      value is set to "00001000".

    - Ensure the "PCI I/O space ending address"
      value is set to "00007fff".

    - Ensure the "PCI 20-bit memory space starting address"
      value is set to "00000000".
 
    - Ensure the "PCI 20-bit memory space ending address"
      value is set to "000fffff".
 
    - Ensure the "PCI memory space starting address"
      value is set to "fc000000".
 
    - Ensure the "PCI memory space ending address"
      value is set to "feafffff".
 
    - Ensure the "PCI prefetch memory space starting address
      value is set to "f5000000".
 
    - Ensure the "PCI prefetch memory space ending address"
      value is set to "f7ffffff".
 
    - Select and enable the "PCI AGP bridge"
      option, i.e. "Y".
 
      - Ensure the "PCI AGP bridge I/O space size"
        value is set to "00000000".
 
      - Ensure the "PCI AGP bridge memory space size"
        value is set to "00100000".
 
      - Ensure the "PCI AGP prefetch memory space size"
        value is set to "01000000".
 
    - Ensure the "PCI local IRQ A"
      value is set to "5".
 
    - Ensure the "PCI local IRQ B"
      value is set to "9".
 
    - Ensure the "PCI local IRQ C"
      value is set to "5".
 
    - Ensure the "PCI local IRQ D"
      value is set to "10".
 
    - If your system is single-domain, then de-select
      and disable the "PCI multi-domain system" option,
      i.e. "N". If your system is multi-domain, then
      select and enable the "PCI multi-domain system"
      option, i.e. "Y".
 
    - If your system is multi-domain, and you have
      selected the "PCI multi-domain system" option,
      then:
 
      - Ensure the "PCI remote IRQ A"
        value is set to "5".
  
      - Ensure the "PCI remote IRQ B"
        value is set to "9".
 
      - Ensure the "PCI remote IRQ C"
        value is set to "5".
 
      - Ensure the "PCI remote IRQ D"
        value is set to "10".

      - Ensure the "PCI remote domain bridge device/function"
        value is set to "00000068"

      - Ensure the "PCI local domain bridge device/function"
        value is set to "00000088"

    - De-select and disable the "PCI PIRQ registers update"
      option, i.e. "N".
 
    - De-select and disable the "PCI Bus 0 device
      configuration" option, i.e. "N".

    - De-select and disable the "PCI Command Reg. - Special
      Cycle Recognition" option, i.e. "N".

    - De-select and disable the "PCI Command Reg. - Memory
      Write/Invalidate" option, i.e. "N".
 
    - De-select and disable the "PCI Command Reg. - Parity
      Error Response" option, i.e. "N".

    - De-select and disable the "PCI Command Reg. - Wait Cycle"
      option, i.e. "N".

    - De-select and disable the "PCI Command Reg. - System
      Error" option, i.e. "N".
 
    - Ensure the "PCI Cache Line Size"
      value is set to "4".
 
    - Ensure the "PCI Latency Timer"
      value is set to "128".
 
    - Ensure the "PCI Secondary Latency Timer"
      value is set to "64".

    - De-select and disable the "PCI Bridge Ctl. - Parity
      Error Response" option, i.e. "N".

    - De-select and disable the "PCI Bridge Ctl. - System
      Error" option, i.e. "N".
 
    - De-select and disable the "PCI Bridge Ctl. - ISA Mode"
      option, i.e. "N".

    - De-select and disable the "PCI Bridge Ctl. - Master
      Abort Mode" option, i.e. "N".

  For CPV5350 based platforms, do:

    - Ensure the "PCI Bus Level 0 nodes"
      value is set to "1".
 
    - If your system is single-domain, then
      ensure the "PCI Bus Level 1 nodes"
      value is set to "1".  If your system is
      multi-domain, then ensure the "PCI Bus
      Level 1 nodes" value is set to "2".
 
    - If your system is single-domain, then
      ensure the "PCI Bus Level 3 nodes"
      value is set to "7". If your system is
      multi-domain, then ensure the "PCI Bus
      Level 3 nodes" value is set to "6".
 
    - Ensure the "PCI Bus Level 3 nodes"
      value is set to "1".
 
    - Ensure the "PCI I/O space starting address"
      value is set to "00002000".
 
    - Ensure the "PCI I/O space ending address"
      value is set to "0000ffff".
 
    - Ensure the "PCI 20-bit memory space starting address"
      value is set to "00000000".
 
    - Ensure the "PCI 20-bit memory space ending address"
      value is set to "000fffff".
 
    - Ensure the "PCI memory space starting address"
      value is set to "f4300000".
 
    - Ensure the "PCI memory space ending address"
      value is set to "f4ffffff".
 
    - Ensure the "PCI prefetch memory space starting address
      value is set to "f5000000".
 
    - Ensure the "PCI prefetch memory space ending address"
      value is set to "f7ffffff".
 
    - Select and enable the "PCI AGP bridge"
      option, i.e. "Y".
 
      - Ensure the "PCI AGP bridge I/O space size"
        value is set to "00000000".
 
      - Ensure the "PCI AGP bridge memory space size"
        value is set to "00100000".
 
      - Ensure the "PCI AGP prefetch memory space size"
        value is set to "01000000".
 
    - Ensure the "PCI local IRQ A"
      value is set to "5".
 
    - Ensure the "PCI local IRQ B"
      value is set to "9".
 
    - Ensure the "PCI local IRQ C"
      value is set to "5".
 
    - Ensure the "PCI local IRQ D"
      value is set to "10".

    - If your system is single-domain, then de-select
      and disable the "PCI multi-domain system" option,
      i.e. "N". If your system is multi-domain, then
      select and enable the "PCI multi-domain system"
      option, i.e. "Y".
 
    - If your system is multi-domain, and you have
      selected the "PCI multi-domain system" option,
      then:
  
    - Ensure the "PCI remote IRQ A"
      value is set to "5".
 
    - Ensure the "PCI remote IRQ B"
      value is set to "9".
 
    - Ensure the "PCI remote IRQ C"
      value is set to "5".
 
    - Ensure the "PCI remote IRQ D"
      value is set to "10".

    - Ensure the "PCI remote domain bridge device/function"
      value is set to "00000068"

    - Ensure the "PCI local domain bridge device/function"
      value is set to "00000088"
 
    - Select and enable the "PCI PIRQ registers update"
      option, i.e. "Y".

    - De-select and disable the "PCI Bus 0 device configuration"
      option, i.e. "N".

    - De-select and disable the "PCI Command Reg. - Special
      Cycle Recognition" option, i.e. "N".
 
    - Select and enable the "PCI Command Reg. - Memory
      Write/Invalidate" option, i.e. "Y".

    - De-select and disable the "PCI Command Reg. - Parity
      Error Response" option, i.e. "N".

    - De-select and disable the "PCI Command Reg. - Wait
      Cycle" option, i.e. "N".
 
    - Select and enable the "PCI Command Reg. - System
      Error" option, i.e. "Y".

    - Ensure the "PCI Cache Line Size"
      value is set to "4".
 
    - Ensure the "PCI Latency Timer"
      value is set to "64".
 
    - Ensure the "PCI Secondary Latency Timer"
      value is set to "64".

    - Select and enable the "PCI Bridge Ctl. - Parity Error
      Response" option, i.e. "Y".

    - Select and enable the "PCI Bridge Ctl. - System Error"
      option, i.e. "Y".
 
    - De-select and disable the "PCI Bridge Ctl. - ISA Mode"
      option, i.e. "N".

    - De-select and disable the "PCI Bridge Ctl. - Master
      Abort Mode" option, i.e. "N".

  For MCP750 based platforms, do:

    - Ensure the "PCI Bus Level 0 nodes"
      value is set to "1".
 
    - Ensure the "PCI Bus Level 1 nodes"
      value is set to "2".
 
    - Ensure the "PCI Bus Level 2 nodes"
      value is set to "6".
 
    - Ensure the "PCI Bus Level 3 nodes"
      value is set to "1".
 
    - Ensure the "PCI I/O space starting address"
      value is set to "00001000".
 
    - Ensure the "PCI I/O space ending address"
      value is set to "0000efff".
 
    - Ensure the "PCI 20-bit memory space starting address"
      value is set to "00000000".
 
    - Ensure the "PCI 20-bit memory space ending address"
      value is set to "000fffff".
 
    - Ensure the "PCI memory space starting address"
      value is set to "01000000".
 
    - Ensure the "PCI memory space ending address"
      value is set to "3affffff".
 
    - Ensure the "PCI prefetch memory space starting address
      value is set to "00000000".
 
    - Ensure the "PCI prefetch memory space ending address"
      value is set to "ffffffff".

    - De-select and disable the "PCI AGP bridge"
      option, i.e. "N".
 
    - Ensure the "PCI local IRQ A"
      value is set to "24".
 
    - Ensure the "PCI local IRQ B"
      value is set to "25".
 
    - Ensure the "PCI local IRQ C"
      value is set to "26".
 
    - Ensure the "PCI local IRQ D"
      value is set to "27".

    - Select and enable the "PCI multi-domain system"
      option, i.e. "Y".
 
      - Ensure the "PCI remote IRQ A"
        value is set to "28".
 
      - Ensure the "PCI remote IRQ B"
        value is set to "29".
 
      - Ensure the "PCI remote IRQ C"
        value is set to "30".
 
      - Ensure the "PCI remote IRQ D"
        value is set to "31".
 
      - Ensure the "PCI remote domain bridge device/function"
        value is set to "000000c0".
 
    - Ensure the "PCI local domain bridge device/function"
      value is set to "000000a0".

    - De-select and disable the "PCI PIRQ registers update"
      option, i.e. "N".
 
    - De-select and disable the "PCI Bus 0 device configuration"
      option, i.e. "N".

    - De-select and disable the "PCI Command Reg. - Special
      Cycle Recognition" option, i.e. "N".

    - De-select and disable the "PCI Command Reg. - Memory
      Write/Invalidate" option, i.e. "N".
 
    - De-select and disable the "PCI Command Reg. - Parity
      Error Response" option, i.e. "N".

    - De-select and disable the "PCI Command Reg. - Wait
      Cycle" option, i.e. "N".

    - De-select and disable the "PCI Command Reg. - System
      Error" option, i.e. "N".
 
    - Ensure the "PCI Cache Line Size"
      value is set to "8".
 
    - Ensure the "PCI Latency Timer"
      value is set to "128".
 
    - Ensure the "PCI Secondary Latency Timer"
      value is set to "128".

    - De-select and disable the "PCI Bridge Ctl. - Parity
      Error Response" option, i.e. "N".

    - De-select and disable the "PCI Bridge Ctl. - System
      Error" option, i.e. "N".
 
    - De-select and disable the "PCI Bridge Ctl. - ISA Mode"
      option, i.e. "N".

    - De-select and disable the "PCI Bridge Ctl. - Master
      Abort Mode" option, i.e. "N".


  2.4 Compilation

  Follow the normal Linux kernel compiling procedures and
  boot the newly built kernel.


  2.5 Notes about specific Linux distributions

  This package has only been tested on a Red Hat distribution.


  3.  Usage and features

  3.1 PKS Interface

  The PCI Kernel Services are accessed from user space through
  the Linux /proc interface, i.e. /proc/bus/pci/node. This interface
  is created during the PCI driver initialization.

  To initialize the interface from an application, just simply
  use an open(2) system call as follows:

    int pci_proc_node;

    pci_proc_node = open("/proc/bus/pci/node", O_RDWR, 0);

  The following structure, found in the PCI driver include file
  /usr/include/linux/pci.h, is used for subsequent ioctl(2) system
  calls to add or delete PCI nodes (i.e. PCI-2-PCI bridges or PCI
  devices) using the PCI Kernel Services:

    struct pci_node {
        unsigned int cmd;     /* PKS command  */
        unsigned int number;  /* bus number */
        unsigned int devfn;   /* encoded device & function numbers */
    };

  The "cmd" field must be set to one of the following, which are
  also defined in the PCI driver include file:

    PCI_NODE_NOP (0) - NOP PKS ioctl command (used for testing),
    PCI_NODE_ADD (1) - add node PKS ioctl command,
    PCI_NODE_DEL (2) - delete node PKS ioctl command.

  The "number" field must be set to the desired bus number of
  the PCI node to be added or deleted.

  The "devfn" field must be set to the desired device/function
  number of the PCI node to be added or deleted.


  3.1.1 Add Node

  PCI nodes/devices are added via an ioctl(2) system call to the
  PCI Kernel Services as follows:

    int pci_proc_node;

    struct pci_node node;

    pci_proc_node = open("/proc/bus/pci/node", O_RDWR, 0);

    node.cmd    = PCI_NODE_ADD;
    node.number = <desired node bus number>;
    node.devfn  = <desired node device/function number>;

    ioctl(pci_proc_node, 0, &node);


  3.1.1 Delete Node

  PCI nodes/devices are deleted via an ioctl(2) system call to the
  PCI Kernel Services as follows:

    int pci_proc_node;

    struct pci_node node;

    pci_proc_node = open("/proc/bus/pci/node", O_RDWR, 0);

    node.cmd    = PCI_NODE_DEL;
    node.number = <desired node bus number>;
    node.devfn  = <desired node device/function number>;

    ioctl(pci_proc_node, 0, &node);


  3.2 Errnos

  ioctl(2) system calls to the PCI Kernel Services will return
  specific errno values for error conditions related to the
  requested command.

  For the PCI_NODE_NOP command:

    EPERM      (1) - must be root to use the /proc/bus/pci/node
                     interface.

    ENOENT     (2) - a PCI device structure for the given
                     bus and device/function numbers wasn't
                     found in the PCI device structure list.

    EINVAL    (22) - couldn't access the pci_node structure in
                     user space or the cmd field was invalid.

  For the PCI_NODE_ADD command:

    EPERM      (1) - must be root to use the /proc/bus/pci/node
                     interface, or cannot add a bus 0 device, or
                     cannot add primary Host Bridge, or cannot
                     add AGP bridge.

    ENOENT     (2) - couldn't find parent PCI bus structure
                     for the given bus and device/function
                     numbers.

    EBADF      (9) - bad PCI configuration header format.

    ENOMEM    (12) - no available resource space, i.e. I/O
                     or memory space.

    EACCES    (13) - an AGP bridge is only allowed at bus
                     level 1.

    EEXIST    (17) - a PCI device structure for the given bus
                     and device/function numbers already exists.

    EBUSY     (16) - couldn't detach the /proc/bus/pci interface
                     as the proc count was not zero, i.e. it
                     was being used.

    ENODEV    (19) - invalid device ID for the given bus and
                     device/function numbers, or no child bus
                     numbers.

    EINVAL    (22) - couldn't access the pci_node structure in
                     user space or the cmd field was invalid.

    ENOSPC    (28) - couldn't find any free bus numbers to use.

    ENOSYS    (38) - unknown PCI configuration header format.

    EIDRM     (43) - an unknown resource type was detected. The
                     parent/child bus resource structure has not
                     been setup. The bus resource list is broken.

    ENOLINK   (67) - there is no PCI device structure associated
                     with the PCI bus structure, or there is no
                     PCI bus structure associated with the PCI
                     device structure. The PCI device list is
                     broken.

    ENOBUFS  (105) - couldn't allocate either a PCI bus or
                     device structure, i.e. no memory.

  For the PCI_NODE_DEL command:

    EPERM      (1) - must be root to use the /proc/bus/pci/node
                     interface, or cannot delete a bus 0 device, or
                     cannot delete primary Host Bridge, or cannot
                     delete AGP bridge.

    ENOENT     (2) - couldn't find PCI bus structure for the
                     given bus and device/function numbers, or
                     the resource structure is not on the list.

    EBUSY     (16) - couldn't detach the /proc/bus/pci interface
                     as the proc count was not zero, i.e. it
                     was being used.

    ENODEV    (19) - couldn't find PCI device structure for the
                     given bus and device/function numbers.

    EINVAL    (22) - couldn't access the pci_node structure in
                     user space or the cmd field was invalid.

    ENOTEMPTY (39) - child resources have not been freed. The
                     bus resource list is broken.

    EIDRM     (43) - an unknown resource type was detected. The
                     parent/child bus resource structure has not
                     been setup. The bus resource list is broken.

    ENOLINK   (67) - there is no PCI device structure associated
                     with the PCI bus structure, or there is no
                     PCI bus structure associated with the PCI
                     device structure. The PCI device list is
                     broken.


  3.3 PCI utilities

  The "lspci" utility (part of the pciutils package) can be used to 
  check the status of all PCI devices in the system. Here is an "lspci" 
  output for the PCI subsystem for a CPV8540 carrier card with two 
  DEC 21140 Ethernet devices:

      0e:0a.0 PCI bridge: Digital Equipment Corporation: 
                          Unknown device 0026 (rev 02)
      00: 11 10 26 00 07 02 90 02 02 00 04 06 08 80 01 00
      10: 00 00 00 00 00 00 00 00 0e 0f 10 80 81 81 80 22
      20: 00 1e c0 22 f1 ff 01 00 ff ff ff ff 00 00 00 00
      30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 80 00

      0f:08.0 Ethernet controller: Digital Equipment Corporation 
                                   DECchip 21140 [FasterNet] (rev 22)
      00: 11 10 09 00 07 00 80 02 22 00 00 02 08 80 00 00
      10: 01 80 00 00 00 00 00 1e 00 00 00 00 00 00 00 00
      20: 00 00 00 00 00 00 00 00 00 00 00 00 12 11 00 23
      30: 00 00 fc ff 00 00 00 00 00 00 00 00 1e 01 14 28

      0f:0d.0 Ethernet controller: Digital Equipment Corporation 
                                   DECchip 21140 [FasterNet] (rev 22)
      00: 11 10 09 00 07 00 80 02 22 00 00 02 08 80 00 00
      10: 81 80 00 00 80 00 00 1e 00 00 00 00 00 00 00 00
      20: 00 00 00 00 00 00 00 00 00 00 00 00 12 11 00 23
      30: 00 00 fc ff 00 00 00 00 00 00 00 00 1f 01 14 28
 
  This utility can also be used to get the signature of a card - 
  the vendor/deviceID pair of PCI Config registers. From the 
  listing, the signature of the DEC 21140 chip is 0x0009_1011 - 
  the first two words in little-endian format.


  4.  Debugging tips and problem reporting


  4.1 Submitting useful bug reports

  The best way to submit bug reports is to use the Comments section   
  in the MCG Linux web site. That way, other people can see current 
  problems (and fixes or workarounds, if available).

  Here are some things that should be included in all bug reports:

      Your platform type - e.g. CPX8216, CPX2208.

      Your processor module type - e.g. CPV5000, CPV5300, CPV5350, MCP750

      The CompactPCI cards you are using.

      Your Linux kernel version, and the PKS version.

      All PKS-related messages in your system log file.

  Bug reports can be sent to me at Robert_Robinson@phx.mcd.mot.com


  4.2 Interpreting kernel trap reports

  If your problem involves a kernel fault, the register dump from the
  fault is only useful if you can translate the fault address, EIP, to
  something meaningful. Recent versions of klogd attempt to translate
  fault addresses based on the current kernel symbol map, but this may
  not work if the fault is in a module, or if the problem is severe
  enough that klogd cannot finish writing the fault information to the
  system log.

  If a fault is in the main kernel, the fault address can be looked up
  in the System.map file. This may be installed in /System.map or
  /boot/System.map. If a fault is in a module, the nm command gives the
  same information, however, the fault address has to be adjusted based
  on the module's load address.
  kernel fault:

  For more background, see "man insmod", "man ksyms", and "man klogd".
  In the kernel source tree, Documentation/oops-tracing.txt is
  also relevant. Here are a few more kernel debugging hints:

     Depending on the fault, it may also be useful to translate
     addresses in the "Call Trace", using the same procedure as for
     the main fault address.

     To diagnose a silent lock-up, try to provoke the problem with X
     disabled, since kernel messages sent to the text console will not
     be visible under X.

     If you kill klogd, most kernel messages will be echoed directly on
     the text console, which may be helpful if the problem prevents
     klogd from writing to the system log.

     To cause all kernel messages to be sent to the console, 
     if /proc/sys/kernel/printk exists, do:

       echo 8 > /proc/sys/kernel/printk

     The key combination <RightAlt><ScrLk> prints a register dump on the
     text console. This may work even if the system is otherwise
     completely unresponsive, and the EIP address can be interpreted as
     for a kernel fault.

     If the kernel was configured with CONFIG_MAGIC_SYSRQ enabled, various
     emergency functions are available via special <Alt><SysRq> key
     combinations, documented in Documentation/sysrq.txt in the kernel
     source tree.


  4.3 Low level PKS debugging aids

  Your default configuration for syslogd may discard kernel debugging
  messages. To ensure that they are recorded, edit /etc/syslog.conf to
  ensure that "kern.debug" messages are recorded somewhere. See 
  "man syslog.conf" for details.

  The /proc/bus/pci tree should accurately reflect the state of the 
  PCI subsystem at any point in time. Use "ls" on this tree to make 
  sure that all inserted devices are listed, and that all extracted 
  devices have been removed.

  The "pciutils" package contains a set of tools that are extremely 
  useful for tracking down problems in the PCI subsystem. This package 
  is available at:  http://atrey.karlin.mff.cuni.cz/~mj/pciutils.html

--------------3E5D695EF8FB80931D6FD853--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
