Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbSKWQSo>; Sat, 23 Nov 2002 11:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267019AbSKWQSo>; Sat, 23 Nov 2002 11:18:44 -0500
Received: from rezznor.smb.utfors.se ([195.58.112.22]:60382 "EHLO
	rezznor.smb.utfors.se") by vger.kernel.org with ESMTP
	id <S266998AbSKWQSk>; Sat, 23 Nov 2002 11:18:40 -0500
Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Brian Murphy" <brian@murphy.dk>, <linux-kernel@vger.kernel.org>
Cc: "Matt Domsch" <Matt_Domsch@Dell.com>
Subject: RE: [PATCH 2.5] crc32 static initialization
Date: Sat, 23 Nov 2002 17:25:49 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLEEEEFIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C29315.5D9C5D00"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
In-Reply-To: <3DDE92B2.20605@murphy.dk>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C29315.5D9C5D00
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Joakim Tjernlund wrote:
> 
> >Hi Brian
> >
> >Would you please also add the CRC32 patch I sent you earlier?
> >It is much faster.
> >
> >  
> >
> Can you test the attached patch - especially on a big endian system. It 
> should
> do the required thing, i.e. what you want and what I want :-) 
> simultaneously.
> 
> /Brian

Hi Brian 

Got some spare time so here I go:

I have tested the new CRC32 patch on my big endian CPU(mpc860) in
linux 2.4. Since the Makefiles look different in 2.4 vs. 2.5 I built and ran 
gen_crctable.c manually, so I can not comment on the Makefile changes.

Also, testing this in 2.4 makes it hard to generate a new 2.5 patch, so 
I will just comment and send the whole file(se below)

Found this:
 
   crc32.c in crc32_be(): crc32table_le should be crc32table_be
   
   gen_crc32table.c: 
     htole()/htobe() stuff does not work when cross compiling and target endian
     != build endian.

     I fixed this and a new gen_crc32table.c is attached.

    Finally, I think the new local crc32.h should be renamed to crc32defs.h to
    avoid confusion with the real linux/crc32.h.

 Jocke
------=_NextPart_000_0000_01C29315.5D9C5D00
Content-Type: application/octet-stream;
	name="gen_crc32table.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="gen_crc32table.c"

#include <stdio.h>=0A=
#include "crc32.h"=0A=
#include <sys/types.h>=0A=
=0A=
#define LE_TABLE_SIZE (1 << CRC_LE_BITS)=0A=
#define BE_TABLE_SIZE (1 << CRC_BE_BITS)=0A=
=0A=
static u_int32_t crc32table_le[LE_TABLE_SIZE];=0A=
static u_int32_t crc32table_be[BE_TABLE_SIZE];=0A=
=0A=
/**=0A=
 * crc32init_le() - allocate and initialize LE table data=0A=
 *=0A=
 * crc is the crc of the byte i; other entries are filled in based on the=0A=
 * fact that crctable[i^j] =3D crctable[i] ^ crctable[j].=0A=
 *=0A=
 */=0A=
static void crc32init_le(void)=0A=
{=0A=
	unsigned i, j;=0A=
	u_int32_t crc =3D 1;=0A=
=0A=
	crc32table_le[0] =3D 0;=0A=
=0A=
	for (i =3D 1 << (CRC_LE_BITS - 1); i; i >>=3D 1) {=0A=
		crc =3D (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);=0A=
		for (j =3D 0; j < LE_TABLE_SIZE; j +=3D 2 * i)=0A=
			crc32table_le[i + j] =3D crc ^ crc32table_le[j];=0A=
	}=0A=
}=0A=
=0A=
/**=0A=
 * crc32init_be() - allocate and initialize BE table data=0A=
 */=0A=
static void crc32init_be(void)=0A=
{=0A=
	unsigned i, j;=0A=
	u_int32_t crc =3D 0x80000000;=0A=
=0A=
	crc32table_be[0] =3D 0;=0A=
=0A=
	for (i =3D 1; i < BE_TABLE_SIZE; i <<=3D 1) {=0A=
		crc =3D (crc << 1) ^ ((crc & 0x80000000) ? CRCPOLY_BE : 0);=0A=
		for (j =3D 0; j < i; j++)=0A=
			crc32table_be[i + j] =3D crc ^ crc32table_be[j];=0A=
	}=0A=
}=0A=
=0A=
static void output_table(u_int32_t table[], int len)=0A=
{=0A=
	int i;=0A=
=0A=
	for (i =3D 0; i < len - 1; i++) {=0A=
		if (i % 6 =3D=3D 0)=0A=
			printf("\n");=0A=
		printf("0x%8.8xL, ", table[i]);=0A=
	}=0A=
	printf("0x%8.8xL\n", table[len - 1]);=0A=
}=0A=
=0A=
static void output_table_endian(u_int32_t table[], int len, char =
endian_str[])=0A=
{=0A=
	int i;=0A=
			=0A=
	for (i =3D 0; i < len; i++) {=0A=
		if (i % 4 =3D=3D 0)=0A=
			printf("\n");=0A=
		printf("%s0x%8.8xL), ", endian_str, table[i]);=0A=
	}=0A=
	printf("\n");=0A=
}=0A=
=0A=
int main(int argc, char** argv)=0A=
{=0A=
	printf("/* this file is generated - do not edit */\n\n");=0A=
=0A=
	if (CRC_LE_BITS > 1) {=0A=
		crc32init_le();=0A=
		printf("const static u32 crc32table_le[] =3D {");=0A=
		if(CRC_LE_BITS =3D=3D 8){=0A=
			printf("\n#define tole32(x) __constant_cpu_to_le32(x)");=0A=
			output_table_endian(crc32table_le, BE_TABLE_SIZE, "tole32(");=0A=
		} else=0A=
			output_table(crc32table_le, LE_TABLE_SIZE);=0A=
		printf("};\n");=0A=
	}=0A=
=0A=
	if (CRC_BE_BITS > 1) {=0A=
		crc32init_be();=0A=
		printf("const static u32 crc32table_be[] =3D {");=0A=
		if(CRC_BE_BITS =3D=3D 8){=0A=
			printf("\n#define tobe32(x) __constant_cpu_to_be32(x)");=0A=
			output_table_endian(crc32table_be, BE_TABLE_SIZE, "tobe32(");=0A=
		} else=0A=
			output_table(crc32table_be, BE_TABLE_SIZE);=0A=
		printf("};\n");=0A=
	}=0A=
=0A=
	return 0;=0A=
}=0A=

------=_NextPart_000_0000_01C29315.5D9C5D00--


