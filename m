Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUFQRmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUFQRmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 13:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUFQRmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 13:42:40 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:64726 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261234AbUFQRmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 13:42:37 -0400
Date: Thu, 17 Jun 2004 19:41:54 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: make checkstack on m68k
Message-ID: <20040617174154.GA29029@wohnheim.fh-wedel.de>
References: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be> <je3c4uqum0.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <je3c4uqum0.fsf@sykes.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 June 2004 13:41:59 +0200, Andreas Schwab wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> 
> > I tried to add m68k support to `make checkstack', but got stuck due to my
> > limited knowledge of complex perl expressions. I actually need to catch both
> > expressions (incl. the one I commented out). Anyone who can help?
> 
> Untested:
> 
>   $re = qr/.*(?:linkw %fp,|addw )#-([0-9]{1,4})(?:,%sp)?$/o;

Thanks!  Geert, can you test the patch below?

[ It will break all platforms except m68k, but I don't want to touch
those REs before someone confirms it to work. ]

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra



 checkstack.pl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.7cow/scripts/checkstack.pl~cs_m68k	2004-06-17 14:58:25.000000000 +0200
+++ linux-2.6.7cow/scripts/checkstack.pl	2004-06-17 19:39:15.000000000 +0200
@@ -40,6 +40,11 @@
 	} elsif ($arch =~ /^ia64$/) {
 		#e0000000044011fc:       01 0f fc 8c     adds r12=-384,r12
 		$re = qr/.*adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12/o;
+	 } elsif ($arch =~ /^m68k$/) {
+		#2b6c:       4e56 fb70       linkw %fp,#-1168
+		#1df770:       defc ffe4       addaw #-28,%sp
+		#$re = qr/.*linkw %fp,#-([0-9]{1,4})/o;
+		$re = qr/.*(?:linkw %fp,|addw )#-[0-9]{1,4}(?:,%sp)?$/o;
 	} elsif ($arch =~ /^mips64$/) {
 		#8800402c:       67bdfff0        daddiu  sp,sp,-16
 		$re = qr/.*daddiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2})/o;
@@ -76,7 +81,7 @@
 		$func = $1;
 	}
 	if ($line =~ m/$re/) {
-		my $size = $1;
+		my $size = $2;
 		$size = hex($size) if ($size =~ /^0x/);
 
 		if ($size > 0x80000000) {
