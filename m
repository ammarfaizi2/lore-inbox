Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315101AbSDWICc>; Tue, 23 Apr 2002 04:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315102AbSDWICb>; Tue, 23 Apr 2002 04:02:31 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:60588 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315101AbSDWIC2>;
	Tue, 23 Apr 2002 04:02:28 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15557.5295.921549.964163@argo.ozlabs.ibm.com>
Date: Tue, 23 Apr 2002 18:00:47 +1000 (EST)
To: James L Peterson <peterson@austin.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, anton@au.ibm.com, mj@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: PowerPC Linux and PCI
In-Reply-To: <3CC41AC6.BD8E32E4@austin.ibm.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James L Peterson writes:

> I haven't overlooked the fact that the pci_read_config_dword will
> do the byte swapping.  But it will do the byte_swapping for a
> dword (32-bits), not for two words (16-bits), and the byte-swapping
> for 32-bits is not the same as for two words.

The host bridge should preserve the byte numbering, i.e. byte address
0 on the host side should access byte 0 on the PCI side, not byte 3.
In your example:

> Specifically:
> 
> Little-endian dword:
> 
>           3    2      1    0
>          80  86    71 11

So we have byte[0] = 0x11, byte[1] = 0x71, byte[2] = 86, byte[3] =
0x80, right?  If we read individual bytes we will get the same results
on a little-endian or a big-endian platform.

> when read in by the pci_read_config_dword,  will swap it to :
> 
>         0    1      2     3
>         11 71     86  80
> 
> For little endian you get device id (bytes 2,3) as 0x8086,
> and vendor id of 0x7111.  For big endian you get device
> id of 0x7111 and vendor id of 0x8086.

On a little endian platform, pci_read_config_dword will return
0x80867111, since byte 0 is the least-significant byte.  Thus we have
vendor id = 0x7111 and device-id = 0x8086.

On a big-endian platform a 32-bit read will return 0x11718680 (since
byte 0 is the most significant byte), and pci_read_config_dword will
byte-swap that to 0x80867111.  Thus we once again have vendor id =
0x7111 and device-id = 0x8086.

> The pci_read_config_dword works just fine for dword
> data types, like the base addresses.  But the fundamental
> rule of big-endian/little-endian code is that you have to
> know the size of the data type that you are working with,
> so that you can byte swap properly.  Reading a dword
> (and byte-swapping for a dword) is not the same as
> reading two words (and byte-swapping them as words).

You do in fact get the same effect because of the invariance of the
individual byte addresses.

Doesn't the fact that people have been successfully using PCI devices
in PowerPC machines since 1995 or 1996 suggest to you that it might be
your understanding that is faulty rather than the code? :)

Paul.
