Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316587AbSFMLuU>; Thu, 13 Jun 2002 07:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317441AbSFMLuT>; Thu, 13 Jun 2002 07:50:19 -0400
Received: from mail.medav.de ([213.95.12.190]:12040 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S316587AbSFMLuR> convert rfc822-to-8bit;
	Thu, 13 Jun 2002 07:50:17 -0400
From: "Daniela Engert" <dani@ngrt.de>
To: "Martin Wilck" <Martin.Wilck@Fujitsu-Siemens.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
Date: Thu, 13 Jun 2002 13:50:25 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <1023794726.23733.375.camel@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: Serverworks OSB4 in impossible state
Message-Id: <20020613104659.37E7B109F6@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as promised I've conducted a test similar to Martin's to check the
behaviour of a Serverworks ROSB4 IDE controller in case of an aborted
ATAPI DMA transfer (probably due to a media error). In fact, I've done
this by comparing it with a known-to-be-good system, a dual processor
Intel BX based board with a PIIX4 IDE controller chip.

The following trace shows how it should be:

 - lines 158-172: setup DMA transfer, send command packet
 - lines 173-174: the DMA engine loads the first (of multiple)
                  PRD entry
 - the actual DMA induced memory writes are not shown here
 - line  175:     IRQ14 is acknowledged
 - lines 176-181: gather unit and DMA status
 - lines 182-210: issue "request sense" and get sense status


CD-ROM read error on Intel PIIX4:

______Time_______Burst_BE#__Wait___Command_Address__Data____
  158  20.089ms  .     1011    .   I/OWri  000001F6 ..B0....
  159	1.656us  .     1011    .   I/ORd   000003F6 ..50....
  160	10.08us  .     0000    .   I/OWri  0000F004 00EAC800
  161	812.7ns  .     1110    .   I/OWri  0000F000 ......08
  162	752.5ns  .     1011    .   I/OWri  0000F002 ..46....
  163	3.100us  .     1110    .   I/OWri  000001F4 ......FF
  164	4.214us  .     1101    .   I/OWri  000001F5 ....FF..
  165	4.244us  .     1101    .   I/OWri  000001F1 ....01..
  166	4.214us  .     0111    .   I/OWri  000001F7 A0......
  167	5.027us  .     1011    .   I/ORd   000003F6 ..58....
  168	5.448us  .     1011    .   I/OWri  0000F002 ..46....
  169	752.5ns  .     1110    .   I/OWri  0000F000 ......09
  170	1.204us  .     0000    .   I/OWri  000001F0 00000028
  171	903.0ns  .     0000    .   I/OWri  000001F0 0000440D
  172	903.0ns  .     0000    .   I/OWri  000001F0 0000001F
  173	 3.673s  Start 0000    .   MemRd   00EAC800 006E3000
  174	 30.1ns  B     0000    .   MemRd   00EAC800 0000D000
  175  648.99ms  .     1110    .   IntAck  ........ ......76
  176	5.779us  .     0111    .   I/ORd   000001F7 51......
  177	11.47us  .     0111    .   I/ORd   000001F7 51......
  178	1.324us  .     1011    .   I/ORd   000001F2 ..03....
  179	1.957us  .     1110    .   I/OWri  0000F000 ......08
  180	812.7ns  .     1011    .   I/ORd   0000F002 ..44....
  181	1.355us  .     1101    .   I/ORd   000001F1 ....30..
  182	9.361us  .     1011    .   I/OWri  000001F6 ..B0....
  183	1.806us  .     1011    .   I/ORd   000003F6 ..51....
  184	9.301us  .     1110    .   I/OWri  000001F4 ......12
  185	4.274us  .     1101    .   I/OWri  000001F5 ....00..
  186	4.244us  .     1101    .   I/OWri  000001F1 ....00..
  187	4.214us  .     0111    .   I/OWri  000001F7 A0......
  188	4.906us  .     1011    .   I/ORd   000003F6 ..58....
  189	6.020us  .     0000    .   I/OWri  000001F0 00000003
  190	903.0ns  .     0000    .   I/OWri  000001F0 00000012
  191	903.0ns  .     0000    .   I/OWri  000001F0 00000000
  192  258.17us  .     1110    .   IntAck  ........ ......76
  193	3.431us  .     0111    .   I/ORd   000001F7 58......
  194	10.08us  .     0111    .   I/ORd   000001F7 58......
  195	1.204us  .     1011    .   I/ORd   000001F2 ..02....
  196	1.535us  .     1101    .   I/ORd   000001F5 ....00..
  197	1.174us  .     1110    .   I/ORd   000001F4 ......12
  198	10.20us  .     1100    .   I/ORd   000001F0 ....0070
  199	1.475us  .     1100    .   I/ORd   000001F0 ....0003
  200	632.1ns  .     1100    .   I/ORd   000001F0 ....0000
  201	632.1ns  .     1100    .   I/ORd   000001F0 ....0A00
  202	602.0ns  .     1100    .   I/ORd   000001F0 ....0000
  203	632.1ns  .     1100    .   I/ORd   000001F0 ....0000
  204	602.0ns  .     1100    .   I/ORd   000001F0 ....0611
  205	632.1ns  .     1100    .   I/ORd   000001F0 ....0000
  206	602.0ns  .     1100    .   I/ORd   000001F0 ....0000
  207	12.79us  .     1110    .   IntAck  ........ ......76
  208	3.401us  .     0111    .   I/ORd   000001F7 50......
  209	9.361us  .     0111    .   I/ORd   000001F7 50......
  210	1.234us  .     1011    .   I/ORd   000001F2 ..03....


And here is the same with the ROSB4. This time, some of the
DMA writes are shown. After loading the second PRD entry
which describes a memory region of 7800h bytes, 3000h bytes
are transferred before IRQ14 is asserted. The IRQ14 INTACK
cycle is the last transaction on the PCI bus ever, the
machine is completely frozen!

CD-ROM read error on ServerWorks ROSB4 revision 0:

______Time_______Burst_BE#__Wait___Command_Address__Data____
51316  297.63us  .     1011    .   I/OWri  000001F6 ..B0....
51317	1.530us  .     1011    .   I/ORd   000003F6 ..50....
51318	6.300us  .     0000    .   I/OWri  00005404 00EF2800
51319	  450ns  .     1110    .   I/OWri  00005400 ......08
51320	  450ns  .     1011    .   I/OWri  00005402 ..66....
51321	1.440us  .     1110    .   I/OWri  000001F4 ......FF
51322	3.480us  .     1101    .   I/OWri  000001F5 ....FF..
51323	3.480us  .     1101    .   I/OWri  000001F1 ....01..
51324	3.510us  .     0111    .   I/OWri  000001F7 A0......
51325	4.470us  .     1011    .   I/ORd   000003F6 ..58....
51326	4.620us  .     1011    .   I/OWri  00005402 ..66....
51327	  660ns  .     0000    .   I/OWri  000001F0 00000028
51328	  420ns  .     0000    .   I/OWri  000001F0 0000F80D
51329	  420ns  .     0000    .   I/OWri  000001F0 0000001F
51330	1.290us  .     1011    .   I/ORd   000003F6 ..D0....
51331	3.660us  .     1110    .   I/OWri  00005400 ......09
51332	1.290us  .     0000    .   MemRd   00EF2800 00B08000
51333	  630ns  .     0000    .   MemRd   00EF2804 00008000
51334  166.11us  Start 0000    .   MemWri  00B08000 7BC0728C
51335	   30ns  B     0000    .   MemWri  00B08000 285DA7D0
51336	   30ns  B     0000    .   MemWri  00B08000 9FAE557A
51337	   30ns  B     0000    .   MemWri  00B08000 B3F88165
51338	   30ns  B     0000    .   MemWri  00B08000 BDFD7823
51339	   30ns  B     0000    .   MemWri  00B08000 42ED22D0
51340	   30ns  B     0000    .   MemWri  00B08000 7BA5743F
51341	   30ns  B     0000    .   MemWri  00B08000 6B5897BA
51342	  780ns  Start 0000    .   MemWri  00B08020 ACF1D36B
  ..
  ..
59518	  930ns  Start 0000    .   MemWri  00B0FFE0 845971B8
59519	   30ns  B     0000    .   MemWri  00B0FFE0 7E325F95
59520	   30ns  B     0000    .   MemWri  00B0FFE0 7ADA36D0
59521	   30ns  B     0000    .   MemWri  00B0FFE0 96BD435C
59522	   30ns  B     0000    .   MemWri  00B0FFE0 4ED88CB0
59523	   30ns  B     0000    .   MemWri  00B0FFE0 2E1CCAF7
59524	   30ns  B     0000    .   MemWri  00B0FFE0 FC8782B3
59525	   30ns  B     0000    .   MemWri  00B0FFE0 9C0A2335
59526	  780ns  .     0000    .   MemRd   00EF2808 00B10000
59527	  630ns  .     0000    .   MemRd   00EF280C 80007800
59528  1.2518ms  Start 0000    .   MemWri  00B10000 E85C33CD
59529	   30ns  B     0000    .   MemWri  00B10000 AD2F9613
59530	   30ns  B     0000    .   MemWri  00B10000 D8BEC924
59531	   30ns  B     0000    .   MemWri  00B10000 E273C0BD
59532	   30ns  B     0000    .   MemWri  00B10000 DC655F5E
59533	   30ns  B     0000    .   MemWri  00B10000 69B3087B
59534	   30ns  B     0000    .   MemWri  00B10000 369B26D1
59535	   30ns  B     0000    .   MemWri  00B10000 9A8C47DF
59536	  780ns  Start 0000    .   MemWri  00B10020 3F026EA5
  ..
  ..
62592	  750ns  Start 0000    .   MemWri  00B12FE0 367016E1
62593	   30ns  B     0000    .   MemWri  00B12FE0 35654905
62594	   30ns  B     0000    .   MemWri  00B12FE0 9968FF02
62595	   30ns  B     0000    .   MemWri  00B12FE0 9ABB5CAE
62596	   30ns  B     0000    .   MemWri  00B12FE0 D32DF135
62597	   30ns  B     0000    .   MemWri  00B12FE0 7A03326A
62598	   30ns  B     0000    .   MemWri  00B12FE0 86CCE8BF
62599	   30ns  B     0000    .   MemWri  00B12FE0 D4E66D21
62600	 1.176s  .     1110    .   IntAck  ........ ......76


My conclusion: don't do ATAPI DMA on a serverworks ROSB4 revision 0 IDE
controller.

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


