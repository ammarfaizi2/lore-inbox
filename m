Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbTBJKAd>; Mon, 10 Feb 2003 05:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbTBJKAd>; Mon, 10 Feb 2003 05:00:33 -0500
Received: from copper.ftech.net ([212.32.16.118]:26297 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id <S264863AbTBJKAb>;
	Mon, 10 Feb 2003 05:00:31 -0500
Message-ID: <7C078C66B7752B438B88E11E5E20E72E0EF6E5@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Anything change in /proc file system in 2.2.22
Date: Mon, 10 Feb 2003 10:10:07 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I have a module (device driver) that creates an entry in the /proc
file system to record information about the hardware that was found when the
driver initialised.  Then later a startup script reads the /proc entry and
uses the information to load each card with firmware.  This has all worked
fine for 2.2.x Kernels up to 2.2.21 and still works fine with the latest
2.4.x Kernel, however things seem to have gone awry in 2.2.22 and 2.2.23.

This is what the /proc entry contains:

kevinc@doctor:~/tmp$ more /proc/fsx25 
4 cards installed

fsx0: FarSync T1U irq=11 mem=0xF4000000,0x1000,0xF4400000 reset
        NCB users 0
fsx1: FarSync T2U irq=3 mem=0xF4100000,0x1400,0xF4400800 reset
        NCB users 0
fsx2: FarSync T2P irq=10 mem=0xF4200000,0x1C00,0xF4401000 reset
        NCB users 0
fsx3: FarSync T4P irq=9 mem=0xF4300000,0x2800,0xF4401800 reset
        NCB users 0

This is a minimised script that reads the /proc entry

kevinc@doctor:~/tmp$ more test
        count=0

        # Read in the card status list and process each card in turn
        while read label series card irq mem state
        do
            echo "line $count $label $series $card $irq $mem $state"
            count=`expr $count + 1`
        done < /proc/fsx25

and this is the output I get

kevinc@doctor:~/tmp$ ./test
line 0 4 cards installed   
line 1 mem=0xF4100000,0x1400,0xF4400800 NCB access OK  
line 2 OK     

If I copy /proc/fsx25 to /tmp/fsx25 and modify the script to get input from
/tmp/fsx25 I get

kevinc@doctor:~/tmp$ ./test
line 0 4 cards installed   
line 1      
line 2 fsx0: FarSync T1U irq=11 mem=0xF4000000,0x1000,0xF4400000 reset
line 3 NCB users 0   
line 4 fsx1: FarSync T2U irq=3 mem=0xF4100000,0x1400,0xF4400800 reset
line 5 NCB users 0   
line 6 fsx2: FarSync T2P irq=10 mem=0xF4200000,0x1C00,0xF4401000 reset
line 7 NCB users 0   
line 8 fsx3: FarSync T4P irq=9 mem=0xF4300000,0x2800,0xF4401800 reset
line 9 NCB users 0   

Anybody got any idea what has changed here?


Kevin
