Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265166AbRGSQco>; Thu, 19 Jul 2001 12:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265101AbRGSQcZ>; Thu, 19 Jul 2001 12:32:25 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:25353 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S265042AbRGSQcM>; Thu, 19 Jul 2001 12:32:12 -0400
Message-ID: <3B570B80.84AD8E8A@folkwang-hochschule.de>
Date: Thu, 19 Jul 2001 18:32:00 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: netfilter@lists.samba.org
CC: netfilter-devel@lists.samba.org, nettings@folkwang-hochschule.de,
        christian@rubbert.de, linux-kernel@vger.kernel.org
Subject: Re: kernel lockup in 2.4.5-ac3 and 2.4.6-pre7 (netfilter ?)
In-Reply-To: <3B52ADC1.95012614@folkwang-hochschule.de> <3B534D06.5090405@earthlink.net> <3B56E91F.12C1AB9B@folkwang-hochschule.de> <3B56FE85.2080802@suche.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

[christian, i'm quoting a message of yours below. maybe this is of
interest to you, so i'm cc:ing]
Thomas wrote:
> 
> Jörn Nettingsmeier wrote:
> 
> > hello brad, hello netfilter people !
> > Brad Chapman wrote:
> >
> >>    Were you able to rescue any console output from the hard
> >> lockup;
> >> i.e. you did a klogd -c 7 to capture _everything_ the kernel
> >> spit out?
> >> If you were able to, could you send them to the list, please?
> >>
> > i have just reproduced the lockup with the klogd setting you
> > suggested, but no entries at all have survived.
> > however, it has been pointed out to me that my lockups might be
> > caused by a faulty pppoe module (i'm using a dsl connection)
> > rather
> > than netfilter.
> > it looks like i need to investigate a little further on pppoe...
> > let's see what the lkml archive has to say.
> > thanks for all the helpful replies. i will keep you posted if i
> > can
> > solve this problem.
> >
> Hi,
> i can't help you exactly, but i also use T-Dsl and also there it
> come to hangup's ( sometimes kernel panic )
> At the moment i get it off, i switched the debug mode on and log
> all the crap in an file ( hoped i find the error )
> but after debug on there was no more hangup. I'm sure it is an bug
> in the pppoe system, wich come to work
> when the T* have trouble and send defekt packets. The ground i
> think it have to do with defekt packets is
> that other frinds with dsl under windoff told me that they also
> have on the same time many disconnects.
> 
> Cu thomas

i found someone else's oops report on lkml, and this is exactly the
one i'm seeing, although i can't save it for lack of a serial
console:

> christian wrote on lkml:
> 
>       PROBLEM: Kernel Panics since i switched to T-DSL, using
> masquadering. Supposed to be 
>       fixed in 2.4.5pre9 ?

> 
>       virtual address 00008ba7
>       *pde = 00000000
>       Oops = 0000
>       CPU = 0
>       EIP = 0010:[<c01c96c9>]
>       EFLAGS: 00010202
> 
>       eax: c1569940 ebx: 00008ba7 ecx: 00000000 edx: 00068ba7
>       esi: c1b5ce80 edi: c15697e0 ebp: 00000060 esp: c0e41dd4
>       ds: 0018 es: 0018 ss: 0018
> 
>       Process dnetc (pid: 2152, stackpage=c0e41000)
> 
>       Stack: ffffff00 c01c976b c1b5ce80 ffffff00 c1b5ce80 c01c9d53
> c1b5ce80 c11fa800
>              c1b5ce80 0000000e c1b5ce80 ffffffe6 c01cc667 c1b5ce80
> 00000020 00000004
>              c1979b20 0000000e c01d0cdd c1b5ce80 00000001 00000000
> c1b5ce80 c01dabf0
>             
>       Call Trace: [<c01c976b>] [<c01c9d53>] [<c01ccdd7>]
> [<c01d0cdd>] [<c01dabf0>] 
>       [<c01dacb0>] [<c01d1ef8>]
>                   [<c01d8240>] [<c01dabd2>] [<c01dabf0>]
> [<c01d829a>] [<c01d1ef8>] 
>       [<c01d8fd6>] [<c01d8240>] [<c01d7290>]
>                                                                            
> ^ f or 1 ? 
>       (that's the f in the third entry, for those not using fixed
> width fonts :)
>                   [<c01d742d>] [<c01d7290>] [<c01d1ef8>]
> [<c01d70d6>] [<c01d7290>] 
>       [<c01cd59e>] [<c0116b8a>] [<c01085cb>]
>                   [<c0106d04>]
> 
>       Code: 8b 1b 8b 42 70 83 f8 01 74 0b f0 ff 4a 70 0f 94 c0 84 c0
> 74
>       Kernel panic: Aiee, killing interrupt handler!
>       In interrupt handler - not syncing.

i can trigger this bug by simply typing ctrl-c in an ftp or ssh
session from a machine on the local (masqueraded) network to the
internet.

some folks have blamed the ppp/pppoe code, but after further testing
it does seem to be netfilter-related somehow, since i cannot
reproduce the
oops on the router itself with iptables modules unloaded. it only
happens on a machine on the local network when masqueraded via the
router.

does this assumption make sense ?

i was pointed to a ppp patch from lkml, but it seems to be relevant
only to starting/stopping a ppp device.
(message "[PATCH] ppp_generic.c - kfree(ppp) called twice")

right now, i'm trying 2.4.7-pre8, it has a load of ppp related
patches. it's still compiling atm.

getting confused...

jörn


-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://icem-www.folkwang-hochschule.de/~nettings/
http://www.linuxdj.com/audio/lad/
