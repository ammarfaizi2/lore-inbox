Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292180AbSBBB2r>; Fri, 1 Feb 2002 20:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292181AbSBBB2k>; Fri, 1 Feb 2002 20:28:40 -0500
Received: from fmr01.intel.com ([192.55.52.18]:48637 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S292180AbSBBB2X>;
	Fri, 1 Feb 2002 20:28:23 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7C0A@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Acpi-linux (E-mail)" <acpi-devel@lists.sourceforge.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: New ACPI source release (20010201)
Date: Fri, 1 Feb 2002 17:28:20 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm pleased to announce that the big changes that we have been working on
are now stable enough to distribute to other developers. Since our web
liaison person doesn't work on the weekend, the developer.intel.com site
will not be updated until the Monday evening push. However, there will be
early access to the Linux patch via the acpi project on SourceForge.net.

There was more than enough changes to justify this release (see below) but
there are also a number of issues remaining, which should be mentioned:

- Integration with the 2.5 driver model is not complete
- FX140 issue is not resolved
- Fix for PIIX4 BMISX issue is needed
- Full processing of the MADT (i.e. for Interrupt source override entries)
has not been implemented
- Thermal policy still needs validation
- Linux-specific code has not been fully converted to the new
"core-allocates" memory model

We are planning on backporting to 2.4 very soon and unifying IA32 and IA64
ACPI driver code, but the patch is against 2.5.3 for now.

Have a great weekend,

-- Andy

----------------------------------------
Summary of changes for this label: 02_01_02

1) Linux

All drivers consolidated to single files in main acpi directory

Supports ACPI PCI IRQ routing (PCI Link and PCI root drivers) in PIC and
IOAPIC modes. (This may not work on machines with interrupt source override
entries in their MADT)

MADT parsing code is more tightly integrated with other ACPI code

Implemented fix for PIIX reverse throttling errata (Processor driver)

Added new Limit interface (Processor and Thermal drivers)

New thermal policy (Thermal driver)

Many updates to /proc

Battery "low" event support (Battery driver)

IA32 - IA64 initialization unification, no longer experimental

Menuconfig options redesigned

2) ACPI CA Core Subsystem:

ACPI 2.0 support is complete in the entire Core Subsystem and the ASL
compiler.
All new ACPI 2.0 operators are implemented and all other changes for ACPI
2.0
support are complete.  With simultaneous code and data optimizations
throughout
the subsystem, ACPI 2.0 support has been implemented with almost no
additional
cost in terms of code and data size.

Implemented a new mechanism for allocation of return buffers.  If the buffer
length is set to ACPI_ALLOCATE_BUFFER, the buffer will be allocated on
behalf
of the caller.  Consolidated all return buffer validation and allocation to
a
common procedure.  Return buffers will be allocated via the primary OSL
allocation interface since it appears that a separate pool is not needed by
most users.  If a separate pool is required for these buffers, the caller
can still use the original mechanism and pre-allocate the buffer(s).

Implemented support for string operands within the DerefOf operator.

Restructured the Hardware and Event managers to be table driven, simplifying
the source code and reducing the amount of generated code.

Split the common read/write low-level ACPI register bitfield procedure into
a separate read and write, simplifying the code considerably.  

Obsoleted the AcpiOsCallocate OSL interface.  This interface was used only a
handful of times and didn't have enough critical mass for a separate
interface.  Replaced with a common calloc procedure in the core.

Fixed a reported problem with the GPE number mapping mechanism that allows
GPE1 numbers to be non-contiguous with GPE0.  Reorganized the GPE
information
and shrunk a large array that was originally large enough to hold info for
all possible GPEs (256) to simply large enough to hold all GPEs up to the
largest GPE number on the machine.

Fixed a reported problem with resource structure alignment on 64-bit
platforms.

Changed the AcpiEnableEvent and AcpiDisableEvent external interfaces to not
require any flags for the common case of enabling/disabling a GPE.

Implemented support to allow a "Notify" on a Processor object.

Most TBDs in comments within the source code have been resolved and
eliminated.

Fixed a problem in the interpreter where a standalone parent prefix (^) was
not handled correctly in the interpreter and debugger.

Removed obsolete and unnecessary GPE save/restore code.

Implemented Field support in the ASL Load operator.  This allows a table to
be loaded from a named field, in addition to loading a table directly from
an Operation Region.

Implemented timeout and handle support in the external Global Lock
interfaces.

Fixed a problem in the AcpiDump utility where pathnames were no longer being
generated correctly during the dump of named objects.

Modified the AML debugger to give a full display of if/while predicates
instead of just one AML opcode at a time.  (The predicate can have several
nested ASL statements.)  The old method was confusing during single
stepping.

Code and Data Size: Current core subsystem library sizes are shown below.
These are the code and data sizes for the acpica.lib produced by the
Microsoft Visual C++ 6.0 compiler, and these values do not include any ACPI
driver or OSPM code.  The debug version of the code includes the debug
output trace mechanism and has a larger code and data size.  Note that
these values will vary depending on the efficiency of the compiler and
the compiler options used during generation.

  Previous Release (12_18_01)
    Non-Debug Version:  66.1K Code,   5.5K Data,   71.6K Total
    Debug Version:     138.3K Code,  55.9K Data,  194.2K Total
  Current Release:
    Non-Debug Version:  65.2K Code,   6.2K Data,   71.4K Total
    Debug Version:     136.9K Code,  56.4K Data,  193.3K Total

3) ASL Compiler, version X2037:

Implemented several new output features to simplify integration of AML code
into
 firmware:
1) Output the AML in C source code with labels for each named ASL object.
The
   original ASL source code is interleaved as C comments.
2) Output the AML in ASM source code with labels and interleaved ASL
   source.
3) Output the AML in raw hex table form, in either C or ASM.

Implemented support for optional string parameters to the LoadTable
operator.

Completed support for embedded escape sequences within string literals.  The
compiler now supports all single character escapes as well as the Octal and
Hex escapes.  Note: the insertion of a null byte into a string literal (via
the hex/octal escape) causes the string to be immediately terminated.  A
warning is issued.

Fixed a problem where incorrect AML was generated for the case where an ASL
namepath consists of a single parent prefix (^) with no trailing name
segments.

The compiler has been successfully generated with a 64-bit C compiler.


----------------------------
Andrew Grover
Intel/MPG/Mobile Arch Lab
andrew.grover@intel.com

