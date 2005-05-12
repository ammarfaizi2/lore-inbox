Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVELFVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVELFVz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 01:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVELFVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 01:21:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20140 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261160AbVELFV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 01:21:27 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Imre Deak <imre.deak@nokia.com>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
       Paulo Marques <pmarques@grupopie.com>
Subject: Re: arm: Inconsistent kallsyms data 
In-reply-to: Your message of "Wed, 11 May 2005 12:05:10 +0300."
             <1115802310.9757.20.camel@mammoth.research.nokia.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 May 2005 15:20:42 +1000
Message-ID: <12529.1115875242@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005 12:05:10 +0300, 
Imre Deak <imre.deak@nokia.com> wrote:
>building 2.6.12-rc4 results in "Inconsistent kallsyms data". Setting
>CONFIG_KALLSYMS_EXTRA_PASS=y doesn't help.
>
>I made a diff of .tmp_kallsyms[12].S after converting them to human
>readable form with kallsyms_uncompress.pl .
>
>--- .tmp_kallsyms1.txt	2005-05-11 11:54:50.000000000 +0300
>+++ .tmp_kallsyms2.txt	2005-05-11 11:54:55.000000000 +0300
>@@ -16718,773 +16718,773 @@
> d gss_kerberos_pfs 	PTR	0xc02ae46c
> d gss_kerberos_ops 	PTR	0xc02ae494
> D net_table 	PTR	0xc02ae4a4
>-D _edata 	PTR	0xc02ae554
>-B __bss_start 	PTR	0xc02ae560
>-B system_state 	PTR	0xc02ae560
>.....
>+B __bss_start 	PTR	0xc02e8a00
>+D _edata 	PTR	0xc02e8a00
>+B system_state 	PTR	0xc02e8a00
>...

The problem is being caused by alignment padding combined with a sort
order combined with the token compression in scripts/kallsyms.c.

Pass 1 generates this map extract.  Note the gap between _edata and
__bss_start, this is linker generated padding to start .bss on a 16
byte boundary.

...
c02ae4a4 D net_table
c02ae554 D _edata
c02ae560 B __bss_start
c02ae560 B system_state
c02ae564 B saved_command_line

...

Pass 2 defines the kallsyms_* symbols and generates data for them.
That adds new symbols and increases _edata, all perfectly normal.

...
c02ae4a4 D net_table
c02ae560 D kallsyms_addresses
c02bf6b0 D kallsyms_num_syms
c02bf6c0 D kallsyms_names
c02e82b0 D kallsyms_markers
c02e83d0 D kallsyms_token_table
c02e8800 D kallsyms_token_index
c02e8a00 B __bss_start
c02e8a00 B system_state
c02e8a00 D _edata
c02e8a04 B saved_command_line
...

After adding the kallsyms data in pass 2, there is no longer a gap
between _edata and __bss_start.  The added kallsyms data moved _edata
to a 16 byte boundary which removed the need for the linker to add any
padding.

When $(NM) is run to produce the map, the -n option first sorts by
address, then by symbol type, then by name.  When two symbols like
_edata and __bss_start have the same address they sort by type.  D
comes after B which changes the order of the output symbols.  That in
turn changes the input to the token compression code in
scripts/kallsyms.c which finally results in different kallsyms output.

This problem can only affect the padding between _edata and the start
of the next section, and only when the amount of padding is zero in one
kallsyms pass and non-zero in another.  The simplest solution is to
change the vmlinux.lds files to add '. = . + 1;' between the definition
of _edata and the start of the next section.  That ensures that _edata
never has the same address as the start of the next section and the
problem goes away.  Of course it means changing 30 vmlinux.lds files,
but it is the same one line change in all of them.

