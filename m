Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316891AbSEVIlv>; Wed, 22 May 2002 04:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316893AbSEVIlv>; Wed, 22 May 2002 04:41:51 -0400
Received: from mx1.mail.ru ([194.67.57.11]:11020 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id <S316891AbSEVIlu>;
	Wed, 22 May 2002 04:41:50 -0400
Date: Wed, 22 May 2002 12:41:16 +0400
From: Nick Kurshev <nickols_k@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: /dev/port BUG and possible workaround
Message-Id: <20020522124116.680f59b8.nickols_k@mail.ru>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: "!)vNpG9Y185-O2<eVyyJ~0qRR)*F6cqQ~4M1t&#ySm7U`/2^cu]w9ue;1a%V[PI9rrNv&) 'SWe=9[7:A?Ku[t,{?*J*`Wfay.pSsvyg2)DXl.M%;-yrV0)pL;(yzPs#(8M|dYuB3%(/}#
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.iErC)5kjTdKk_M"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.iErC)5kjTdKk_M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello!

It seems that I've found out bug in subj
(sorry if this subj was already discussed here)

looking at sources of drivers/char/mem.c I found out:

static ssize_t read_port(struct file * file, char * buf,
			 size_t count, loff_t *ppos)
{
	unsigned long i = *ppos;
[snip]
	while (count-- > 0 && i < 65536) {
		if (__put_user(inb(i),tmp) < 0) 
			return -EFAULT;  
[snip]
}

static ssize_t write_port(struct file * file, const char * buf,
			  size_t count, loff_t *ppos)
{
	unsigned long i = *ppos;
[snip]
	while (count-- > 0 && i < 65536) {
		char c;
		if (__get_user(c, tmp)) 
			return -EFAULT; 
		outb(c,i);
[snip]
}

Well, when I'm trying to use this device in the way:
  lseek(port_fd,port_idx,SEEK_SET);
  write(port_fd,&val32,4);
I get perfectly broken results due outl() != outb()*4
Please look at logs:
1. Correct log with using of inport/outport:
outb(CF8,0)
outb(CFA,0)
FF=inb(CF8)
FF=inb(CFA)
80FFFFFC=inl(CF8)
outl(CF8,80000000)
80000000=inl(CF8)
outl(CF8,80FFFFFC)
outl(CF8,80000000)
3051106=inl(CFC)
outl(CF8,80000004)
22100006=inl(CFC)
outl(CF8,80000008)
6000003=inl(CFC)
outl(CF8,8000000C)
800=inl(CFC)
2. Wrong log with using of /dev/port:
outb(CF8,0)
outb(CFA,0)
FF=inb(CF8)
FF=inb(CFA)
FFFFFFFF=inl(CF8)
outl(CF8,80000000)
FFFFFFFF=inl(CF8)
outl(CF8,FFFFFFFF)

As possible workaround it would be better to examine size of
buffer and use corresponded insn within of these functions:
switch(size)
{
case 4: outl
case 2: outw
default: outb
}

But it seems that nobody uses this device. Then what is goal
of implementing of this device?

Best regards! Nick

--=.iErC)5kjTdKk_M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE861muB/1cNcrTvJkRAqw3AJ9gTKieh2BP0eFuCLYn+2OPsQmYpACg8aUW
IzZh5qyVYGwngVFT2qTxC3U=
=lzOw
-----END PGP SIGNATURE-----

--=.iErC)5kjTdKk_M--

