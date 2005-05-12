Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVELJmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVELJmW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 05:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVELJmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 05:42:22 -0400
Received: from mgw-ext03.nokia.com ([131.228.20.95]:18833 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP id S261375AbVELJmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 05:42:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C556D6.9AB5F4AA"
Subject: RE: arm: Inconsistent kallsyms data 
Date: Thu, 12 May 2005 12:40:16 +0300
Message-ID: <B21B3447981E7E4E9FB4281B8F50AAE50CDA37@esebe103.NOE.Nokia.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: arm: Inconsistent kallsyms data 
Thread-Index: AcVWspgRjJEkl9/xSbGFbHivKdP1/gAIibDA
From: <Imre.Deak@nokia.com>
To: <kaos@ocs.com.au>
Cc: <linux-kernel@vger.kernel.org>, <sam@ravnborg.org>,
       <pmarques@grupopie.com>
X-OriginalArrivalTime: 12 May 2005 09:40:30.0278 (UTC) FILETIME=[A2B66660:01C556D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C556D6.9AB5F4AA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks! After changing vmlinux.lds.in as you suggest the problem goes
away. The relevant parts in Pass1 and Pass2 now:

Pass1:
D net_table     PTR     0xc02ae4a4
D _edata        PTR     0xc02ae554
B __bss_start   PTR     0xc02ae560
B system_state  PTR     0xc02ae560
B saved_command_line    PTR     0xc02ae564

Pass2:
D net_table     PTR     0xc02ae4a4
D _edata        PTR     0xc02e8a00
B __bss_start   PTR     0xc02e8a20
B system_state  PTR     0xc02e8a20
B saved_command_line    PTR     0xc02e8a24

So the order remains.

The patch for arm is included.

--Imre

> -----Original Message-----
> From: ext Keith Owens [mailto:kaos@ocs.com.au]
> Sent: 12 May, 2005 08:21
> To: Deak Imre (Nokia-M/Helsinki)
> Cc: linux-kernel@vger.kernel.org; Sam Ravnborg; Paulo Marques
> Subject: Re: arm: Inconsistent kallsyms data=20
>=20
> The problem is being caused by alignment padding combined with a sort
> order combined with the token compression in scripts/kallsyms.c.
>=20
> Pass 1 generates this map extract.  Note the gap between _edata and
> __bss_start, this is linker generated padding to start .bss on a 16
> byte boundary.
>=20
> ...
> c02ae4a4 D net_table
> c02ae554 D _edata
> c02ae560 B __bss_start
> c02ae560 B system_state
> c02ae564 B saved_command_line
>=20
> ...
>=20
> Pass 2 defines the kallsyms_* symbols and generates data for them.
> That adds new symbols and increases _edata, all perfectly normal.
>=20
> ...
> c02ae4a4 D net_table
> c02ae560 D kallsyms_addresses
> c02bf6b0 D kallsyms_num_syms
> c02bf6c0 D kallsyms_names
> c02e82b0 D kallsyms_markers
> c02e83d0 D kallsyms_token_table
> c02e8800 D kallsyms_token_index
> c02e8a00 B __bss_start
> c02e8a00 B system_state
> c02e8a00 D _edata
> c02e8a04 B saved_command_line
> ...
>=20
> After adding the kallsyms data in pass 2, there is no longer a gap
> between _edata and __bss_start.  The added kallsyms data moved _edata
> to a 16 byte boundary which removed the need for the linker to add any
> padding.
>=20
> When $(NM) is run to produce the map, the -n option first sorts by
> address, then by symbol type, then by name.  When two symbols like
> _edata and __bss_start have the same address they sort by type.  D
> comes after B which changes the order of the output symbols.  That in
> turn changes the input to the token compression code in
> scripts/kallsyms.c which finally results in different kallsyms output.
>=20
> This problem can only affect the padding between _edata and the start
> of the next section, and only when the amount of padding is=20
> zero in one
> kallsyms pass and non-zero in another.  The simplest solution is to
> change the vmlinux.lds files to add '. =3D . + 1;' between the=20
> definition
> of _edata and the start of the next section.  That ensures that _edata
> never has the same address as the start of the next section and the
> problem goes away.  Of course it means changing 30 vmlinux.lds files,
> but it is the same one line change in all of them.
>=20
>=20

------_=_NextPart_001_01C556D6.9AB5F4AA
Content-Type: application/octet-stream;
	name="arm-kbuildfix-patch.diff"
Content-Transfer-Encoding: base64
Content-Description: arm-kbuildfix-patch.diff
Content-Disposition: attachment;
	filename="arm-kbuildfix-patch.diff"

LS0tIDdmNWM5OWRhODkzNzNkNWI0ZDdjN2MyN2M2MzdmMmU3YzJiYjljNGMvYXJjaC9hcm0vYm9v
dC9jb21wcmVzc2VkL3ZtbGludXgubGRzLmluICAobW9kZToxMDA2NDQpCisrKyB1bmNvbW1pdHRl
ZC9hcmNoL2FybS9ib290L2NvbXByZXNzZWQvdm1saW51eC5sZHMuaW4gIChtb2RlOjEwMDY0NCkK
QEAgLTM3LDYgKzM3LDggQEAKICAgLmRhdGEJCQk6IHsgKiguZGF0YSkgfQogICBfZWRhdGEgPSAu
OwogCisgIC4gPSAuICsgMTsKKwogICAuID0gQlNTX1NUQVJUOwogICBfX2Jzc19zdGFydCA9IC47
CiAgIC5ic3MJCQk6IHsgKiguYnNzKSB9Ci0tLSA3ZjVjOTlkYTg5MzczZDViNGQ3YzdjMjdjNjM3
ZjJlN2MyYmI5YzRjL2FyY2gvYXJtL2tlcm5lbC92bWxpbnV4Lmxkcy5TICAobW9kZToxMDA2NDQp
CisrKyB1bmNvbW1pdHRlZC9hcmNoL2FybS9rZXJuZWwvdm1saW51eC5sZHMuUyAgKG1vZGU6MTAw
NjQ0KQpAQCAtMTQ0LDYgKzE0NCw4IEBACiAJCUNPTlNUUlVDVE9SUwogCiAJCV9lZGF0YSA9IC47
CisKKwkJLiA9IC4gKyAxOwogCX0KIAogCS5ic3MgOiB7Cg==

------_=_NextPart_001_01C556D6.9AB5F4AA--
