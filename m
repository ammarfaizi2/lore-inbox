Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291796AbSBAPfn>; Fri, 1 Feb 2002 10:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291798AbSBAPff>; Fri, 1 Feb 2002 10:35:35 -0500
Received: from e22.nc.us.ibm.com ([32.97.136.228]:21929 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291796AbSBAPfU>; Fri, 1 Feb 2002 10:35:20 -0500
Message-ID: <3C5AB5B3.7050908@us.ibm.com>
Date: Fri, 01 Feb 2002 07:35:15 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Revealing unload_lock to everyone
In-Reply-To: <200202011010.g11AAIIZ008097@tigger.cs.uni-dortmund.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
 > Dave Hansen <haveblue@us.ibm.com> said:
 >
 >>This came up in a conversation about ieee1394_core.c.  In 2.5.3, the BKL
 >>is used to protect a module from being unloaded.  The code looks like 
this:
 >>
 >>         lock_kernel();
 >>         read_lock(&ieee1394_chardevs_lock);
 >>         file_ops = ieee1394_chardevs[blocknum].file_ops;
 >>         module = ieee1394_chardevs[blocknum].module;
 >>         read_unlock(&ieee1394_chardevs_lock);
 >>	...
 >>         INCREF(module);
 >>         unlock_kernel();
 >>	
 >>
 >>The question is, how can we keep the module from being unloaded between
 >>the file_ops assignment, and the INCREF.  Do we have a general purpose
 >>way, other than the BKL, to keep a module from being unloaded?  There is
 >>unload_lock, but it is static to module.c.  We can always make it
 >>global, but is there a better solution?
 >>
 >
 > Move the INCREF() up?
 >

This is really perverse, but here is why that doesn't work:

module not loaded
      INCREF(module); /* this fails, no module loaded*/
interrupt, blah, blah, blah
now module is loaded by insmod or something
      module = ieee1394_chardevs[blocknum].module;
module now set, but no refcnt bump has been done because it's newly loaded.
module removed
try to set something which went with the module
*BAM*

So, instead, we used try_mod_inc_count() instead of the local INCREF()
#define and return failure if try_mod_inc_count() fails.  Thanks to
Keith Ownens for pointing me to try_mod_inc_count().

-- 
Dave Hansen
haveblue@us.ibm.com


