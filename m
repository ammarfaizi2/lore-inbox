Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315271AbSEAA3L>; Tue, 30 Apr 2002 20:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315272AbSEAA3K>; Tue, 30 Apr 2002 20:29:10 -0400
Received: from vir2.relay.fluke.com ([129.196.184.26]:18899 "EHLO
	vir2.relay.fluke.com") by vger.kernel.org with ESMTP
	id <S315271AbSEAA3K>; Tue, 30 Apr 2002 20:29:10 -0400
Date: Tue, 30 Apr 2002 17:28:58 -0700 (PDT)
From: David Dyck <dcd@tc.fluke.com>
To: Stuart MacDonald <stuartm@connecttech.com>,
        Alan Modra <alan@linuxcare.com>, Kiyokazu SUTO <suto@ks-and-ks.ne.jp>,
        Andrew Morton <andrewm@uow.edu.au>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Kanoj Sarcar <kanoj@sgi.com>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Robert Schwebel <robert@schwebel.de>,
        Juergen Beisert <jbeisert@eurodsn.de>, "Theodore Ts'o" <tytso@mit.edu>,
        Sapan Bhatia <sapan@corewars.org>
cc: <linux-kernel@vger.kernel.org>
Subject: changes between 2.2.20 and 2.4.x 'broke' select() from detecting
 input characters in my serial /dev/ttyS0 program
Message-ID: <Pine.LNX.4.33.0204301451300.2964-100000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 01 May 2002 00:33:31.0232 (UTC) FILETIME=[D1C02600:01C1F0A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a program that opened "/dev/ttyS0" twice,
once as O_RDONLY, and once as O_WRONLY
 (I know now that I could have opened only one channel O_RDWR)

The program used tcsetattr( ,TCSANOW, ) to modify
c_iflag, c_oflag, and c_cflag for both channels.
first for the O_RDONLY channel, and then for the O_WRONLY.

Later the program used select() on the O_RDONLY channel to
detect characters, and read() to extract them from the driver.
This used to work in 2.2.x, (2.2.20) but select() now reports no characters
available on 2.4.x (today it is 2.4.19-pre7-ac3).

If I change the order of the tcsetattr() to modify the O_RDONLY
after the O_WRONLY channel, then it works on both 2.2.x and 2.4.x.
I have a workaround (by changing the order), but this order
dependency is not documented and I wonder if it is some new
feature, or a bug.
 (I think it is a bug)

I have a 158 line program that I use to demonstrate the
bug that I could email if requested.

I am wondering what changed between 2.2.x and 2.4.x that
could have caused this change in behaviour.

It turns out also that the O_WRONLY channel had CREAD turned off,
which I would expect was appropriate for an output channel, and
in 2.2 kernels, it didn't affect the O_RDONLY channel.  If I enable
the CREAD bit in termios c_cflag register for the O_WRONLY channel also
then the select on the O_RDONLY channel reports characters available.

I suspect that there is a different level of information sharing
between the 2 channels that are open, but which is the correct behaviour,
and why?

 David

I've addressed this email to those that have modified
the code since 2.2.20, maybe these symtoms will ring a bell.
Perhaps the change that causes this is outside of serial.c.

