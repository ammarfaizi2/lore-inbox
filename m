Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTEBJhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 05:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbTEBJhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 05:37:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49541 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262011AbTEBJhy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 05:37:54 -0400
Date: Fri, 2 May 2003 10:50:18 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Bodo Rzany <bodo@rzany.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is there small mistake in lib/vsprintf.c of kernel 2.4.20 ?
Message-ID: <20030502095018.GY10374@parcelfarce.linux.theplanet.co.uk>
References: <20030502090835.GX10374@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0305021131290.493-100000@joel.ro.ibrro.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305021131290.493-100000@joel.ro.ibrro.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 11:42:36AM +0200, Bodo Rzany wrote:

> > IOW, %d _does_ mean base=10.  base=0 is %i.  That goes both for kernel and
> > userland implementations of scanf family (and for any standard-compliant
> > implementation, for that matter).
> 
> As I can see, 'base=10' is used for all conversions except for '%x' and
> '%o'. If '%i' or '%u' are given, base should be really set to 0, what is
> not the case (it is fixed to 10 instead!).

Sorry - in 2.4 it's really broken.  What we should have:
%d	->	10
%i	->	0
%o	->	8
%u	->	10
%x	->	16
(note: %u is decimal-only; see manpage).

Fix (2.4-only, 2.5 is OK as it is):

--- S21-rc1/lib/vsprintf.c	Fri Jul 12 11:25:33 2002
+++ /tmp/vsprintf.c	Fri May  2 05:46:07 2003
@@ -616,8 +616,9 @@
 		case 'X':
 			base = 16;
 			break;
-		case 'd':
 		case 'i':
+			base = 0;
+		case 'd':
 			is_sign = 1;
 		case 'u':
 			break;
