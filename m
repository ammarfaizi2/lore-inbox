Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVG1Kny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVG1Kny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 06:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVG1Kl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 06:41:59 -0400
Received: from [195.23.16.24] ([195.23.16.24]:45237 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261406AbVG1KkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 06:40:16 -0400
Message-ID: <42E8B60C.9070703@grupopie.com>
Date: Thu, 28 Jul 2005 11:40:12 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: "J.A. Magallon" <jamagallon@able.es>, Sam Ravnborg <sam@ravnborg.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signed char fixes for scripts
References: <1121465068l.13352l.0l@werewolf.able.es>	 <1121465683l.13352l.5l@werewolf.able.es>	 <20050727202757.GB31180@mars.ravnborg.org>	 <1122507398l.19829l.0l@werewolf.able.es>  <42E8AD47.6010501@grupopie.com> <1122545777.16156.59.camel@tara.firmix.at>
In-Reply-To: <1122545777.16156.59.camel@tara.firmix.at>
Content-Type: multipart/mixed;
 boundary="------------000000060309090802060900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000000060309090802060900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bernd Petrovitsch wrote:
> On Thu, 2005-07-28 at 11:02 +0100, Paulo Marques wrote:
>>J.A. Magallon wrote:
>>[...]
>>>All the problems are born here:
>>>
>>>struct sym_entry {
>>>    unsigned long long addr;
>>>    unsigned int len;
>>>    unsigned char *sym;
>>>};
>>
>>What are you guys talking about?
> 
> "unsigned char *" is simply the wrong type for mere text strings. "char
> *" ist the corrrect one. These are BTW two completely different types
> (yes, "char" can be promoted into an "unsigned char" but essentially
> these are two completely different types like "int" and "long long *").

You're comming really late in this thread :)

The problem is that "sym" isn't really a string. It starts out as a 
string, but as the compression scheme begins to work it just becomes a 
"bunch of bytes" using all the values in the range 0-255 for which 
unsigned char is the perfect type.

Since only the loading of the symbols use string functions, and all the 
compression process treats these as bytes, it seemed better to treat 
them as unsigned chars and just typecast the first few uses.

The union suggested by J.A.Magallon might be a reasonable solution, but 
we only need 4 casts in the 500 lines of code of scripts/kallsyms.c to 
solve all problems, so this seems really overkill.

>>Is my compiler version the problem (3.3.2), or are you testing with the 
> 
> Compiler version - zse gcc-4.*.

Yes, I know J.A.Magallon is trying to silence the warnings of gcc 4.0, 
but as I understood it, gcc 3 would also complain of the same problems 
if -Wsign-compare were specified. It was just that gcc4 would complain 
even without -Wsign-compare.

So the question is: is gcc4 complaining about signedness problems that 
gcc3 doesn't, even with -Wsign-compare?

Now that I look at the source, I can see that it must be complaining! 
There are still 3 calls to strcmp that use sym directly, and gcc3 
doesn't say a thing.

I thought that these were already taken care of. In any cased the 
attached patch should fix those and make the code more readable too. 
With this patch we end up only having 2 casts to (char *) in the whole 
source.

Can someone with gcc 4 apply this to the latest -mm and check that it 
fixes everything?

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams

--------------000000060309090802060900
Content-Type: text/x-patch;
 name="kallsyms_sign.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kallsyms_sign.patch"

--- ./scripts/kallsyms.c.orig	2005-07-28 11:31:29.000000000 +0100
+++ ./scripts/kallsyms.c	2005-07-28 11:33:58.000000000 +0100
@@ -150,11 +150,13 @@ static int symbol_valid(struct sym_entry
 		"_SDA2_BASE_",		/* ppc */
 		NULL };
 	int i;
-	int offset = 1;
+	char *name;
+
+	name = (char *) s->sym + 1;
 
 	/* skip prefix char */
-	if (symbol_prefix_char && *(s->sym + 1) == symbol_prefix_char)
-		offset++;
+	if (symbol_prefix_char && *name == symbol_prefix_char)
+		name++;
 
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
@@ -169,18 +171,18 @@ static int symbol_valid(struct sym_entry
 		 * move then they may get dropped in pass 2, which breaks the
 		 * kallsyms rules.
 		 */
-		if ((s->addr == _etext && strcmp(s->sym + offset, "_etext")) ||
-		    (s->addr == _einittext && strcmp(s->sym + offset, "_einittext")) ||
-		    (s->addr == _eextratext && strcmp(s->sym + offset, "_eextratext")))
+		if ((s->addr == _etext && strcmp(name, "_etext")) ||
+		    (s->addr == _einittext && strcmp(name, "_einittext")) ||
+		    (s->addr == _eextratext && strcmp(name, "_eextratext")))
 			return 0;
 	}
 
 	/* Exclude symbols which vary between passes. */
-	if (strstr((char *)s->sym + offset, "_compiled."))
+	if (strstr(name, "_compiled."))
 		return 0;
 
 	for (i = 0; special_symbols[i]; i++)
-		if( strcmp((char *)s->sym + offset, special_symbols[i]) == 0 )
+		if( strcmp(name, special_symbols[i]) == 0 )
 			return 0;
 
 	return 1;

--------------000000060309090802060900--
