Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280460AbRKFUMx>; Tue, 6 Nov 2001 15:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280479AbRKFUMp>; Tue, 6 Nov 2001 15:12:45 -0500
Received: from cc78409-a.hnglo1.ov.nl.home.com ([212.120.97.185]:390 "EHLO
	dexter.hensema.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280460AbRKFUMe>; Tue, 6 Nov 2001 15:12:34 -0500
From: spamtrap@use.reply-to (Erik Hensema)
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Date: 6 Nov 2001 20:12:32 GMT
Message-ID: <slrn9ugh1g.dld.spamtrap@dexter.hensema.xs4all.nl>
In-Reply-To: <20011105144112.Q11619@pasky.ji.cz> <4.3.2.7.2.20011106093248.00bea990@10.1.1.42>
Reply-To: erik@hensema.net
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Satchell (satch@concentric.net) wrote:
>The RIGHT tool to fix the problem is the pen, not the coding pad.  I
>hereby pick up that pen and put forth version 0.0.0.0.0.0.0.0.1 of the
>Rules of /Proc:

Agreed.

>1)  IT SHOULD NOT BE PRETTY.  No tabs to line up columns.  No "progress 
>bars."  No labels except as "proc comments" (see later).  No in-line labelling.

It should not be pretty TO HUMANS. Slight difference. It should be pretty
to shellscripts and other applications though.

Yes, that means we won't be able to do a 'cat /proc/cpuinfo' anymore in the
future. Bummer.

>2)  All signed decimal values shall be preceded by the "+" or "-" character 
>-- no exceptions.  Implementers:  this is available with *printf formats 
>with the + modifier, so the cost of this rule is one character per signed 
>value.

Why?

>3)  All integral decimal values shall be assumed by both programs and 
>humans to consist of any number of bits.  [C'mon, people, dealing with 
>64-bit or 128-bit numbers is NOT HARD.  If you don't know how, 
>LEARN.  bc(1) can provide hints on how to do this -- use the Source, 
>Luke.]  Numbers shall contain decimal digits [0-9] only.  Zero-padding is 
>allowed.

Ack.

>4)  All floating-point values shall contain a leading sign ("+" or "-") and 
>a decimal point (US) or comma (Europe).  This rule assumes that the locale 
>for the kernel can be set; if this isn't true, then a period shall be used 
>to separate the integral part and the fractional part.  Floating point 
>values may also contain exponents (using the *printf format %E or %G, NOT 
>%e -- the exponent must be preceded by the letter "e" or "E").  The 
>specification of a zero precision (which suppresses the output of the 
>decimal point or comma) is prohibited.

As long as I can parse it easily, it's fine by me. Easily parsable -> not
localised! Localisation is for userspace, not for the kernel.

[...]

>7)  The /proc data may include comments.  Comments start when an  unescaped 
>hash character "#" is seen, and end at the next newline \n.  Comments may 
>appear on a line of data, and the unescaped # shall be treated as end of 
>data for that line.

Please don't do this. I want to be able to do 'read JIFFIES <
/proc/$jiffiesfile'. Make the name of the file speak for itself. One field
per file in a clearly defined format.

>8)  The regular expression ^#!([A-Za-z0-9_.-]+ )*[A-Za-z0-9_.-]$ defines a 
>special form of comment, which may be used to introduce header labels to an 
>application.  As shown in the regular expression, each label is defined by 
>the regular subexpression [A-Za-z0-9_.-]+ and are separated by a single 
>space.  The final (or only) label is terminated by a newline \n.  No data 
>may appear on the header comment line.  This line may only appear at the 
>beginning of the /proc pseudo file, and appears only ONCE.
>
>9) The regular expression ^#=[0-9]+$ shall be used to output a optional 
>"version number" comment line  If this appears in the /proc output, it 
>precedes the header comment line, and appears only ONCE.

You don't need 8) and 9) when using single fields in a file. Multiple
fields are pretty to a human but not to a simple script.

Optionally doing a 
while read MOUNTPOINT DIR OPTS ; do
	# blah
done < /proc/$mountfile

Would be acceptable.

>10)  Network addresses are defined as strings, either in their name form, 
>in dot quad notation for IPV4 numeric addresses, or in the numeric 
>equivalent for IPV6.  Parsers can recognize the difference between a 
>dot-quad IP address and a floating-point number by the presence of the 
>second dot in the number.  Network information output on /proc shall not 
>use the base/mask notation (123.456.789.012/255.255.255.0) and instead use 
>the bit-length notation (123.456.789.012/24).

You should already know you're going to read an IP address to begin with.

>11)  IPX network addresses are a problem.  In their normal form, they are 
>indistinguishable from a %F-format floating-point number with leading zeros 
>(which is allowed).  Therefore the dot that usually appears in an IPX 
>network number must be replaced with the hyphen or dash "-" 
>character.  Parsers can then differentiate an IPX network address from a 
>floating point number by noticing the embedded dash without the leading "e" 
>or "E" character.  Flex handles this just fine.

See 10).


As you can see, I don't really care about the user reading /proc. We should
provide a backwards compatible /proc to avoid major backage, so users would
be able to read from this interface. Please keep the new interface to the
applications, as it should have been from the start.

And yes, coding a cpuinfo.sh would be very, very easy, so we (the users)
don't need the old interface anyway.

-- 
Erik Hensema (erik@hensema.net)                             ICQ# 8280101
Registered Linux user #38371 -- http://counter.li.org
--S279844AbRKFT36=_/vger.kernel.org--

