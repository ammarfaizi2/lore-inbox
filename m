Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUHYXxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUHYXxS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUHYXxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:53:17 -0400
Received: from [195.23.16.24] ([195.23.16.24]:41147 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S266291AbUHYXu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:50:28 -0400
Message-ID: <412D25C2.6060908@grupopie.com>
Date: Thu, 26 Aug 2004 00:50:26 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
References: <1093406686.412c0fde79d4f@webmail.grupopie.com> <20040825173941.GJ5414@waste.org> <412CDE9D.3090609@grupopie.com> <20040825185854.GP31237@waste.org> <412CE3ED.5000803@grupopie.com> <20040825211248.GQ31237@waste.org>
In-Reply-To: <20040825211248.GQ31237@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.32; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Wed, Aug 25, 2004 at 08:09:33PM +0100, Paulo Marques wrote:
> 
>>diff -uprN -X dontdiff linux-2.6.9-rc1/kernel/kallsyms.c 
>>linux-2.6.9-rc1-kall/kernel/kallsyms.c
>>--- linux-2.6.9-rc1/kernel/kallsyms.c	2004-08-24 23:16:39.000000000 +0100
>>+++ linux-2.6.9-rc1-kall/kernel/kallsyms.c	2004-08-25 
>>03:59:27.000000000 +0100
>>@@ -5,6 +5,12 @@
>>  * module loader:
>>  *   Copyright 2002 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
>>  * Stem compression by Andi Kleen.
> 
> 
> Might as well kill this dangling reference to stem compression.

Will do.

>>+static unsigned int kallsyms_expand_symbol(unsigned int off, char *result)
>>+{
>>+	int len, tlen;
>>+	u8 *tptr, *data;
>>+
>>+	data = &kallsyms_names[off];
>>+	
>>+	len=*data++;
>>+	off += len + 1;
>>+	while(len) {
>>+		tptr=&kallsyms_token_table[kallsyms_token_index[*data]];
>>+		data++;
>>+		len--;
>>+
>>+		tlen=*tptr++;
>>+		while(tlen) {
>>+			*result++=*tptr++;
> 
> 
> Whitespace, please. Vertical and horizontal. Also, this style with
> pointer manipulation tends to be frowned on - it's compact but
> needlessly obscure. Using a couple index variables and for loops would
> make this quite a bit more readable.

Yikes! I didn't release this code. It escaped leaving a trail of blood
in its wake :)  (Klingon programmer)

Consider this fixed, and some comments thrown in, while I'm at it.

>>+static unsigned int get_symbol_offset(unsigned long pos)
>>+{
>>+	u8 *name;
>>+	int i;
>>+
>>+	name = &kallsyms_names[ kallsyms_markers[pos>>8] ];
>>+	for(i = 0; i < (pos&0xFF); i++)
>>+		name = name + (*name) + 1;
> 
> 
> That's a bit magic looking. A brief description of the data structure in this
> vicinity would be appreciated. 

Ok.

>>--- linux-2.6.9-rc1/scripts/kallsyms.c	2004-08-24 23:16:39.000000000 +0100
>>+++ linux-2.6.9-rc1-kall/scripts/kallsyms.c	2004-08-25 
>>03:30:30.000000000 +0100
>>@@ -6,6 +6,13 @@
>>  * of the GNU General Public License, incorporated herein by reference.
>>  *
>>  * Usage: nm -n vmlinux | scripts/kallsyms [--all-symbols] > symbols.S
>>+ *
>>+ * ChangeLog:
>>+ *
>>+ * (25/Aug/2004) Paulo Marques
>>+ *      Changed the compression method from stem compression to "table 
>>lookup"
>>+ *      compression
>>+ *
>>  */
> 
> 
> Throw an address in there so we know where to direct complaints. Also
> a description of "table compression" belongs here.

Ok.

> Generally looks decent, could use a bit more in the way of comments.

The next patch will come with all this fixed. I was actually afraid of
putting in too many comments, that I ended up putting hardly any
comments.

Thanks for all the sugestions,

-- 
Paulo Marques - www.grupopie.com
