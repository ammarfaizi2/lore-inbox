Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbTEBO4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 10:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbTEBO4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 10:56:09 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:57274 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262392AbTEBO4H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 10:56:07 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk, Bodo Rzany <bodo@rzany.de>
Subject: Re: is there small mistake in lib/vsprintf.c of kernel 2.4.20 ?
Date: Fri, 2 May 2003 10:03:33 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030502090835.GX10374@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0305021131290.493-100000@joel.ro.ibrro.de> <20030502095018.GY10374@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030502095018.GY10374@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305021003.33638.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 May 2003 04:50, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Fri, May 02, 2003 at 11:42:36AM +0200, Bodo Rzany wrote:
> > > IOW, %d _does_ mean base=10.  base=0 is %i.  That goes both for kernel
> > > and userland implementations of scanf family (and for any
> > > standard-compliant implementation, for that matter).
> >
> > As I can see, 'base=10' is used for all conversions except for '%x' and
> > '%o'. If '%i' or '%u' are given, base should be really set to 0, what is
> > not the case (it is fixed to 10 instead!).
>
> Sorry - in 2.4 it's really broken.  What we should have:
> %d	->	10
> %i	->	0
> %o	->	8
> %u	->	10
> %x	->	16
> (note: %u is decimal-only; see manpage).
>
> Fix (2.4-only, 2.5 is OK as it is):
>
> --- S21-rc1/lib/vsprintf.c	Fri Jul 12 11:25:33 2002
> +++ /tmp/vsprintf.c	Fri May  2 05:46:07 2003
> @@ -616,8 +616,9 @@
>  		case 'X':
>  			base = 16;
>  			break;
> -		case 'd':
>  		case 'i':
> +			base = 0;
> +		case 'd':
>  			is_sign = 1;
>  		case 'u':
>  			break;

In order to get the hex and octal scanning correct, the following patch
also needs to be applied. For example, trying to scan "fe" with "%x"
currently fails. This is the same change that was made in 2.5.

diff -Naur linux-2.4.20a/lib/vsprintf.c linux-2.4.20b/lib/vsprintf.c
--- linux-2.4.20a/lib/vsprintf.c	2003-04-28 12:04:44.000000000 -0500
+++ linux-2.4.20b/lib/vsprintf.c	2003-04-28 12:04:25.000000000 -0500
@@ -637,7 +637,11 @@
 		while (isspace(*str))
 			str++;
 
-		if (!*str || !isdigit(*str))
+		if (!*str
+		    || (base == 16 && !isxdigit(*str))
+		    || (base == 10 && !isdigit(*str))
+		    || (base == 8 && (!isdigit(*str) || *str > '7'))
+		    || (base == 0 && !isdigit(*str)))
 			break;
 
 		switch(qualifier) {


-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

