Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbTLCDf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 22:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTLCDf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 22:35:56 -0500
Received: from dhcp024-209-033-037.neo.rr.com ([24.209.33.37]:45443 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S264481AbTLCDfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 22:35:53 -0500
Date: Tue, 2 Dec 2003 22:28:44 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Frank Dekervel <kervel@drie.kotnet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4 (does not boot)
Message-ID: <20031202222844.GA1718@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Frank Dekervel <kervel@drie.kotnet.org>,
	linux-kernel@vger.kernel.org
References: <200311191749.28327.kervel@drie.kotnet.org> <200311240426.09709.kervel@drie.kotnet.org> <20031123230517.GG30835@neo.rr.com> <200311240910.29565.kervel@drie.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311240910.29565.kervel@drie.kotnet.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 09:10:29AM +0100, Frank Dekervel wrote:
> Op Monday 24 November 2003 00:05, schreef u:
> > > - will the original behaviour really solve the problem ?(not only a
> > > symptom) ? as i wrote, i can trigger almost the same oops (general
> > > protection fault #0000 , invalid EIP value ), probably non-fatal because
> > > another process is killed instead of the pid=1 process, and i can trigger
> > > it on a mm4 with all pnpbios fixes backed out ...

Is the oops triggered by reading /proc/bus/pnp/devices a general protection fault?
Once in a while it will produce a different error in userspace.  If so, I'd like
to see the output.

> >
> > Yes but through the /proc/bus/pnp/devices file. ?Correct? ?It is
> > independent from this change and would also need to be corrected. ?Does the
> > escd interface in /proc/bus/pnp also trigger an oops?
>
> yup it seems so, but this time with valid backtrace
> bakvis:/proc/bus/pnp# cat escd
> Segmentation fault

Could you please try this patch (without pnp-patch-1)... It may fix the ESCD
reading problem.  If it doesn't oops when catted, you may want to test it out
with lsescd by Gunther Mayer.
(http://home.t-online.de/home/gunther.mayer/lsescd-0.10.tar.bz2)

--- a/drivers/pnp/pnpbios/bioscalls.c	2003-11-26 20:44:47.000000000 +0000
+++ b/drivers/pnp/pnpbios/bioscalls.c	2003-12-02 21:17:42.000000000 +0000
@@ -493,7 +493,7 @@
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
 	status = call_pnp_bios(PNP_READ_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0,
-			       data, 65536, (void *)nvram_base, 65536);
+			       data, 65536, __va((void *)nvram_base), 65536);
 	return status;
 }

@@ -516,7 +516,7 @@
 	if (!pnp_bios_present())
 		return ESCD_FUNCTION_NOT_SUPPORTED;
 	status = call_pnp_bios(PNP_WRITE_ESCD, 0, PNP_TS1, PNP_TS2, PNP_DS, 0, 0, 0,
-			       data, 65536, nvram_base, 65536);
+			       data, 65536, __va((void *)nvram_base), 65536);
 	return status;
 }
 #endif


Also just out of curiosity, could I see what the real mode CS and DS are?  I'm
looking for patterns...

So far all of the offenders have a datasegement at 0xf0000.

--- a/drivers/pnp/pnpbios/core.c	2003-11-26 20:42:52.000000000 +0000
+++ b/drivers/pnp/pnpbios/core.c	2003-12-02 21:59:18.000000000 +0000
@@ -460,6 +460,9 @@
                        check->fields.version >> 4, check->fields.version & 15,
 		       check->fields.pm16cseg, check->fields.pm16offset,
 		       check->fields.pm16dseg);
+		printk(KERN_INFO "PnPBIOS: realmode entry 0x%x:0x%x, dseg 0x%x\n",
+		       check->fields.rmcseg, check->fields.rmoffset,
+		       check->fields.rmdseg);
 		pnp_bios_install = check;
 		return 1;
 	}

Thanks,
Adam

