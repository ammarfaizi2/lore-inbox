Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWJDTYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWJDTYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWJDTYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:24:10 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:59592 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750868AbWJDTYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:24:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q0vnTuL6CZED/ujuHN0m859XzRr+vOc3cSOTRlYvV5QZ+l0yryhYFz4KbWjgv0r4J/oLFVrhHUpH+SXwSfWXLthqQvsvi/bc7C6I6ESfSYdfezXgBiHBPvGGnGeEd2+TWmbazoj2G0ueD0bqqGZ40dFkHokZNVI9uEehUtVjqkc=
Message-ID: <9a8748490610041224h7de321r6507a0d9e99ad015@mail.gmail.com>
Date: Wed, 4 Oct 2006 21:24:06 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2
Cc: "Randy Dunlap" <rdunlap@xenotime.net>, akpm <akpm@osdl.org>,
       "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0610030950230.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
	 <Pine.LNX.4.64.0609191453310.4388@g5.osdl.org>
	 <20061002191638.093fde85.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org>
	 <20061002213809.7a3f995f.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610030805490.3952@g5.osdl.org>
	 <20061003092339.999d0011.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610030933250.3952@g5.osdl.org>
	 <20061003094926.0e99d13f.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610030950230.3952@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Tue, 3 Oct 2006, Randy Dunlap wrote:
> > >
> > > So Randy, with this you can boot all the way into user space, and some FP
> > > apps still work too?
> >
> > My few trivial float and double apps work.
> > Is there any particular test/workload that you want me to run?
>
> Not really, if "most things just seem to work", that's already pretty much
> all we should ask for from the math emulation.
>

I just tested 2.6.18-git21 and here's a small status report :

The good news is: The kernel boots.
The bad news is: Userspace breaks left and right.

I'm booting with "no387 nofxsr"

On my first boot I just used the options above and the result was that
most of the bootup sequence looked quite normal until I got to the
point of starting sshd, then things started to go wrong. This is what
I got :

...
/etc/rc.d/rc.sshd: line 4: 1491 Illegal instruction    /usr/sbin/sshd
...
/usr/sbin/apachectl: line 81:    1588 Illegal instruction    $HTTPD
/usr/sbin/apachectl: start: httpd could not be started
Starting up X11 Session manager...
   At this point X starts and gets as far as showing me the default X
cursor on a black background very briefly, then I'm back in text mode
and the box is hung - CTRL+ALT+DEL did work, but that was about it.

Then I tried a boot to single user mode ("no387 nofxsr single").
That worked a little better, although sshd and abache were still
broken (didn't really expect otherwise). I managed to get a login
prompt, logged in and successfully switched to runlevel 3 (which on my
distro (Slackware 11) is multi-user without X). Then I tried to
"startx" by hand to see if that would get me any further details, and
it did. I got this :

...
(==) Using config file: "/etc/X11/xorg.conf"
Could not init font path element /usr/X11R6/lib/X11/fonts/CID/, removing
from list!
xset:  bad font path element (#62), possible causes are:
    Directory does not exist or has wrong permissions
    Directory missing fonts.dir
    Incorrect font server address or syntax
xset:  bad font path element (#62), possible causes are:
    Directory does not exist or has wrong permissions
    Directory missing fonts.dir
    Incorrect font server address or syntax

   *** If unresolved symbols were reported above, they might not
   *** be the reason for the server aborting.

Backtrace:
0: X(xf86SigHandler+0x8a) [0x8088b2a]
1: [0xb7fb9420]
2: /usr/X11R6/lib/modules/libfb.so(fbCopyNtoN+0x214) [0xb79658d4]
3: /usr/X11R6/lib/modules/libfb.so(fbCopyRegion+0x1df) [0xb796617f]
4: /usr/X11R6/lib/modules/libfb.so(fbDoCopy+0x46b) [0xb796660b]
5: /usr/X11R6/lib/modules/libfb.so(fbCopyArea+0x78) [0xb79666b8]
6: /usr/X11R6/lib/modules/libshadow.so [0xb7985c34]
7: X [0x8168ec1]
8: X [0x81b2260]
9: X [0x81b06cc]
10: X [0x81b12b8]
11: X(miPointerUpdate+0x126) [0x81afbc6]
12: X [0x81afc7b]
13: X [0x816e262]
14: X [0x8183a4e]
15: X [0x80c9c95]
16: X(ChangeWindowAttributes+0x9ee) [0x80dceee]
17: X(ProcChangeWindowAttributes+0x81) [0x80c0e21]
18: X(Dispatch+0x171) [0x80c7e21]
19: X(main+0x3ed) [0x80d465d]
20: /lib/tls/libc.so.6(__libc_start_main+0xd4) [0xb7e39e14]
21: X [0x806ff61]

Fatal server error:
Caught signal 4.  Server aborting


Please consult the The X.Org Foundation support
         at http://wiki.X.Org
 for help.
Please also check the log file at "/var/log/Xorg.0.log" for additional
information.

X connection to :0.0 broken (explicit kill or server shutdown).
/usr/X11R6/bin/xinit:  connection to X server lost.
root@(none):~# GOT SIGHUP
startkde: Starting up...
ksplash: cannot connect to X server :0
kdeinit: Can't connect to the X Server.
kdeinit: Might not terminate at end of session.
kded: cannot connect to X server :0
DCOP aborting call from 'anonymous-2278' to 'kded'
kded: ERROR: Communication problem with kded, it probably crashed.
kcminit_startup: cannot connect to X server :0
root@(none):~#
ksmserver: cannot connect to X server :0
startkde: Shutting down...
klauncher: Exiting on signal 1
startkde: Running shutdown scripts...
startkde: Done.
root@(none):~#

This time the system didn't hang, it was still somewhat usable (except
for random apps breaking with "Illegal instruction").


So that's great progress, but it could certainly work a lot better.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
