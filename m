Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135277AbRD3Ool>; Mon, 30 Apr 2001 10:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135292AbRD3Ooc>; Mon, 30 Apr 2001 10:44:32 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:11169 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S135277AbRD3OoR>; Mon, 30 Apr 2001 10:44:17 -0400
Message-ID: <3AED7B34.A5BF717@veritas.com>
Date: Mon, 30 Apr 2001 15:48:20 +0100
From: "Amit S. Kale" <akale@veritas.com>
Organization: Veritas Software (India)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hanish Menon C <hanishkvc@fedtec.com>
CC: linux-kernel@vger.kernel.org, akale@users.sourceforge.net
Subject: Re: Patch to gdbstub++ taking care of possible stale data in 
 Recievebuffers and qOffsets cmd for x86.
In-Reply-To: <Pine.LNX.4.21.0104301426260.1474-200000@hanishkvc.fedtec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for analyzing a possible scenario where
gdb and kgdb could go out of sync.

The gdb remote debugging protocol isn't quite safe whenever
both gdb and stub try to talk to each other. There are
a few other scenarios which occur more frequently.

Some gdb developers are trying to make the gdb
remote protocol better. Hopefully they should come up
with a protocol that does not suffer from such problems.
You can look in gdb mailing list archives from 
http://sources.redhat.com/gdb/

I'll list another unsafe gdb packet on which there was
a discussion on gdb mailing list: The kgdb console output
uses "O" gdb packet which doesn't have an acknowledgement
associated with it. Since the number of console messages
can be large at times, this may cause gdb to go out of sync
when a user presses Ctrl + C. I have seen this occur,
though rarely.

Hanish Menon C wrote:
> 
> Hi
> 
> This patch takes care of 2 things related to remote debuging of Linux
> kernel using Gdb
> 
> Problem and Solution (1)
> ------------------------
> 
> When trying out Remote Debugging of Linux kernel using GDB, I found a
> possible protocol synchronisation issue between gdb (in host) and gdbstub
> (on RemoteTarget) in the current gdb remote protocol implementation (i.e
> which don't use the SequenceNumber mechanism of the protocol).
> 
> The situation unfolds as follows
> 1) HostGdb sends a command to the RemoteTargetStub.
> 2) Before the RemoteTargetStub can process the command a exception or
> breakpoint occurs. Or the RemoteTargetStub is getting activated only now
> during booting of the RemoteTarget m/c.
> 3) RemoteTargetStub sends Sxx to HostGDB. HostGDB takes this as response
> to command from 1 above (or ignores the command from 1 due to this)
> 4) HostGDB sends a new gdb command.
> 5) RemoteTargetStub picks up the old gdb command (from 1), and responds
> to it.
> 6) HostGDB assumes its the response to the new command from 4 above, but
> actually its response to the old (now stale or no longer valid) command
> from 1 above.
> 
> Thus the RemoteTargetGdbStub and the HostGDB go out of sync.
> 
> I faced this problem when trying out remote debuging between a Linux Host
> and a PC Emulation software (vmware or so) using /dev/ptyq0 and /dev/ttyq0
> for communication. On looking into this I found this possible
> synchronisation problem between the Host and Remote in GDB protocol, if
> there is any content or old command in the Recieve buffers (s/w buffer in
> gdbserial.c and or h/w buffer of uart) due to what ever reason.
> 
> To solve this problem I have implemented a clearRecieveDataBufferGDB in
> gdbserail which when invoked will clear all buffered contents associated
> with recieving ((a) the s/w buffer in gdbserial and (b) the buffer in
> uart). It uses the existing read_char implementation of gdbserial in a
> loop to accomplish this.
> 
> INTURN I call this from with in handle_exception of gdbstub just before
> sending SXX signal(to notify of the exception) to HostGDB, So that
> handle_exception won't respond to any old (and no longer valid)command or
> invalid data in the Recieve buffer.
> 
> Problem and Solution (2)
> ------------------------
> 
> Also I noticed that HostGDB was sending a qOffsets query to the
> RemoteTargetStub, but x86 gdbstub doesn't currently provide a
> implementation for qOffset. So I implemented one which uses the following
> symbols to provide the required offsets
> 
>   stext for Text
>   gdt_table for Data (currently corresponds to .data or sdata)
>   __bss_start for Bss.
> 
> However once Implemented I did find that HostGDBs symbol info was getting
> corrupted and I was forced to reload the symbols using symbol_file. On
> looking into gdb source casualy it felt as if I can ignore qOffsets
> command. Either way I already had a implementation (which is very
> simple) for qOffsets command, so I have retained it in the patch __as the
> bug__ seems to be __in the HostGDB code__. On looking into other gdbstub
> implementations in the linux kernel Even the PPC arch's gdbstub talks
> about this bug in HostGDB.
> 
> Also I picked up the elegent sprintf solution to create the response
> string for qOffset from the PPC guys. Earlier I had tried a solution with
> mem2hex which retains the Bytes of the address in the Target Byte order,
> but for qOffset one requires to represent the address (in Hex) in the
> normal reading order (varified by looking into remote.c in gdb
> source) which automaticaly suites the sprintf solution.
> 
> These problem seems to be universal as far as gdb remote debug protocols
> current implementations are concerned, so may be even the GDB guys need to
> be informed about these possible problems. But I am not in the GDB devel
> list, so someone on the list can inform them also.
> 
> -----------
> Keep :-)
> HanishKVC
> 
>   ------------------------------------------------------------------------
>                                                  Name: linux-2.4.3-kgdb-hankvc-30Apr2001-p1.patch
>    linux-2.4.3-kgdb-hankvc-30Apr2001-p1.patch    Type: Plain Text (TEXT/PLAIN)
>                                              Encoding: BASE64

-- 
Amit Kale
Veritas Software ( http://www.veritas.com )
