Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318022AbSGWKqy>; Tue, 23 Jul 2002 06:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318025AbSGWKqy>; Tue, 23 Jul 2002 06:46:54 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:24742 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S318022AbSGWKqx>;
	Tue, 23 Jul 2002 06:46:53 -0400
Date: Tue, 23 Jul 2002 12:49:56 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207231049.MAA16464@harpo.it.uu.se>
To: romieu@cogenit.fr, support@promise.com.tw
Subject: Re: [PATCH] 2.4.19-rc2-ac2 pdc202xx.c update
Cc: hanky@promise.com.tw, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2002 09:19:15 +0200, Francois Romieu wrote:
>support <support@promise.com.tw> :
>> We think there is no problems, Acturally it is
>> 
>> if (speed == XFER_UDMA_2) {
>>         OUT_BYTE((thold + adj), indexreg);
>>         OUT_BYTE((IN_BYTE(datareg) & 0x7f), datareg);
>> }
>> 
>> So,
>> if (speed == XFER_UDMA_2)
>>         set_2regs(thold, (IN_BYTE(datareg) & 0x7f));

The problem is a common one for complex statement-like macros.
You have a macro M consisting of (in this case) two statements
S1 and S2: "#define M S1; S2". Now consider what happens when
M is used in non-block context, i.e. not as a top-level
statement between { and } but rather in e.g. the true branch
of an if-statement:

	if (condition)
		M;

which after preprocessing becomes

	if (condition)
		S1; S2;

However, indentation doesn't matter, only grouping does, so this
USE of the macro really is

	if (condition)
		S1;
	S2;

Now do you see? The macro body was broken up, and the second statement
is now executed unconditionally.

The traditional approach is to write the body of a complex macro as a
do { ... } while(0) statement (i.e. #define M do { S1; S2; } while(0))
since this turns the macro body into a single unbreakable statement
which is safe to use in any context where a statement may occur.

Simply wrapping the macro body with a pair of braces { } doesn't work
in all contexts; the do{...}while(0) idiom does.

/Mikael
