Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261877AbTCQT47>; Mon, 17 Mar 2003 14:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261891AbTCQT47>; Mon, 17 Mar 2003 14:56:59 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:32264
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S261867AbTCQT46>; Mon, 17 Mar 2003 14:56:58 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DE6@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.20 modem control
Date: Mon, 17 Mar 2003 12:07:42 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 8:19 AM, Richard B. Johnson wrote:
> Hello any tty gurus,
> 
> If a modem is connected to /dev/ttyS0 and a getty (actually agetty)
> is associated with that device, one can log-in using that modem.
> 
> This is how we've operated for many years. But, Linux version 2.4.20
> presents a new problem.
> 
> When a logged-in caller logs out, it is mandatory for the modem
> to disconnect. This has previously been done automatically when
> the terminal is closed. The closing of the tasks file-descriptors
> will eventually call tty_hangup() and the modem would (previously)
> hang up.
> 
> Something has changed so that the hang-up sequence doesn't happen if
> agetty has already opened the terminal for another possible 
> connection.
> It used to be that the caller, calling close(), did not get control
> back until the modem had been hung up. This prevented another agetty
> from opening that terminal for I/O because the previous task had not
> completed its exit procedure until the terminal was hung up.
> 
> Now, the hang-up sequence appears to be queued. It can (and does)
> happen after the previous terminal owner has expired and another
> owner has opened the device. This makes /dev/ttyS0 useless for remote
> log-ins.
> 
> It needs to be, that a 'close()' of a terminal, configured as a modem,
> cannot return to the caller until after the DTR has been lowered, and
> preferably, after waiting a few hundred milliseconds. Without this,
> once logged in, the modem will never disconnect so a new caller
> can't log in.
> 
> With faster machines, it is not sufficient to just lower DTR. One
> needs to lower DTR and then wait. This is because the next task
> can open that terminal in a few hundred microseconds, raising
> DTR again. This is not enough time for the modem to hang up because
> there is "glitch-filtering" on all modem-control leads. The hang-up
> event won't even be seen by the modem.
> 
> So, either the modem control needs to be reverted to its previous
> functionality or `agetty` needs to hang up its terminal when it
> starts, which seems backwards. In other words, the user of kernel
> services should not have to compensate for a defect in the logic
> of that service.
> 
> I have temporarily "fixed" this problem by modifying `agetty`.
> Can the kernel please be fixed instead?
> 
Hi Richard,

Is the HUPCL cflags option (termio hang-up-on-close) asserted 
when the close happens? 

The "drop DTR and then wait a bit" behavior is requested by the 
HUPCL termio option. Otherwise, if CLOCAL is off, it is supposed 
to just drop DTR with no guarantee of holding it low for any 
particular amount of time. 

cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
