Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWBVQvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWBVQvr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWBVQvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:51:47 -0500
Received: from mail.bencastricum.nl ([213.84.203.196]:29327 "EHLO
	bencastricum.nl") by vger.kernel.org with ESMTP id S1030275AbWBVQvp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:51:45 -0500
Message-ID: <001401c637d0$01873040$0602a8c0@links>
From: "Ben Castricum" <support@bencastricum.nl>
To: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Jens Axboe" <axboe@suse.de>,
       "James Bottomley" <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, "Greg KH" <greg@kroah.com>,
       "Yu, Luming" <luming.yu@intel.com>,
       "Ben Castricum" <lk@bencastricum.nl>, <sanjoy@mrao.cam.ac.uk>,
       "Helge Hafting" <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       =?iso-8859-1?Q?Gerrit_Bruchh=E4user?= <gbruchhaeuser@gmx.de>,
       <Nicolas.Mailhot@LaPoste.net>, "Jaroslav Kysela" <perex@suse.cz>,
       "Takashi Iwai" <tiwai@suse.de>,
       "Patrizio Bassi" <patrizio.bassi@gmail.com>,
       =?iso-8859-1?Q?Bj=F6rn_Nilsson?= <bni.swe@gmail.com>,
       "Andrey Borzenkov" <arvidjaar@mail.ru>,
       "P. Christeas" <p_christ@hol.gr>, "ghrt" <ghrt@dial.kappa.ro>,
       "jinhong hu" <jinhong.hu@gmail.com>,
       "Andrew Vasquez" <andrew.vasquez@qlogic.com>,
       "Benjamin LaHaise" <bcrl@kvack.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060212190520.244fcaec.akpm@osdl.org>
Subject: Re: Linux 2.6.16-rc3
Date: Wed, 22 Feb 2006 17:49:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-bencastricum-MailScanner-Information: Please contact the ISP for more information
X-bencastricum-MailScanner: Found to be clean
X-MailScanner-From: support@bencastricum.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We still have some serious bugs, several of which are in 2.6.15 as well:
> [...]
> - "Ben Castricum" <lk@bencastricum.nl> reports that ppp has started
>  exhibiting mysterious failures (again).

I found the time to do some more testing, this time with the latest 
2.6.16-rc4 from git and still pppd version 2.4.1.

The problem was very easy to reproduce, within 10 minutes I appeared again. 
I could narrow the problem down to not being able to _send_ traffic. 
Ifconfig -a and tcpdump showed traffic coming in, but not going out. I tried 
stracing the relevant programs (I use pptp to connect to the dsl modem)

root@gateway:~# ps -ef | grep pp
root       870     1  0 16:47 ?        00:00:00 /usr/sbin/upnpd ppp0 eth1
root       329     1  0 16:45 ?        00:00:00 /usr/sbin/pptp pptp: call 
manager for 10.0.0.138
root       323   322  0 16:45 ?        00:00:14 /usr/sbin/pptp pptp: 
GRE-to-PPP gateway on /dev/ptmx
root       322     1  0 16:45 ?        00:00:00 /usr/sbin/pppd call adsl
root      3156  2941  0 17:15 pts/2    00:00:00 grep pp

root@gateway:~# strace -p 322
select(4, [0 3], NULL, [0 3], NULL <unfinished ...>

(nothing happening there)

root@gateway:~# strace -p 323
write(4, " \201\210\v\0\0\0\0\0\2\320X", 12) = 12
select(5, [0 4], NULL, NULL, NULL)      = 1 (in [4])
read(4, "E\0\0`\36P\0\0@/G\225\n\0\0\212\n\0\0\0010\1\210\v\0@\0"..., 8260) 
= 96
write(0, "\377\3\0!E\0\0< \211@\0(\6\27\336\310\256\260\215\325T"..., 64) = 
64
select(5, [0 4], NULL, NULL, {0, 500000}) = 1 (in [4], left {0, 488000})
read(4, "E\0\0T\36Q\0\0@/G\240\n\0\0\212\n\0\0\0010\1\210\v\000"..., 8260) = 
84
write(0, "\377\3\0!E\0\0000_E@\0w\6\320rRH\340\256\325T\313\304\20"..., 52) 
= 52
select(5, [0 4], NULL, NULL, {0, 0})    = 0 (Timeout)
write(4, " \201\210\v\0\0\0\0\0\2\320Z", 12) = 12
select(5, [0 4], NULL, NULL, NULL)      = 1 (in [4])
read(4, "E\0\0T\36R\0\0@/G\237\n\0\0\212\n\0\0\0010\1\210\v\000"..., 8260) = 
84
write(0, "\377\3\0!E\0\0000_F@\0w\6\320qRH\340\256\325T\313\304\20"..., 52) 
= 52
select(5, [0 4], NULL, NULL, {0, 500000}) = 1 (in [4], left {0, 472000})
read(4, "E\0\0T\36S\0\0@/G\236\n\0\0\212\n\0\0\0010\1\210\v\000"..., 8260) = 
84
write(0, "\377\3\0!E\0\0000\21\223@\0q\6\205\\P\313\200\364\325T"..., 52) = 
52
select(5, [0 4], NULL, NULL, {0, 0})    = 0 (Timeout)
write(4, " \201\210\v\0\0\0\0\0\2\320\\", 12) = 12
select(5, [0 4], NULL, NULL, NULL)      = 1 (in [4])
read(4, "E\0\0T\36T\0\0@/G\235\n\0\0\212\n\0\0\0010\1\210\v\000"..., 8260) = 
84
write(0, "\377\3\0!E\0\0000C\2@\0h\6\17\233\311\307UJ\325T\313\304"..., 52) 
= 52
select(5, [0 4], NULL, NULL, {0, 500000}) = 1 (in [4], left {0, 496000})
read(4, "E\0\0`\36U\0\0@/G\220\n\0\0\212\n\0\0\0010\1\210\v\0@\0"..., 8260) 
= 96
write(0, "\377\3\0!E\0\0<0e@\0003\6\4T\303\200\256i\325T\313\304"..., 64) = 
64
select(5, [0 4], NULL, NULL, {0, 0})    = 0 (Timeout)
write(4, " \201\210\v\0\0\0\0\0\2\320^", 12) = 12
select(5, [0 4], NULL, NULL, NULL)      = 1 (in [4])
read(4, "E\0\0d\36V\0\0@/G\213\n\0\0\212\n\0\0\0010\1\210\v\0D\0"..., 8260) 
= 100
write(0, "\377\3\0!E\0\0@:S\0\0003\6\203Y\311\32_\330\325T\313\304"..., 68) 
= 68
select(5, [0 4], NULL, NULL, {0, 500000}) = 1 (in [4], left {0, 484000})
read(4, "E\0\0`\36W\0\0@/G\216\n\0\0\212\n\0\0\0010\1\210\v\0@\0"..., 8260) 
= 96
write(0, "\377\3\0!E\0\0<\275\240@\0%\6\24\355\310\320\31E\325T\313"..., 64) 
= 64
select(5, [0 4], NULL, NULL, {0, 0})    = 0 (Timeout)
write(4, " \201\210\v\0\0\0\0\0\2\320`", 12) = 12
select(5, [0 4], NULL, NULL, NULL)      = 1 (in [4])
read(4, "E\0\0d\36X\0\0@/G\211\n\0\0\212\n\0\0\0010\1\210\v\0D\0"..., 8260) 
= 100
write(0, "\377\3\0!E\0\0@a\264\0\0003\6\250\345\311\374\22\t\325"..., 68) = 
68
select(5, [0 4], NULL, NULL, {0, 500000}) = 1 (in [4], left {0, 496000})
read(4, "E\0\0d\36Y\0\0@/G\210\n\0\0\212\n\0\0\0010\1\210\v\0D\0"..., 8260) 
= 100
write(0, "\377\3\0!E\0\0@j\217\0\0003\6\272\317\310\350\370W\325"..., 68) = 
68
select(5, [0 4], NULL, NULL, {0, 0})    = 0 (Timeout)
write(4, " \201\210\v\0\0\0\0\0\2\320b", 12) = 12
select(5, [0 4], NULL, NULL, NULL)      = 1 (in [4])
read(4, "E\0\0T\36Z\0\0@/G\227\n\0\0\212\n\0\0\0010\1\210\v\000"..., 8260) = 
84
write(0, "\377\3\0!E\0\0000\26\217@\0p\6\375o\310\251\215\6\325T"..., 52) = 
52
select(5, [0 4], NULL, NULL, {0, 500000}) = 1 (in [4], left {0, 440000})
read(4, "E\0\0T\36[\0\0@/G\226\n\0\0\212\n\0\0\0010\1\210\v\000"..., 8260) = 
84
write(0, "\377\3\0!E\0\0000\3672@\0o\6[-\310\264O\232\325T\313\304"..., 52) 
= 52
select(5, [0 4], NULL, NULL, {0, 0})    = 0 (Timeout)
write(4, " \201\210\v\0\0\0\0\0\2\320d", 12) = 12
select(5, [0 4], NULL, NULL, NULL <unfinished ...>

(and so on...)

root@gateway:~# strace -p 329
select(7, [3 4 6], [], NULL, NULL <unfinished ...>

nothing hapening here either.

checking the iptables setup (I flushed the rules before I started with 
troubleshooting):
root@gateway:~# iptables-save
# Generated by iptables-save v1.2.6a on Wed Feb 22 17:10:44 2006
*filter
:INPUT ACCEPT [6204:440626]
:FORWARD ACCEPT [8:284]
:OUTPUT ACCEPT [18978:2854072]
COMMIT
# Completed on Wed Feb 22 17:10:44 2006
# Generated by iptables-save v1.2.6a on Wed Feb 22 17:10:44 2006
*nat
:PREROUTING ACCEPT [44153:2316103]
:POSTROUTING ACCEPT [805:50699]
:OUTPUT ACCEPT [2308:153409]
COMMIT
# Completed on Wed Feb 22 17:10:44 2006

root@gateway:~# iptables-save
# Generated by iptables-save v1.2.6a on Wed Feb 22 17:10:48 2006
*filter
:INPUT ACCEPT [6721:478137]
:FORWARD ACCEPT [8:284]
:OUTPUT ACCEPT [20528:3083677]
COMMIT
# Completed on Wed Feb 22 17:10:48 2006
# Generated by iptables-save v1.2.6a on Wed Feb 22 17:10:48 2006
*nat
:PREROUTING ACCEPT [44241:2320941]
:POSTROUTING ACCEPT [806:50777]
:OUTPUT ACCEPT [2309:153487]
COMMIT
# Completed on Wed Feb 22 17:10:48 2006


Does this help anything?

Kind regards,
Ben 

