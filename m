Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263984AbUD0Kh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbUD0Kh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 06:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbUD0Kh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 06:37:29 -0400
Received: from imap.gmx.net ([213.165.64.20]:16010 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263984AbUD0Kh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 06:37:26 -0400
X-Authenticated: #21910825
Message-ID: <408E37D9.7030804@gmx.net>
Date: Tue, 27 Apr 2004 12:37:13 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
CC: Rusty Russell <rusty@rustcorp.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <408DC0E0.7090500@gmx.net> <Pine.LNX.4.58.0404262116510.19703@ppc970.osdl.org> <1083045844.2150.105.camel@bach> <20040427092159.GC29503@lug-owl.de>
In-Reply-To: <20040427092159.GC29503@lug-owl.de>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:
> On Tue, 2004-04-27 16:04:06 +1000, Rusty Russell <rusty@rustcorp.com.au>
> wrote in message <1083045844.2150.105.camel@bach>:
> 
>>On Tue, 2004-04-27 at 14:31, Linus Torvalds wrote:
>>diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31262-linux-2.6.6-rc2-bk4/include/linux/module.h .31262-linux-2.6.6-rc2-bk4.updated/include/linux/module.h
>>--- .31262-linux-2.6.6-rc2-bk4/include/linux/module.h	2004-04-22 08:03:55.000000000 +1000
>>+++ .31262-linux-2.6.6-rc2-bk4.updated/include/linux/module.h	2004-04-27 15:52:19.000000000 +1000
>>@@ -61,7 +64,14 @@ void sort_main_extable(void);
>> #ifdef MODULE
>> #define ___module_cat(a,b) __mod_ ## a ## b
>> #define __module_cat(a,b) ___module_cat(a,b)
>>+/* Some sick fucks embeded NULs in MODULE_LICENSE to circumvent checks. */
>>+#define __MODULE_INFO_CHECK(info)					  \
>>+	static void __init __attribute_used__				  \
>>+	__module_cat(__mc_,__LINE__)(void) {				  \
>>+		BUILD_BUG_ON(__builtin_strlen(info) + 1 != sizeof(info)); \
>>+	}
>> #define __MODULE_INFO(tag, name, info)					  \
>>+__MODULE_INFO_CHECK(info);						  \
>> static const char __module_cat(name,__LINE__)[]				  \
>>   __attribute_used__							  \
>>   __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
> 
> 
> Erm, that's a pure compile-time check, which the companies can remove.
> So they can still put their fucked up license string into the module,
> customer's kernel won't detect it.
> 
> So I'm full for embedding the supplied string's size into the module, or
> some compile-time generated checksum. We need something that can be
> checked at module load time, not at compile time, or do I misread the
> code?

# objdump -t forcedeth.ko |grep '\.modinfo'|sort
00000000 l    d  .modinfo       00000000
00000000 l     O .modinfo       0000000c __mod_license1618
00000020 l     O .modinfo       00000036 __mod_description1617
00000060 l     O .modinfo       00000031 __mod_author1616
000000a0 l     O .modinfo       00000047 __mod_max_interrupt_work1614
00000100 l     O .modinfo       0000002b __mod_alias58
00000140 l     O .modinfo       0000002b __mod_alias57
00000180 l     O .modinfo       0000002b __mod_alias56
000001ab l     O .modinfo       00000009 __module_depends
000001c0 l     O .modinfo       0000002d __mod_vermagic5

Wouldn't it be possible to check the length info from the module symbol
table and compare it with the strlen for the corresponding symbol? If that
gives us a mismatch, refuse to load the module (or mark it as
proprietary). Additionally, check that nothing but NULLs is used as
padding between the strings.

This way, the module format doesn't change, but we can do additional
verification in the loader.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

