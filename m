Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262010AbTCHNXD>; Sat, 8 Mar 2003 08:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262015AbTCHNXD>; Sat, 8 Mar 2003 08:23:03 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:31530 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S262010AbTCHNXC>; Sat, 8 Mar 2003 08:23:02 -0500
Date: Sat, 8 Mar 2003 14:24:49 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Anton Altaparmakov <aia21@cantab.net>, <linux-kernel@vger.kernel.org>,
       <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
In-Reply-To: <20030307100849.7afb53ae.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.30.0303081100420.2790-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Randy.Dunlap wrote:
> On Fri, 7 Mar 2003 18:56:41 +0100 (MET) Szakacsits Szabolcs <szaka@sienet.hu> wrote:
> |
> | It seems (and CONFIG_DEBUG_SPINLOCK also seems to contribute)
> |         init_MUTEX(&ni->mrec_lock);
> | 	        ...
> | 		INIT_LIST_HEAD(...)
>
> OK, I'm fine with closing it as not an NTFS issue or as a tools issue
> or something along those lines.

I took a closer look now:

 EFLAGS: 00010282
 eax: f6c0f080   ebx: 0000416d   ecx: 00010282 edx: f6c0f0f8
 esi: c040b078   edi: f6c0f0f8   ebp: f6dd1dbc esp: f6dd1db4
 ds: 007b   es: 007b   ss: 0068

 3c0:       b9 06 00 00 00          mov    $0x6,%ecx
 ... not important ...
 3cc:       89 d7                   mov    %edx,%edi
 3ce:       89 55 f4                mov    %edx,0xfffffff4(%ebp)
 3d1:       f3 a5                   repz movsl %ds:(%esi),%es:(%edi)
 3d3:       8d 50 78                lea    0x78(%eax),%edx
 3d6:       8b 4d f4                mov    0xfffffff4(%ebp),%ecx
 3d9:       89 51 18                mov    %edx,0x18(%ecx)  ## OOPS ##

So %ecx should be %edi-24 = f6c0f0e0, instead it's EFLAGS. Oops [indeed].
%ebp value is correct, I checked. So it seems a hardware, strong
radiation or an interrupt that didn't restore ecx.

> Thanks for looking into this.

Thanks for reporting.

	Szaka

