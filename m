Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263517AbSJRI7x>; Fri, 18 Oct 2002 04:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbSJRI7x>; Fri, 18 Oct 2002 04:59:53 -0400
Received: from hestia.herts.ac.uk ([147.197.200.9]:24308 "EHLO
	hestia.herts.ac.uk") by vger.kernel.org with ESMTP
	id <S263517AbSJRI7t>; Fri, 18 Oct 2002 04:59:49 -0400
Message-ID: <3DAFCCA4.507BC6C6@herts.ac.uk>
Date: Fri, 18 Oct 2002 09:56:05 +0100
From: "G.de-With" <G.de-With@herts.ac.uk>
Organization: University of Hertfordshire
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
       linux-kernel@vger.kernel.org
Subject: Re: I/O performance test
References: <200209260854.g8Q8s1403660@blueraja.scyld.com> <3DAE162D.D36EB07A@herts.ac.uk> <3DAE89B1.F58E90C3@herts.ac.uk> <200210172310.54274.roger.larsson@skelleftea.mail.telia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner: No Virus detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roger

> > Since a month we have a LINUX BEOWULF cluster, the clusters contains 7
> > P4 dual processor 2GHz computers, with 8Gb of RAM per machine. For our
> > network we have used Gigabit ethernet. On our cluster we are running RH
> > 7.2, with Linux 2.4.19.
> >
> > These are some of the hardware specs:
> >
> > - Dual Intel Xeon 2.GHz, 512 cache 400 MHz FSB
> > - 8 Gb ECC DDR
> > - Fujitsu 72Gb 10.000 rpm Ultra 160 SCA HDD SCSI HARDDISK
>
> Do you have a 72 GB HD per dual processors? Or only on one?
> Or do the data have to pass through the ethernet for your tests?


I have 3*72Gb HD per computer. The test is carried out both on the server,
whereby data was written directly to the harddisk, as well the test was
carried out from one of the nodes whereby data had to pass through the
ethernet.
When carrying out the test of the ethernet no problems were discovered.

> > The problem we have with our cluster is as follows. When running large
> > scientific simulations the computer performance gradually goes down as
> > the I/O activity is increasing. At some point the response of the
> > computer is so poor that we have to kill the simulation. In a worst case
> > when the simulation was running overnight the computer hangs and a reset
> > of the computer is necessary. Nevertheless, even when we manage to kill
> > the simulation in time the computer remains very slow and a reboot is
> > necessary to regain full computer power.
> >
> > My first suspicion was that the computer simply started swapping, but
> > there is no swap space being used, instead free RAM memory is still
> > apparent
> > (between 5-10%) and only 90% of the RAM is in use whereby 50% is cached
> > and another 50% is in usage. In addition the cpu usage is very low as
> > well.
>
> Could still be that all DMA or normal zone memory is used up.
> Use the magic sysrq to get zone info.
>  Alt+Sys Rq+M
> check in vt10 (Alt+F10 or Ctrl+Alt+F10) or with dmesg.

OK, good idea, didn't knew this.

> > In order to improve the I/O performance I have add some patches to the
> > kernel, including the patch for 00_block-highmem-all-19-1, to avoid
> > bounce buffers. Unfortunately none of the patches let to any improvement
> > in the I/O performance.
> >
> > I don't think the machine should be behaving like this. I certainly
> > expect some slowdowns with that much IO, but the computer should still
> > be reasonably responsive, particularly because no system or user files
> > that need to be accessed are on that channel of the SCSI controller.
> >
> > As a sort of a desperate move I did two other test in addition which
> > could be of use to the understanding of the problem:
> >
> > - I removed 6Gb from the server and run the test bonnie++ -s 16096
> > succesfully with 2Gb of RAM.
>
> This points towards a highmem issue...
>
> > - I placed an IDE disk 40Gb and run the test bonnie++ -s 16096 with 8Gb
> > of RAM succesfully.
>
> This is why I asked the first question.
>
> My guess: Highmem issue with Gb Ethernet?
>
> Brand and model of the Ethernet boards?

Someone suggested me to install the -aa patch 2.4.19rc5aa1. When running the
modified kernel all test were performed well.

Hereby I send you the output from Bonnie++. In this test I run bonnie++ on
the server, whereby it was writting directly to the 72Gb HD.

[govert@galaxy govert]$ bonnie++ -s 16096
Writing with putc()...done
Writing intelligently...done
Rewriting...done
Reading with getc()...done
Reading intelligently...done
start 'em...done...done...done...
Create files in sequential order...done.
Stat files in sequential order...done.
Delete files in sequential order...done.
Create files in random order...done.
Stat files in random order...done.
Delete files in random order...done.
Version 1.02c       ------Sequential Output------ --Sequential Input-
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec
%CP
galaxy       16096M 16268  72 38745  21 17456  10 18672  82 37469  14 318.1
1
                    ------Sequential Create------ --------Random
Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read---
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec
%CP
                 16  3665  99 +++++ +++ +++++ +++  3762  99 +++++ +++  9147
99
galaxy,16096M,16268,72,38745,21,17456,10,18672,82,37469,14,318.1,1,16,3665,99,+++++,+++,+++++,+++,3762,99,+++++,+++,9147,99

[govert@galaxy govert]$ emacs bonnie++
bonnie++16096.txt  bonnie++4084.txt
[govert@galaxy govert]$


Govert


--
 ------------------------------------------------------------
| Dr. Govert de With     Research Fellow                     |
| Fluid Mechanics Research Group                             |
| University of Hertfordshire                                |
| Tel: 01707 284124 Fax: 01707 285086                        |
 ------------------------------------------------------------
| Der Horizont vieler Menschen ist ein Kreis mit Radius Null |
| und das nennen sie ihren Standpunkt.                       |
 ------------------------------------------------------------



