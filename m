Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272959AbRIMKOd>; Thu, 13 Sep 2001 06:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272964AbRIMKOX>; Thu, 13 Sep 2001 06:14:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9744 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272967AbRIMKOI>; Thu, 13 Sep 2001 06:14:08 -0400
Message-ID: <3BA086E1.9040605@zytor.com>
Date: Thu, 13 Sep 2001 03:13:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Edgar Toernig <froese@gmx.de>, linux-kernel@vger.kernel.org,
        vojtech@ucw.cz, Hamera Erik <HAMERAE@cs.felk.cvut.cz>
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
In-Reply-To: <20010909220921.A19145@bug.ucw.cz> <20010909170206.A3245@redhat.com> <20010909230920.A23392@atrey.karlin.mff.cuni.cz> <9nh5p0$3qt$1@cesium.transmeta.com> <20010911005318.C822@bug.ucw.cz> <3BA04514.D65EDF98@gmx.de> <20010913120706.C25204@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>I found out I can boot it after little games with mars netware
>>>emulator. However I have problems booting anything else than
>>>freedos. Trying to boot zImage directly results in crc errors or in
>>>errors in compressed data. Too much failures and too repeatable
>>>(althrough ram seems flakey) for me to believe its hw.
>>>
>>I bet that's the same problem I had booting a zImage directly from an
>>El-Torito CD.  The problem was the autoprobing for the floppy type
>>performed by the boot loader.  It detected a 2.88 drive and issued
>>corresponding read requests (track x, 36 blocks; track x+1, 36 blocks;
>>...).  The bios performs these request, but it emulates a 1.44 disk so
>>the last 18 blocks of track x are actually the blocks from track x+1.
>>In my case I did not even got a crc error but an immediate reboot.
>>
>>I removed the autoprobing from bootsect.S and fixed it to 1.44MB format
>>et voila, it worked perfectly.
>>
> 
> Do you have patch to do that?
> 								Pavel

Sure... but he's hard-coding 1.44 MB format.  This behaviour is also 
quite common on for example USB drives; it is simply no longer correct 
to expect the BIOS to reject invalid CHS geometries (if the underlying 
drive is really an LBA drive most if not all BIOSes will simply apply 
the conversion algorithm without limit checks.)

Can we please retire bootsect.S and get on with our lives?  This thing 
is becoming a millstone around our necks!

(For those that don't know, there is no way to determine the CHS 
geometry of floppy media from the BIOS.  The "get geometry" call on a 
floppy drive returns what the drive is capable of, not what the current 
medium is using.  DOS and its relatives don't care, since a FAT 
filesystem includes the CHS geometry in the superblock.)

	-hpa

