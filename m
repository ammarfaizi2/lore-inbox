Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSKCT3p>; Sun, 3 Nov 2002 14:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262365AbSKCT3p>; Sun, 3 Nov 2002 14:29:45 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:11536 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262360AbSKCT3n>; Sun, 3 Nov 2002 14:29:43 -0500
Message-Id: <200211031931.gA3JV4p29144@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Date: Sun, 3 Nov 2002 22:23:01 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>
References: <200211031322.gA3DMTp28125@Port.imtp.ilyichevsk.odessa.ua> <3700332466.1036308224@[10.10.2.3]>
In-Reply-To: <3700332466.1036308224@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 November 2002 13:23, Martin J. Bligh wrote:
> > Here is the cure: force_inline will guarantee inlining.
> >
> > To use _only_ with functions which meant to be almost
> > optimized away to nothing but are large and gcc might decide
> > they are _too_ large for inlining.
>
> So aside from the ugliness of code, which one actually runs faster?

This can *never* run faster non-inlined because it is called with
n being compile time constant:

static inline void * __constant_memcpy(void * to, const void * from, size_t n)
{
	switch (n) {
		case 0:
			return to;
		case 1:
			*(unsigned char *)to = *(const unsigned char *)from;
			return to;
		case 2:
			*(unsigned short *)to = *(const unsigned short *)from;
			return to;
		case 3:
			*(unsigned short *)to = *(const unsigned short *)from;
			*(2+(unsigned char *)to) = *(2+(const unsigned char *)from);
			return to;
		case 4:
			*(unsigned long *)to = *(const unsigned long *)from;
			return to;
		case 6:	/* for Ethernet addresses */
			*(unsigned long *)to = *(const unsigned long *)from;
			*(2+(unsigned short *)to) = *(2+(const unsigned short *)from);
			return to;
		case 8:
			*(unsigned long *)to = *(const unsigned long *)from;
			*(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
			return to;
		case 12:
			*(unsigned long *)to = *(const unsigned long *)from;
			*(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
			*(2+(unsigned long *)to) = *(2+(const unsigned long *)from);
			return to;
		case 16:
			*(unsigned long *)to = *(const unsigned long *)from;
			*(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
			*(2+(unsigned long *)to) = *(2+(const unsigned long *)from);
			*(3+(unsigned long *)to) = *(3+(const unsigned long *)from);
			return to;
		case 20:
			*(unsigned long *)to = *(const unsigned long *)from;
			*(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
			*(2+(unsigned long *)to) = *(2+(const unsigned long *)from);
			*(3+(unsigned long *)to) = *(3+(const unsigned long *)from);
			*(4+(unsigned long *)to) = *(4+(const unsigned long *)from);
			return to;
	}
#define COMMON(x) \
__asm__ __volatile__( \
	"rep ; movsl" \
	x \
	: "=&c" (d0), "=&D" (d1), "=&S" (d2) \
	: "0" (n/4),"1" ((long) to),"2" ((long) from) \
	: "memory");
{
	int d0, d1, d2;
	switch (n % 4) {
		case 0: COMMON(""); return to;
		case 1: COMMON("\n\tmovsb"); return to;
		case 2: COMMON("\n\tmovsw"); return to;
		default: COMMON("\n\tmovsw\n\tmovsb"); return to;
	}
}
--
vda
