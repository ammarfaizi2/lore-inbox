Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUE1RiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUE1RiD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbUE1RiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:38:03 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:27837 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263714AbUE1Rh6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:37:58 -0400
To: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
Cc: Tuukka Toivonen <tuukkat@ee.oulu.fi>
References: <MPG.1b2111558bc2d299896a2@news.gmane.org> <20040525201616.GE6512@gucio> <xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de>
Subject: Re: keyboard problem with 2.6.6
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 28 May 2004 19:37:57 +0200
Message-ID: <xb7aczscv0q.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Giuseppe" == Giuseppe Bilotta <bilotta78@hotpop.com> writes:

    Giuseppe> Concerning GPM vs kernel support for mice, maybe we can
    Giuseppe> hope for a merging of the efforts and a reduction of
    Giuseppe> code duplication, if there is any?

I'm trying to port the kernel's psmouse.c to userspace, exploiting the
SERIO_USERDEV patch that Tuukka  Toivonen and I developed.  That patch
provided a  direct path  from the  PC keyboard and  PS2 mouse  port to
userspace programs.  I've been using it so as to use my legacy XFree86
driver for my touch screen for many weeks.

I've just had some success porting atkbd.c to userspace.  Running this
userspace  program and  unloading the  'atkbd' module,  I can  type as
usual.  It works like this:


        userland          atkbd.c --------+             apps
                               ^          |              ^
                               |3         |4             |7
        module           'serio' with     |              |
                        SERIO_USERDEV     v        {input system}
                               ^        uinput           |
                               |2         |              |
        module              'i8042'       |5             |6
                               ^          |              |
                               |          |              |
        virtual device         |          +---> "AT keyboard"
                               |1
                               |
        hardware           i8042 chip

Data abstraction:
  (1) electronic signals
  (2), (3) byte stream
  (4), (5), (6), (7) a stream of struct input_event

By moving  the translation from  byte-stream to input events,  we have
more  flexibilities.  E.g.,  I've imagined  using SSH  to pipe  (3) to
another machine,  where my atkbd.c userland program  can then continue
converting to (4) and feeding that to the *remote* system.  This means
it's  possible  to  Alt-F1,  SysRq-*, ctrl-alt-delete  from  a  REMOTE
machine!   It's also  possible to  replace atkbd.c  above with  an X11
client that gives a virtual keyboard.  Again, this can be exploited to
do remote controlling.

Right now, my  atkbd.c doesn't hand the LEDs.  I get  stuck with a bug
with  'uinput',  which  oops   upon  select()  and  poll(),  which  is
necessary.  I've posted this bug,  which has been entered into buzilla
as bug #2786.

        http://bugzilla.kernel.org/show_bug.cgi?id=2786

As soon  as this  bug is fixed,  the userland  atkbd.c can be  made to
support the keyboard LEDs.



    Giuseppe> Overall, I think that the new system *could* be a good
    Giuseppe> starting point, but it still needs a *lot* of work.

I also agree the  new system has its merits.  What I  hate is only the
part  where  mouse/keyboard drivers  are  now  in  kernel space.   The
translation of  raw byte  streams into input  events should  be better
done in userland.  One important  argument is: userland program may be
swapped out.  Kernel modules can't.




--
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ)

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

