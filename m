Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262941AbSJGI6F>; Mon, 7 Oct 2002 04:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262938AbSJGI6F>; Mon, 7 Oct 2002 04:58:05 -0400
Received: from rj.sgi.com ([192.82.208.96]:63942 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S262956AbSJGI6D>;
	Mon, 7 Oct 2002 04:58:03 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Andreas Schuldei <andreas@schuldei.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kdb against memory corruption? 
In-reply-to: Your message of "Sun, 06 Oct 2002 22:08:01 +0200."
             <20021006200801.GD1316@lukas> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Oct 2002 19:03:26 +1000
Message-ID: <10888.1033981406@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Oct 2002 22:08:01 +0200, 
Andreas Schuldei <andreas@schuldei.org> wrote:
>I think i found a case of memory corruption in the backport of
>the linuxconsole-ruby patch to 2.4.19.
>
>Some parts (not sure which yet) of the tty_struct get
>overwritten. I do not yet know when that happens or how, but i
>intend to find out with kdb and its bph brakepoint feature.
>
>Unfortunatly my initial attempts to find the instance where the
>memory segment gets corrupted failed. I specified a certain
>address, a length of 4 byte and DATAW as arguments to the bph
>command.
>
>but reading the kdb manpage i get the impression that
>startaddress and length have to match precisly:
>
>DATAW   Enters  the  kernel  debugger  when  data of length
>        length is written to the specified address.
>
>how can i use this to find the cause of the corruption? Anyone
>done this before? i would want to be alerted whenever anything
>withing a certain memory range gets overwritten.

bph dataw uses the debug registers to set a write breakpoint.
>From ia32 volume 3 section 15.2.5:

----------------------------------------------------------------------

The breakpoint address registers (debug registers DR0 through DR3) and
the LENn fields for each breakpoint define a range of sequential byte
addresses for a data or I/O breakpoint. The LENn fields permit
specification of a 1-, 2-, or 4-byte range beginning at the linear
address spec- ified in the corresponding debug register (DRn).
Two-byte ranges must be aligned on word boundaries and 4-byte ranges
must be aligned on doubleword boundaries. I/O breakpoint addresses are
zero extended from 16 to 32 bits for purposes of comparison with the
breakpoint address in the selected debug register. These requirements
are enforced by the processor; it uses the LENn field bits to mask the
lower address bits in the debug registers. Unaligned data or I/O
breakpoint addresses do not yield the expected results.

A data breakpoint for reading or writing data is triggered if any of
the bytes participating in an access is within the range defined by a
breakpoint address register and its LENn field. Table 15-1 gives an
example setup of the debug registers and the data accesses that would
subsequently trap or not trap on the breakpoints.

Table 15-1.  Breakpointing Examples

           Debug Register Setup
Debug Register    R/Wn               Breakpoint Address    LENn
      DR0     R/W0 = 11 (Read/Write)    A0001H          LEN0 = 00 (1 byte)
      DR1     R/W1 = 01 (Write)         A0002H          LEN1 = 00 (1 byte)
      DR2     R/W2 = 11 (Read/Write)    B0002H          LEN2 = 01 (2 bytes)
      DR3     R/W3 = 01 (Write)         C0000H          LEN3 = 11 (4 bytes)

           Data Accesses
                            Access Length 
     Operation    Address   (In Bytes)
Data operations that trap
- Read or write    A0001H    1
- Read or write    A0001H    2
- Write            A0002H    1
- Write            A0002H    2
- Read or write    B0001H    4
- Read or write    B0002H    1
- Read or write    B0002H    2
- Write            C0000H    4
- Write            C0001H    2
- Write            C0003H    1
Data operations that do not trap
- Read or write    A0000H    1
- Read             A0002H    1
- Read or write    A0003H    4
- Read or write    B0000H    2
- Read             C0000H    2
- Read or write    C0004H    4

A data breakpoint for an unaligned operand can be constructed using two
breakpoints, where each breakpoint is byte-aligned, and the two
breakpoints together cover the operand. These breakpoints generate
exceptions only for the operand, not for any neighboring bytes.
Instruction breakpoint addresses must have a length specification of 1
byte (the LENn field is set to 00). The behavior of code breakpoints
for other operand sizes is undefined. The processor recognizes an
instruction breakpoint address only when it points to the first byte of
an instruction. If the instruction has any prefixes, the breakpoint
address must point to the first prefix.

----------------------------------------------------------------------

I just ran some tests to make sure and kdb bph works as described
above.  Things to watch out for :-

  bph is current cpu only, use bpha for all cpus.  Is your box SMP?

  Address must be a multiple of the length.

It is easier to pick a single byte that you know is being changed and
just watch that byte, with bpha <address> dataw 1.

