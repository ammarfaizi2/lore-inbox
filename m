Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbTIDRue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbTIDRud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:50:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22486 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265329AbTIDRu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:50:27 -0400
Date: Thu, 4 Sep 2003 19:50:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       campbell@torque.net, linux-scsi@vger.kernel.org
Subject: [new patch] Re: 2.6.0-test4-mm5: SCSI imm driver doesn't compile
Message-ID: <20030904175019.GB1374@fs.tum.de>
References: <20030902231812.03fae13f.akpm@osdl.org> <20030903170256.GA18025@fs.tum.de> <20030904133056.GA2411@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904133056.GA2411@conectiva.com.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 10:30:56AM -0300, Arnaldo Carvalho de Melo wrote:
>...
> I just converted it to the more safe c99 init style, but haven't noticed
> the original bug, that is "EPP 16 bit" was duplicated... But this is already
> fixed by Andrew Morton on current Linus bk tree.
> 
> Thanks Andrew for fixing, Adrian for noticing.

Andrews patch removed the first IMM_EPP_16 line in the array.

This isn't correct especially in the !CONFIG_SCSI_IZIP_EPP16 case,
reading all uses of this array (IMM_MODE_STRING is used to print the
corresponding string in printks).

If I'm not misunderstanding it, CONFIG_SCSI_IZIP_EPP16 means "use 16bit 
even when 32bit is requested".

It seems the right solution is


static char *IMM_MODE_STRING[] =
{
        [IMM_AUTODETECT] = "Autodetect",
        [IMM_NIBBLE]     = "SPP",
        [IMM_PS2]        = "PS/2",
        [IMM_EPP_8]      = "EPP 8 bit",
        [IMM_EPP_16]     = "EPP 16 bit",
#ifdef CONFIG_SCSI_IZIP_EPP16
        [IMM_EPP_32]     = "EPP 16 bit",
#else
        [IMM_EPP_32]     = "EPP 32 bit",
#endif
        [IMM_UNKNOWN]    = "Unknown",
};


A patch against the current BK tree is below.


> - Arnaldo

cu
Adrian

--- linux-2.6.0-test4/drivers/scsi/imm.h.old	2003-09-04 19:47:23.000000000 +0200
+++ linux-2.6.0-test4/drivers/scsi/imm.h	2003-09-04 19:48:05.000000000 +0200
@@ -100,8 +100,9 @@
 	[IMM_NIBBLE]	 = "SPP",
 	[IMM_PS2]	 = "PS/2",
 	[IMM_EPP_8]	 = "EPP 8 bit",
-#ifdef CONFIG_SCSI_IZIP_EPP16
 	[IMM_EPP_16]	 = "EPP 16 bit",
+#ifdef CONFIG_SCSI_IZIP_EPP16
+	[IMM_EPP_32]	 = "EPP 16 bit",
 #else
 	[IMM_EPP_32]	 = "EPP 32 bit",
 #endif


