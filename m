Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262739AbTC0AsI>; Wed, 26 Mar 2003 19:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262737AbTC0AsH>; Wed, 26 Mar 2003 19:48:07 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:65033
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S262733AbTC0Ar6>; Wed, 26 Mar 2003 19:47:58 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33E05@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Henrique Gobbi'" <henrique.gobbi@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "'linux-serial'" <linux-serial@vger.kernel.org>
Subject: RE: Interpretation of termios flags on a serial driver
Date: Wed, 26 Mar 2003 16:59:11 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 4:17 PM, Henrique Gobbi wrote:
> 
> Hello Ed !
> Thanks for the feedback. 
> 
> Please read my coments (doubts actually) below:
> 
> > > 4 - INPCK flag: What's the purpose of this flag. What's the 
> > > diference in 
> > > relation to IGNPAR;
> >      If INPCK is set, input parity checking  is  enabled.      If
> >      INPCK is  not  set, input parity checking is disabled.  This
> >      allows output parity generation without input parity errors.
> >      Note  that  whether input parity checking is enabled or dis-
> >      abled is independent of whether parity detection is  enabled
> >      or disabled. If parity detection is enabled but input parity
> >      checking is disabled, the hardware to which the terminal  is
> >      connected  will  recognize  the parity bit, but the terminal
> >      special file will not check whether this is set correctly or
> >      not.
> > 
> >      If IGNPAR is set, a  byte  with  framing  or  parity  errors
> >      (other than break) is ignored. This means that the data byte
> >      with the error is thrown away  by the  driver as if the byte
> >      had never been received. 
> > 
> > In short,
> > If INPCK is _not_ set, then all received data bytes will be 
> delivered 
> > to the user level, regardless of parity errors.
> > If IGNPAR is set, then only received data bytes that do not have 
> > parity errors will be delivered to the user level.
> > If PARENB is _not_ set, then the receiver hardware will not detect 
> > bad parity, so all received data bytes are considered free 
> of errors. 
> > Since there are no data bytes with associated error indications, 
> > setting IGNPAR would have no effect. All of the data are considered 
> > error free.
> 
> Your explanation makes sense to me. With this information I built the
> table:
>    IGNPAR    INPCK         ACTION:
>      0         0           Deliver all data to the user-level
>      0         1           Check parity. Discard erroneous bytes
>      1         0           ????
>      1         1           Check parity. Discard erroneous bytes 
> 
> What goes on ????   ?

   IGNPAR    INPCK         ACTION:
     0         0           Deliver all data to the user-level, as is.
     0         1           Deliver nulls in place of erroneous bytes
     1         0           Discard erroneous bytes, deliver the rest
     1         1           Discard erroneous bytes, deliver the rest 

IGNPAR gets processed before INPCK: 
(from drivers/char/n_tty.c:488)

static inline void n_tty_receive_parity_error(struct tty_struct *tty,
                                              unsigned char c)
{
        if (I_IGNPAR(tty)) {
                return;          /* discard data */
        }
        if (I_PARMRK(tty)) {
                put_tty_queue('\377', tty);
                put_tty_queue('\0', tty);
                put_tty_queue(c, tty);
        } else  if (I_INPCK(tty))
                put_tty_queue('\0', tty);     /* deliver null */
        else
                put_tty_queue(c, tty);        /* deliver data */
        wake_up_interruptible(&tty->read_wait);
}

> 
> > > 5 - If the TTY knows the data status (PARITY, FRAMING, 
> > > OVERRUN, NORMAL), 
> > > why the driver has to deal with the flag IGNPAR. Shouldn't 
> > > the TTY being 
> > > doing it ?
> > 
> > Not sure I understand the question. Received data does not carry any
> > information about errors with it after it leaves the driver, unless 
> > PARMRK is set. 
> 
> When the driver copy the data from the controler to the flip buffer it
> copies the data to the buffer tty->flip.char_buf_ptr and it set a flag
> (TTY_NORMAL, TTY_PARITY, TTY_FRAME, etc) on the buffer
> tty->flip.flag_buf_ptr telling the TTY how this byte was received. So
> the TTY knows if certain byte was problematic or not. Did you 
> understand my doubt know ?

Yes. I call that part a "line discipline". n_tty is the TTY line 
discipline that implements termio(s) and some legacy functionality.

And yes, for received data with parity errors, the line discipline 
handles IGNPAR, as well INPCK and PARMRK. See snippet of n_tty.c above. 

> 
> Thanks for your patience
> Henrique
> 

Cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
