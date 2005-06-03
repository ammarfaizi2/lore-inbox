Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVFCF6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVFCF6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 01:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVFCF6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 01:58:39 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:61390 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261305AbVFCF6V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 01:58:21 -0400
Message-ID: <429FF17C.9080902@free.fr>
Date: Fri, 03 Jun 2005 07:58:20 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net> <429FA1F3.9000001@tls.msk.ru>
In-Reply-To: <429FA1F3.9000001@tls.msk.ru>
Content-Type: multipart/mixed;
 boundary="------------030306040405090000020908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030306040405090000020908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

Michael Tokarev wrote:
> castet.matthieu@free.fr wrote:
> 
>> Hi,
>>
>> try pnpacpi=off in your kernel options and it should work.
>> An other solution is to comment pnpacpi_disable_resources in
>> drivers/pnp/pnpacpi/core.c in order to avoid that the resource are
>> disable.
> 
> 
> Both ways solves this problem for me.  Now I can insmod/rmmod
> parport_pc as many times as I want:
> 
> parport: PnPBIOS parport detected.
> parport0: PC-style at 0x378, irq 7 [PCSPP]
> pnp: Device 00:0b disabled.
> pnp: Device 00:0b activated.
> parport: PnPBIOS parport detected.
> parport0: PC-style at 0x378, irq 7 [PCSPP]
> pnp: Device 00:0b disabled.
> pnp: Device 00:0b activated.
> parport: PnPBIOS parport detected.
> parport0: PC-style at 0x378, irq 7 [PCSPP]
> ....
> 
> BTW, how "stable" pnpacpi=off is?  I mean, is it supposed to
> work on more hardware than current default acpi-aware method?
> 
pnpacpi=off use the old PNP bios  if it is enabled. It seem to work most 
of hardware that support it
(some recent acpi-only computer don't).
There could also have conflict if you use acpi and PNPBios together.

>> There was a problem in pnp layer implementation : the resource weren't
>> given in the right order, Adam Belay send me a patch, but I don't know
>> if it got in main-line ?
> 
> 
> Which patch was that?  I can try it here, but can't seem to be able
> to find it...
> 
http://bugme.osdl.org/attachment.cgi?id=4504&action=view plus the 
attached ones.

>> May be there also a bug in pnpacpi_encode_resources (with the pnp patch
>> apply I didn't still work on some hardware...)
>>
>> You can try to send your dsdt, but I am quit busy for the moment.
>> May be some Intel guy could look at the problem...
> 
> 
> The DSDTs are at http://www.corpit.ru/mjt/hpml150.dsdt
> and http://www.corpit.ru/mjt/hpml310.dsdt (that's a
> (binary) copy from /proc/acpi/dsdt -- is there a way
> to decode it into some text form?)
> 
there is a dissasembler call iasl on intel site.

Matthieu


--------------030306040405090000020908
Content-Type: text/x-patch;
 name="pnp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnp.patch"

Index: drivers/pnp/resource.c
===================================================================
RCS file: /home/mat/dev/linux-cvs-rep/linux-cvs/drivers/pnp/resource.c,v
retrieving revision 1.21
diff -u -r1.21 resource.c
--- drivers/pnp/resource.c	10 Nov 2004 01:11:02 -0000	1.21
+++ drivers/pnp/resource.c	5 Feb 2005 22:29:34 -0000
@@ -42,7 +42,7 @@
 
 	option->priority = priority & 0xff;
 	/* make sure the priority is valid */
-	if (option->priority > PNP_RES_PRIORITY_FUNCTIONAL)
+	if (option->priority > PNP_RES_PRIORITY_INDEPENDENT)
 		option->priority = PNP_RES_PRIORITY_INVALID;
 
 	return option;

--------------030306040405090000020908
Content-Type: text/x-patch;
 name="pnp_rsparser.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnp_rsparser.patch"

Index: drivers/pnp/pnpacpi/rsparser.c
===================================================================
RCS file: /home/mat/dev/linux-cvs-rep/linux-cvs/drivers/pnp/pnpacpi/rsparser.c,v
retrieving revision 1.2
diff -u -r1.2 rsparser.c
--- drivers/pnp/pnpacpi/rsparser.c	10 Nov 2004 01:11:02 -0000	1.2
+++ drivers/pnp/pnpacpi/rsparser.c	5 Feb 2005 22:01:14 -0000
@@ -506,7 +506,11 @@
 			parse_data->option = option;	
 			break;
 		case ACPI_RSTYPE_END_DPF:
-			return AE_CTRL_TERMINATE;
+			option = pnp_register_independent_option(dev);
+			if (!option)
+				return AE_ERROR;
+			parse_data->option = option;
+			break;
 		default:
 			pnp_warn("PnPACPI:Option type: %d not handle", res->id);
 			return AE_ERROR;

--------------030306040405090000020908--
