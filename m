Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265552AbUABSIz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 13:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbUABSIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 13:08:55 -0500
Received: from mx1.it.wmich.edu ([141.218.1.89]:5363 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S265552AbUABSIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 13:08:47 -0500
Message-ID: <3FF5B3AB.5020309@wmich.edu>
Date: Fri, 02 Jan 2004 13:08:43 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ornati <ornati@lycos.it>
CC: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
References: <200401021658.41384.ornati@lycos.it>
In-Reply-To: <200401021658.41384.ornati@lycos.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I do not see this behavior and i'm using the same ide chipset driver 
(though not the same ide chipset).  btw, readahead for all my other 
drives is set to 8192 during these tests but changing them showed no 
effect on my numbers.



/dev/hda:

  Model=Maxtor 6Y120P0, FwRev=YAR41VW0, SerialNo=Y40D924E
  Config={ Fixed }
  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
  BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240121728
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6
  AdvancedPM=yes: disabled (255) WriteCache=enabled
  Drive conforms to: (null):

00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)

it's a vt82C686A

128
/dev/hda:
  Timing buffered disk reads:  130 MB in  3.05 seconds =  42.69 MB/sec

256
/dev/hda:
  Timing buffered disk reads:  134 MB in  3.03 seconds =  44.27 MB/sec

512
/dev/hda:
  Timing buffered disk reads:  136 MB in  3.00 seconds =  45.33 MB/sec

8192
/dev/hda:
  Timing buffered disk reads:  140 MB in  3.03 seconds =  46.24 MB/sec




Note, sometimes when moving backwards back to a lower readhead my speed 
does not decrease to the values you see here. readahead on my system 
always goes up (on avg) with higher readahead numbers, maxing at 8192. 
No matter the buffer size or speed or position the ide drive is in.

hdparm -t is difficult to get really accurate, which is why they suggest 
running it multiple times.  I see differences of 4MB/sec on subsequent 
runs without changing anything.  run hdparm -t at least 3-4 times for 
each readahead value.

I suggest trying 128, 256,512,8192 as values for readahead and skip all 
those crap numbers in between.


if you still see on avg lower numbers on the top end, try nicing hdparm 
to -20.  Also, update to a newer hdparm. hdparm v5.4, you seem to be 
using an older one.

Paolo Ornati wrote:
> As I have already said I have noticed a strange IDE performance change 
> upgrading from 2.6.0 to 2.6.1-rc1.
> 
> Now I have more data (and a graph) to show: the test is done using
> "hdparm -t dev/hda" at various readahead (form 0 to 512).
> 
> o SCRIPT
> 
> #!/bin/bash
> 
> MIN=0
> MAX=512
> 
> ra=$MIN
> while test $ra -le $MAX; do
>     hdparm -a $ra /dev/hda > /dev/null;
>     echo -n $ra$'\t';
>     s1=`hdparm -t /dev/hda | grep 'Timing' | cut -d'=' -f2| cut -d' ' -f2`;
>     s2=`hdparm -t /dev/hda | grep 'Timing' | cut -d'=' -f2| cut -d' ' -f2`;
>     s=`echo "scale=2; ($s1+$s2)/2" | bc`;
>     echo $s;
>     ra=$(($ra+16));
> done
> 
> 
> o RESULTS for 2.6.0  (readahead / speed)
> 
> 0	13.30
> 16	13.52
> 32	13.76
> 48	31.81
> 64	31.83
> 80	31.90
> 96	31.86
> 112	31.82
> 128	31.89
> 144	31.93
> 160	31.89
> 176	31.86
> 192	31.93
> 208	31.91
> 224	31.87
> 240	31.18
> 256	26.41
> 272	27.52
> 288	31.74
> 304	27.29
> 320	27.23
> 336	25.44
> 352	27.59
> 368	27.32
> 384	31.84
> 400	28.03
> 416	28.07
> 432	20.46
> 448	28.59
> 464	28.63
> 480	23.95
> 496	27.21
> 512	22.38
> 
> 
> o RESULTS for 2.6.1-rc1  (readahead / speed)
> 
> 0	13.34
> 16	25.86
> 32	26.27
> 48	24.81
> 64	26.26
> 80	24.88
> 96	27.09
> 112	24.88
> 128	26.31
> 144	24.79
> 160	26.31
> 176	24.51
> 192	25.86
> 208	24.35
> 224	26.48
> 240	24.82
> 256	26.38
> 272	24.60
> 288	31.15
> 304	24.61
> 320	26.69
> 336	24.54
> 352	26.23
> 368	24.87
> 384	25.91
> 400	25.74
> 416	26.45
> 432	23.61
> 448	26.44
> 464	24.36
> 480	26.80
> 496	24.60
> 512	26.49
> 
> 
> The graph is attached. (x = readahead && y = MB/s)
> 
> The kernel config for 2.6.0 is attached (for 2.6.1-rc1 I have just used 
> "make oldconfig").
> 
> INFO on my HD:
> 
> /dev/hda:
> 
>  Model=WDC WD200BB-53AUA1, FwRev=18.20D18, SerialNo=WD-WMA6Y1501425
>  Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
>  RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
>  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39102336
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 *udma4 udma5
>  AdvancedPM=no WriteCache=enabled
>  Drive conforms to: device does not report version:  1 2 3 4 5
> 
> INFO on my IDE controller:
> 
> 00:04.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
> Master IDE (rev 10)
> 
> 
> Comments are welcomed.
> 
> Bye,
> 
> 

