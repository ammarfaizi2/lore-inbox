Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291824AbSBHU4N>; Fri, 8 Feb 2002 15:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291817AbSBHU4E>; Fri, 8 Feb 2002 15:56:04 -0500
Received: from fungus.teststation.com ([212.32.186.211]:28686 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S291818AbSBHUzu>; Fri, 8 Feb 2002 15:55:50 -0500
Date: Fri, 8 Feb 2002 21:55:19 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.18pre6+ll: autofs+smbfs: processes in D state
In-Reply-To: <200202081459.g18Ex3t19504@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33.0202082046200.2508-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Denis Vlasenko wrote:

> Is here somebody willing to look into smbfs related bugs?

Why not read the MAINTAINERS file?

> I wanted to verify that mp3 was good before I got all of it,
> so cd'ed to /mnt/auto/smb.host.dir, paused download,
> copied incomplete file to Linux and tried to resume dl.
> It failed (JetCar: "can't open file").
> I rebooted NT box.

This has nothing to do with the automounter.

Rebooting the NT box with smbfs mounted probably made some process go to
sleep for a long time, waiting for a reply or some network timeout.

smbfs has an ugly and incorrect assumption that it will always get a reply
to it's requests. And one process will block all others from sending any
requests until it is done.

You may want to test the 2.4.17 patch on:
    http://www.hojdpunkten.ac.se/054/samba/index.html

But that code is (very) experimental. It will allow multiple processes
sending data, the processes will be in interruptible sleep and capable of
timeout.

Further down on that page there is a patch for 2.4.4 to make it poll()
before reading and time-out. That is a smaller change and I have some good
feedback on the 2.2 version of it.


> Now I have some processes in D state. mc and ls hung trying to stat
> /mnt/auto/smb.host.dir it seems. Ksymoopsed SysRq-T output below.

They are all waiting for access to the smbfs "server" struct. None of them
is the real problem.

The process that is blocking the others is probably sleeping in
tcp_data_wait(), and if so it is interruptible.

> BTW, do I have to run klogd with -x? It seems to produce half-ksymoopsed

Yes, it is the recommended setting by the ksymoops maintainer.

/Urban

