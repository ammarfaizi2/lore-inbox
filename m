Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSKHXOn>; Fri, 8 Nov 2002 18:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262914AbSKHXOn>; Fri, 8 Nov 2002 18:14:43 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:56454 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262901AbSKHXOm> convert rfc822-to-8bit; Fri, 8 Nov 2002 18:14:42 -0500
Mime-Version: 1.0
Message-Id: <p05111b00b9f1ef8c20e1@[193.251.15.192]>
In-Reply-To: <200211081956.26946.faure@kde.org>
References: <200211081956.26946.faure@kde.org>
Date: Sat, 9 Nov 2002 00:20:30 +0100
To: David Faure <faure@kde.org>, Paul Larson <plars@linuxtestproject.org>,
       Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
From: Waldo Bastian <bastian@kde.org>
Subject: Re: 2.5.46-mm1: CONFIG_SHAREPTE do not work with KDE 3
Cc: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Am Freitag, 8. November 2002 19:18 schrieb Paul Larson:
>>  On Wed, 2002-11-06 at 22:53, Andrew Morton wrote:
>>  > Dieter Nützel wrote:
>>  > > When I enable shared 3rd-level pagetables between processes KDE 3.0.x
>>  > > and KDE 3.1 beta2 at least do not work.
>>  >
>>  > Yup.  That's a bug which happens to everyone in the world
>>  > except Dave :(
>>
>>  I've tried to reproduce this also on a RH 7.3 box.  ksmserver is
>>  running, but strace says it's stuck on a select() call.  There are no
>>  kernel messages, but I got this from startx:
>>
>>  DCOPServer up and running.
>>  Warning: connect() failed: : Connection refused
>
>That's similar to mine.

Not sure where that comes from, it's either someone who tries to make 
connection to ksmserver for the purpose of session management or it 
is someone who tries to connect to the dcop server. It would surprise 
me somewhat if it is the dcop server because the dcopserver has a 
self-test and that apparently has succeeded.

It says "KDE does not work" but it doesn't mention to what degree. 
Does nothing show up? By the time ksmserver gets executed already a 
bunch of KDE processes should be running, what happens with them?

You may want to try to start the various KDE components one by one:

* dcopserver, it's workings can be tested by running the dcop command.
* kbuildsycoca, it should build/verify the sycoca database (see 
/tmp/kde-$USER/ksycoca)
* kdeinit, this should start another 4 processes or so
* kedit, simple application
* kwin, window manager, your kedit should now get a window border
* 'kdeinit_wrapper kedit', the same application but now started through kdeinit
* ksmserver
* 'kdeinit_wrapper kedit', the same application but it should now 
connect to ksmserver for session management purposes.

You may also want to test what happens when you start ksmserver with 
'kdeinit_wrapper ksmserver'

ksmserver, when idle, hangs in a select() waiting for input on some 
sockets, including the connection with the X server, (as part of the 
Qt event loop) not sure if that select call sets a timeout as well. 
You say it "hangs in select", I'm not sure if you mean with that "is 
stuck in select()" or just "waits for select to return", but the 
latter would be the normal idle state for most KDE applications. They 
often (always?) have a timeout set though.

Since you guys seems to be working page-tables the problems may be 
related to kdeinit which forks and then loads applications in the 
form of libraries. That usage pattern is somewhat different from the 
more common fork() + exec() combination. The exec() basically never 
happens.

Hope this helps a bit.

Cheers,
Waldo
