Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284264AbSCCNVd>; Sun, 3 Mar 2002 08:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbSCCNVN>; Sun, 3 Mar 2002 08:21:13 -0500
Received: from fungus.teststation.com ([212.32.186.211]:23309 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S284264AbSCCNVJ>; Sun, 3 Mar 2002 08:21:09 -0500
Date: Sun, 3 Mar 2002 14:21:02 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
cc: Cyrille Chepelov <cyrille@chepelov.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] smbfs codepage fixes for 2.4.18
In-Reply-To: <E16h45n-0005bn-00@mrvdomng1.kundenserver.de>
Message-ID: <Pine.LNX.4.33.0203021243170.25101-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Mar 2002, Christian Bornträger wrote:

> my smb.conf:
> character set = ISO8859-1
> client code page = 850

smbmount does not use smb.conf for these values.

It does matter what/if the server has as "client code page" and your
client must use matching settings. Either with the codepage/iocharset 
mount options or what was set as default in make *config.


> But I think, that my local code page is actually 8859-15 (I have euro-support 
> so it has to be 15)
> Is that a problem? AFAIK the only difference between 1 and 15 is the 
> Euro-sign.

I count 8 differences in the codepage->unicode mapping in the kernel.

Even if you pick the correct mappings you can get errors where the server
is failing to convert its unicode chars into codepage chars.

http://marc.theaimsgroup.com/?t=96709071500001&r=1&w=2
http://marc.theaimsgroup.com/?l=samba&m=96835905219782&w=2

What might be 0x00a8 (DIAERESIS) or 0x0308 (COMBINING DIAERESIS) is mapped
into 0x22 by the server, smbfs sees 0x22 and uses that for open requests
and others. The server then complains because 0x22 doesn't match 0x00a8
(or whatever that char is on the server side).

I have added 3 patches for 2.4.18 to my smbfs page:
    http://www.hojdpunkten.ac.se/054/samba/index.html

00 - fixes the oopses on failed codepages, now maps failed conversions
     into :## strings for debugging.
01 - adds LFS
02 - adds Unicode support

For 01 and 02 you need to patch samba and add some extra options when 
mounting to activate them. Details on the page.


> If I run a find over all shares I still get some rare:
> 
> smb_proc_readdir_long: name=directory\*, result=-13, rcls=1, err=5
> smb_proc_readdir_long: name=directory\*, result=-2, rcls=1, err=2

Access denied, permissions on the server?
File not found, probably a char translation error.

/Urban

