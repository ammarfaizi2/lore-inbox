Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261970AbTCQW4W>; Mon, 17 Mar 2003 17:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbTCQW4W>; Mon, 17 Mar 2003 17:56:22 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:38921
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S261970AbTCQW4T>; Mon, 17 Mar 2003 17:56:19 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DE8@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.20 modem control
Date: Mon, 17 Mar 2003 15:07:10 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 1:33 PM, Richard B. Johnson wrote:
> 
> On Mon, 17 Mar 2003, Ed Vance wrote:
> 
> > On Mon, Mar 17, 2003 at 8:19 AM, Richard B. Johnson wrote:
> > > Hello any tty gurus,
> > >
> > > If a modem is connected to /dev/ttyS0 and a getty 
> (actually agetty)
> > > is associated with that device, one can log-in using that modem.
> > >
> > > This is how we've operated for many years. But, Linux 
> version 2.4.20
> > > presents a new problem.
> > >
> > > When a logged-in caller logs out, it is mandatory for the modem
> > > to disconnect. This has previously been done automatically when
> > > the terminal is closed. The closing of the tasks file-descriptors
> > > will eventually call tty_hangup() and the modem would (previously)
> > > hang up.
> > >
> > > Something has changed so that the hang-up sequence 
> doesn't happen if
> > > agetty has already opened the terminal for another possible
> > > connection.
> > > It used to be that the caller, calling close(), did not 
> get control
> > > back until the modem had been hung up. This prevented 
> another agetty
> > > from opening that terminal for I/O because the previous 
> task had not
> > > completed its exit procedure until the terminal was hung up.
> > >
> > > Now, the hang-up sequence appears to be queued. It can (and does)
> > > happen after the previous terminal owner has expired and another
> > > owner has opened the device. This makes /dev/ttyS0 
> useless for remote
> > > log-ins.
> > >
> > > It needs to be, that a 'close()' of a terminal, 
> configured as a modem,
> > > cannot return to the caller until after the DTR has been 
> lowered, and
> > > preferably, after waiting a few hundred milliseconds. 
> Without this,
> > > once logged in, the modem will never disconnect so a new caller
> > > can't log in.
> > >
> > > With faster machines, it is not sufficient to just lower DTR. One
> > > needs to lower DTR and then wait. This is because the next task
> > > can open that terminal in a few hundred microseconds, raising
> > > DTR again. This is not enough time for the modem to hang 
> up because
> > > there is "glitch-filtering" on all modem-control leads. 
> The hang-up
> > > event won't even be seen by the modem.
> > >
> > > So, either the modem control needs to be reverted to its previous
> > > functionality or `agetty` needs to hang up its terminal when it
> > > starts, which seems backwards. In other words, the user of kernel
> > > services should not have to compensate for a defect in the logic
> > > of that service.
> > >
> > > I have temporarily "fixed" this problem by modifying `agetty`.
> > > Can the kernel please be fixed instead?
> > >
> > Hi Richard,
> >
> > Is the HUPCL cflags option (termio hang-up-on-close) asserted
> > when the close happens?
> >
> > The "drop DTR and then wait a bit" behavior is requested by the
> > HUPCL termio option. Otherwise, if CLOCAL is off, it is supposed
> > to just drop DTR with no guarantee of holding it low for any
> > particular amount of time.
> >
> > cheers,
> > Ed
> 
> Well I didn't want to have to re-write agetty. Upon boot, before
> init spawns an agetty, I initialize the modem in 'raw' mode like
> this......
> 
>     /*
>      * Set to dumb RAW mode with no echo and no character 
> interpretation.
>      */
>     memset(&io_mod, 0x00, sizeof(io_mod));      /* bzero() is 
> obsolete  */
>     io_mod.c_cflag     = B57600|CS8|CREAD|CLOCAL;
>     io_mod.c_iflag     = IGNBRK|IGNPAR;
>     io_mod.c_cc[VMIN]  = (cc_t) 1;
>     io_mod.c_cc[VTIME] = (cc_t) 1;
>     if(ioctl(fd, TCSETS, &io_mod) < 0)
>     {
>         fprintf(stderr, "ioctl of %s failed setting 
> parameters (%s)\n",
>                          argv[1], strerror(errno));
>         ERROR_EXIT;
>     }
>     (void)hangup(fd, buffer);
> 
> Hangup just sets the baud-rate to B0 while keeing all other parameters
> the same. It waits a second, then restores the c_clag variables.
> 
> This program then sends initialization strings to the modem, reads
> any echo, then closes. This makes sure that agetty gets connected
> to a modem that will actually answer a call. Agetty sleeps in open()
> because it attempts to open the terminal in blocking mode. That way
> agetty will only wake up after a connection is made. Agetty then
> sets its own parameters which include HUPCL Line 1116:
>            tp->c_cflag = CS8|HUPCL|CREAD| op->speeds[FIRST_SPEED];
> Later on, it sets CRTSCTS when it examines the device parameters.
> 
> So, although my initialization program didn't set HUPCL, agetty did.
> 
> The problem is that agetty execs (does not fork and exec) so 
> it becomes
> /bin/login. /bin/login execs and becomes /bin/bash. There is no
> program waiting to restore modem parameters. When /bin/bash exits,
> /sbin/init will spawn another agetty task and the process repeats.
> If, when /bin/bash exits, the close doesn't lower DTR long enough,
> the modem will not hang up.
> 
Hi Richard,

What you are doing looks just fine.

As long as HUPCL is set when the close happens, DTR will drop. There are
delays that are enforced in both open and close when a second process is
blocked opening a closing port. Of course, that would not be your case,
because the open does not occur until the closing process terminates. In a
quick look, I didn't see an enforced close-to-open delay for your case.
Maybe I missed something. I am looking at 2.4.18 Red Hat -3. I didn't notice
a patch to serial.c in the 2.4.19 or 2.4.20 changelog that would affect
this. There are some weird calculations that appear to scale the close_delay
field value based on HZ.

Which was the last "working" kernel rev that you used?

Did you switch to a faster CPU?

Are you using any "low latency" patches?

Did the HZ value change between the last rev that worked and 2.4.20? 

What HZ value are you running with? 

Cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
