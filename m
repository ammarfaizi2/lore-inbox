Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUA0I7p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 03:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUA0I7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 03:59:45 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:49030 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262827AbUA0I7f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 03:59:35 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: PPC KGDB changes and some help?
Date: Tue, 27 Jan 2004 14:29:13 +0530
User-Agent: KMail/1.5
Cc: Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       George Anzinger <george@mvista.com>
References: <20040120172708.GN13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org> <20040126213255.GC32525@stop.crashing.org>
In-Reply-To: <20040126213255.GC32525@stop.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401271429.14201.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 Jan 2004 3:02 am, Tom Rini wrote:
> On Wed, Jan 21, 2004 at 12:21:28PM -0700, Tom Rini wrote:
> > On Wed, Jan 21, 2004 at 11:42:17AM -0700, Tom Rini wrote:
> > > On Wed, Jan 21, 2004 at 10:23:12PM +0530, Amit S. Kale wrote:
> > > > Hi,
> > > >
> > > > Here it is: ppc kgdb from timesys kernel is available at
> > > > http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.1.0.tar.bz2
> > > >
> > > > This is my attempt at extracting kgdb from TimeSys kernel. It works
> > > > well in TimeSys kernel, so blame me if above patch doesn't work.
> > >
> > > Okay, here's my first patch against this.
> >
> > And dependant upon this is a patch to fixup the rest of the common PPC
> > code, as follows:
>
> Relative to this, due to the PPC changes is the following:
>
> - In kgdb_handle_exception, memset remcomOutBuffer twice, instead of
>   continiously throwing in NULLs around.

Good.

> - Remove a KERN_CRIT from the printk while waiting for kgdb to connect
>   (it's not needed there).

It's needed for kgdb over ethernet. At present the ethernet comes up really 
late. At that point syslogd has taken over printing of kernel messages, 
KERN_CRIT ensures that a user sees that message regardless of the syslogd 
configuratio.

> - Switch the initial packet from an 'S' packet (followed by a p for the
>   thread ID) to a 'T' packet.

That's also good.

>
> This is tested on PPC and i386 (lightly).
>
>  include/asm-i386/kgdb.h   |    4 ++
>  include/asm-ppc/kgdb.h    |    3 +
>  include/asm-x86_64/kgdb.h |    4 ++
>  kernel/kgdbstub.c         |   70
> ++++++++++++++++++++++------------------------ 4 files changed, 45
> insertions(+), 36 deletions(-)
>
> --- 1.1/include/asm-i386/kgdb.h	Wed Jan 21 10:13:15 2004
> +++ edited/include/asm-i386/kgdb.h	Mon Jan 26 12:15:22 2004
> @@ -43,6 +43,10 @@
>  	_GS    /* 15 */
>  };
>
> +#define PC_REGNUM	_PC	/* Program Counter */
> +#define SP_REGNUM	_ESP	/* Stack Pointer */
> +#define PTRACE_PC	eip	/* Program Counter, in ptrace regs. */
> +
>  #define BREAKPOINT() asm("   int $3");
>  #define BREAK_INSTR_SIZE       1
>
> --- 1.5/include/asm-ppc/kgdb.h	Wed Jan 21 12:21:23 2004
> +++ edited/include/asm-ppc/kgdb.h	Mon Jan 26 12:16:39 2004
> @@ -19,6 +19,9 @@
>  #define NUMREGBYTES		(MAXREG * sizeof(int))
>  #define BUFMAX			((NUMREGBYTES * 2) + 512)
>  #define OUTBUFMAX		((NUMREGBYTES * 2) + 512)
> +#define PC_REGNUM		64
> +#define SP_REGNUM		1
> +#define PTRACE_PC		nip	/* Program Counter, in ptrace regs. */
>  #define BREAKPOINT()		asm(".long 0x7d821008") /* twge r2, r2 */
>
>  /* Things specific to the gen550 backend. */
> --- 1.1/include/asm-x86_64/kgdb.h	Wed Jan 21 10:13:16 2004
> +++ edited/include/asm-x86_64/kgdb.h	Mon Jan 26 12:16:15 2004
> @@ -44,6 +44,10 @@
>  	       _PS,
>  	       _LASTREG=_PS };
>
> +#define PC_REGNUM	_PC	/* Program Counter */
> +#define SP_REGNUM	_RSP	/* Stack Pointer */
> +#define PTRACE_PC	rip	/* Program Counter, in ptrace regs. */
> +
>  /* Number of bytes of registers.  */
>  #define NUMREGBYTES (_LASTREG*8)
>
> --- 1.2/kernel/kgdbstub.c	Wed Jan 21 12:21:23 2004
> +++ edited/kernel/kgdbstub.c	Mon Jan 26 12:17:02 2004
> @@ -615,6 +615,9 @@
>  	 * need one here */
>  	procindebug[smp_processor_id()] = 1;
>
> +	/* Clear the out buffer. */
> +	memset(remcomOutBuffer, 0, sizeof(remcomOutBuffer));
> +
>  	/* Master processor is completely in the debugger */
>  	if (kgdb_ops->post_master_code)
>  		kgdb_ops->post_master_code(linux_regs, exVector, err_code);
> @@ -624,9 +627,7 @@
>  		if(remcomInBuffer[0] == 'H' && remcomInBuffer[1] =='c') {
>  			remove_all_break();
>  			atomic_set(&kgdb_killed_or_detached, 0);
> -			remcomOutBuffer[0] = 'O';
> -			remcomOutBuffer[1] = 'K';
> -			remcomOutBuffer[2] = 0;
> +			strcpy(remcomOutBuffer, "OK");
>  		}
>  		else
>  			return 1;
> @@ -634,13 +635,25 @@
>  	else {
>
>  		/* reply to host that an exception has occurred */
> -		remcomOutBuffer[0] = 'S';
> -		remcomOutBuffer[1] = hexchars[signo >> 4];
> -		remcomOutBuffer[2] = hexchars[signo % 16];
> -		remcomOutBuffer[3] = 'p';
> -
> +		ptr = remcomOutBuffer;
> +		*ptr++ = 'T';
> +		*ptr++ = hexchars[(signo >> 4) % 16];
> +		*ptr++ = hexchars[signo % 16];
> +		*ptr++ = hexchars[(PC_REGNUM >> 4) % 16];
> +		*ptr++ = hexchars[PC_REGNUM % 16];
> +		*ptr++ = ':';
> +		ptr = kgdb_mem2hex((char *)&linux_regs->PTRACE_PC, ptr, 4, 0);
> +		*ptr++ = ';';
> +		*ptr++ = hexchars[SP_REGNUM >> 4];
> +		*ptr++ = hexchars[SP_REGNUM & 0xf];
> +		*ptr++ = ':';
> +		ptr = kgdb_mem2hex(((char *)linux_regs) + SP_REGNUM * 4, ptr,
> +				4, 0);
> +		*ptr++ = ';';
> +		ptr += strlen(strcpy(ptr, "thread:"));
>  		int_to_threadref(&thref, shadow_pid(current->pid));
> -		*pack_threadid(remcomOutBuffer + 4, &thref) = 0;
> +		ptr = pack_threadid(ptr, &thref);
> +		*ptr++ = ';';
>  	}
>  	putpacket(remcomOutBuffer, 0);
>  	kgdb_connected = 1;
> @@ -651,8 +664,10 @@
>  	while (1) {
>  		int bpt_type = 0;
>  		error = 0;
> -		remcomOutBuffer[0] = 0;
> -		remcomOutBuffer[1] = 0;
> +
> +		/* Clear the out buffer. */
> +		memset(remcomOutBuffer, 0, sizeof(remcomOutBuffer));
> +
>  		getpacket(remcomInBuffer);
>
>  #if KGDB_DEBUG
> @@ -666,7 +681,6 @@
>  			remcomOutBuffer[0] = 'S';
>  			remcomOutBuffer[1] = hexchars[signo >> 4];
>  			remcomOutBuffer[2] = hexchars[signo % 16];
> -			remcomOutBuffer[3] = 0;
>  			break;
>
>  		case 'g':	/* return the value of the CPU registers */
> @@ -764,9 +778,7 @@
>  			 * continue.
>  			 */
>  		case 'D':
> -			remcomOutBuffer[0] = 'O';
> -			remcomOutBuffer[1] = 'K';
> -			remcomOutBuffer[2] = '\0';
> +			strcpy(remcomOutBuffer, "OK");
>  			remove_all_break();
>  			putpacket(remcomOutBuffer, 0);
>  			kgdb_connected = 0;
> @@ -804,19 +816,16 @@
>  						i++;
>  					}
>  				}
> -				*(--ptr) = '\0';
>  				break;
>
>  			case 'C':
>  				/* Current thread id */
> -				remcomOutBuffer[0] = 'Q';
> -				remcomOutBuffer[1] = 'C';
> +				strcpy(remcomOutBuffer, "QC");
>
>  				threadid = shadow_pid(current->pid);
>
>  				int_to_threadref(&thref, threadid);
>  				pack_threadid(remcomOutBuffer + 2, &thref);
> -				remcomOutBuffer[18] = '\0';
>  				break;
>
>  			case 'E':
> @@ -829,7 +838,6 @@
>  			case 'T':
>  				if (memcmp(remcomInBuffer+1, "ThreadExtraInfo,",16))
>  				{
> -					remcomOutBuffer[0] = 0;
>  					strcpy(remcomOutBuffer, "E05");
>  					break;
>  				}
> @@ -872,14 +880,11 @@
>  				thread = getthread(linux_regs, threadid);
>  				if (!thread && threadid > 0) {
>  					remcomOutBuffer[0] = 'E';
> -					remcomOutBuffer[1] = '\0';
>  					break;
>  				}
>  				kgdb_usethread = thread;
>  				kgdb_usethreadid = threadid;
> -				remcomOutBuffer[0] = 'O';
> -				remcomOutBuffer[1] = 'K';
> -				remcomOutBuffer[2] = '\0';
> +				strcpy(remcomOutBuffer, "OK");
>  				break;
>
>  			case 'c':
> @@ -892,14 +897,11 @@
>  					thread = getthread(linux_regs, threadid);
>  					if (!thread && threadid > 0) {
>  						remcomOutBuffer[0] = 'E';
> -						remcomOutBuffer[1] = '\0';
>  						break;
>  					}
>  					kgdb_contthread = thread;
>  				}
> -				remcomOutBuffer[0] = 'O';
> -				remcomOutBuffer[1] = 'K';
> -				remcomOutBuffer[2] = '\0';
> +				strcpy(remcomOutBuffer, "OK");
>  				break;
>  			}
>  			break;
> @@ -909,14 +911,10 @@
>  			ptr = &remcomInBuffer[1];
>  			kgdb_hexToLong(&ptr, &threadid);
>  			thread = getthread(linux_regs, threadid);
> -			if (thread) {
> -				remcomOutBuffer[0] = 'O';
> -				remcomOutBuffer[1] = 'K';
> -				remcomOutBuffer[2] = '\0';
> -			} else {
> +			if (thread)
> +				strcpy(remcomOutBuffer, "OK");
> +			else
>  				remcomOutBuffer[0] = 'E';
> -				remcomOutBuffer[1] = '\0';
> -			}
>  			break;
>  		case 'z':
>  		case 'Z':
> @@ -1127,7 +1125,7 @@
>  	 */
>  	printk(KERN_CRIT "Waiting for connection from remote gdb... ");
>  	breakpoint() ;
> -	printk(KERN_CRIT "Connected.\n");
> +	printk("Connected.\n");
>  }
>
>  #ifdef CONFIG_KGDB_CONSOLE
>
> --
> Tom Rini
> http://gate.crashing.org/~trini/
>
> ** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

