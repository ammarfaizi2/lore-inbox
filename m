Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVFUXv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVFUXv2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 19:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVFUWkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:40:25 -0400
Received: from imf19aec.mail.bellsouth.net ([205.152.59.67]:33787 "EHLO
	imf19aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262322AbVFUWS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:18:58 -0400
Message-ID: <00d501c576b6$943da300$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Jean Delvare" <khali@linux-fr.org>
Cc: "Denis Vlasenko" <vda@ilport.com.ua>,
       "LKML" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost><200506211359.25632.vda@ilport.com.ua><20050621232409.06a3400e.khali@linux-fr.org><008401c576b1$4f2ec000$2800000a@pc365dualp2> <20050621234943.713ecc40.khali@linux-fr.org>
Subject: Re: [RFC] cleanup patches for strings
Date: Tue, 21 Jun 2005 19:11:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a way to defeat the GCC string alignments by putting the strings in
a dynamically sized structure if anyone cares.  A bonus side effect of this
scheme is that kernel/driver NLS translations would become almost trivial
because all the string texts are collected in one place.

The basic idea looks like this:

#define MSG1 "Message text blah"
#define MSG2 "Message text blah, blah"
#define MSG3 "Message text blah, blah, blah"

#ifndef __GCC_FORMAT_STRING_CHECKS__
static const struct
    {
    char m1[sizeof(MSG1)+1];
    char m2[sizeof(MSG2)+1];
    char m3[sizeof(MSG3)+1];
    } msg = {
    {MSG1},
    {MSG2},
    {MSG3}
    };
#undef MSG1
#undef MSG2
#undef MSG3
#define MSG1 msg.m1
#define MSG2 msg.m2
#define MSG3 msg.m3
#endif

The #ifdef allows for a "trial build" so GCC can type match parms to format
strings by just plugging the texts in verbatim like it is today.

The next logical step up from this would be to extract the #define "...."
stuff into a header, and voila, you've got trivial kernel/driver translation
(at least for pan-euro/western languages) essentially for free that doesn't
require anyone to fork off a special translation tree - they can keep using
mainline code base and just do a language specific header translation.

This scheme has saved several hundreds of bytes in couple of drivers I've
been diddling around with prototyping some changes on.

 (Name == Tony Ingenoso)


----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: <cutaway@bellsouth.net>
Cc: "Denis Vlasenko" <vda@ilport.com.ua>; "LKML"
<linux-kernel@vger.kernel.org>
Sent: Tuesday, June 21, 2005 17:49
Subject: Re: [RFC] cleanup patches for strings


> Hi,... hm, don't you have a name?
>
> > Jean, the default string alignments GCC seems to insist on using are
> > going to screw you far more than the extra byte here or there ;->
>
> That's possible, however I can't do anything against GCC personally,
> while I can help cleanup the code and possibly actually space a few
> bytes here and there. So let's just do it.
>
> Oh, and GCC might end up being smart, who knows.
>
> -- 
> Jean Delvare
>

