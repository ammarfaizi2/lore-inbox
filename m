Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSKFJPO>; Wed, 6 Nov 2002 04:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSKFJPO>; Wed, 6 Nov 2002 04:15:14 -0500
Received: from redrock.inria.fr ([138.96.248.51]:9694 "HELO redrock.inria.fr")
	by vger.kernel.org with SMTP id <S261375AbSKFJPL>;
	Wed, 6 Nov 2002 04:15:11 -0500
SCF: #mh/Mailbox/outboxDate: Wed, 6 Nov 2002 09:53:28 +0100
From: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre10-ac2, Sony PCG-C1MHP and Sonypi
Message-Id: <20021106095328.1052afb0.Manuel.Serrano@sophia.inria.fr>
References: <20021105104620.7c1282fa.Manuel.Serrano@sophia.inria.fr>
	<20021105151540.GB12610@tahoe.alcove-fr>
	<20021105155836.GE12610@tahoe.alcove-fr>
Organization: Inria
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: 06 Nov 2002 10:15:51 +0100
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Nov 05, 2002 at 04:15:40PM +0100, Stelian Pop wrote:
> 
> > > Incompatibility between USB and SONYPI.
> > > 
> > > [2.] Full description of the problem/report:
> > > ============================================
> > > 
> > > Sonypi and USB modules seems to be incompatible. That is, if I don't load
> > > any USB kernel modules, using Sonypi works perfectly (I mostly use it
> > > to access the LCD brightness). 
> > 
> > Does this mean that you can use it to get jogdial or Fn keys events too ?
> > 
> > > If I load USB modules, then Sonypi reports
> > > errors:
> > 
> > Please send me (off list)  a copy of your dissassambled ACPI bios(*)
> > and I'll take a look at it.
> 
> After seing your ACPI bios I cannot find out the reason why it 
> interferes with the USB subsystem.
> 
> The failed commands happen when sonypi tries to access the 0x62
> and 0x66 ports, which are (wrongly) reserved by the keyboard 
> (this is why sonypi cannot reserve them). These registers are
> also used by ACPI 'Embedded Controller'.
> 
> But I still cannot understand what the USB does in this area.
> 
> You didn't say if you compiled in the ACPI susbystem. Does it
> change something if you do not compile it (in case you did
> previously) or if you do compile it (in case you didn't) ?
> 
> Stelian.
> -- 
> Stelian Pop <stelian.pop@fr.alcove.com>
> Alcove - http://www.alcove.com
Well,

first of all this things is driving me nuts ;-) I have compiled and
tested at least 10 variations around the kernel and ACPI and I have
noticed about 10 different behaviors. Basically at the one end I have tried
to compile all the ACPI support inside the kernel. At the other end, 
I have tried to compile the whole ACPI support as modules. In the middle
I have tried several variation on compiling some part in the kernel, some
others parts in modules.

My intuition (which may be totally erroneous) is that there is something
broken in the ospm_ec support. I explain this:

1. When I have compiled the whole ACPI in the kernel everything was fine.
The problem of spurious characters (probably caused by erroneous keyboard
events) disappear. However, the problem is that for a reason I'm not able
to understand, in this configuration, the ACPI driver does not see the
thermal and the battery information! On the other hand, the ac_adapter 
information is correct. (Note that it is not possible to compile the
support for battery and thermal information unless the ospm_ec part is
compiled in the kernel too.)

2. When I compile some parts as modules I have the following problem:
Until I load ospm_ec, I see information about the line status, the
battery, and the processor temperature. As soon as I load this last
module, I'm unable to access these two last information. For instance,
when I attempt to read the battery, I see:

-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
> cat /proc/acpi/battery/0/status
Present:                 yes
Error reading battery status (_BST)
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

The situation can be even worth depending on the order I load the modules.
I have even add a configuration where the command:

-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
cat /proc/scsi/scsi 
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

Was crashing with a bus error! The kernel was logging messages such as:

-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----
Nov  6 00:19:25 owens kernel: Unable to handle kernel paging request at virtual address 000a0a0c
Nov  6 00:19:25 owens kernel:  printing eip:
Nov  6 00:19:25 owens kernel: c01f5e3a
Nov  6 00:19:25 owens kernel: *pde = 00000000
Nov  6 00:19:25 owens kernel: Oops: 0000
Nov  6 00:19:25 owens kernel: CPU:    0
Nov  6 00:19:25 owens kernel: EIP:    0010:[<c01f5e3a>]    Not tainted
Nov  6 00:19:25 owens kernel: EFLAGS: 00010297
Nov  6 00:19:25 owens kernel: eax: 000a0a0c   ebx: c89c7079   ecx: 000a0a0c   edx: fffffffe
Nov  6 00:19:25 owens kernel: esi: c89cbf28   edi: ffffffff   ebp: 000a0a0c   esp: c89cbed0
Nov  6 00:19:25 owens kernel: ds: 0018   es: 0018   ss: 0018
Nov  6 00:19:25 owens kernel: Process less (pid: 854, stackpage=c89cb000)
Nov  6 00:19:25 owens kernel: Stack: c89c7013 0000005c 00000004 cd2fdcf2 cd2fdcf2 ffffffff ffffffff 00000000 
Nov  6 00:19:25 owens kernel:        ffffffff c01f603d c89c706f 37638f91 cf880a2d c89cbf24 c01f6055 c89c706f 
Nov  6 00:19:25 owens kernel:        cf880a22 c89cbf24 cf873772 c89c706f cf880a22 000a0a0c cd2fdc00 00000013 
Nov  6 00:19:25 owens kernel: Call Trace:    [<c01f603d>] [<cf880a2d>] [<c01f6055>] [<cf880a22>] [<cf873772>]
Nov  6 00:19:25 owens kernel:   [<cf880a22>] [<cf8704ae>] [<c0149aae>] [<c01309a2>] [<c0106a4f>]
Nov  6 00:19:25 owens kernel: 
Nov  6 00:19:25 owens kernel: Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 89 44 24 10 8b 44 
-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----

(I'm sorry because I imagine that this bare information is not very
useful but I'm currently unable to reproduce the crash).

Sorry for being so confused with all this.

-- 
Manuel
