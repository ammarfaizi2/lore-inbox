Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265097AbUFAQuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265097AbUFAQuy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUFAQuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:50:54 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:43206 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S265097AbUFAQun convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:50:43 -0400
To: Tuukka Toivonen <tuukkat@ee.oulu.fi>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: SERIO_USERDEV patch for 2.6
References: <Pine.GSO.4.58.0406011105330.6922@stekt37> <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <20040530111847.GA1377@ucw.cz> <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de> <20040530124353.GB1496@ucw.cz> <xb7aczq9he1.fsf@savona.informatik.uni-freiburg.de> <20040530134246.GA1828@ucw.cz>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 01 Jun 2004 18:50:41 +0200
Message-ID: <xb7n03n5iji.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



    Tuukka> Dmitry suggested adding a kernel parameter to specify
    Tuukka> which ports would allow to be read in raw mode and which
    Tuukka> would be handled by kernel drivers.

That means changes have to be made to ALL drivers.  That looks "ugly".


    Tuukka> In my opinion, almost the same is achieved more
    Tuukka> conveniently by handling in raw mode simply exactly those
    Tuukka> ports that are opened from userspace (ie. "cat serio1"
    Tuukka> would disconnect kernel driver), and everything else by
    Tuukka> kernel drivers.  No additional parameters would be then
    Tuukka> necessary, nor module reloads to change anything.

I have a suggestion using sysfs or procfs:

In some directory (e.g. /proc/input/serio):

        unbound_ports/  (contains a pseudo file for each serio port
                         that is not attached to any device yet)
        keyboards/      (contains a pseudo file for each serio port
                         that is attached to the keyboard device)
        mice/           (contains a pseudo file for each serio port
                         attached to mousedev.ko)
        touchscreens/   (contains a pseudo file for each serio port
                         attached to tsdev.ko)
        direct/         (contains a pseudo file for each serio port
                         that is exposed to userland (currently via "misc")
                         directly, RAW)
etc.  The contents of the pseudo files are unimportant.  (We could use
it to show useful info, though.)

Initially,  all  serio  ports  have  their  corresponding  pseudofiles
created   under   "unbound_ports".   When   a   serio  device   module
(e.g. mousedev) is loaded,  the module, in the current implementation,
will attach all mouse device  to it.  So, the corresponding entries in
"unbound_ports/" will be moved to "mice/".

If we now  want the PS AUX port  to be accessed directly, we  do a "mv
unbound_ports/isa0060.serio1 direct/".   The serio port isa0060/serio1
will   then   be  detached   from   mousedev.ko   and  reattached   to
SERIO_USERDEV,  which then  creates  /dev/misc/isa0060.serio1 for  raw
access.   Similarly,  the  user  can  "mv" any  device  between  these
directories.  Moving  it to "unbound_ports" disconnects  the port from
any device.  This userland interface should be doable!

If  I   try  to  "mv   unbound_ports/isa0060.serio1  keyboards/",  the
operation should fail because  the keyboard device cannot handle ports
connected  to  mice.  An  "rm  mice/isa0060.serio1"  should either  be
forbidden, or  be automatically translated  to "mv mice/isa0060.serio1
unbound_ports/".


Advantage: currently, the  binding of serio ports to  serio devices is
basically hardcoded  into the serio  device modules.  The  user cannot
override anything.  This is very  inflexible.  (It'd be nice it add an
option so  that they don't  attach to any  ports, leaving the  task to
some start-up scripts, which do "mv" in that proc directory.)  Suppose
that  tomorrow, someone  comes  up with  a  mousedev2.ko with  special
features that  mousedev.ko doesn't provide.  Moreover, he  has 2 mice,
and wants to attach one  to mousedev.ko and the other to mousedev2.ko.
Now,  using this  proc/sysfs  interface, he  has  complete freedom  to
attach any mouse to any serio device module.  (Without this, he has to
write mousedev2.ko  in a way  so that it  only attaches to one  of his
mice, and load this moudle before mousedev.ko, so that mousedev2 grabs
the desired mouse before mousedev steals all the two mice.)

A  similar  interface  can  also  be  used  for  fine-controlling  the
connection between input devices and input handlers.




    >> I'd like to keep it separate from the serio.c file, although
    >> it's obvious it'll require to be linked to it statically,
    >> because it needs hooks there

    Tuukka> Agreed. I'll do that (serio-dev.c). Disadvantage: the
    Tuukka> functions can not be anymore inline (unless I put lots of
    Tuukka> stuff into header file) which may make code less
    Tuukka> efficient. Hopefully not significantly.

I've also  though about separating SERIO_USERDEV into  a separate file
during the development and testing of that patch.  Like both of you, I
realized that  it is difficult to  do, because it  requires many hooks
deep into the  guts of serio.c.  Moreover, we  would need the #ifdef's
anyway,  if we  want  to  make the  USERDEV  an optional  compile-time
feature.  So, ...

The separate file doesn't have  to be linked statically.  We could use
function pointer  (i.e. hooks) variables,  or a SINGLE pointer  to one
structure  containing  func.   pointers  to  all  required  functions.
Initially, these are NULL, and serio.c would check this before calling
the hooks.  After loading the "serio_userdev" module, the module would
set these  pointers to its  functions.  Then, serio.c will  call these
functions.  These function pointers can  be removed with #if's to save
space when we  don't want the USERDEV feature  during compilation.  Of
course, the  world is not  that ideal.  There are  concurrency issues,
and we need  to keep track of which  _existing_ ports are userdev-ized
and  which aren't.   Moreover,  one more  level  of indirection  means
reduced efficiency.  I don't think it worths these complications.



BTW,   Tuukka,   I   suggest   renaming   the   "isa0060/serio?"    to
"isa0060.serio?".  The  reason is that the old  names are incompatible
with  sysfs.  I  just played  around with  sysfs, and  found something
funny:  

        $ ls /sys/class/misc
        isa0060/serio0  isa0060/serio1

        $ ls /sys/class/misc/isa0060
        ls: /sys/class/misc/isa0060: No such file or directory

This is  due to  a "/" in  the filename "isa0060/serio0",  which rests
under /sys/class/misc/.

(Should  this be  considered  a  sysfs bug?   Anyway,  renaming it  to
"isa0060.serio0" can avoid the problem.)



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

