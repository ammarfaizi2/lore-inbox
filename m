Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbTEBJNb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 05:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTEBJNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 05:13:30 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:41456 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261993AbTEBJN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 05:13:29 -0400
Date: Fri, 2 May 2003 11:42:36 +0200 (CEST)
From: Bodo Rzany <bodo@rzany.de>
X-X-Sender: bo@joel.ro.ibrro.de
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Bodo Rzany <bodo@rzany.de>, <linux-kernel@vger.kernel.org>
Subject: Re: is there small mistake in lib/vsprintf.c of kernel 2.4.20 ?
In-Reply-To: <20030502090835.GX10374@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0305021131290.493-100000@joel.ro.ibrro.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 May 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Fri, May 02, 2003 at 11:06:32AM +0200, Bodo Rzany wrote:
> > PROBLEM:
> > 	Hex/Octal decoding with sscanf from kernel library does not work
> > 	within kernel 2.4.20
> >
> > DESCRIPTION:
> > 	Line 570 in lib/vsprintf.c
> >
> > 			14677 11. Okt 2001  vsprintf.c
> >
> > 	holds '	base = 10; '
> >
> > 	which prevents the real conversion routines ('simple_strtoul' a.s.o.)
> > 	from decoding numbers from bases other than 10.
>
> It's not a problem, it's standard-mandated behaviour.

I don't think so. Please read a few lines below:

>
> >From vsscanf(3):
>        The following conversions are available:
> ...
>        d      Matches  an  optionally signed decimal integer; the next pointer
>               must be a pointer to int.
> ...
>        i      Matches an optionally signed integer; the next pointer must be a
>               pointer  to  int.   The  integer is read in base 16 if it begins
>               with `0x' or `0X', in base 8 if it begins with `0', and in  base
>               10  otherwise.   Only characters that correspond to the base are
>               used.

If one tries to read an '0xabc' or even '0732' entry in the data buffer,
sscanf returns '-1'. The problem seems to be that 'sscanf' claims for
'base=10' every time, and this prevents 'simple_strtoul' (and the other
conversion routines) from extracting the desired base out of the input
string (format string declarations works fine, as you stated!).

> IOW, %d _does_ mean base=10.  base=0 is %i.  That goes both for kernel and
> userland implementations of scanf family (and for any standard-compliant
> implementation, for that matter).

As I can see, 'base=10' is used for all conversions except for '%x' and
'%o'. If '%i' or '%u' are given, base should be really set to 0, what is
not the case (it is fixed to 10 instead!).

