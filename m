Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314210AbSDVOX4>; Mon, 22 Apr 2002 10:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314211AbSDVOXz>; Mon, 22 Apr 2002 10:23:55 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:49312 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S314210AbSDVOXy>; Mon, 22 Apr 2002 10:23:54 -0400
Message-ID: <3CC41AC6.BD8E32E4@austin.ibm.com>
Date: Mon, 22 Apr 2002 09:14:31 -0500
From: James L Peterson <peterson@austin.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulus@samba.org
CC: "David S. Miller" <davem@redhat.com>, anton@au.ibm.com, mj@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: PowerPC Linux and PCI
In-Reply-To: <OF8A238806.80D1511C-ON87256B75.00773B75@boulder.ibm.com>
		<20020307220318.GA4664@haven>
		<3CC08DFF.787F6E54@austin.ibm.com>
		<20020419.143839.15920500.davem@redhat.com> <15553.12447.849592.261245@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't overlooked the fact that the pci_read_config_dword will
do the byte swapping.  But it will do the byte_swapping for a
dword (32-bits), not for two words (16-bits), and the byte-swapping
for 32-bits is not the same as for two words.

Specifically:

Little-endian dword:

          3    2      1    0
         80  86    71 11

when read in by the pci_read_config_dword,  will swap it to :

        0    1      2     3
        11 71     86  80

For little endian you get device id (bytes 2,3) as 0x8086,
and vendor id of 0x7111.  For big endian you get device
id of 0x7111 and vendor id of 0x8086.

The pci_read_config_dword works just fine for dword
data types, like the base addresses.  But the fundamental
rule of big-endian/little-endian code is that you have to
know the size of the data type that you are working with,
so that you can byte swap properly.  Reading a dword
(and byte-swapping for a dword) is not the same as
reading two words (and byte-swapping them as words).

jim



Contrast this with replacing the read_config_dword with
reading two words:

Instead of:

if (pci_read_config_dword(temp, PCI_VENDOR_ID, &l))
  return NULL;
     ....
  memcpy(dev, temp, sizeof(*dev));
 dev->vendor = l & 0xffff;
 dev->device = (l >> 16) & 0xffff;

It would seem that we need:

 if (pci_read_config_word(temp, PCI_VENDOR_ID, &vendor))
  return NULL;
 if (pci_read_config_word(temp, PCI_DEVICE_ID, &device))
  return NULL;



Paul Mackerras wrote:

> David S. Miller writes:
>
> >    From: James L Peterson <peterson@austin.ibm.com>
> >    Date: Fri, 19 Apr 2002 16:37:03 -0500
> >
> >    if (pci_read_config_dword(temp, PCI_VENDOR_ID, &l))
> >      return NULL;
> >         ....
> >      memcpy(dev, temp, sizeof(*dev));
> >     dev->vendor = l & 0xffff;
> >     dev->device = (l >> 16) & 0xffff;
> >
> >    It seems to me this is incorrect for a big-endian machine
> >    (like PowerPC).  If we read the two 16-bit parts out of the
> >    first 32-bit part, we will end up with:
> >
> > pci_read_config_dword should do the byte swapping on &l for
> > the caller, fix your pci_{read,write}_config_*() arch implementation.
>
> It does, that's why it all works. :)  James Peterson seems to have
> missed this fact, hence his confusion.
>
> Paul.

