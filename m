Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUFQS2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUFQS2s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 14:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUFQS2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 14:28:47 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:53976 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261606AbUFQS1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 14:27:45 -0400
Date: Thu, 17 Jun 2004 20:26:58 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Finn Thain <ft01@webmastery.com.au>
Cc: Andreas Schwab <schwab@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: make checkstack on m68k
Message-ID: <20040617182658.GB29029@wohnheim.fh-wedel.de>
References: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be> <je3c4uqum0.fsf@sykes.suse.de> <Pine.LNX.4.58.0406180048180.13963@bonkers.disegno.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0406180048180.13963@bonkers.disegno.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 June 2004 01:17:31 +1000, Finn Thain wrote:
> To:	Andreas Schwab <schwab@suse.de>
> cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
> 	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
> 	Linux Kernel Development <linux-kernel@vger.kernel.org>

Could you *please* *not* shorten the CC list?  Looks like I'm the
checkstack maintainer, so I like to read your comments.  Especially,
since they are useful ;)

> On Thu, 17 Jun 2004, Andreas Schwab wrote:
> >
> >   $re = qr/.*(?:linkw %fp,|addw )#-([0-9]{1,4})(?:,%sp)?$/o;
> 
> I think that should be addaw, not addw. And it may be necessary to remove
> the $ anchor at the end.

Changed, updated patch below.  Thanks.

Can anyone test?

Jörn

-- 
Don't patch bad code, rewrite it.
-- Kernigham and Pike, according to Rusty


 checkstack.pl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6.7cow/scripts/checkstack.pl~cs_m68k	2004-06-17 14:58:25.000000000 +0200
+++ linux-2.6.7cow/scripts/checkstack.pl	2004-06-17 20:25:30.000000000 +0200
@@ -40,6 +40,10 @@
 	} elsif ($arch =~ /^ia64$/) {
 		#e0000000044011fc:       01 0f fc 8c     adds r12=-384,r12
 		$re = qr/.*adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12/o;
+	 } elsif ($arch =~ /^m68k$/) {
+		#2b6c:       4e56 fb70       linkw %fp,#-1168
+		#1df770:       defc ffe4       addaw #-28,%sp
+		$re = qr/.*(?:linkw %fp,|addaw )#-[0-9]{1,4}(?:,%sp)?/o;
 	} elsif ($arch =~ /^mips64$/) {
 		#8800402c:       67bdfff0        daddiu  sp,sp,-16
 		$re = qr/.*daddiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2})/o;
@@ -76,7 +80,7 @@
 		$func = $1;
 	}
 	if ($line =~ m/$re/) {
-		my $size = $1;
+		my $size = $2;
 		$size = hex($size) if ($size =~ /^0x/);
 
 		if ($size > 0x80000000) {
