Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136689AbRAMMYR>; Sat, 13 Jan 2001 07:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136687AbRAMMYG>; Sat, 13 Jan 2001 07:24:06 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:8712 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136648AbRAMMX5>;
	Sat, 13 Jan 2001 07:23:57 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Christian Zander <phoenix@minion.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: Your message of "Sat, 13 Jan 2001 12:46:00 BST."
             <20010113124559.A2108@chronos> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Jan 2001 23:23:50 +1100
Message-ID: <7816.979388630@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2001 12:46:00 +0100, 
Christian Zander <phoenix@minion.de> wrote:
>I see what you mean. What do you suggest should be done in the context of
>the driver? As you can easily tell, I'm not overly familiar with the
>internal workings of the kernel. That and the mere impossibility to get
>any kind of help at the mere mention of the Nvidia driver module ("go bitch
>at nvidia", "who cares", ...) do not exactly make it easier to fix problems
>that arise from changes to the kernel.

Hmm, can I charge Nvidia for this fix?

The only reason you are looking at symbols is to map Nvidia registry
names to module symbols.  There are 9 registry names, 4 of which are
#ifdeffed out.

MODULE_PARM(NVreg_resman_debuglevel, "i");
MODULE_PARM(NVreg_VideoMemoryTypeOverride, "i");	#ifdeffed out
MODULE_PARM(NVreg_EnableVia4x, "i");
MODULE_PARM(NVreg_ReqAGPRate, "i"); 			#ifdeffed out
MODULE_PARM(NVreg_SkipBiosPost, "i");			#ifdeffed out
MODULE_PARM(NVreg_UseKernelAGP, "i");
MODULE_PARM(NVreg_UpdateKernelAGP, "i");		#ifdeffed out
MODULE_PARM(NVreg_ReqAGPSBA, "i");
MODULE_PARM(NVreg_ReqAGPFW, "i");

Simple fix is an array to map names to addresses.

struct {
	const char *name;
	int *value;
} linux_registry[] = {
	{ "resman_debuglevel",	&NVreg_resman_debuglevel },
	{ "EnableVia4x",	&NVreg_EnableVia4x },
	{ "UseKernelAGP",	&NVreg_UseKernelAGP },
	{ "ReqAGPSBA",		&NVreg_ReqAGPSBA },
	{ "ReqAGPFW",		&NVreg_ReqAGPFW },
};

Changing osRegistryLookup to scan that array for the registry name and
return the address of the corresponding variable is left as an exercise
for the reader.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
