Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130336AbRADTns>; Thu, 4 Jan 2001 14:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130232AbRADTni>; Thu, 4 Jan 2001 14:43:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:45440 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130198AbRADTn1>; Thu, 4 Jan 2001 14:43:27 -0500
Date: Thu, 4 Jan 2001 14:42:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mo McKinlay <mmckinlay@gnu.org>
cc: David Lang <david.lang@digitalinsight.com>, Chris Wedgwood <cw@f00f.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@innominate.de>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <Pine.LNX.4.30.0101041820200.967-100000@nvws005.nv.london>
Message-ID: <Pine.LNX.3.95.1010104140542.17050A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Mo McKinlay wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Today, David Lang (david.lang@digitalinsight.com) wrote:
> 
>   > On Thu, 4 Jan 2001, Mo McKinlay wrote:
>   >
>   > >   > The off button need not and _does not_ remove power instantly (if at
>   > >   > all) on many appliances.
>   > >
>   > > Indeed - but unplugging your VCR from the wall won't harm it. Everyone
>   > > knows the power button on a TV/VCR/etc doesn't actually kill the power,
>   > > just reduce consumption (i.e., standby mode). But unplugging it at the
>   > > wall doesn't have any detrimental effects - doing that to a PC will.
>   >
>   > if you change that statement to "usually won't harm it" I agree with you
>   > (I have had a VCR eat a tape when this was done)
> 
> Crikey. Most people would consider that a fault in the VCR.
> 
> Just goes to show how far removed from appliances PCs currently are.
> 

A nice "brand-name" Network-centric printer (with an IP address) requires
that you "save" the parameters in NVRAM. If you pull the plug during
this operation, it comes up with its default IP and you have to do
it again. A mobile-phone that runs out of battery power will also
lose all the phone numbers you have stored, etc. The same is true
for most all embedded systems that save data.

A file-system is a bit more sophisticated. You can design it so
that no "known" corruption occurs. A simple, but not fast method
would be to never actually modify an existing file. Instead, when
an existing file is opened for write, a copy is created. All new
work is done on the copy (which is probably invisible at the time).
Once the file is closed, and all buffers written, the new file
replaces the old. This has to be done in a manner in which a
power-failure at any time will leave you with either file, but
not both. This requires a journal to show how far you've gotten
into the 'rename' operation. A corrupted journal just leaves
you with the old file. This same idea can be modularized into
file-sections that are much smaller than an entire file. In this
manner, the working file that is actually accessed will always
seem to be perfect, although your last N-seconds of updates may
have been lost to the power failure. This means that the data-base
software has to roll-back and redo the temporarily-lost updates
when it restarts. It uses the journal to accomplish this. As
N-seconds gets smaller, the overhead necessary to maintain data
consistency gets greater, so there are trade-offs.

In the case of NVRAM data, the printer software could have been
designed to survive a power failure even though a cursory look
at the way NVRAM operates may make it seem impossible. To write
NVRAM, you erase if first. If you have a power-failure at this
time, all is lost --not. You just need to erase sectors (pages),
or have two NVRAM devices. Part of the data saved, is a number
that increases during each save operation. The CPU software
gets its parameters from the latest (highest number). 

A journaling file-system also needs some number to show the
order of operations so that roll-backs and restarts work.
Unfortunately, the systems that I have seen all use time for
the number! You don't want time to reconstruct 'order'. You
need a number that represents 'order'. Time is not your friend.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
